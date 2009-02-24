From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 13/23] builtin-remote: remove unused code in get_ref_states
Date: Tue, 24 Feb 2009 04:51:01 -0500
Message-ID: <b968867b87671e478382b3ecd873fc82e5a4909d.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:55:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbu00-0002Ej-1d
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755965AbZBXJv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753917AbZBXJvy
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:51:54 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:58685 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541AbZBXJvs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:51:48 -0500
Received: by mail-gx0-f174.google.com with SMTP id 22so6475210gxk.13
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=IAzUZ7EZLI14X6o3FWt53jBkCYwwGAPonrs/nqm9ueM=;
        b=FTRa3c+1yPE8gde0E7tYIgZXmSzbTAzPGYw8d9xarGV2P55mlAoMSYnBNlj3pvhWw4
         JDM8VsCfZS29a9OmUjiZqYZtDCqt8qw+biiGegKAL2viWha3S/jLiw+f57EG4qS+OnTa
         gvHwzBE9AmMbPBxj/a3fWF5t//Fl7rG47fymM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rljnNa071mr5K5pjhcWo6dAwIqiNY4unPwZoxemnTDAsxgCn5YnfjmKNG0D8Uu3OYo
         fk8mHcZvn+DV1MsnaHyI4diK2WECAwxeDnq51Bv62nCHyMbRuwtCxFM9I/uNOWTNRii2
         MxeOjcYOxBu0ELbEC5DJqLY4tcDxg3q97Sr9Y=
Received: by 10.100.141.5 with SMTP id o5mr5435210and.53.1235469107399;
        Tue, 24 Feb 2009 01:51:47 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c28sm10476416anc.25.2009.02.24.01.51.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:51:45 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111272>

get_ref_states() populates the util pointer of the string_list_item's
that it adds to states->new and states->tracked, but nothing ever uses
the pointer, so we can get rid of the extra code.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index d5c808c..56d73c8 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -251,18 +251,11 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 
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
