From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 1/4] notes: don't leak memory in
 git_config_get_notes_strategy
Date: Thu, 31 Mar 2016 19:32:52 -0400
Message-ID: <20160331233252.GB6120@sigill.intra.peff.net>
References: <1459447446-32260-1-git-send-email-sbeller@google.com>
 <1459447446-32260-2-git-send-email-sbeller@google.com>
 <CAPig+cRPNt1aNdsONXgX0SkgNiYtTS8vCGQzE2u4+vpd-N-Vew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 01:33:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alm5D-0006eq-C9
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 01:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757286AbcCaXcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 19:32:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:42057 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753371AbcCaXcz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 19:32:55 -0400
Received: (qmail 27384 invoked by uid 102); 31 Mar 2016 23:32:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 19:32:55 -0400
Received: (qmail 19434 invoked by uid 107); 31 Mar 2016 23:32:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 19:32:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2016 19:32:52 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cRPNt1aNdsONXgX0SkgNiYtTS8vCGQzE2u4+vpd-N-Vew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290489>

On Thu, Mar 31, 2016 at 05:08:30PM -0400, Eric Sunshine wrote:

> On Thu, Mar 31, 2016 at 2:04 PM, Stefan Beller <sbeller@google.com> wrote:
> > `value` is just a temporary scratchpad, so we need to make sure it doesn't
> > leak. It is xstrdup'd in `git_config_get_string_const` and
> > `parse_notes_merge_strategy` just compares the string against predefined
> > values, so no need to keep it around longer. Instead of using
> > `git_config_get_string_const`, use `git_config_get_value`, which doesn't
> > return a copy.
> >
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > ---
> > diff --git a/builtin/notes.c b/builtin/notes.c
> > @@ -746,7 +746,7 @@ static int git_config_get_notes_strategy(const char *key,
> >  {
> >         const char *value;
> >
> > -       if (git_config_get_string_const(key, &value))
> > +       if (git_config_get_value(key, &value))
> 
> Hmm, doesn't this introduce a rather severe regression? Unless I'm
> misreading the code (possible), with the original, if 'key' was
> boolean (lacked a value in the config file), then it would complain:
> 
>     Missing value for 'floop.blork'
> 
> but, with this change, it will dereference NULL and crash.
> 
> (My understanding was that Peff's suggestion to use
> git_config_get_value() implied a bit of work beyond the simple textual
> substitution of 'git_config_get_value' for
> 'git_config_get_string_const'.)

Ah, yeah, I didn't even think about that case. I was thinking that
wouldn't it be nice if we had:

  const char *git_config_get_string(const char *key);

which would be a much more natural interface. But the reason we don't is
that we have to represent the "NULL as boolean true" case in the first
place.

So I dunno. Getting the NULL-handling for free is rather nice, and maybe
worth using the normal git_config_get_string(). It's too bad there's not
a variant that just returns a non-allocated pointer, but given that
there is already a confusing proliferation of functions to retrieve a
config string, it's hard to justify adding another.

-Peff
