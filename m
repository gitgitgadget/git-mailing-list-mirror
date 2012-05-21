From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/2] git-sh-setup: work around Cygwin path handling gotchas
Date: Mon, 21 May 2012 19:43:32 +0100
Message-ID: <4FBA8CD4.3020001@ramsay1.demon.co.uk>
References: <4FB09FF2.70309@viscovery.net> <1337191208-21110-1-git-send-email-gitster@pobox.com> <1337191208-21110-3-git-send-email-gitster@pobox.com> <CAAXzdLW5VYnHc41WZ0id=4Qe17dHSj4+J9tqVvG-PvtpXLmh+Q@mail.gmail.com> <7vd364c5kt.fsf@alter.siamese.dyndns.org> <4FB58678.1050009@ramsay1.demon.co.uk> <7vehqib4kk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Penny <svnpenn@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 20:45:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWXcD-0000WY-It
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 20:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758972Ab2EUSpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 14:45:49 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:47399 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758759Ab2EUSps (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 May 2012 14:45:48 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1SWXc2-0005Z5-gB; Mon, 21 May 2012 18:45:47 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vehqib4kk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198122>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> I guess you won't be shocked to hear that I don't think this patch is
>> necessary. :-P
> 
> That is more or less irrelevant, not in the sense that what you say is
> irrelevant, but in the sense that something can be worked around in a
> different way alone is not a good reason to reject a patch, if its benefit
> outweigh its costs.

I completely agree.

In case it was not clear, I was not suggesting that the patch be rejected on
the basis that the problem could be worked around in a different way.

> If I speculated in the other message is correct (in short, "In Cygwin
> world, Git is compiled to use POSIX paths and would not work with Windows
> paths."), I think this "problem" is fundamentally un"fix"able.

Yes, Cygwin is essentially just another POSIX target as far as Git is
concerned. Cygwin tries hard to provide a POSIX-like environment, but it is
not possible for it to completely hide the fact that the base OS is not
actually a POSIX system.
 
> And from Cygwin Git, your programs (like $EDITOR and hooks) will get POSIX
> paths.  It is your programs' responsibility to turn them into Windows
> paths if/as necessary.

I would say that this is the only sensible way to proceed.

However, you could imagine adding code to accommodate external windows
programs. If we limit ourselves to the text editor, for example, I could
imagine something like the diff attached below to fix up the C based git
programs. (You would need to make similar changes to the shell and perl
scripts which launch the text editor).

I would not like to see a patch based on this (or any others like it) applied,
since it is going in the wrong direction. (Why do people use Cygwin git rather
than MinGW git and vice versa). Of course, it is not my decision to make ... :-P

>> Anyway, I applied this patch tonight to give it a go. The very first test
>> I tried failed. I've attached the log of the failing test below.
>> Note that it is attempting to use "ssh" to a "host" that ends in ".../C:".
> 
> Of course.  That is one typical symptom that suggests my speculation was
> correct.

Heh, I was surprised that it did as well as it did; after all, it passed 44
out of the 45 tests run (from t7400-submodule-basic.sh). ;-)

> So "I don't think this patch is necessary" is irrelevant, but "This patch
> is harmful; Git on Cygwin is never supposed to use Windows paths" is very
> relevant ;-)

I agree.

ATB,
Ramsay Jones

-- >8 --
diff --git a/editor.c b/editor.c
index d834003..cf36e62 100644
--- a/editor.c
+++ b/editor.c
@@ -1,6 +1,9 @@
 #include "cache.h"
 #include "strbuf.h"
 #include "run-command.h"
+#ifdef __CYGWIN__
+# include <sys/cygwin.h>
+#endif
 
 #ifndef DEFAULT_EDITOR
 #define DEFAULT_EDITOR "vi"
@@ -37,6 +40,12 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 
 	if (strcmp(editor, ":")) {
 		const char *args[] = { editor, path, NULL };
+#ifdef __CYGWIN__
+		char win32_path[1024];
+
+		cygwin_conv_to_full_win32_path(path, win32_path);
+		args[1] = win32_path;
+#endif
 
 		if (run_command_v_opt_cd_env(args, RUN_USING_SHELL, NULL, env))
 			return error("There was a problem with the editor '%s'.",
-- 8< --
