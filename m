From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 01/13] Fix memory leak in helper method for disconnect
Date: Wed,  4 Nov 2009 20:48:06 +0100
Message-ID: <1257364098-1685-2-git-send-email-srabbelier@gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:50:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lrm-0000NL-Ip
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbZKDTtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758021AbZKDTtG
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:49:06 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:55343 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758038AbZKDTtB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:49:01 -0500
Received: by ewy3 with SMTP id 3so3490482ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 11:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cW09vra3wr57MOYQ2hGEXQB/DK/O7z4S0wlb7at8sog=;
        b=J3EOXVjXiaYdz7Ftl5UHxhJb+AY6Vfhz73wBX9F0GWO8ZCCOPJl9dFkm+Xfo8WguE8
         /CJ9FyRGM8GBqiUL8LAbI/1ElnOU8WW2QkO9vupNVWZ/GOYrMtvtGoCmy+jjIb1laFkg
         J6QftZf7SPJDTar6id9GhCZQqrgVUKlPYArkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MAVVXmmFfBpBJ9/QafEOvcmUPGSiANl48Ppy6kvixgtkFr9fZJ+cFWg7nE6pSqUOsu
         KjXZnKb5442fnixOVcRckCoBNvy4w3QzkUENFb01TYi9zKI4R+rOd0idcxUxSbr0hhfQ
         5ATGy31j4qegOkJ95x4PQUqck7AEy7vBmaFKY=
Received: by 10.213.25.77 with SMTP id y13mr2566170ebb.77.1257364145701;
        Wed, 04 Nov 2009 11:49:05 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 5sm4314489eyh.2.2009.11.04.11.49.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 11:49:05 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.295.g0d105
In-Reply-To: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132131>

From: Daniel Barkalow <barkalow@iabervon.org>

Since some cases may need to disconnect from the helper and reconnect,
wrap the function that just disconnects in a function that also frees
transport->data.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

	Moved to the beginning of the series as it is most important.

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
1.6.5.2.295.g0d105
