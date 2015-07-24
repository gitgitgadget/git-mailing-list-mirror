From: Jeff King <peff@peff.net>
Subject: Re: "git am" and then "git am -3" regression?
Date: Fri, 24 Jul 2015 11:09:21 -0700
Message-ID: <20150724180921.GA17730@peff.net>
References: <xmqqr3nxmopp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 20:09:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIhPX-0007iK-VN
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 20:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbbGXSJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 14:09:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:34613 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753512AbbGXSJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 14:09:25 -0400
Received: (qmail 9382 invoked by uid 102); 24 Jul 2015 18:09:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 13:09:25 -0500
Received: (qmail 22094 invoked by uid 107); 24 Jul 2015 18:09:29 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 14:09:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jul 2015 11:09:21 -0700
Content-Disposition: inline
In-Reply-To: <xmqqr3nxmopp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274577>

On Fri, Jul 24, 2015 at 10:48:18AM -0700, Junio C Hamano wrote:

> Hmm, there seems to be some glitches around running "am -3"
> after a failed "am" between 'maint' and 'master'.
> 
> When I try the following sequence, the 'am' from 'maint' succeeds,
> but 'am' in 'master' fails:
> 
>  * Save Eric's "minor documetation improvements" $gmane/274537
>    to a file.  
> 
>  * "git checkout e177995" (that's "next^0") and then apply them with
>    "git am" (no -3 necessary).
> 
>  * "git checkout 272be14" (that's "es/worktree-add-cleanup^0") and
>    then apply them with "git am" (without -3).
> 
>    This is expected to stop at 2/6, as the context has changed
>    between 272be14 and the tip of 'next'.
> 
>  * "git am -3".  This should restart and resolve cleanly.

Thanks for diagnosing. This bit me the other day, but I hadn't had time
to look at it yet (and I "am" a lot less than you do, I imagine).

> Reverting d96a275b91bae1800cd43be0651e886e7e042a17 seems to fix it,
> so that is what I'll do for 2.5 final.

Yeah, I think this hunk is to blame (though I just read the code and did not
test):

@@ -658,6 +665,8 @@ fi
 if test "$(cat "$dotest/threeway")" = t
 then
        threeway=t
+else
+       threeway=f
 fi

It comes after the command-line option parsing, so it overrides our option (I
think that running "git am -3" followed by "git am --no-3way" would have the
same problem). It cannot just check whether $threeway is unset, though, as it
may have come from the config. We'd need a separate variable, the way the code
is ordered now.

Ideally the code would just be ordered as:

  - load config from git-config

  - override that with defaults inherited from a previous run

  - override that with command-line parsing

but I don't know if there are other ordering gotchas that would break.
It does look like that is how Paul's builtin/am.c does it, which makes
me think it might not be broken. It's also possibly I've horribly
misdiagnosed the bug. ;)

-Peff
