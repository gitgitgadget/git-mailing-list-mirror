From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] Check recursive submodule update to have correct path from subdirectory
Date: Fri, 26 Feb 2016 12:51:51 -0800
Message-ID: <1456519912-10641-2-git-send-email-sbeller@google.com>
References: <1456519912-10641-1-git-send-email-sbeller@google.com>
Cc: jacob.e.keller@intel.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 21:52:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZPMo-0004VA-CC
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 21:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099AbcBZUv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 15:51:59 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33328 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946AbcBZUv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 15:51:58 -0500
Received: by mail-pa0-f50.google.com with SMTP id fl4so56543001pad.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 12:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/xDYe5IiObgYOhfWu2Z7KV9Djp4A3eMKN7s6stdj6HY=;
        b=FstBICXcpmrJ6Uo9laSxyy7el3eH2vh4ohTOwmkY36mIdcwCLqdC73hk/1LY0YHCSL
         N4GZmJ8ak1xqlvh85cQFu2P8MRRz0u0SdPV1BhkdtjkTCyyLF3WnxaiUqBBpBz+207A1
         64YFC9t1skHjd83XBi9t6VbhYeNjNJJcmW/SWrvUfVbeVqM1eK5lFF+/7RgTO7FoTVSL
         JkcSP7HjPOXSQyXsikLpPakaOWBIQcj9FC3p6FMxq0bJ4rv0Jnn5M5GQwGeGuFYJ26f1
         wy0e2qc7I8b8hL4rRZl61XTEbR6pcvjp0DzrhaYhfk2HqFD+nV6KQ7bzUysBnBNt7458
         nP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/xDYe5IiObgYOhfWu2Z7KV9Djp4A3eMKN7s6stdj6HY=;
        b=fHRPEPpLVA06Gczkp4hDVzYgB7wd/4b20v9VeDbqyqm0wMUkxvlgWnrStfVx+knQS4
         o12hHAgDmeV9WFhwVpv9U7J05QFuz1bQ2qz+mVcPkZuACx5HCCHQraGiXzbHEjQnBebt
         5k4tzAcW3zW0mJ9fMM5LtwFrjboNHqU3oO+MIh8y2sM0cX5DjRRQ8FpWn7y9bZB1DkwY
         VlrzSoUIvI6+7naIj76HPdglETqGhFhTrKLyIS9h3K7iGnjYbfUBPSLH9opohfYTHD16
         CsGzlenUY6Re3nC0yaP0To8c+hAdklkuN2boJiIlmHee39FD5+HcNfTXIN11b9LOTCg8
         mo5Q==
X-Gm-Message-State: AD7BkJK9nk2wL6TWVOJ54nQayTfjYBiPIxJ0RUIV9dxDHVQS2eB1x+RMnP3f6FQrCeT3pZ8A
X-Received: by 10.66.139.234 with SMTP id rb10mr4936011pab.82.1456519917508;
        Fri, 26 Feb 2016 12:51:57 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a09f:64c6:9d8b:3a18])
        by smtp.gmail.com with ESMTPSA id 4sm7378970pft.44.2016.02.26.12.51.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 Feb 2016 12:51:56 -0800 (PST)
X-Mailer: git-send-email 2.7.2.368.g934fe14
In-Reply-To: <1456519912-10641-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287619>

A similar test exists for `submodule sync` to behave well when being in
an unrelated subdirectory and performing operations on submodules.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7406-submodule-update.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 68ea31d..628da7f 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -774,4 +774,16 @@ test_expect_success 'submodule update --recursive drops module name before recur
 	 test_i18ngrep "Submodule path .deeper/submodule/subsubmodule.: checked out" actual
 	)
 '
+
+test_expect_success 'submodule update --recursive works from subdirectory' '
+	(cd super2 &&
+	 (cd deeper/submodule/subsubmodule &&
+	  git checkout HEAD^
+	 ) &&
+	 mkdir untracked &&
+	 cd untracked &&
+	 git submodule update --recursive >actual &&
+	 test_i18ngrep "Submodule path .../deeper/submodule/subsubmodule.: checked out" actual
+	)
+'
 test_done
-- 
2.7.2.368.g934fe14
