From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] credential: let empty credential specs reset helper list
Date: Fri, 26 Feb 2016 17:37:20 -0500
Message-ID: <20160226223719.GA2429@sigill.intra.peff.net>
References: <20160226105135.GA30215@sigill.intra.peff.net>
 <xmqqa8mnl71v.fsf@gitster.mtv.corp.google.com>
 <xmqqk2lrjmff.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Guilherme <guibufolo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 23:37:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZR0r-0001bC-Ld
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 23:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423113AbcBZWhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 17:37:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:50380 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755336AbcBZWhW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 17:37:22 -0500
Received: (qmail 6959 invoked by uid 102); 26 Feb 2016 22:37:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 17:37:22 -0500
Received: (qmail 8412 invoked by uid 107); 26 Feb 2016 22:37:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 17:37:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 17:37:20 -0500
Content-Disposition: inline
In-Reply-To: <xmqqk2lrjmff.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287631>

On Fri, Feb 26, 2016 at 11:34:12AM -0800, Junio C Hamano wrote:

> >> -	if (!strcmp(key, "helper"))
> >> -		string_list_append(&c->helpers, value);
> >> -	else if (!strcmp(key, "username")) {
> >> +	if (!strcmp(key, "helper")) {
> >> +		if (*value)
> >> +			string_list_append(&c->helpers, value);
> >> +		else
> >> +			string_list_clear(&c->helpers, 0);
> >> +	} else if (!strcmp(key, "username")) {
> >
> > I wondered why neither the existing code nor the updated one has a
> > check for !value, but this callback assumes no credential
> > configuration variable will ever be a boolean and rejects it
> > upfront, so this code before or after the change is safe.
> >
> > Not pointing out anything that needs to be changed; demonstrating
> > that I did read this sufficiently well to say that I have reviewed
> > it ;-)
> 
> This reminds me of one thing.  The only reason why we are hesitant
> to introduce a new syntax like
> 
> 	[credential]
>         	!helper ;# clear
>                 helper = ...
> 
> to allow explicit clearing of accumulated values so far IIRC is
> because such a _file_ will not be readable by existing versions of
> Git.  Am I correct?

I think there is another reason, which is that the interface we expose
to config callbacks (and via "config --get-all") is to sequentially pass
in all values. How does that interact with this "reset"? For example,
what is the output of:

  git config foo.bar one
  git -c '!foo.bar' config --get-all foo.bar

?

Do we continue to output the "reset" values, or do we quietly munge the
list on behalf of the caller? If the former, how do we represent that in
the output? I can see arguments both ways.

Implementation-wise (both for git-config and for internal callbacks), it
means we cannot parse the config as a single pass anymore. That's
probably OK; we've already moved partially toward that with the
configset stuff. If we _just_ support this via command-line options, we
could do an initial pass over those, looking for negatives, and then
simply skip all negatives while parsing the config files.

> If that is the case, then that reasoning will still not prevent us
> from adding corresponding support for a command-line overide, i.e.
> either one or both of these:
> 
> 	$ git -c credential.!helper cmd
> 	$ git -c !credential.helper cmd
> 
> no?

Yes, that would work, though to me it really feels like a
half-implemented feature. You cannot override a bad /etc/gitconfig line
via your ~/.gitconfig or repo-specific .git/config. Those things are
useful.

One other thing that occurred to me is that Apple Git hard-codes the
osxkeychain helper (rather than putting it into the system-wide
gitconfig <sigh>). No config-based system can "undo" that, but my patch
does. I admit that's probably not the best argument; hitting Apple with
a clue-stick is a cleaner approach.

> Of course, the code in the configuration subsystem for updated
> version of Git needs to become aware of the new syntax, and those
> that deal with the multi-value variables need custom code, which is
> similar to the way you special cased an empty value in the above
> patch, so I am not sure how much this would help.

I think you could get away without changing the users of the multi-value
variables, using the "negative" approach I mentioned above. Basically:

  1. parse GIT_CONFIG_PARAMETERS looking for negatives; stick them in a
     string-list or whatever.

  2. parse the files; look up each key in the string-list, and if it
     matches, don't even send it to the callback

  3. clear the string-list

  4. parse GIT_CONFIG_PARAMETERS again, ignoring any negatives

But like I said, that does feel somewhat half-implemented to me, since
it treats the command-line specially.

-Peff
