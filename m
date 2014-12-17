From: Jeff King <peff@peff.net>
Subject: Re: hooks scripts and noexec partition
Date: Tue, 16 Dec 2014 22:03:29 -0500
Message-ID: <20141217030328.GB4033@peff.net>
References: <CAJ1PRS=96aSp3GE+wj=zHX=JGfZbjUeiUuiDDvfJNuRhrbK_Yg@mail.gmail.com>
 <20140115091609.GC14335@sigill.intra.peff.net>
 <CAJ1PRS=KmiQJG91nxG5pQXPHX2XruoyL9c4yzzPeYayw+UAjPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "krzf83@gmail.com " <krzf83@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 04:03:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y14tk-00051D-Hy
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 04:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbaLQDDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 22:03:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:53608 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751066AbaLQDDb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 22:03:31 -0500
Received: (qmail 18230 invoked by uid 102); 17 Dec 2014 03:03:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Dec 2014 21:03:31 -0600
Received: (qmail 27951 invoked by uid 107); 17 Dec 2014 03:03:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Dec 2014 22:03:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Dec 2014 22:03:29 -0500
Content-Disposition: inline
In-Reply-To: <CAJ1PRS=KmiQJG91nxG5pQXPHX2XruoyL9c4yzzPeYayw+UAjPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261474>

On Sun, Dec 14, 2014 at 02:44:35AM +0100, krzf83@gmail.com  wrote:

> Thanks for the patch, however it is not working (no change, hooks
> still dont work on noexec partition). Since I see that you are fluent
> in git code and C can you by any chance tell me how to modify
> run-command.c to make git run hooks as: /bin/sh <hook_path> ?

I do not think that is a smart thing to do in general, as there is no
guarantee that the hook is in fact a shell script (and not a binary, or
some other scripting language). But if you want do a one-off patch for
yourself, knowing that you will only use shell scripts, it is probably
something like:

diff --git a/run-command.c b/run-command.c
index a476999..ccfccf0 100644
--- a/run-command.c
+++ b/run-command.c
@@ -812,6 +812,7 @@ int run_hook_ve(const char *const *env, const char *name, va_list args)
 	if (!p)
 		return 0;
 
+	argv_array_push(&hook.args, "/bin/sh");
 	argv_array_push(&hook.args, p);
 	while ((p = va_arg(args, const char *)))
 		argv_array_push(&hook.args, p);

-Peff
