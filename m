From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/5] refactor userdiff textconv code
Date: Fri, 24 Oct 2008 09:15:54 +0200
Message-ID: <4901762A.3090003@viscovery.net>
References: <20081024024631.GA20365@coredump.intra.peff.net> <20081024025330.GC2831@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 24 09:17:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtGvR-0000wK-OV
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 09:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959AbYJXHQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 03:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756075AbYJXHQB
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 03:16:01 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:64223 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756041AbYJXHQA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 03:16:00 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KtIlm-0001N0-3b; Fri, 24 Oct 2008 11:15:48 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E9CE44FB; Fri, 24 Oct 2008 09:15:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20081024025330.GC2831@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99016>

Jeff King schrieb:
> This patch moves the text conversion to a
> diff_filespec_textconv function; this function can be called
> to insert the text-converted contents of the file into the
> filespec. These contents will survive through any
> diff_populate_filespec calls, meaning that it is safe to
> pass the resulting filespec to other diff functions which
> will look at the content.

What do we do when symlinks are involved? Pilot error? Or should we
exclude them from textconv (and diff.*.command, for that matter)
at all times? See a test case below.

> Also, I'm happy to hear comments on which functionality should get
> text-converted. I think I like seeing the --stat report the binary
> changes.

At this time I also think that it is enough to apply textconv only
to generate diffs.

Test case follows:
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index e456746..dab4338 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -19,6 +19,18 @@ cat >expect.text <<'EOF'
 +1
 EOF

+cat >expect.typechange <<'EOF'
+Binary files a/file and /dev/null differ
+diff --git a/file b/file
+new file mode 120000
+index ad8b3d2..67be421
+--- /dev/null
++++ b/file
+@@ -0,0 +1 @@
++frotz
+\ No newline at end of file
+EOF
+
 cat >hexdump <<'EOF'
 #!/bin/sh
 perl -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' "$1"
@@ -75,4 +87,16 @@ test_expect_success 'format-patch produces binary' '
 	test_cmp expect.binary actual
 '

+# make a symlink the hard way that works on symlink-challenged file systems
+test_expect_failure 'textconv does not kick in if there is a type change' '
+	echo -n frotz > file &&
+	git add file &&
+	git ls-files -s | sed -e s/100644/120000/ |
+		git update-index --index-info &&
+	git commit -m typechange &&
+	git show >diff &&
+	find_diff <diff >actual &&
+	test_cmp expect.typechange actual
+'
+
 test_done
