From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] ewah/bitmap: silence warning about MASK macro redefinition
Date: Tue,  2 Jun 2015 17:47:55 -0400
Message-ID: <1433281675-24893-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 23:52:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzu2v-0005P5-6e
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 23:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbbFBVs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 17:48:26 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36559 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbbFBVsY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 17:48:24 -0400
Received: by igbpi8 with SMTP id pi8so97469457igb.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 14:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=kVcJHnOZHQypAMKQTbI6LYXJRTMTemZjnqbs9Qdnj/Y=;
        b=pu2VZjGq+SS/AUTb1c5b+O4MeNjOoFMiz6fDMHRPLZYrgPEHb2hmVaPO+HbHeM8dWu
         NAqfX0yDqavFekndH18OWI/YKDt8/7UaqlG3RHuQJ7g/RuG80mY9SdVAQ6ADBm7rpJX7
         AfzM7n79n1MOvWAcC47Zx2U96Ah9f39CzNHVzPDIgCon5nvo27v7A/cDzvKSK7US0Du4
         5mqj44TRJbhrXIlPHeHbcVDBcJP714BcQ7W3aq9Z5x3mVIx409Y//5uGlL2MxpGLk/Ds
         8JECfy0xUvaVoTCV68FjSltLgHZURa47z4lz8D8Z8FPWAIKI7QMsbz1ejuUnjzJ0wMvT
         P30A==
X-Received: by 10.50.110.104 with SMTP id hz8mr22748697igb.38.1433281703861;
        Tue, 02 Jun 2015 14:48:23 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id a139sm13368724ioa.14.2015.06.02.14.48.23
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 14:48:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.598.gb4379f4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270610>

On PowerPC Mac OS X (10.5.8 "Leopard" with Xcode 3.1), system header
/usr/include/ppc/param.h[1] pollutes the preprocessor namespace with a
macro generically named MASK. This conflicts with the same-named macro
in ewah/bitmap.c.

[1]: Included indirectly via:
     git-compat-util.h ->
     sys/sysctl.h ->
     sys/ucred.h ->
     sys/param.h ->
     machine/param.h ->
     ppc/param.h

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

The alternative is to rename MASK in ewah/bitmap.c to something less
generic, resulting in a slightly more noisy patch. I chose the #undef
approach since it's a relatively common idiom to #undef a macro before
#defining it in order to avoid exactly this sort of redefinition
problem.

 ewah/bitmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 710e58c..b31cf75 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -20,6 +20,8 @@
 #include "git-compat-util.h"
 #include "ewok.h"
 
+#undef MASK
+#undef BLOCK
 #define MASK(x) ((eword_t)1 << (x % BITS_IN_WORD))
 #define BLOCK(x) (x / BITS_IN_WORD)
 
-- 
2.4.2.598.gb4379f4
