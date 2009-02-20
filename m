From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 next 1/4] format-patch: threading test reactivation
Date: Fri, 20 Feb 2009 20:55:37 +0100
Message-ID: <47e4d803ed1d784e9911a90e1ca052573f77b9d6.1235158956.git.trast@student.ethz.ch>
References: <alpine.LNX.1.00.0902191734110.19665@iabervon.org> <cover.1235158956.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 20:57:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LabV3-0006tb-D0
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 20:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284AbZBTTz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 14:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753841AbZBTTzz
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 14:55:55 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:28518 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791AbZBTTzx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 14:55:53 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Feb 2009 20:55:52 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Feb 2009 20:55:51 +0100
X-Mailer: git-send-email 1.6.2.rc1.310.ga3b4a
In-Reply-To: <cover.1235158956.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 20 Feb 2009 19:55:51.0756 (UTC) FILETIME=[3BAFD8C0:01C99395]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110883>

t4014 tests format-patch --thread since 7d812145, but the tests were
ineffective right from the start at least for bash and dash.  The
loops of the form

  for ...; do something || break; done

introduced by 7d812145 and 5d02294 always exit with status 0, even if
'something' failed, because 'break' returns 0 unless there was no loop
to break.

We take a rather different approach that uses an admittedly heinous
inline Perl script to mangle all interesting information into a format
that is invariant between runs.  We can then test the full patch
sequence in one go (with --stdout), doing away with the loop problem.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Same as v1.


 t/t4014-format-patch.sh |  144 ++++++++++++++++++++++++++++++++++-------------
 1 files changed, 104 insertions(+), 40 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index f045898..345e6de 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -138,56 +138,120 @@ test_expect_success 'multiple files' '
 	ls patches/0001-Side-changes-1.patch patches/0002-Side-changes-2.patch patches/0003-Side-changes-3-with-n-backslash-n-in-it.patch
 '
 
-test_expect_success 'thread' '
+check_threading () {
+	expect="$1" &&
+	shift &&
+	(git format-patch --stdout "$@"; echo $? > status.out) |
+	# Prints everything between the Message-ID and In-Reply-To,
+	# and replaces all Message-ID-lookalikes by a sequence number
+	perl -ne '
+		if (/^(message-id|references|in-reply-to)/i) {
+			$printing = 1;
+		} elsif (/^\S/) {
+			$printing = 0;
+		}
+		if ($printing) {
+			$h{$1}=$i++ if (/<([^>]+)>/ and !exists $h{$1});
+			for $k (keys %h) {s/$k/$h{$k}/};
+			print;
+		}
+		print "---\n" if /^From /i;
+	' > actual &&
+	test 0 = "$(cat status.out)" &&
+	test_cmp "$expect" actual
+}
+
+cat >> expect.no-threading <<EOF
+---
+---
+---
+EOF
 
-	rm -rf patches/ &&
+test_expect_success 'no threading' '
 	git checkout side &&
-	git format-patch --thread -o patches/ master &&
-	FIRST_MID=$(grep "Message-Id:" patches/0001-* | sed "s/^[^<]*\(<[^>]*>\).*$/\1/") &&
-	for i in patches/0002-* patches/0003-*
-	do
-	  grep "References: $FIRST_MID" $i &&
-	  grep "In-Reply-To: $FIRST_MID" $i || break
-	done
+	check_threading expect.no-threading master
 '
 
-test_expect_success 'thread in-reply-to' '
+cat > expect.thread <<EOF
+---
+Message-Id: <0>
+---
+Message-Id: <1>
+In-Reply-To: <0>
+References: <0>
+---
+Message-Id: <2>
+In-Reply-To: <0>
+References: <0>
+EOF
 
-	rm -rf patches/ &&
-	git checkout side &&
-	git format-patch --in-reply-to="<test.message>" --thread -o patches/ master &&
-	FIRST_MID="<test.message>" &&
-	for i in patches/*
-	do
-	  grep "References: $FIRST_MID" $i &&
-	  grep "In-Reply-To: $FIRST_MID" $i || break
-	done
+test_expect_success 'thread' '
+	check_threading expect.thread --thread master
 '
 
-test_expect_success 'thread cover-letter' '
+cat > expect.in-reply-to <<EOF
+---
+Message-Id: <0>
+In-Reply-To: <1>
+References: <1>
+---
+Message-Id: <2>
+In-Reply-To: <1>
+References: <1>
+---
+Message-Id: <3>
+In-Reply-To: <1>
+References: <1>
+EOF
 
-	rm -rf patches/ &&
-	git checkout side &&
-	git format-patch --cover-letter --thread -o patches/ master &&
-	FIRST_MID=$(grep "Message-Id:" patches/0000-* | sed "s/^[^<]*\(<[^>]*>\).*$/\1/") &&
-	for i in patches/0001-* patches/0002-* patches/0003-*
-	do
-	  grep "References: $FIRST_MID" $i &&
-	  grep "In-Reply-To: $FIRST_MID" $i || break
-	done
+test_expect_success 'thread in-reply-to' '
+	check_threading expect.in-reply-to --in-reply-to="<test.message>" \
+		--thread master
 '
 
-test_expect_success 'thread cover-letter in-reply-to' '
+cat > expect.cover-letter <<EOF
+---
+Message-Id: <0>
+---
+Message-Id: <1>
+In-Reply-To: <0>
+References: <0>
+---
+Message-Id: <2>
+In-Reply-To: <0>
+References: <0>
+---
+Message-Id: <3>
+In-Reply-To: <0>
+References: <0>
+EOF
 
-	rm -rf patches/ &&
-	git checkout side &&
-	git format-patch --cover-letter --in-reply-to="<test.message>" --thread -o patches/ master &&
-	FIRST_MID="<test.message>" &&
-	for i in patches/*
-	do
-	  grep "References: $FIRST_MID" $i &&
-	  grep "In-Reply-To: $FIRST_MID" $i || break
-	done
+test_expect_success 'thread cover-letter' '
+	check_threading expect.cover-letter --cover-letter --thread master
+'
+
+cat > expect.cl-irt <<EOF
+---
+Message-Id: <0>
+In-Reply-To: <1>
+References: <1>
+---
+Message-Id: <2>
+In-Reply-To: <1>
+References: <1>
+---
+Message-Id: <3>
+In-Reply-To: <1>
+References: <1>
+---
+Message-Id: <4>
+In-Reply-To: <1>
+References: <1>
+EOF
+
+test_expect_success 'thread cover-letter in-reply-to' '
+	check_threading expect.cl-irt --cover-letter \
+		--in-reply-to="<test.message>" --thread master
 '
 
 test_expect_success 'excessive subject' '
-- 
1.6.2.rc1.310.ga3b4a
