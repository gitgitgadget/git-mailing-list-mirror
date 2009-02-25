From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 13/21] builtin-remote: remove unused code in get_ref_states
Date: Wed, 25 Feb 2009 03:32:20 -0500
Message-ID: <7d4f71366ccbea877d9904ba149b6521acb9cf7a.1235546708.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:35:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFF8-0000Xo-IA
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760011AbZBYIdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759883AbZBYIdM
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:33:12 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:53623 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759736AbZBYIdC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:33:02 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1285047yxm.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 00:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ZLOeOB9YlmPZGmD0dP9CJ6FvF0779i9DD4Nds3+fsIs=;
        b=aFZNoGbecP0wlQ+XmhROS899f5+VwzZ1jg1Sl90gur2C/vnqOX0a42RME1x3SY2hW6
         fufunh4OKINWTJOqKCw4xPVnknPZTj92XBXjn3nE8r5wCltMdW9kbsVpVcEwKa1bMybF
         dUCnwnjlYjm/wb6vlpPJWdlQMQpfZ7M1fG/mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Q4TjYX7Kh8H2UQTEGHMkWHkum24nXSI5ST+6+zxBSs20xJjs+ZQdT02YkgakGvysC4
         LA/X6bNa0huBqIrnnFc/PxClUSA55oLEyyoLCUIigBZojiWgI7ggM1DlQgF9nzD0xG7v
         Et1k8aoyoNhYcVarIVYCfvuwMKNWAkdrFN8eU=
Received: by 10.100.240.17 with SMTP id n17mr818376anh.137.1235550780527;
        Wed, 25 Feb 2009 00:33:00 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c23sm3712889ana.52.2009.02.25.00.32.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 00:33:00 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111402>

get_ref_states() populates the util pointer of the string_list_item's
that it adds to states->new and states->tracked, but nothing ever uses
the pointer, so we can get rid of the extra code.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index b89a353..3e6dee4 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -250,18 +250,11 @@ static int get_ref_states(const struct ref *ref, struct ref_states *states)
 
 	states->new.strdup_strings = states->tracked.strdup_strings = 1;
 	for (ref = fetch_map; ref; ref = ref->next) {
-		struct string_list *target = &states->tracked;
 		unsigned char sha1[20];
-		void *util = NULL;
-
 		if (!ref->peer_ref || read_ref(ref->peer_ref->name, sha1))
-			target = &states->new;
-		else {
-			target = &states->tracked;
-			if (hashcmp(sha1, ref->new_sha1))
-				util = &states;
-		}
-		string_list_append(abbrev_branch(ref->name), target)->util = util;
+			string_list_append(abbrev_branch(ref->name), &states->new);
+		else
+			string_list_append(abbrev_branch(ref->name), &states->tracked);
 	}
 	free_refs(fetch_map);
 
-- 
1.6.2.rc1.291.g83eb
