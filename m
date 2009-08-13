From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 3/3] fast-import: test the new option command
Date: Thu, 13 Aug 2009 12:02:36 -0700
Message-ID: <1250190156-4752-4-git-send-email-srabbelier@gmail.com>
References: <1250190156-4752-1-git-send-email-srabbelier@gmail.com>
 <1250190156-4752-2-git-send-email-srabbelier@gmail.com>
 <1250190156-4752-3-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 21:03:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbfZt-0007Q3-52
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 21:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379AbZHMTDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 15:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755373AbZHMTC7
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 15:02:59 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:36825 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354AbZHMTC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 15:02:57 -0400
Received: by rv-out-0506.google.com with SMTP id f6so305427rvb.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 12:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Img2k8pnAPuztUsn+jy6Wi/gU3etmUtmZwzRRqMbv40=;
        b=mx/KYvYkwK93kljNs4dmhJNEpdNTBKrJCd4m06jfyfEIu5PYG9VdsxCuZ5wdoXwvsc
         LnPaUd5htfiaUBV2OpOOS6bjlqGA6EMfFH77m6WcRVgMrotc56DvOYsP3Qnim507QaXr
         imcNOupMEiiUA/q2GFQuHXi38sPXw50QQ9ZvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MksW3jQk3jzYx1g6MGJeTRxpRLnb8iMuiMcXvvRTpJl9bwwkr7R9KM9hHb1uu3Olhj
         uNJGtsEzZ6x9bHe1pBqlhXEuVMeke/t/0A0bM6HtNRZka6oa9NgGmNvNTdBl0/FbripS
         IAcyaCmMxn2okmAqbcqbYWI5ZjHPv1pXe7UCA=
Received: by 10.140.125.3 with SMTP id x3mr630826rvc.281.1250190178777;
        Thu, 13 Aug 2009 12:02:58 -0700 (PDT)
Received: from localhost.localdomain ([216.239.45.19])
        by mx.google.com with ESMTPS id f42sm3575374rvb.35.2009.08.13.12.02.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Aug 2009 12:02:57 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1250190156-4752-3-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125850>

Test three options (quiet and import/export-marks) and verify that the
commandline options override these.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Added some tests to verify that the marks file is handled
	properly as suggested by Dscho and Shawn.

 t/t9300-fast-import.sh |   58 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 821be7c..62369e5 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1088,4 +1088,62 @@ INPUT_END
 test_expect_success 'P: fail on blob mark in gitlink' '
     test_must_fail git fast-import <input'
 
+###
+### series Q (options)
+###
+
+cat >input << EOF
+option quiet
+blob
+data 3
+hi
+
+EOF
+
+touch empty
+
+test_expect_success 'Q: quiet option results in no stats being output' '
+    cat input | git fast-import 2> output &&
+    test_cmp empty output
+'
+
+cat >input << EOF
+option export-marks=git.marks
+blob
+mark :1
+data 3
+hi
+
+EOF
+
+test_expect_success \
+    'Q: export-marks option results in a marks file being created' \
+    'cat input | git fast-import &&
+    grep :1 git.marks'
+
+test_expect_success \
+    'Q: export-marks options can be overriden by commandline options' \
+    'cat input | git fast-import --export-marks=other.marks &&
+    grep :1 other.marks'
+
+cat >input << EOF
+option import-marks=marks.out
+option export-marks=marks.new
+EOF
+
+test_expect_success \
+    'Q: import to output marks works without any content' \
+    'cat input | git fast-import &&
+    test_cmp marks.out marks.new'
+
+cat >input <<EOF
+option import-marks=nonexistant.marks
+option export-marks=marks.new
+EOF
+
+test_expect_success \
+    'Q: import marks uses the commandline marks file when the stream specifies one' \
+    'cat input | git fast-import --import-marks=marks.out &&
+    test_cmp marks.out marks.new'
+
 test_done
-- 
1.6.4.122.g6ffd7
