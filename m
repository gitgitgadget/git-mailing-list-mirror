From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 12/15] builtin/merge-base: fix memleak
Date: Fri, 20 Mar 2015 17:28:09 -0700
Message-ID: <1426897692-18322-13-git-send-email-sbeller@google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 21 01:28:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ7HV-0001vV-Tw
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 01:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbbCUA2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 20:28:33 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:32779 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbbCUA2b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 20:28:31 -0400
Received: by ignm3 with SMTP id m3so1309626ign.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 17:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=owdk6Ua1xWvTV90RqZxX9d4C9AKtlJJoq/pXsXTCI4w=;
        b=T0871C+obm8WQ54ui2I9jq/cr1teWcLJFIociLDpPkzQKX+rTnB4ILVuPC+RCChVz+
         sY1txMYeVctozm/bF7241O/ezhJ1pxIgc63qGrT3ZErxz9ZwQFFLZR7bgfg3lqDH3rmW
         GWz7VTVoGfWhqGBKbEwMDtf/3HkxMZanm2T5HxshOHBuOfMOXcEkKCUDeSg40wl+cN1v
         MIuMiO0NMu7/jpSjNi5iQO9NrD774tSiCTa9ekyRqMY6+fEWm1RuGs9eoVJ/IVMGzNVM
         w1RH8dr7aVT6Odr83wfSioFvqTMvfNVoRBJnhCu0epWzvWRxel8XCBewWoWNPhiLduah
         GnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=owdk6Ua1xWvTV90RqZxX9d4C9AKtlJJoq/pXsXTCI4w=;
        b=k57OuJ7MEVTxl0LFBlmInEouynw7nRZ4CzRWQP0C4XZM0yBR+Y2jbPNVucAFnqjjsf
         YPXt+ROe6WGf71PzrKDYDCCmptnh/T8KHR7NH1T1x7wlOtKbrLl6n61glW+YroZ4PWGa
         C3g2PeIRm5vk477PpuiCo8Py5y2oEL2Ojuun6dTJtcVlxtSqaoCOlVNDR0kuhNgcPyI9
         NVCLA4VJMsm5d45pufRjOkg1UxSxVt9VATa5izVUWJq0NaPse+Hck+Les9X5ZRfETakW
         QEuWPMVbsgrrsYF0GQWAoUTyUNubr3gwYxyYpnywoMt/ZDtpS1iRwcCPvSjSDgTlMeVc
         ba/A==
X-Gm-Message-State: ALoCoQmsoUYnNfcqtK6ex7oMp55uJNgpmAZF+6iOfmS83oXWh/M9ACS/bQEzC9lygFtiwJcAebSr
X-Received: by 10.42.250.9 with SMTP id mm9mr7736947icb.56.1426897710679;
        Fri, 20 Mar 2015 17:28:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c4ad:7c66:d5e8:7112])
        by mx.google.com with ESMTPSA id s10sm194605igr.2.2015.03.20.17.28.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 17:28:30 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1426897692-18322-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265988>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    see discussion on previous patch.

 builtin/merge-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 08a8217..4a8ff02 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -22,6 +22,7 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 		result = result->next;
 	}
 
+	free(rev);
 	return 0;
 }
 
-- 
2.3.0.81.gc37f363
