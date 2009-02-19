From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/4] format-patch: threading test reactivation
Date: Thu, 19 Feb 2009 22:26:30 +0100
Message-ID: <f4556c46b8b74d12ccfd0dc5c13865c89062233a.1235078708.git.trast@student.ethz.ch>
References: <200902170027.09406.trast@student.ethz.ch> <cover.1235078708.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 22:28:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaGRK-0002DO-0R
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 22:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756239AbZBSV0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 16:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756134AbZBSV0r
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 16:26:47 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:21625 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756157AbZBSV0p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 16:26:45 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 22:26:43 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 22:26:42 +0100
X-Mailer: git-send-email 1.6.2.rc1.295.g1e29
In-Reply-To: <cover.1235078708.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 19 Feb 2009 21:26:42.0732 (UTC) FILETIME=[C24F06C0:01C992D8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110757>

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
1.6.2.rc1.295.g1e29
