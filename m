From: Tomas Carnecky <tom@dbservice.com>
Subject: [PATCH 1/6] Remote helper: accept ':<value> <name>' as a response to 'list'
Date: Sun,  3 Oct 2010 14:21:46 +0200
Message-ID: <1286108511-55876-1-git-send-email-tom@dbservice.com>
References: <4CA86A12.6080905@dbservice.com>
Cc: Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 14:22:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2NaC-0005Mv-2R
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 14:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975Ab0JCMWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 08:22:08 -0400
Received: from gw.ptr-62-65-141-13.customer.ch.netstream.com ([62.65.141.13]:60845
	"EHLO calvin.caurea.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751077Ab0JCMWH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 08:22:07 -0400
Received: by calvin.caurea.org (Postfix, from userid 501)
	id 67BA3245A74A; Sun,  3 Oct 2010 14:22:05 +0200 (CEST)
X-Mailer: git-send-email 1.7.3.37.gb6088b
In-Reply-To: <4CA86A12.6080905@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157864>

Parse <value> as the remote-specific revision indicator. The ref is first stored
as 'impure', meaning that it doesn't have any representation within git. Only
after the remote helper fetches that version into git, it can tell us which
git object (SHA1) that revision maps to. That is done with the new reply
'map <value> <sha1>' to the 'list' command.

Signed-off-by: Tomas Carnecky <tom@dbservice.com>
---
 builtin/ls-remote.c |    7 ++++++-
 cache.h             |    2 +-
 remote.c            |    8 +++++++-
 transport-helper.c  |   41 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 97eed40..23dd0d2 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -109,7 +109,12 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			continue;
 		if (!tail_match(pattern, ref->name))
 			continue;
-		printf("%s	%s\n", sha1_to_hex(ref->old_sha1), ref->name);
+		if (ref->impure) {
+			int len = strlen(ref->impure) + strlen(" (impure)");
+			printf("%s (impure)%*s  %s\n", ref->impure, 40 - len, " ", ref->name);
+		} else {
+			printf("%s      %s\n", sha1_to_hex(ref->old_sha1), ref->name);
+		}
 	}
 	return 0;
 }
diff --git a/cache.h b/cache.h
index 2ef2fa3..23b43a6 100644
--- a/cache.h
+++ b/cache.h
@@ -905,7 +905,7 @@ struct ref {
 	struct ref *next;
 	unsigned char old_sha1[20];
 	unsigned char new_sha1[20];
-	char *symref;
+	char *symref, *impure;
 	unsigned int force:1,
 		merge:1,
 		nonfastforward:1,
diff --git a/remote.c b/remote.c
index 9143ec7..c355f11 100644
--- a/remote.c
+++ b/remote.c
@@ -907,6 +907,7 @@ static struct ref *copy_ref(const struct ref *ref)
 	memcpy(cpy, ref, sizeof(struct ref) + len + 1);
 	cpy->next = NULL;
 	cpy->symref = ref->symref ? xstrdup(ref->symref) : NULL;
+	cpy->impure = ref->impure ? xstrdup(ref->impure) : NULL;
 	cpy->remote_status = ref->remote_status ? xstrdup(ref->remote_status) : NULL;
 	cpy->peer_ref = copy_ref(ref->peer_ref);
 	return cpy;
@@ -931,6 +932,7 @@ static void free_ref(struct ref *ref)
 	free_ref(ref->peer_ref);
 	free(ref->remote_status);
 	free(ref->symref);
+	free(ref->impure);
 	free(ref);
 }
 
@@ -1453,7 +1455,11 @@ int resolve_remote_symref(struct ref *ref, struct ref *list)
 		return 0;
 	for (; list; list = list->next)
 		if (!strcmp(ref->symref, list->name)) {
-			hashcpy(ref->old_sha1, list->old_sha1);
+			if (list->impure) {
+				ref->impure = xstrdup(list->impure);
+			} else {
+				hashcpy(ref->old_sha1, list->old_sha1);
+			}
 			return 0;
 		}
 	return 1;
diff --git a/transport-helper.c b/transport-helper.c
index acfc88e..0fe886e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -307,6 +307,29 @@ static int release_helper(struct transport *transport)
 	return 0;
 }
 
+/* Map an impure ref to its actual value within Git. */
+static void map_impure_ref(int nr_heads, struct ref **to_fetch, char *map)
+{
+	int i;
+	char *eov;
+
+	eov = strchr(map, ' ');
+	if (!eov)
+		die("Malformed impure ref mapping: %s", map);
+	*eov = '\0';
+
+	/* There may be multiple impure refs with the same value, be sure to
+	 * map all of them. */
+	for (i = 0; i < nr_heads; i++) {
+		struct ref *posn = to_fetch[i];
+		if (posn->impure && !strcmp(map, posn->impure)) {
+			get_sha1_hex(eov + 1, posn->old_sha1);
+			free(posn->impure);
+			posn->impure = NULL;
+		}
+	}
+}
+
 static int fetch_with_fetch(struct transport *transport,
 			    int nr_heads, struct ref **to_fetch)
 {
@@ -318,11 +341,17 @@ static int fetch_with_fetch(struct transport *transport,
 
 	for (i = 0; i < nr_heads; i++) {
 		const struct ref *posn = to_fetch[i];
+
 		if (posn->status & REF_STATUS_UPTODATE)
 			continue;
 
-		strbuf_addf(&buf, "fetch %s %s\n",
+		if (posn->impure) {
+			strbuf_addf(&buf, "fetch %s %s\n",
+				posn->impure, posn->name);
+		} else {
+			strbuf_addf(&buf, "fetch %s %s\n",
 			    sha1_to_hex(posn->old_sha1), posn->name);
+		}
 	}
 
 	strbuf_addch(&buf, '\n');
@@ -337,12 +366,18 @@ static int fetch_with_fetch(struct transport *transport,
 				warning("%s also locked %s", data->name, name);
 			else
 				transport->pack_lockfile = xstrdup(name);
+		} else if (!prefixcmp(buf.buf, "map ")) {
+			map_impure_ref(nr_heads, to_fetch, buf.buf + 4);
 		}
 		else if (!buf.len)
 			break;
 		else
 			warning("%s unexpectedly said: '%s'", data->name, buf.buf);
 	}
+
+	/* The helper may have created one or more new packs. */
+	reprepare_packed_git();
+
 	strbuf_release(&buf);
 	return 0;
 }
@@ -824,7 +859,9 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 		*tail = alloc_ref(eov + 1);
 		if (buf.buf[0] == '@')
 			(*tail)->symref = xstrdup(buf.buf + 1);
-		else if (buf.buf[0] != '?')
+		else if (buf.buf[0] == ':') {
+			(*tail)->impure = xstrdup(buf.buf + 1);
+		} else if (buf.buf[0] != '?')
 			get_sha1_hex(buf.buf, (*tail)->old_sha1);
 		if (eon) {
 			if (has_attribute(eon + 1, "unchanged")) {
-- 
1.7.3.37.gb6088b
