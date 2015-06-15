From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 5/5] am: teach mercurial patch parser how to read from stdin
Date: Mon, 15 Jun 2015 19:08:13 +0800
Message-ID: <1434366493-27155-6-git-send-email-pyokagan@gmail.com>
References: <1434366493-27155-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 13:09:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4SGI-0002jV-Ah
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 13:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbbFOLJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 07:09:00 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33630 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbbFOLI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 07:08:57 -0400
Received: by pdjn11 with SMTP id n11so70813534pdj.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 04:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6VDgSjuJTYGwA9PDjNgtvPPs0/6QXXfIcp0gov/au9g=;
        b=SRWdTVDMk/AegrKd49lOX6qJl+EcyblQwGnaE8zNaBoWq3esvA5qK3Oq20FZlEybAX
         BYXaDeDP9rZtbKx4TEmuADPKxLZlJkofNbY37DDAkq+F4EVXA62ECJyyZYrPydHHdjVG
         Jo0lxeWbzgnUuWCD3KGOuCfez7LxT0j5a6fqufBGlliGTjjODXl6PuBN3TEpwtdSq6s5
         Vt2yulnexoRgQ4ArUvqmAp2ATeLR21iBSLnrQCemnVpK/t8+4ZdhRP8LmDN+iR5o9IC8
         lKbLeVp5ttkWlnS+H/0ygA1MNWQpQXciEI0SVF9T+V0n3S9WPFGXdpA/MIoYFhWx+x+9
         HKMw==
X-Received: by 10.66.218.6 with SMTP id pc6mr46905317pac.20.1434366536474;
        Mon, 15 Jun 2015 04:08:56 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id jt2sm11886795pbc.21.2015.06.15.04.08.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Jun 2015 04:08:55 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434366493-27155-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271676>

git-mailsplit, which splits mbox patches, will read the patch from stdin
when the filename is "-" or there are no files listed on the
command-line.

To be consistent with this behavior, teach the mercurial patch parser to
read from stdin if the filename is "-" or no files are listed on the
command-line.

Based-on-patch-by: Chris Packham <judge.packham@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v2
    
    * Pass the filename directly to perl instead.

 git-am.sh     |  3 ++-
 t/t4150-am.sh | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index f0b6c16..a8d33ef 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -327,6 +327,7 @@ split_patches () {
 		;;
 	hg)
 		this=0
+		test 0 -eq "$#" && set -- -
 		for hg in "$@"
 		do
 			this=$(( $this + 1 ))
@@ -353,7 +354,7 @@ split_patches () {
 					print "\n", $_ ;
 					$subject = 1;
 				}
-			' <"$hg" >"$dotest/$msgnum" || clean_abort
+			' -- "$hg" >"$dotest/$msgnum" || clean_abort
 		done
 		echo "$this" >"$dotest/last"
 		this=
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 4beb4b3..3ebafd9 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -259,6 +259,16 @@ test_expect_success 'am applies hg patch' '
 	test_cmp_rev second^ HEAD^
 '
 
+test_expect_success 'am --patch-format=hg applies hg patch' '
+	rm -fr .git/rebase-apply &&
+	git checkout -f first &&
+	git am --patch-format=hg <patch1-hg.eml &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code second &&
+	test_cmp_rev second HEAD &&
+	test_cmp_rev second^ HEAD^
+'
+
 test_expect_success 'setup: new author and committer' '
 	GIT_AUTHOR_NAME="Another Thor" &&
 	GIT_AUTHOR_EMAIL="a.thor@example.com" &&
-- 
2.1.4
