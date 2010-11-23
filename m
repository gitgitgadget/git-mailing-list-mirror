From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2] format-patch: page output with --stdout
Date: Tue, 23 Nov 2010 11:16:30 +0800
Message-ID: <1290482190-5932-1-git-send-email-rctay89@gmail.com>
References: <1290229542-3116-1-git-send-email-rctay89@gmail.com> <20101122181501.GF2084@burratino>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 23 04:17:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKjNS-0001gT-T5
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 04:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733Ab0KWDRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 22:17:00 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43501 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab0KWDQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 22:16:59 -0500
Received: by gyb11 with SMTP id 11so1808486gyb.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 19:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xhAGWT98kBKfbRmwnHTA9WcmPksoR2zpcacm5VN/gFA=;
        b=q0/gC/6mgNuIWEUQW8+eHcMHVV7yRVsv8nBqDMQi27lslpcbiZs13iPnQSXTCNvZR/
         Ph1z3/on89pKpcXgiR9fLIGcgUPsETnNBEbYWqSsWPWY4Ie/3AjHMiwzXjfUF0cdlbeL
         UYo0IDGzIJqmcJJvpGC4YiWN1GTfp2sSRzHuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iDIwMJqItn9RR5owdhFa1A8lqvKHZKjqsTn4FWlNd9m0AAnhoYMwagwUu0Sntxgs1S
         Fq7QQ5dRPPJ2sqSsOs4YMyl/EJzo/A+iFbveiYy6Q3zueg3ipj9/usAD4L4oNPkVVVk1
         qAJqEm8hC4VvRMa1CwGwK/smWxCmOy2wnCDUs=
Received: by 10.150.143.2 with SMTP id q2mr10862882ybd.46.1290482218589;
        Mon, 22 Nov 2010 19:16:58 -0800 (PST)
Received: from localhost.localdomain (cm69.zeta153.maxonline.com.sg [116.87.153.69])
        by mx.google.com with ESMTPS id r6sm17087yba.23.2010.11.22.19.16.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Nov 2010 19:16:57 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <20101122181501.GF2084@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161927>

Pass output through the pager if format-patch is run with --stdout. This
saves the user the trouble of running git with '-p' or piping through a
pager.

setup_pager() already checks if stdout is a tty, so we don't have to
worry about behaviour if the user redirects/pipes stdout. Paging can
also be disabled with the config

  [pager]
      format-patch = false

Add tests to check for these behaviour.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Thanks for the tests, Johnathan.

 builtin/log.c           |    2 ++
 t/t4014-format-patch.sh |   23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index d0297a1..c631950 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1159,6 +1159,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 	if (!use_stdout)
 		output_directory = set_outdir(prefix, output_directory);
+	else
+		setup_pager();
 
 	if (output_directory) {
 		if (use_stdout)
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 07bf6eb..027c13d 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -6,6 +6,7 @@
 test_description='various format-patch tests'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 test_expect_success setup '
 
@@ -686,4 +687,26 @@ test_expect_success 'format-patch --signature="" supresses signatures' '
 	! grep "^-- \$" output
 '
 
+test_expect_success TTY 'format-patch --stdout paginates' '
+	rm -f pager_used &&
+	(
+		GIT_PAGER="wc >pager_used" &&
+		export GIT_PAGER &&
+		test_terminal git format-patch --stdout --all
+	) &&
+	test_path_is_file pager_used
+'
+
+ test_expect_success TTY 'format-patch --stdout pagination can be disabled' '
+	rm -f pager_used &&
+	(
+		GIT_PAGER="wc >pager_used" &&
+		export GIT_PAGER &&
+		test_terminal git --no-pager format-patch --stdout --all &&
+		test_terminal git -c "pager.format-patch=false" format-patch --stdout --all
+	) &&
+	test_path_is_missing pager_used &&
+	test_path_is_missing .git/pager_used
+'
+
 test_done
-- 
1.7.3.2.487.gd5344.dirty
