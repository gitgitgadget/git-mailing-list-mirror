From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 02/13] remote: remove unused code in get_ref_states
Date: Mon, 23 Feb 2009 01:28:50 -0500
Message-ID: <f9c6cc9cdcb6d95ca9589d66dd0291ac807a89c6.1235368324.git.jaysoffian@gmail.com>
References: <cover.1235368324.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 07:31:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbULK-00072Y-DS
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 07:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbZBWG3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 01:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbZBWG3N
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 01:29:13 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:10242 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbZBWG3L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 01:29:11 -0500
Received: by yw-out-2324.google.com with SMTP id 5so749066ywh.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 22:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=L2sngJFaJQHzTtO0M7jai3BUL1RmASmAZ8kmdfZjwOo=;
        b=ARcHZn6anqGG/i75cJ18Ugw6aftVuJ5B5gas78J8IVa8x/qw8p7PMoXXneCYkLs1mu
         K8z5tdIOHZof+j3kfnSCuA67/fWxPG+rW3c624PzuRW0yCcpZ5oWPk97H1cWWjM0DJ2v
         QJXO8bGg1DY/o+hpXJjZ12HcpQANNHc2Pkbl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UkezNC5AMIPtDly20a9gJOdkR+aVClSkDRWjqXpBL997v71Q2/K3YkhcTqxkgXIehz
         s96kCST3cMN2D1/WoXgKfx88NTV6N5eCXtDm8A34ZPhsEBoiTL/sm5jqz7o+o7TNhtvx
         cyRnmdoP15DeThLmanf6Mp5Uml4u5D0jJY7fs=
Received: by 10.100.173.18 with SMTP id v18mr3594772ane.20.1235370549791;
        Sun, 22 Feb 2009 22:29:09 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d38sm7231146and.49.2009.02.22.22.29.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 22:29:09 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.223.gfed32
In-Reply-To: <cover.1235368324.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111091>

get_ref_states() populates the util pointer of the string_list_item's
that it adds to states->new and states->tracked, but nothing ever uses
the pointer, so we can get rid of the extra code.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 1603219..f2ef08a 100644
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
1.6.2.rc1.223.gfed32
