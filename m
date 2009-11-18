From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v4 01/12] Fix memory leak in helper method for disconnect
Date: Wed, 18 Nov 2009 02:42:21 +0100
Message-ID: <1258508552-20752-2-git-send-email-srabbelier@gmail.com>
References: <1258508552-20752-1-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 02:43:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAZa3-0000gW-RY
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 02:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756751AbZKRBnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 20:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756721AbZKRBnY
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 20:43:24 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:60684 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756672AbZKRBnW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 20:43:22 -0500
Received: by bwz27 with SMTP id 27so622806bwz.21
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 17:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ciTx1o+puFmB2FIZielXZ0jXi9ZjRufimTQUSxqcnDk=;
        b=YmV7i0i5qAp+VafusC2mEQqYv6qqmVAyCaF0/fddRe2BCG0K1dlILSCLUIMr9EYaOj
         CKw/mw6Q2X3e+CZov3hGqRR1/vomXqRqaTr55zDqa0JTAh/f0/m9AKFCBBZokunKZr/w
         JkStbBUIJjn/zn5iM9Pzhqfs9iHdDCbJf3fk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cUsANbaTPInwG+rM0TAFl3l5LvKlRX0P36dRPaAEUoG8pOoc5qyFW6zbnQZFSuY9TG
         WXSqCH+xEQHWTKm9/3Nmwylmv6OpIfUd1gDc1yaYTN/Ur5Q933E/ulp4+5Uq6uldR/Qx
         0dHdBzMTFimO3L+xYrsVnbGeKrIBXcOM+Cduo=
Received: by 10.216.89.5 with SMTP id b5mr50108wef.143.1258508607803;
        Tue, 17 Nov 2009 17:43:27 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 28sm2372670eye.3.2009.11.17.17.43.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 17:43:27 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
In-Reply-To: <1258508552-20752-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133124>

From: Daniel Barkalow <barkalow@iabervon.org>

Since some cases may need to disconnect from the helper and reconnect,
wrap the function that just disconnects in a function that also frees
transport->data.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

	Unchanged.

 transport-helper.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index f57e84c..e24fcbb 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -67,6 +67,13 @@ static int disconnect_helper(struct transport *transport)
 	return 0;
 }
 
+static int release_helper(struct transport *transport)
+{
+	disconnect_helper(transport);
+	free(transport->data);
+	return 0;
+}
+
 static int fetch_with_fetch(struct transport *transport,
 			    int nr_heads, const struct ref **to_fetch)
 {
@@ -163,6 +170,6 @@ int transport_helper_init(struct transport *transport, const char *name)
 	transport->data = data;
 	transport->get_refs_list = get_refs_list;
 	transport->fetch = fetch;
-	transport->disconnect = disconnect_helper;
+	transport->disconnect = release_helper;
 	return 0;
 }
-- 
1.6.5.3.164.g07b0c
