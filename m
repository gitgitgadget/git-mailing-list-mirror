From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git mergetool broken when rerere active
Date: Thu, 06 Jan 2011 11:33:27 -0800
Message-ID: <7v62u1bzeg.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.10.1101052119530.26654@debian>
 <7vbp3tc142.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Magnus Baeck <magnus.back@sonyericsson.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	David Aguilar <davvid@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 20:34:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pavaw-0003nw-Fy
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 20:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab1AFTdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 14:33:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62627 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322Ab1AFTdp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 14:33:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 083ED3D5E;
	Thu,  6 Jan 2011 14:34:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pbHHN/rv1yxdAZ2Y/gT0IiTcV0I=; b=guPIJo
	XF/xt/TKjAHmBTrSxj1uqNxTsXY8oZKV9iV9PW2439NecGSnJvvEPCv8lhqJea2p
	BRjsJQ4rmo/rbmQZOE1qge9g3ZklvYPENXfFRC09OEz7kIWcXgf9FucIgugsSLM8
	/IJp7NbPCbOL3hAjtpoOKEoFR4c2yz9UgOUbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o6p99RT9FPXyLV4tI0pPG6usE15z08DY
	t+keXcMOPTXLQhCNijYqkpNKyjsC6Dtb682v9+39OLvAqh+hY9EE4qpvCgrwVRrI
	gxyR6YFKOrE/rK0OMj38v0ge2ZDH8p177BznslXoR+xTnMKhJj9Mj1jDNlRTAVSI
	3RUzDZ68/Sg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 961B83D58;
	Thu,  6 Jan 2011 14:34:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 737813D57; Thu,  6 Jan 2011
 14:34:06 -0500 (EST)
In-Reply-To: <7vbp3tc142.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 06 Jan 2011 10\:56\:29 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F1BB1576-19CB-11E0-A638-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164657>

Junio C Hamano <gitster@pobox.com> writes:

> Probably we would need a "git rerere remaining" sobcommand that is similar
> to status but also includes the "punted" paths.

... which may look like this.

Replace use of "git rerere status" in bb0a484 (mergetool: Skip
autoresolved paths, 2010-08-17) with "git rerere remainder" and see what
happens.

 builtin/rerere.c |   12 +++++++++-
 rerere.c         |   63 +++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 642bf35..081fccc 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -8,7 +8,7 @@
 #include "xdiff-interface.h"
 
 static const char * const rerere_usage[] = {
-	"git rerere [clear | status | diff | gc]",
+	"git rerere [clear | status | remaining | diff | gc]",
 	NULL,
 };
 
@@ -147,6 +147,8 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 	if (!strcmp(argv[0], "clear")) {
 		for (i = 0; i < merge_rr.nr; i++) {
 			const char *name = (const char *)merge_rr.items[i].util;
+			if (!name)
+				continue;
 			if (!has_rerere_resolution(name))
 				unlink_rr_item(name);
 		}
@@ -154,12 +156,20 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 	} else if (!strcmp(argv[0], "gc"))
 		garbage_collect(&merge_rr);
 	else if (!strcmp(argv[0], "status"))
+		for (i = 0; i < merge_rr.nr; i++) {
+			if (!merge_rr.items[i].util)
+				continue;
+			printf("%s\n", merge_rr.items[i].string);
+		}
+	else if (!strcmp(argv[0], "remaining"))
 		for (i = 0; i < merge_rr.nr; i++)
 			printf("%s\n", merge_rr.items[i].string);
 	else if (!strcmp(argv[0], "diff"))
 		for (i = 0; i < merge_rr.nr; i++) {
 			const char *path = merge_rr.items[i].string;
 			const char *name = (const char *)merge_rr.items[i].util;
+			if (!name)
+				continue;
 			diff_two(rerere_path(name, "preimage"), path, path, path);
 		}
 	else
diff --git a/rerere.c b/rerere.c
index d260843..eb47f97 100644
--- a/rerere.c
+++ b/rerere.c
@@ -350,21 +350,57 @@ static int find_conflict(struct string_list *conflict)
 	int i;
 	if (read_cache() < 0)
 		return error("Could not read index");
-	for (i = 0; i+1 < active_nr; i++) {
-		struct cache_entry *e2 = active_cache[i];
-		struct cache_entry *e3 = active_cache[i+1];
-		if (ce_stage(e2) == 2 &&
-		    ce_stage(e3) == 3 &&
-		    ce_same_name(e2, e3) &&
-		    S_ISREG(e2->ce_mode) &&
-		    S_ISREG(e3->ce_mode)) {
-			string_list_insert(conflict, (const char *)e2->name);
-			i++; /* skip over both #2 and #3 */
+
+	/*
+	 * Collect paths with conflict, mark them with NULL (punted) or
+	 * !NULL (eligible) in their ->util field.
+	 */
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *e = active_cache[i];
+		struct string_list_item *it;
+
+		if (!ce_stage(e))
+			continue;
+		it = string_list_insert(conflict, (const char *)e->name);
+		it->util = NULL;
+		if (ce_stage(e) == 1) {
+			if (active_nr <= ++i)
+				break;
 		}
+
+		/* Only handle regular files with both stages #2 and #3 */
+		if (i + 1 < active_nr) {
+			struct cache_entry *e2 = active_cache[i];
+			struct cache_entry *e3 = active_cache[i + 1];
+			if (ce_stage(e2) == 2 &&
+			    ce_stage(e3) == 3 &&
+			    ce_same_name(e, e3) &&
+			    S_ISREG(e2->ce_mode) &&
+			    S_ISREG(e3->ce_mode))
+				it->util = (void *) 1;
+		}
+
+		/* Skip the entries with the same name */
+		while (i < active_nr && ce_same_name(e, active_cache[i]))
+			i++;
+		i--; /* compensate for the outer loop */
 	}
 	return 0;
 }
 
+static void add_punted(struct string_list *merge_rr)
+{
+	int i;
+	struct string_list conflict = STRING_LIST_INIT_DUP;
+
+	find_conflict(&conflict);
+	for (i = 0; i < conflict.nr; i++) {
+		if (conflict.items[i].util)
+			continue;
+		string_list_insert(merge_rr, conflict.items[i].string);
+	}
+}
+
 static int merge(const char *name, const char *path)
 {
 	int ret;
@@ -451,6 +487,8 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 
 	for (i = 0; i < conflict.nr; i++) {
 		const char *path = conflict.items[i].string;
+		if (!conflict.items[i].util)
+			continue; /* punted */
 		if (!string_list_has_string(rr, path)) {
 			unsigned char sha1[20];
 			char *hex;
@@ -478,6 +516,8 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		const char *path = rr->items[i].string;
 		const char *name = (const char *)rr->items[i].util;
 
+		if (!name)
+			continue;
 		if (has_rerere_resolution(name)) {
 			if (!merge(name, path)) {
 				if (rerere_autoupdate)
@@ -552,6 +592,7 @@ int setup_rerere(struct string_list *merge_rr, int flags)
 	fd = hold_lock_file_for_update(&write_lock, merge_rr_path,
 				       LOCK_DIE_ON_ERROR);
 	read_rr(merge_rr);
+	add_punted(merge_rr);
 	return fd;
 }
 
@@ -607,6 +648,8 @@ int rerere_forget(const char **pathspec)
 	find_conflict(&conflict);
 	for (i = 0; i < conflict.nr; i++) {
 		struct string_list_item *it = &conflict.items[i];
+		if (!conflict.items[i].util)
+			continue; /* punted */
 		if (!match_pathspec(pathspec, it->string, strlen(it->string),
 				    0, NULL))
 			continue;
