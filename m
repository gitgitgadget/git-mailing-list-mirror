From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 03/17] Define SNPRINTF_SIZE_CORR=1 for Microsoft Visual C++
Date: Mon, 14 Sep 2009 15:11:16 +0200
Message-ID: <e2eff51e8d956e7cf854bea9fb9f10491f6d6543.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
 <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com>
 <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Mon Sep 14 15:12:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBMM-0004Gq-EX
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 15:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384AbZINNMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 09:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755381AbZINNMd
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 09:12:33 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:64577 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260AbZINNMa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 09:12:30 -0400
Received: by ey-out-2122.google.com with SMTP id 4so419999eyf.5
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=X2GFeF0cAbAEV69LRXGyB7TsJv38u0QxST1svSh9bvk=;
        b=VMtwpxphueIQrIQqjHqM9pydmsMRokxVFNYyQdKWdprSgEJnEvdafvfYgKzoETJiqU
         1n6oO4tonIsTo54OknItTkJKKUcQbB0D0DQWFOipLs7a/U+oZRiIvQSl1O5c4CVA4n7f
         9cj+UCTSTVrw8xqNngByk5mbw39WRCSvX13Pw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FVKFaSZFTrCWioCq55T1A56Xsx5IjwP3rfU3BeiESAP+1CVkCd/WfVBAPh784AXGLY
         4nEagG/4MthVOlogQO4du0Mq+kMT+acBXg0YEhwb4j/kBwxgls/tiqZMc5nhOlSd3Oez
         tY6Yn1ZfzAJrx5jNlMK9kVcab85OTswEgqmUA=
Received: by 10.211.159.19 with SMTP id l19mr6895551ebo.83.1252933953566;
        Mon, 14 Sep 2009 06:12:33 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm2690277eyz.2.2009.09.14.06.12.32
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Sep 2009 06:12:32 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com>
In-Reply-To: <cover.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128459>

From: Frank Li <lznuaa@gmail.com>

Microsoft's vsnprintf function does not add NUL at the end
of the buffer, if the result fits the buffer size exactly.

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/snprintf.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/compat/snprintf.c b/compat/snprintf.c
index 4d07087..e1e0e75 100644
--- a/compat/snprintf.c
+++ b/compat/snprintf.c
@@ -2,12 +2,14 @@
 
 /*
  * The size parameter specifies the available space, i.e. includes
- * the trailing NUL byte; but Windows's vsnprintf expects the
- * number of characters to write, and does not necessarily write the
- * trailing NUL.
+ * the trailing NUL byte; but Windows's vsnprintf uses the entire
+ * buffer and avoids the trailing NUL, should the buffer be exactly
+ * big enough for the result. Defining SNPRINTF_SIZE_CORR to 1 will
+ * therefore remove 1 byte from the reported buffer size, so we
+ * always have room for a trailing NUL byte.
  */
 #ifndef SNPRINTF_SIZE_CORR
-#if defined(__MINGW32__) && defined(__GNUC__) && __GNUC__ < 4
+#if defined(WIN32) && (!defined(__GNUC__) || __GNUC__ < 4)
 #define SNPRINTF_SIZE_CORR 1
 #else
 #define SNPRINTF_SIZE_CORR 0
-- 
1.6.2.1.418.g33d56.dirty
