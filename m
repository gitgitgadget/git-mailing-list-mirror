From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 3/3] fast-import: test the new option command
Date: Thu, 13 Aug 2009 09:51:17 -0700
Message-ID: <1250182277-17762-3-git-send-email-srabbelier@gmail.com>
References: <1250182277-17762-1-git-send-email-srabbelier@gmail.com>
 <1250182277-17762-2-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 18:57:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbdcM-0004Ss-1y
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 18:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbZHMQ5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 12:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbZHMQ5Z
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 12:57:25 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:46245 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbZHMQ5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 12:57:24 -0400
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Aug 2009 12:57:24 EDT
Received: by pxi34 with SMTP id 34so71533pxi.4
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 09:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hZVZFlLlWXOfI3Whv/3zgySKW8D8OQk0zm3ObmpoPF4=;
        b=CuYtPssyEAZ0azI9Ty3hAf1hVB9auJujgyeV7DSp5DgLVaI+pZGp8pp2ohLhWMYhMK
         /j7/hCgm4//19VkBNtGeWO7J6PS80UnKYOxFA67w9E2ZLeGXc5d7MAJJAVDwNalb8r+V
         kAZSm1u3xJd4M4qNypPF6uL/btEht+/MxewSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TY+/DqkbWuwu5ZF7grk2v/Wp5UecjWOOo9bfgYOWt6pdelKfhGH2jNI1v8myvmVSlJ
         D3ADRtDrzH9UyPVgZaSQjuuoxAEEX2UKKW3208cxwPfYGHcF3q8UewVUCNoQw/5MZR9L
         nfqs6r1jhove1LXbZpSop2UU43wfYPTaNI7C0=
Received: by 10.140.208.16 with SMTP id f16mr586743rvg.131.1250182295620;
        Thu, 13 Aug 2009 09:51:35 -0700 (PDT)
Received: from localhost.localdomain ([216.239.45.19])
        by mx.google.com with ESMTPS id b39sm795112rvf.8.2009.08.13.09.51.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Aug 2009 09:51:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1250182277-17762-2-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125836>

Test two options (quiet and export-marks) and verify that the
commandline options override these.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

    Added test to ensure that commandline options override options
    from the stream. Also removed unneeded 2> output in second test.

 t/t9300-fast-import.sh |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 821be7c..f085f1f 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1088,4 +1088,42 @@ INPUT_END
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
 test_done
-- 
1.6.4.16.g72c66.dirty
