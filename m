From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 7/7] Factor ref updating out of fetch_with_import
Date: Wed, 28 Oct 2009 23:40:26 -0700
Message-ID: <1256798426-21816-8-git-send-email-srabbelier@gmail.com>
References: <1256798426-21816-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 07:41:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Ohk-0003Ks-EK
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 07:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490AbZJ2Glf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 02:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756487AbZJ2Gle
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 02:41:34 -0400
Received: from mail-pw0-f42.google.com ([209.85.160.42]:39138 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756481AbZJ2Gld (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 02:41:33 -0400
Received: by mail-pw0-f42.google.com with SMTP id 9so1251845pwj.21
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 23:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dYrPnNxlw7AfluPFNPJmb4hPdRfIsvoy0SVYoi3Iogc=;
        b=Xw+9tfkQ5B1D4dIh55v3XidF8eRLTfvMXwob9rjj0Z/Fs0wPyndd58kMRdDGZ5ROQU
         lgCvRfugWP5nC4J7FOKf9+HNcg/XQqDlYOctMefdG/beva1mk8UC4K3+3FY/0IEs0RCv
         fM73NXMVpGcR1p9lpV9OFFyKiLyHIBe//onAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jUR4YsAlr/C6gJvJcRM8Jv6D54aGGhjqtQN7m8N3M/2pbrGLOIqMuQKpX9j+s2/yx/
         AbriToDwTUB9NFdFwCMioSOsmddAQv4Z67z7030JdxRLrr4fTOJOT4Ovp57rHw1SpR8b
         6W365m0tKAdAKvWDXn/scf28gchjjEu3YWw7s=
Received: by 10.115.66.24 with SMTP id t24mr1925074wak.39.1256798498559;
        Wed, 28 Oct 2009 23:41:38 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm401242pxi.1.2009.10.28.23.41.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 23:41:37 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256798426-21816-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131560>

Also allow the new update_refs to actually update the refs set, this
way the remote helper can set the value of previously unknown refs.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	This is the most important patch of the series, without it it
	is truly impossible to 'git clone hg::/path/to/hg/repo' since
	when we try to guess remote_head, we use
	find_ref_by_name(refs, "HEAD"), which will not find anything
	unless we set refs to the updated refs _after_ doing the
	import. This is a result of the fact that we do not know the
	value of the remote HEAD until after the import is complete.

 builtin-clone.c    |    7 +++++++
 builtin-fetch.c    |    4 ++++
 transport-helper.c |   22 +++++++++++++++-------
 transport.h        |    7 +++++--
 4 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index f281756..768668d 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -512,6 +512,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (refs) {
 			struct ref *ref_cpy = copy_ref_list(refs);
 			transport_fetch_refs(transport, ref_cpy);
+			if (transport->update_refs)
+			{
+				ref_cpy = copy_ref_list(refs);
+				transport->update_refs(transport, ref_cpy);
+				refs = ref_cpy;
+				mapped_refs = wanted_peer_refs(refs, refspec);
+			}
 		}
 	}
 
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 63a4ff0..3aaac47 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -479,7 +479,11 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
 {
 	int ret = quickfetch(ref_map);
 	if (ret)
+	{
 		ret = transport_fetch_refs(transport, ref_map);
+		if (transport->update_refs)
+			transport->update_refs(transport, ref_map);
+	}
 	if (!ret)
 		ret |= store_updated_refs(transport->url,
 				transport->remote->name,
diff --git a/transport-helper.c b/transport-helper.c
index a361366..9a98fae 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -154,13 +154,6 @@ static int fetch_with_import(struct transport *transport,
 	finish_command(&fastimport);
 	free((char *) fastimport.argv[2]);
 	free((char *) fastimport.argv[3]);
-
-	for (i = 0; i < nr_heads; i++) {
-		posn = to_fetch[i];
-		if (posn->status & REF_STATUS_UPTODATE)
-			continue;
-		read_ref(posn->symref ? posn->symref : posn->name, posn->old_sha1);
-	}
 	return 0;
 }
 
@@ -255,6 +248,20 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
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
@@ -264,5 +271,6 @@ int transport_helper_init(struct transport *transport, const char *name)
 	transport->get_refs_list = get_refs_list;
 	transport->fetch = fetch;
 	transport->disconnect = release_helper;
+	transport->update_refs = update_refs;
 	return 0;
 }
diff --git a/transport.h b/transport.h
index 40dfe64..6d31df3 100644
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
-- 
1.6.5.2.291.gf76a3
