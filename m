From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: More builtin git-am issues..
Date: Fri, 4 Sep 2015 17:36:43 -0700
Message-ID: <CA+55aFzR2kZuS=b5D0sSV7u7Wm3a2_FENOD1_kYmr4gqdcVS2w@mail.gmail.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<CA+55aFw2bnhSQYk4FaHfp4ED0Y611NWyQs05TMQtFj=2As1=nA@mail.gmail.com>
	<20150905000745.GC11443@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 05 02:37:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZY1Tc-0007FY-Bv
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 02:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbbIEAgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 20:36:49 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35671 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964955AbbIEAgo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 20:36:44 -0400
Received: by igbkq10 with SMTP id kq10so23488874igb.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 17:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SDy2GFZ+Q601Qkngl0g/0NaTbaxcZuZ3WYR1MgYkkYU=;
        b=M8z8IiXnGdyrWISHEp7X4j6oisaBOR8Gqa4WxVTQpfk/GR0RTsbUj94GvZxK2XASc6
         a7SdEgr4Ynoy7xUtoIRAZXzLyypu5uyF7l/M1Kyqr7N9NUHppasGmody62uGO0R+4ONY
         LP7T9+fVBqSS7qOsqW1SEfnNfp0UkOvFx4OYgLCN5aduRYfzbgLGPSTpcE3DHoPELz00
         b7y6ofzpNz35WJr9dyF/9h07Nsa7MOQfpj1NSdzQeVarbKOCXfu1CqYgUJ695BWmLzXo
         AQwvoCExO0cWDvdGvCVNJwm37RQgNyh8qMkpPiknFPXpW/L27uFEJ93OlvWwcTdRz0gc
         D0Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SDy2GFZ+Q601Qkngl0g/0NaTbaxcZuZ3WYR1MgYkkYU=;
        b=TeMHkl2QnG6e9fL25IDuvCAVjO20DKU0FrYThzGZgR7SAgmeGckTTy5TW7qGTl3hRJ
         5twxa/AUSYtsTUF6TWFJOorHT0DQetc5YQvN5BbUDMs7PyEQ288UKvOhpvowi7S4+LMt
         LYWXZmt01QKkikcg2ka124oOyF1PgAvDMG46A=
X-Received: by 10.50.73.168 with SMTP id m8mr11664518igv.25.1441413403667;
 Fri, 04 Sep 2015 17:36:43 -0700 (PDT)
Received: by 10.36.124.195 with HTTP; Fri, 4 Sep 2015 17:36:43 -0700 (PDT)
In-Reply-To: <20150905000745.GC11443@sigill.intra.peff.net>
X-Google-Sender-Auth: eqkSvy1YTRcqYTSsWmRH6GQiMH8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277352>

On Fri, Sep 4, 2015 at 5:07 PM, Jeff King <peff@peff.net> wrote:
>
> Do we want to make Signed-off-by a special token here? What about "Cc:",
> and other project-specific trailers? You wouldn't want to end up with:
>
>   [some comment]
>   Cc: somebody
>
>   Signed-off-by: somebody else
>
> It's not a problem for git-am, which should be taking in patches that
> are already signed-off (and after all, if your project does not use
> signoffs, why are you using "am -s"?). But won't "git commit -s" run
> into the same problem?

So I'm a *bit* worried about taking anything else than Signed-off-by:
exactly because of the problem you mention:

> We could look for an arbitrary rfc2822-ish string, but I'd be worried
> slightly about false positives, like:
>
>   This is a paragraph with arbitrary text. But one
>   of the lines will use a colon, and that a causes a
>   problem: because of wrapping, this line kind of looks
>   like a trailer.

which clearly needs an empty line before the sign-off.

And even if we limit it to just the last line, like you suggest:

> Maybe only the final line needs to look rfc2822-ish?

I'd still worry, for the same exact reason. The "rfc2822-ish" check is
_so_ weak that it can be trivially triggered by normal text.

So maybe it doesn't require a strict "Signed-off-by:" match, but I
think it needs something stricter than the found_rfc2822 format (like
maybe "looks like a name/email").  We just don't want to require that
*all* the lines are that way, because at least in the kernel we often
do end up adding small comments in that section.

The git project sign-off rules seem to be stricter, and it looks like
it's almost universally of the form "Signed-off-by:" with a few
"Helped-by:" and "Reviewed-by:". In the kernel, we really do tend to
be messier in that area, with the sign-off chunk not just having the
sign-offs and cc's etc, but also tends to have those occasional small
notes left by the people forwarding the emails.

And we also often don't have _strictly_ just an email. We tend to have
things like

    Cc: <stable@vger.kernel.org> # v3.13+

etc, and sometimes we don't have have any email at all, but things like

    Reported-by: coverity
    Tested-by: MysterX on #openelec
    Generated-by: Coccinelle SmPL

so it's hard to give a really strict rule. It's fairly free-format.

That said, I would argue that when you apply a patch with sign-off,
pretty much by definition that patch _should_ have a sign-off from the
originator. So I suspect that the "there is an existing sign-off in
that last chunk" is a fairly good rule. Even if there are lots of
other lines too.

If you're using "git commit -s" to just commit your own work, you
presumably would normally want the extra sign-off. Or at least you can
do a "git commit --amend" fairly easily to fix things up. Doing the
amending later for "git am" is rather impractical, when it might have
been a series of 100+ emails..

                  Linus
