From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [RFC PATCH 06/19] Factor ref updating out of fetch_with_import
Date: Thu, 29 Oct 2009 11:01:14 -0700
Message-ID: <1256839287-19016-7-git-send-email-srabbelier@gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:02:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZKk-0004ac-Fe
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127AbZJ2SCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753815AbZJ2SCX
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:02:23 -0400
Received: from mail-px0-f179.google.com ([209.85.216.179]:55291 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbZJ2SCV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:02:21 -0400
Received: by mail-px0-f179.google.com with SMTP id 9so1335963pxi.4
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 11:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ll5KLJOlE2RLaStN17bRSVWI0jc07ytSDSeIdxN+n+E=;
        b=eUt//2aOm1wGyrvRLH7MBEtDHiTlBTkK3GZOU23cZDHqu4Wn9YjRxWqUnnVWTu/SM/
         P85fjUsXnDaazmb+ig+qhst0pUkrHyStn5H+GzIurXtoNQ+5HDknpYtHP7yNeMIFPw7n
         0N6qF/HTWZpglO/FWOYE9sJ8+/1ji7BYvejWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qI9lveLycZbKW0kmDWiSF/ppp4ZQOAbzhpQla9/UEGkB9z6s7voUuqVMY3/wWBxvM3
         QYV3hgK1UvtIyuLqR8xIpOJ/ToXqyV9Lcr6fXNR6JbHqbTOMUxgKThk4PFDVW69ERHfr
         PtwEbWkCitYwDralb1EZJ6pAMZ9pr4d+vsgOE=
Received: by 10.114.116.12 with SMTP id o12mr270899wac.83.1256839346434;
        Thu, 29 Oct 2009 11:02:26 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm1332445pxi.5.2009.10.29.11.02.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 11:02:24 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also allow the new update_refs to actually update the refs set, this
way the remote helper can set the value of previously unknown refs.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Daniel, if we can get wanted_peer_refs to keep HEAD as a
	wanted ref somehow this patch could be a lot simpler.

 builtin-clone.c    |    7 +++++++
 builtin-fetch.c    |    3 +++
 transport-helper.c |   15 +++++++++++++++
 transport.c        |    6 ++++++
 transport.h        |    8 ++++++--
 5 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 0042bee..7c90ce2 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -529,6 +529,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			struct ref *ref_cpy = wanted_peer_refs(refs, refspec);
 			mapped_refs = ref_cpy;
 			transport_fetch_refs(transport, ref_cpy);
+			if (transport->update_refs)
+			{
+				ref_cpy = copy_ref_list(refs);
+				transport_update_refs(transport, ref_cpy);
+				refs = ref_cpy;
+				mapped_refs = wanted_peer_refs(refs, refspec);
+			}
 		}
 	}
 
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 013a6ba..c35188b 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -479,7 +479,10 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
 {
 	int ret = quickfetch(ref_map);
 	if (ret)
+	{
 		ret = transport_fetch_refs(transport, ref_map);
+		transport_update_refs(transport, ref_map);
+	}
 	if (!ret)
 		ret |= store_updated_refs(transport->url,
 				transport->remote->name,
diff --git a/transport-helper.c b/transport-helper.c
index f840842..ab40a9a 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -207,6 +207,20 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 	return ret;
 }
 
+static int update_refs(struct transport *transport, struct ref *refs)
+{
+	struct ref *ref = refs;
+
+	while (ref) {
+		if (ref->status & REF_STATUS_UPTODATE)
+			continue;
+		read_ref(ref->symref ? ref->symref : ref->name, ref->old_sha1);
+		ref = ref->next;
+	}
+
+	return 0;
+}
+
 int transport_helper_init(struct transport *transport, const char *name)
 {
 	struct helper_data *data = xcalloc(sizeof(*data), 1);
@@ -215,6 +229,7 @@ int transport_helper_init(struct transport *transport, const char *name)
 	transport->data = data;
 	transport->get_refs_list = get_refs_list;
 	transport->fetch = fetch;
+	transport->update_refs = update_refs;
 	transport->disconnect = disconnect_helper;
 	return 0;
 }
diff --git a/transport.c b/transport.c
index 13bab4e..741a3a7 100644
--- a/transport.c
+++ b/transport.c
@@ -966,6 +966,12 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 	return rc;
 }
 
+void transport_update_refs(struct transport *transport, struct ref *refs)
+{
+	if (transport->update_refs)
+		transport->update_refs(transport, refs);
+}
+
 void transport_unlock_pack(struct transport *transport)
 {
 	if (transport->pack_lockfile) {
diff --git a/transport.h b/transport.h
index 503db11..1aba16c 100644
--- a/transport.h
+++ b/transport.h
@@ -32,12 +32,15 @@ struct transport {
 	/**
 	 * Fetch the objects for the given refs. Note that this gets
 	 * an array, and should ignore the list structure.
-	 *
+	 **/
+	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs);
+
+	/**
 	 * If the transport did not get hashes for refs in
 	 * get_refs_list(), it should set the old_sha1 fields in the
 	 * provided refs now.
 	 **/
-	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs);
+	int (*update_refs)(struct transport *transport, struct ref *refs);
 
 	/**
 	 * Push the objects and refs. Send the necessary objects, and
@@ -112,6 +115,7 @@ int transport_push(struct transport *connection,
 const struct ref *transport_get_remote_refs(struct transport *transport);
 
 int transport_fetch_refs(struct transport *transport, struct ref *refs);
+void transport_update_refs(struct transport *transport, struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
-- 
1.6.5.2.291.gf76a3
