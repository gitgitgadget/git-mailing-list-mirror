From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v4 08/12] Allow helper to map private ref names into normal names
Date: Wed, 18 Nov 2009 02:42:28 +0100
Message-ID: <1258508552-20752-9-git-send-email-srabbelier@gmail.com>
References: <1258508552-20752-1-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-2-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-3-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-4-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-5-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-6-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-7-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-8-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 02:44:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAZat-0000vW-Jy
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 02:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856AbZKRBnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 20:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756831AbZKRBnh
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 20:43:37 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:60684 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756407AbZKRBne (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 20:43:34 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so622806bwz.21
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 17:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=AgY9wXHFFl9kBbMwzYTi9g0Sk2mmY2rxirzPyJISFpM=;
        b=Vlyil/FhkAg85QwEnxAuH0sCE9CIMl5hSVX4k/4qQXx0CyG/DsQoUhsTPFjWBelQU3
         Pfv1zZi/iikozyiKQaFdCV9/PokAiHnmrwK+Q0F/GMYn/IviaUNu0cdYJoKuJ2XWQIXa
         rSGFannHJWUM3eRL3VbTNLKlpRO69ApXtZE8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JZiUD7pUnIsM428NkrHQmqQPwbRgyOiUFPatfOmm8HvcpbvEFoFne5pnoJ3ztlqyck
         AajTv0tA2N1E5gn7hA/QwqWKE9V1aBi84lCmY2pwDwipUa9LWnVjtt1Rd6vUyTqRz+9r
         CgDypDV64r5bnkbH+NkRikaXx40JQ5wIw3iVY=
Received: by 10.216.88.1 with SMTP id z1mr502310wee.49.1258508619970;
        Tue, 17 Nov 2009 17:43:39 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 28sm2372670eye.3.2009.11.17.17.43.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 17:43:38 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
In-Reply-To: <1258508552-20752-8-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133133>

From: Daniel Barkalow <barkalow@iabervon.org>

This allows a helper to say that, when it handles "import
refs/heads/topic", the script it outputs will actually write to
refs/svn/origin/branches/topic; therefore, transport-helper should
read it from the latter location after git-fast-import completes.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

	This has Daniel's documentation and leak fixes squashed in.

 Documentation/git-remote-helpers.txt |   16 +++++++++++++++-
 remote.c                             |   27 +++++++++++++++++++++++++++
 remote.h                             |    5 +++++
 transport-helper.c                   |   34 +++++++++++++++++++++++++++++++++-
 4 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index e9aa67e..d6c5268 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -46,7 +46,11 @@ Supported if the helper has the "fetch" capability.
 'import' <name>::
 	Produces a fast-import stream which imports the current value
 	of the named ref. It may additionally import other refs as
-	needed to construct the history efficiently.
+	needed to construct the history efficiently. The script writes
+	to a helper-specific private namespace. The value of the named
+	ref should be written to a location in this namespace derived
+	by applying the refspecs from the "refspec" capability to the
+	name of the ref.
 +
 Supported if the helper has the "import" capability.
 
@@ -67,6 +71,16 @@ CAPABILITIES
 'import'::
 	This helper supports the 'import' command.
 
+'refspec' 'spec'::
+	When using the import command, expect the source ref to have
+	been written to the destination ref. The earliest applicable
+	refspec takes precedence. For example
+	"refs/heads/*:refs/svn/origin/branches/*" means that, after an
+	"import refs/heads/name", the script has written to
+	refs/svn/origin/branches/name. If this capability is used at
+	all, it must cover all refs reported by the list command; if
+	it is not used, it is effectively "*:*"
+
 REF LIST ATTRIBUTES
 -------------------
 
diff --git a/remote.c b/remote.c
index 09bb79c..1f7870d 100644
--- a/remote.c
+++ b/remote.c
@@ -673,6 +673,16 @@ static struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
 	return parse_refspec_internal(nr_refspec, refspec, 0, 0);
 }
 
+void free_refspec(int nr_refspec, struct refspec *refspec)
+{
+	int i;
+	for (i = 0; i < nr_refspec; i++) {
+		free(refspec[i].src);
+		free(refspec[i].dst);
+	}
+	free(refspec);
+}
+
 static int valid_remote_nick(const char *name)
 {
 	if (!name[0] || is_dot_or_dotdot(name))
@@ -811,6 +821,23 @@ static int match_name_with_pattern(const char *key, const char *name,
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
index ac0ce2f..cdc3b5b 100644
--- a/remote.h
+++ b/remote.h
@@ -91,6 +91,11 @@ void ref_remove_duplicates(struct ref *ref_map);
 int valid_fetch_refspec(const char *refspec);
 struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
 
+void free_refspec(int nr_refspec, struct refspec *refspec);
+
+char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
+		     const char *name);
+
 int match_refs(struct ref *src, struct ref **dst,
 	       int nr_refspec, const char **refspec, int all);
 
diff --git a/transport-helper.c b/transport-helper.c
index 82caaae..da8185a 100644
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
@@ -51,6 +58,21 @@ static struct child_process *get_helper(struct transport *transport)
 			data->fetch = 1;
 		if (!strcmp(buf.buf, "import"))
 			data->import = 1;
+		if (!data->refspecs && !prefixcmp(buf.buf, "refspec ")) {
+			ALLOC_GROW(refspecs,
+				   refspec_nr + 1,
+				   refspec_alloc);
+			refspecs[refspec_nr++] = strdup(buf.buf + strlen("refspec "));
+		}
+	}
+	if (refspecs) {
+		int i;
+		data->refspec_nr = refspec_nr;
+		data->refspecs = parse_fetch_refspec(refspec_nr, refspecs);
+		for (i = 0; i < refspec_nr; i++) {
+			free((char *)refspecs[i]);
+		}
+		free(refspecs);
 	}
 	return data->helper;
 }
@@ -72,6 +94,9 @@ static int disconnect_helper(struct transport *transport)
 
 static int release_helper(struct transport *transport)
 {
+	struct helper_data *data = transport->data;
+	free_refspec(data->refspec_nr, data->refspecs);
+	data->refspecs = NULL;
 	disconnect_helper(transport);
 	free(transport->data);
 	return 0;
@@ -119,6 +144,7 @@ static int fetch_with_import(struct transport *transport,
 {
 	struct child_process fastimport;
 	struct child_process *helper = get_helper(transport);
+	struct helper_data *data = transport->data;
 	int i;
 	struct ref *posn;
 	struct strbuf buf = STRBUF_INIT;
@@ -139,10 +165,16 @@ static int fetch_with_import(struct transport *transport,
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
1.6.5.3.164.g07b0c
