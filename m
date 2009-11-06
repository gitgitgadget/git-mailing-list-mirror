From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 08/12] Allow helper to map private ref names into normal names
Date: Fri,  6 Nov 2009 23:52:42 +0100
Message-ID: <1257547966-14603-9-git-send-email-srabbelier@gmail.com>
References: <1257547966-14603-1-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-2-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-3-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-4-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-5-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-6-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-7-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-8-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 06 23:53:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Xgp-000813-L3
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 23:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbZKFWxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 17:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbZKFWxm
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 17:53:42 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:44637 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759945AbZKFWxi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 17:53:38 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so1557937ewy.37
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 14:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SPO6sSVButArbCP9TOfzF/7+seG7athhsHIWgJBd5A8=;
        b=ri6NvSxmRRlsfHCIenV9t8ZggXAtnVRVG9y4qu9Gp7bbmZwL+aSXx84lAGgcm1emMj
         mIpYx19f4fLmSCmYeQFJslrBtHNZOeclCOUEGmXrbhCjeeY+P2gbFI3igD/9MLFkp8Ow
         oCtaBOk9e9/fSRnmc0ZAomg1Zj2qe7yCh4eqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QK+psaRNqzYnWFInZxRL4UnQS+nRfkDbKRIhVxamNDrQ5VRjSUhq7F+5ioYRAQJWc0
         j7DhLyfniZfIWriRztmcdsUvtr6aAIEgAuqk1jnhjIY+DcsaZ5Fie/86JpDS5T9DYvQE
         jbwBG6R6bka4KfA3q94x6ifa6ShuNGSzOjiNM=
Received: by 10.213.109.148 with SMTP id j20mr45080ebp.2.1257548023461;
        Fri, 06 Nov 2009 14:53:43 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 7sm1501175eyb.40.2009.11.06.14.53.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 14:53:42 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.158.g6dacb
In-Reply-To: <1257547966-14603-8-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132333>

From: Daniel Barkalow <barkalow@iabervon.org>

This allows a helper to say that, when it handles "import
refs/heads/topic", the script it outputs will actually write to
refs/svn/origin/branches/topic; therefore, transport-helper should
read it from the latter location after git-fast-import completes.
---

	New in this series.
	Daniel, you did not include a S-o-b, I assume because you
	mean to add documentation?

 remote.c           |   17 +++++++++++++++++
 remote.h           |    3 +++
 transport-helper.c |   26 +++++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index 09bb79c..09e14a8 100644
--- a/remote.c
+++ b/remote.c
@@ -811,6 +811,23 @@ static int match_name_with_pattern(const char *key, const char *name,
 	return ret;
 }
 
+char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
+		     const char *name)
+{
+	int i;
+	char *ret = NULL;
+	for (i = 0; i < nr_refspec; i++) {
+		struct refspec *refspec = refspecs + i;
+		if (refspec->pattern) {
+			if (match_name_with_pattern(refspec->src, name,
+						    refspec->dst, &ret))
+				return ret;
+		} else if (!strcmp(refspec->src, name))
+			return strdup(refspec->dst);
+	}
+	return NULL;
+}
+
 int remote_find_tracking(struct remote *remote, struct refspec *refspec)
 {
 	int find_src = refspec->src == NULL;
diff --git a/remote.h b/remote.h
index ac0ce2f..c2f920b 100644
--- a/remote.h
+++ b/remote.h
@@ -91,6 +91,9 @@ void ref_remove_duplicates(struct ref *ref_map);
 int valid_fetch_refspec(const char *refspec);
 struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
 
+char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
+		     const char *name);
+
 int match_refs(struct ref *src, struct ref **dst,
 	       int nr_refspec, const char **refspec, int all);
 
diff --git a/transport-helper.c b/transport-helper.c
index 82caaae..c4ab84a 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -5,6 +5,7 @@
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
+#include "remote.h"
 
 struct helper_data
 {
@@ -12,6 +13,9 @@ struct helper_data
 	struct child_process *helper;
 	unsigned fetch : 1;
 	unsigned import : 1;
+	/* These go from remote name (as in "list") to private name */
+	struct refspec *refspecs;
+	int refspec_nr;
 };
 
 static struct child_process *get_helper(struct transport *transport)
@@ -20,6 +24,9 @@ static struct child_process *get_helper(struct transport *transport)
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process *helper;
 	FILE *file;
+	const char **refspecs = NULL;
+	int refspec_nr = 0;
+	int refspec_alloc = 0;
 
 	if (data->helper)
 		return data->helper;
@@ -51,6 +58,16 @@ static struct child_process *get_helper(struct transport *transport)
 			data->fetch = 1;
 		if (!strcmp(buf.buf, "import"))
 			data->import = 1;
+		if (!prefixcmp(buf.buf, "refspec ")) {
+			ALLOC_GROW(refspecs,
+				   refspec_nr + 1,
+				   refspec_alloc);
+			refspecs[refspec_nr++] = strdup(buf.buf + strlen("refspec "));
+		}
+	}
+	if (refspecs) {
+		data->refspec_nr = refspec_nr;
+		data->refspecs = parse_fetch_refspec(refspec_nr, refspecs);
 	}
 	return data->helper;
 }
@@ -119,6 +136,7 @@ static int fetch_with_import(struct transport *transport,
 {
 	struct child_process fastimport;
 	struct child_process *helper = get_helper(transport);
+	struct helper_data *data = transport->data;
 	int i;
 	struct ref *posn;
 	struct strbuf buf = STRBUF_INIT;
@@ -139,10 +157,16 @@ static int fetch_with_import(struct transport *transport,
 	finish_command(&fastimport);
 
 	for (i = 0; i < nr_heads; i++) {
+		char *private;
 		posn = to_fetch[i];
 		if (posn->status & REF_STATUS_UPTODATE)
 			continue;
-		read_ref(posn->name, posn->old_sha1);
+		if (data->refspecs)
+			private = apply_refspecs(data->refspecs, data->refspec_nr, posn->name);
+		else
+			private = strdup(posn->name);
+		read_ref(private, posn->old_sha1);
+		free(private);
 	}
 	return 0;
 }
-- 
1.6.5.2.158.g6dacb
