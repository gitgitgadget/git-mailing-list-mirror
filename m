From: Jeff King <peff@peff.net>
Subject: Re: Minor bug with help.autocorrect.
Date: Mon, 24 Aug 2015 01:43:27 -0400
Message-ID: <20150824054327.GB14403@sigill.intra.peff.net>
References: <CA+cck7Ex4UO9BAzZ1kq5jw1vYqFb+mbzNQh-RvYAvK5v2T4G0g@mail.gmail.com>
 <xmqqsi7c7hc4.fsf@gitster.dls.corp.google.com>
 <20150821162347.GA4828@sigill.intra.peff.net>
 <xmqqmvxk47e5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tanay Abhra <tanayabh@gmail.com>,
	=?utf-8?Q?Bj=C3=B8rnar?= Snoksrud <snoksrud@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 07:43:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTkXt-0005N3-8r
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 07:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbbHXFnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 01:43:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:48886 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751036AbbHXFna (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 01:43:30 -0400
Received: (qmail 4256 invoked by uid 102); 24 Aug 2015 05:43:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 00:43:30 -0500
Received: (qmail 20293 invoked by uid 107); 24 Aug 2015 05:43:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 01:43:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Aug 2015 01:43:27 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmvxk47e5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276433>

On Fri, Aug 21, 2015 at 03:13:38PM -0700, Junio C Hamano wrote:

> > diff --git a/config.c b/config.c
> > index 9fd275f..dd0cb52 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -1314,7 +1314,7 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
> >  	 * `key` may come from the user, so normalize it before using it
> >  	 * for querying entries from the hashmap.
> >  	 */
> > -	ret = git_config_parse_key(key, &normalized_key, NULL);
> > +	ret = git_config_parse_key(key, &normalized_key, NULL, CONFIG_ERROR_QUIET);
> 
> Hmm, I am not sure if this is correct, or it is trying to do things
> at too low a level.
> 
> configset_add_value() calls configset_find_element().
> 
> A NULL return from find_element() could be because parse_key()
> errored out due to bad name, or the key genuinely did not exist in
> the hashmap, and the caller cannot tell.  So add_value() can end up
> adding a new <key,value> pair under a bogus key, which is not a new
> problem, but what makes me cautious is that it happens silently with
> the updated code.
> 
> In fact, git_configset_add_file() uses git_config_from_file() with
> configset_add_value() as its callback function, and the error that
> is squelched with this CONFIG_ERROR_QUIET would be the only thing
> that tells the user that the config file being read is malformed.

I assumed that we would only get well-formed keys here. That is, the
config parser should be enforcing the rules already in
config.c:get_parse_source and friends. In that sense, the parse_key in
the configset_add_value path _should_ be a noop (and this patch does
make it worse by quieting a warning we would get for a potential bug).

For example:

  $ echo "utter_crap = true" >.git/config
  $ git config foo.bar
  fatal: bad config file line 6 in .git/config

It looks like the "-c" code is more forgiving, though, and does rely on
this check:

  $ git -c utter_crap=true log >/dev/null
  error: key does not contain a section: utter_crap

So the patch is a regression there.

> Right now, "git config" does not seem to use the full configset API
> so nobody would notice, but still...

Hmm. I don't think that matters for bad config files. Even after we move
to configset there, it will still have to run that same parsing code.
But when I say:

  $ git config utter_crap
  error: key does not contain a section: utter_crap

I think we would end up relying on this code to tell me that my request
was bogus. And that needs to keep being noisy, to tell the user what's
going on (as opposed to check_pager_config(), which really wants to say
"I'm _aware_ I might be feeding you junk").

> I wonder if alias_lookup() and check_pager_config(), two functions
> that *know* that the string they have, cmd, could be invalid and
> unusable key to give to the config API, should be doing an extra
> effort (e.g. call parse_key() with QUIET option and refrain from
> calling git_config_get_value()).  It feels that for existing callers
> of parse_key(), not passing QUIET would be the right thing to do.
> 
> Of course, I am OK if git_config_get_value() and friends took the
> QUIET flag and and passed it all the way down to parse_key(); that
> would be a much more correct approach to address this issue (these
> two callers do not have to effectively call parse_key() twice that
> way), but at the same time, that would be a lot more involved
> change.

Yeah, I agree these are the only two sane fixes. Plumbing the quiet flag
through does seem really invasive; every "git_config_get_foo" variant
would have to learn it. Probably it's too gross to have a global like:

  config_lax_mode = 1;
  git_config_get_string(key.buf, &v);
  config_lax_mode = 0;

That makes a nice tidy patch, but I have a feeling we would regret it
later. :)

-Peff
