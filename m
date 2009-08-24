From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v4 4/4] fast-import: test the new option command
Date: Mon, 24 Aug 2009 13:52:36 -0700
Message-ID: <1251147156-19279-5-git-send-email-srabbelier@gmail.com>
References: <1251147156-19279-1-git-send-email-srabbelier@gmail.com>
 <1251147156-19279-2-git-send-email-srabbelier@gmail.com>
 <1251147156-19279-3-git-send-email-srabbelier@gmail.com>
 <1251147156-19279-4-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 24 22:53:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfgXq-00068r-Gw
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 22:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbZHXUxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 16:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753484AbZHXUxD
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 16:53:03 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:61682 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbZHXUxB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 16:53:01 -0400
Received: by pxi34 with SMTP id 34so5359320pxi.4
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 13:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=S1Aq4Dv8FC61R/mN1HR31uIdwm7R00oKhiRG6e4NkeE=;
        b=j9wxqTE/RSc1qAceBozU+sm6y9vofOIN0mPj1ADPH1CSjubYwZFwaRGuZ6LsJzw2tp
         ovOfXmxKjlXHqWeR8tPrWr/IZJBvHKWcFEPm0LN75PgF1fuZFrhhXTCiKMtfrWlgtYYD
         Mv+zbDFhh6hh/IN0em45CBOqytj4AxZAvTAU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Szs614jhKhbo0wkMHmnVbRVYYW9f74tQe1Ozms8UsBWxl5OOlY3i97RPJggMNltmNZ
         OFAoR4LaX1v56RcbjsVjQWtbkCyLTolsFZp7aq5yr2a19ehTNIxR3UNbpmCFHxkIACEV
         MiY4umBW9D/9F6uFURrAmrzh09mzNboMp5EB4=
Received: by 10.114.162.32 with SMTP id k32mr6456390wae.196.1251147182756;
        Mon, 24 Aug 2009 13:53:02 -0700 (PDT)
Received: from localhost.localdomain ([216.239.45.19])
        by mx.google.com with ESMTPS id 20sm1023981pzk.5.2009.08.24.13.53.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 13:53:01 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1251147156-19279-4-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126967>

Test three options (quiet and import/export-marks) and verify that the
commandline options override these.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

    Unchanged from v3.

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
1.6.4.16.g72c66.dirty
