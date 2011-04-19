From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] run-command: write full error message in die_child
Date: Tue, 19 Apr 2011 02:05:10 -0500
Message-ID: <20110419070510.GB28291@elie>
References: <7v8vv78eld.fsf@alter.siamese.dyndns.org>
 <7v4o5v8dlp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 09:05:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC4zy-0005h2-5Z
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 09:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274Ab1DSHFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 03:05:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60228 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889Ab1DSHFP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 03:05:15 -0400
Received: by iwn34 with SMTP id 34so4543755iwn.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 00:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=tW8HPAsg9dxxt7hZGnclH+pe8k2PlOVo3tST32DM26Q=;
        b=T70YC5r/1dh1mM0M/BCglmoLFmk/m5eeHsRJq1UTwOXBc40CXA4z3Wz5pI4uQNu2hG
         mkB2721PGvWFvSVNrYLO02chvWETU/Q3+xHZEZXdO53qdFaqV1+nfoGcX4mEBPbX37I8
         ZbYUh5cRuwloP1tzgkavwLthS/S5kOOLiCrko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZfgniPjir+j35PAmXA6lVS7RwrfJp0lSNVAMjz+MmoD2e3FSV3ZCjVy1OYoxaG+oG3
         U2AGCBEGh7OncGA9IYfdKZ4lZpqCuDJdIClL2xkodBUrIhlrxns+Ju1VwHmADAOR9Tcl
         yVXuwGePUHj1A9RR7NlES5zvxpqv7dwnWIluU=
Received: by 10.231.28.164 with SMTP id m36mr4402652ibc.163.1303196714931;
        Tue, 19 Apr 2011 00:05:14 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.ameritech.net [69.209.64.141])
        by mx.google.com with ESMTPS id c1sm3170093ibe.17.2011.04.19.00.05.13
        (version=SSLv3 cipher=OTHER);
        Tue, 19 Apr 2011 00:05:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4o5v8dlp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171776>

The run_command facility writes a truncated error message when the
command is present but cannot be executed for some other reason.  For
example, if I add a 'hello' command to git:

	$ echo 'echo hello' >git-hello
	$ chmod +x git-hello
	$ PATH=.:$PATH git hello
	hello

and then make it non-executable, this is what I get from 'maint':

	$ chmod a-x git-hello
	$ git hello
	fatal: cannot exec 'git-hello': Permission denied

But with 'master', we get disturbing output:

	$ PATH=.:$PATH git hello
	fatal: $

That is a regression introduced by v1.7.5-rc0~29^2 (run-command:
prettify -D_FORTIFY_SOURCE workaround, 2011-03-16), which uses the
construct "if (write(...) || write(...) || write(...))" to perform
some writes in sequence, with the "if" body acknowledging errors from
them once.  write does not return 0 on success, so only the first
write succeeds.  Oops.

While fixing the above, let's actually pay attention to the return
value and handle partial writes.  write_in_full has the desired
semantics --- it loops until the desired number of bytes have been
written and on error it returns -1 to let us handle the error.

The "if" to appease warn_unused_result is no longer necessary after
this patch since xwrite and write_in_full check the return value from
write(2), but we leave it in for clarity and for robustness against
future static analyzers.

Reported-by: Junio C Hamano <gitster@pobox.com>
Analysis-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> I'm reverting it for now, but am open to a submission of a proper fix
> after 1.7.5.

Knowing myself, I'm likely to forget to submit a fix later.  So here's
a patch to consider applying after 1.7.5.

Based directly against ebec84277 (run-command: prettify
-D_FORTIFY_SOURCE workaround, 2011-03-16).  The "grep" in the test
case should be test_i18ngrep if applying to a gettextized git.

Sorry for the breakage.

 run-command.c          |    8 ++++----
 t/t0061-run-command.sh |   24 ++++++++++++++++++++++++
 test-run-command.c     |    2 ++
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/run-command.c b/run-command.c
index 8619c76..3e2ce2a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -72,7 +72,7 @@ static void notify_parent(void)
 	 * know, so failures like ENOENT can be handled right away; but
 	 * otherwise, finish_command will still report the error.
 	 */
-	if (write(child_notifier, "", 1))
+	if (xwrite(child_notifier, "", 1) < 0)
 		; /* yes, dear gcc -D_FORTIFY_SOURCE, there was an error. */
 }
 
@@ -83,9 +83,9 @@ static NORETURN void die_child(const char *err, va_list params)
 	if (len > sizeof(msg))
 		len = sizeof(msg);
 
-	if (write(child_err, "fatal: ", 7) ||
-	    write(child_err, msg, len) ||
-	    write(child_err, "\n", 1))
+	if (write_in_full(child_err, "fatal: ", 7) < 0 ||
+	    write_in_full(child_err, msg, len) < 0 ||
+	    write_in_full(child_err, "\n", 1) < 0)
 		; /* yes, gcc -D_FORTIFY_SOURCE, we know there was an error. */
 	exit(128);
 }
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 10b26e4..be602fd 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -7,8 +7,32 @@ test_description='Test run command'
 
 . ./test-lib.sh
 
+cat >hello-script <<-EOF
+	#!$SHELL_PATH
+	echo hello
+EOF
+>empty
+
 test_expect_success 'start_command reports ENOENT' '
 	test-run-command start-command-ENOENT ./does-not-exist
 '
 
+test_expect_success 'run_command can run a command' '
+	echo hello >expect &&
+	cat hello-script >hello.sh &&
+	chmod +x hello.sh &&
+	test-run-command run-command ./hello.sh >actual 2>err &&
+
+	test_cmp expect actual &&
+	test_cmp empty err
+'
+
+test_expect_success POSIXPERM,SANITY 'run_command reports EACCES' '
+	cat hello-script >hello.sh &&
+	chmod -x hello.sh &&
+	test_must_fail test-run-command run-command ./hello.sh 2>err &&
+
+	grep "fatal: cannot exec.*hello.sh" err
+'
+
 test_done
diff --git a/test-run-command.c b/test-run-command.c
index 0612bfa..37918e1 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -29,6 +29,8 @@ int main(int argc, char **argv)
 		fprintf(stderr, "FAIL %s\n", argv[1]);
 		return 1;
 	}
+	if (!strcmp(argv[1], "run-command"))
+		exit(run_command(&proc));
 
 	fprintf(stderr, "check usage\n");
 	return 1;
-- 
1.7.5.rc2
