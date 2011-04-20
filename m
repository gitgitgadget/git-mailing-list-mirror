From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] tests: check error message from run_command
Date: Wed, 20 Apr 2011 05:35:08 -0500
Message-ID: <20110420103508.GB6027@elie>
References: <7v8vv78eld.fsf@alter.siamese.dyndns.org>
 <7v4o5v8dlp.fsf@alter.siamese.dyndns.org>
 <20110419070510.GB28291@elie>
 <4DAE8E66.5060705@viscovery.net>
 <20110420103319.GA6027@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 12:35:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCUki-0002LS-Ud
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 12:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151Ab1DTKfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 06:35:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49597 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983Ab1DTKfN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 06:35:13 -0400
Received: by iwn34 with SMTP id 34so482901iwn.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 03:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=JK15jumOoZRMcp4qXtmdgQQz5l2JRVzlheqLY8idx9E=;
        b=XyZPTKZs62LIS/2oyjb0vBYOsxj3lQz1EzEqfxImiGUw0R8vqsTdk9GPWGIJJdA3BQ
         RVuQV/mApynpsbsaBX4izLjoT0XrSuP55Bia6/0WRTUDv3mfOH2v5Zeyv18MB5Ci7nCC
         Q7AE0t1iJvHdRATNvn3qCuYsJ9F8xpRq1rT9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=a/lJ7DWbbnMiXdZd0OYXcKNQbIXdoRA6hsU1yMFEilRbw3W22zGhkGhzvAgg4IaRug
         7ISUGzO9iGZrZ5o8/R6X28/yqLrvtkFUnh06U/EZdDauywE4HjN+Pf67miDiHzzML5mb
         4Qp6LSTnURrWPHBkz6Hski08QxCkLGXsW5tG8=
Received: by 10.42.151.138 with SMTP id e10mr6609576icw.251.1303295712744;
        Wed, 20 Apr 2011 03:35:12 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.ameritech.net [69.209.64.141])
        by mx.google.com with ESMTPS id d9sm330719ibb.19.2011.04.20.03.35.11
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Apr 2011 03:35:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110420103319.GA6027@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171856>

In git versions starting at v1.7.5-rc0~29^2 until v1.7.5-rc3~2 (Revert
"run-command: prettify -D_FORTIFY_SOURCE workaround", 2011-04-18)
fixed it, the run_command facility would write a truncated error
message when the command is present but cannot be executed for some
other reason.  For example, if I add a 'hello' command to git:

	$ echo 'echo hello' >git-hello
	$ chmod +x git-hello
	$ PATH=.:$PATH git hello
	hello

and make it non-executable, this is what I normally get:

	$ chmod -x git-hello
	$ git hello
	fatal: cannot exec 'git-hello': Permission denied

But with the problematic versions, we get disturbing output:

	$ PATH=.:$PATH git hello
	fatal: $

Add some tests to make sure it doesn't happen again.

The hello-script used in these tests uses cat instead of echo because
on Windows the bash spawned by git converts LF to CRLF in text written
by echo while the bash running tests does not, causing the test to
fail if "echo" is used.  Thanks to Hannes for noticing.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Improved-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t0061-run-command.sh |   23 +++++++++++++++++++++++
 test-run-command.c     |    2 ++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 10b26e4..8d4938f 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -7,8 +7,31 @@ test_description='Test run command'
 
 . ./test-lib.sh
 
+cat >hello-script <<-EOF
+	#!$SHELL_PATH
+	cat hello-script
+EOF
+>empty
+
 test_expect_success 'start_command reports ENOENT' '
 	test-run-command start-command-ENOENT ./does-not-exist
 '
 
+test_expect_success 'run_command can run a command' '
+	cat hello-script >hello.sh &&
+	chmod +x hello.sh &&
+	test-run-command run-command ./hello.sh >actual 2>err &&
+
+	test_cmp hello-script actual &&
+	test_cmp empty err
+'
+
+test_expect_success POSIXPERM 'run_command reports EACCES' '
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
