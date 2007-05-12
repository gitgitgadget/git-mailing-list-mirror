From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 3/3] Add handlers for fetch-side configuration of remotes.
Date: Fri, 11 May 2007 22:39:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705112238520.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 04:40:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmhX3-0001i4-Ge
	for gcvg-git@gmane.org; Sat, 12 May 2007 04:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762051AbXELCjd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 22:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760986AbXELCjd
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 22:39:33 -0400
Received: from iabervon.org ([66.92.72.58]:3652 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762115AbXELCjc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 22:39:32 -0400
Received: (qmail 6092 invoked by uid 1000); 12 May 2007 02:39:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 May 2007 02:39:30 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47018>

These follow the pattern of the push side configuration, but aren't
taken from anywhere else, because git-fetch is still in shell.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 remote.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h |   10 ++++++++++
 2 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/remote.c b/remote.c
index 2ac7bc8..8070803 100644
--- a/remote.c
+++ b/remote.c
@@ -17,6 +17,15 @@ static void add_push_refspec(struct remote *remote, const char *ref)
 	remote->push_refspec_nr = nr;
 }
 
+static void add_fetch_refspec(struct remote *remote, const char *ref)
+{
+	int nr = remote->fetch_refspec_nr + 1;
+	remote->fetch_refspec =
+		xrealloc(remote->fetch_refspec, nr * sizeof(char *));
+	remote->fetch_refspec[nr-1] = ref;
+	remote->fetch_refspec_nr = nr;
+}
+
 static void add_uri(struct remote *remote, const char *uri)
 {
 	int nr = remote->uri_nr + 1;
@@ -74,6 +83,9 @@ static void read_remotes_file(struct remote *remote)
 		} else if (!prefixcmp(buffer, "Push:")) {
 			value_list = 1;
 			s = buffer + 5;
+		} else if (!prefixcmp(buffer, "Pull:")) {
+			value_list = 2;
+			s = buffer + 5;
 		} else
 			continue;
 
@@ -93,6 +105,9 @@ static void read_remotes_file(struct remote *remote)
 		case 1:
 			add_push_refspec(remote, xstrdup(s));
 			break;
+		case 2:
+			add_fetch_refspec(remote, xstrdup(s));
+			break;
 		}
 	}
 }
@@ -154,6 +169,8 @@ static int handle_config(const char *key, const char *value)
 		add_uri(remote, xstrdup(value));
 	} else if (!strcmp(subkey, ".push")) {
 		add_push_refspec(remote, xstrdup(value));
+	} else if (!strcmp(subkey, ".fetch")) {
+		add_fetch_refspec(remote, xstrdup(value));
 	} else if (!strcmp(subkey, ".receivepack")) {
 		if (!remote->receivepack)
 			remote->receivepack = xstrdup(value);
@@ -237,10 +254,52 @@ struct remote *remote_get(const char *name)
 		add_uri(ret, name);
 	if (!ret->uri)
 		return NULL;
+	ret->fetch = parse_ref_spec(ret->fetch_refspec_nr, ret->fetch_refspec);
 	ret->push = parse_ref_spec(ret->push_refspec_nr, ret->push_refspec);
 	return ret;
 }
 
+int remote_has_uri(struct remote *remote, const char *uri)
+{
+	int i;
+	for (i = 0; i < remote->uri_nr; i++) {
+		if (!strcmp(remote->uri[i], uri))
+			return 1;
+	}
+	return 0;
+}
+
+int remote_find_tracking(struct remote *remote, struct refspec *refspec)
+{
+	int i;
+	for (i = 0; i < remote->fetch_refspec_nr; i++) {
+		struct refspec *fetch = &remote->fetch[i];
+		if (!fetch->dest)
+			continue;
+		if (fetch->pattern) {
+			if (!prefixcmp(refspec->src, fetch->src)) {
+				refspec->dest =
+					xmalloc(strlen(fetch->dest) +
+						strlen(refspec->src) -
+						strlen(fetch->src) + 1);
+				strcpy(refspec->dest, fetch->dest);
+				strcpy(refspec->dest + strlen(fetch->dest),
+				       refspec->src + strlen(fetch->src));
+				refspec->force = fetch->force;
+				return 0;
+			}
+		} else {
+			if (!strcmp(refspec->src, fetch->src)) {
+				refspec->dest = xstrdup(fetch->dest);
+				refspec->force = fetch->force;
+				return 0;
+			}
+		}
+	}
+	refspec->dest = NULL;
+	return -1;
+}
+
 static int count_refspec_match(const char *pattern,
 			       struct ref *refs,
 			       struct ref **matched_ref)
diff --git a/remote.h b/remote.h
index 79cedde..3608119 100644
--- a/remote.h
+++ b/remote.h
@@ -11,11 +11,17 @@ struct remote {
 	struct refspec *push;
 	int push_refspec_nr;
 
+	const char **fetch_refspec;
+	struct refspec *fetch;
+	int fetch_refspec_nr;
+
 	const char *receivepack;
 };
 
 struct remote *remote_get(const char *name);
 
+int remote_has_uri(struct remote *remote, const char *uri);
+
 struct refspec {
 	unsigned force : 1;
 	unsigned pattern : 1;
@@ -27,4 +33,8 @@ struct refspec {
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	       int nr_refspec, char **refspec, int all);
 
+/** For the given remote, reads the refspec's src and sets the other fields.
+ **/
+int remote_find_tracking(struct remote *remote, struct refspec *refspec);
+
 #endif
-- 
1.5.2.rc2.45.g3d9b43-dirty
