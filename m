From: David Turner <dturner@twopensource.com>
Subject: [PATCH] refs.c: handle REFNAME_REFSPEC_PATTERN at end of page
Date: Sat,  5 Jul 2014 12:00:59 -0700
Message-ID: <1404586859-24464-1-git-send-email-dturner@twitter.com>
References: <CAA787rnMonCuON+C0U5FDXKzjTBdpOusCpGLeWytDWaA1torEw@mail.gmail.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org,
	=?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Sat Jul 05 21:04:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3VG4-0002iv-R3
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jul 2014 21:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbaGETEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2014 15:04:20 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:53546 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbaGETEU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2014 15:04:20 -0400
Received: by mail-pd0-f170.google.com with SMTP id z10so3325266pdj.1
        for <git@vger.kernel.org>; Sat, 05 Jul 2014 12:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ign07nJRYZZktt5QKIQXICnIVKPzLCPo6Y/gw76UpQ=;
        b=iEC+hucmrcc4CXNFM/0CRd1KRog+Ja/1hARpGM/0agbZiHClBNBpTmSd/5whm3dZTT
         y4wkCyTjgoNz/uP42hmRM+LjOFcE0uj8HHusYDVXJg5vcE84kKbdsnVgipW50U1hPG36
         xVU+4KU5V+8Qcs0DIw0kLTd0APathjeQfURpdrRdsIrJHTsleaqwIuCk51zY8aZGvpqw
         BptkIpTnfqHtei9tWcxooDultr0r+dzgN07vq9aU+QcPLJxQwymO9x3KUPZ2tZQ9fgDk
         usYyRFrK8flvLUp/Z6SbDSrma8I65tWcTzj806ehc9QUQ5Y47j6/V5zOP0RJnHhhGXE9
         o0qQ==
X-Gm-Message-State: ALoCoQla/GAhmsGn1KIguildyxQ5FYGvweLrIvHY8bPLMZxNdwvre/LWLC61L5VujqgQ7R3aWJeW
X-Received: by 10.67.30.130 with SMTP id ke2mr18380225pad.44.1404587059424;
        Sat, 05 Jul 2014 12:04:19 -0700 (PDT)
Received: from stross.twitter.corp (50-206-59-106-static.hfc.comcastbusiness.net. [50.206.59.106])
        by mx.google.com with ESMTPSA id qf10sm47855863pbc.23.2014.07.05.12.04.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Jul 2014 12:04:18 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <CAA787rnMonCuON+C0U5FDXKzjTBdpOusCpGLeWytDWaA1torEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252919>

When a ref crosses a memory page boundary, we restart the parsing
at the beginning with the bytewise code.  Pass the original flags
to that code, rather than the current flags.

Signed-off-by: David Turner <dturner@twitter.com>
---
 refs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 20e2bf1..82e4842 100644
--- a/refs.c
+++ b/refs.c
@@ -153,6 +153,7 @@ int check_refname_format(const char *refname, int flags)
 	const __m128i tilde_lb = _mm_set1_epi8('~' - 1);
 
 	int component_count = 0;
+	int orig_flags = flags;
 
 	if (refname[0] == 0 || refname[0] == '/') {
 		/* entirely empty ref or initial ref component */
@@ -178,7 +179,7 @@ int check_refname_format(const char *refname, int flags)
 			 * End-of-page; fall back to slow method for
 			 * this entire ref.
 			 */
-			return check_refname_format_bytewise(refname, flags);
+			return check_refname_format_bytewise(refname, orig_flags);
 
 		tmp = _mm_loadu_si128((__m128i *)cp);
 		tmp1 = _mm_loadu_si128((__m128i *)(cp + 1));
-- 
2.0.0.390.gcb682f8
