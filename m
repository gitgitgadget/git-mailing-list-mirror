From: Jeff King <peff@peff.net>
Subject: Re: pager config for external commands
Date: Fri, 19 Nov 2010 12:29:01 -0500
Message-ID: <20101119172901.GA9747@sigill.intra.peff.net>
References: <AANLkTimtjR0O3K8iGOVVVaFJS2+2wHcHhWf45tFYXjRQ@mail.gmail.com>
 <AANLkTimMSp8XVzoaax2mW-jYP26B+zF2QSJFcy4TUi60@mail.gmail.com>
 <20101119160058.GA7967@sigill.intra.peff.net>
 <AANLkTikE6=At-BV22myZtM4nuNL6z4hoJ-kS=O1LkBXo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeffrey Middleton <jefromi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 18:29:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJUlt-00078m-3V
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 18:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851Ab0KSR3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 12:29:08 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55153 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755646Ab0KSR3H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 12:29:07 -0500
Received: (qmail 26261 invoked by uid 111); 19 Nov 2010 17:29:05 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 19 Nov 2010 17:29:05 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Nov 2010 12:29:01 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikE6=At-BV22myZtM4nuNL6z4hoJ-kS=O1LkBXo@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161771>

On Fri, Nov 19, 2010 at 11:16:53AM -0600, Jeffrey Middleton wrote:

> Okay, that makes sense, I think. But execv_dashed_external does
> currently commit the pager choice, just without looking it up from the
> config. This means that, for example, git --paginate
> <nonexistent-command> does invoke the pager. Is that intended? I don't
> think I see any tests covering the combination of pager.<cmd> for
> anything but builtins.

Hmm. You're right, I should have looked at the current code instead of
digging in the history. :)

Looks like it was part of some pager work Jonathan did this summer. I
think there may have been issues in the past, too, with actually looking
at config before exec'ing the external, but those seem cleared up, too.

So in theory you just need this:

diff --git a/git.c b/git.c
index 0409ac9..bb2c726 100644
--- a/git.c
+++ b/git.c
@@ -438,6 +438,8 @@ static void execv_dashed_external(const char **argv)
 	const char *tmp;
 	int status;
 
+	if (use_pager == -1)
+		use_pager = check_pager_config(argv[0]);
 	commit_pager_choice();
 
 	strbuf_addf(&cmd, "git-%s", argv[0]);

But beyond seeing that it does in fact turn on the pager for an external
command, I've done no testing.

As far as "git -p bogus", I guess we have accepted that it will start
a pager. These days we at least send stderr to the pager, too, so the
error message won't go unseen.

> Also, instead of having git implement "look up in PATH" internally,
> would it make sense to simply commit the pager choice, try the execv,
> then uncommit the pager choice if the command was not found?

No. The reason we push commit_pager_choice off to the last minute is
that you can't uncommit it gracefully. It actually execs the pager,
which may then do things to the terminal outside of our control.

-Peff
