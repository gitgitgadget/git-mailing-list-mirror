From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH] builtin/apply: free patch when parse_chunk() fails
Date: Wed, 16 Mar 2016 20:35:11 +0100
Message-ID: <1458156911-26649-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 20:38:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agHHM-00009c-5O
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 20:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581AbcCPTio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 15:38:44 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37938 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515AbcCPTin (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 15:38:43 -0400
Received: by mail-wm0-f46.google.com with SMTP id l68so87484632wml.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0SM4Ruvx0bMtyodK+qfa9Xj8c9jOpTMBVZYwz8nzoVc=;
        b=Jl+3aVcEssgIQKVElsIxt1Dm0qc0DPgAv+LdDcDcsko0YgPcLUJMU+bwscwCrUd0E7
         hZ5YdiOTv6xRWqFJe2UOJC6KEXLYK/yJANm3vZLXnvLqgB/cbB7yuBOM12GPfdAODBwM
         WSz/Ocul2hhd/NafllI9ETcOwARuzFnECQum/maDy4rZRJRPPsREOHmbKOqgCjATcH3M
         /BpDCqzd3jPv7SE67vNfbxZbf+RvX4z1umBv8Lg8EfxhyfrNmIdaYx2ruPckcvpDgaEe
         P60F++oT05+oU4BsApsxvOisunh4nP/bJY1JuNbJmsPheXhnJKgwlztgSnawMD7JQ7Fy
         R9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0SM4Ruvx0bMtyodK+qfa9Xj8c9jOpTMBVZYwz8nzoVc=;
        b=NT4TD3lUbFIVT+fVQmVqZIHesiEQPSCKeXelKbIn2zNRcCCpgRSvJRNbFlG9Jghrjm
         amIuC6nQPqwp+M0bVS48oKO+4HL7BruyasGZ4wUMXpNMSL78qVeyMNKsvAssc1M6tgRb
         f2f+GF4YYF/jQqyay0r9xcG7wwWA6N4TFrqlzTXlQjiUdi5cHnvBrRQpeNvBUHK1npIN
         deSHg2D9xYYDYgnI8AuxWeGD027+eSg/Ft8/uOIznhf1Pu6lDOIGKY1lGtYcSo4CcDK0
         KP5IlDe+VH3bByT9E7YvriaGwPfXIxzGjFDVRoyZ7Zp8tIOEDItQZoCRTySo3KxpsyTJ
         fWLg==
X-Gm-Message-State: AD7BkJJL8s1ygytpmoC3YhE7GmNP3g5l5HN4ZMiOjCgEESZDUPPTPlxOPvzLA6tl9Qukfg==
X-Received: by 10.28.184.18 with SMTP id i18mr30446522wmf.96.1458157121826;
        Wed, 16 Mar 2016 12:38:41 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id x203sm4847984wmg.23.2016.03.16.12.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 12:38:41 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc2.54.g810e8ee
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289023>

When parse_chunk() fails it can return -1, for example
when find_header() doesn't find a patch header.

In this case it's better in apply_patch() to free the
"struct patch" that we just allocated instead of
leaking it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 42c610e..bf78282 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4373,8 +4373,10 @@ static int apply_patch(int fd, const char *filename, int options)
 		patch->inaccurate_eof = !!(options & INACCURATE_EOF);
 		patch->recount =  !!(options & RECOUNT);
 		nr = parse_chunk(buf.buf + offset, buf.len - offset, patch);
-		if (nr < 0)
+		if (nr < 0) {
+			free_patch(patch);
 			break;
+		}
 		if (apply_in_reverse)
 			reverse_patches(patch);
 		if (use_patch(patch)) {
-- 
2.8.0.rc2.54.g810e8ee
