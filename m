From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH v2 6/7] string_list: Fix argument order for string_list_append
Date: Sat, 26 Jun 2010 00:41:38 +0100
Message-ID: <20100625234140.18927.79321.julian@quantumfyre.co.uk>
References: <20100625234110.18927.33169.julian@quantumfyre.co.uk>
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 26 01:55:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSIkJ-0004gB-Nf
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 01:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097Ab0FYXzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 19:55:36 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:39010 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756089Ab0FYXzU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 19:55:20 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id B137C819C6DD;
	Sat, 26 Jun 2010 01:20:45 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id C49CB1EC128;
	Sat, 26 Jun 2010 00:45:46 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id fRq-b7lsL0me; Sat, 26 Jun 2010 00:45:45 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id BDCAB1EC125;
	Sat, 26 Jun 2010 00:45:45 +0100 (BST)
X-git-sha1: 25973359cc475fb6f127e7f65ffafcd761cf9fb3 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20100625234110.18927.33169.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149721>

Update the definition and callers of string_list_append to use the
string_list as the first argument.  This helps make the string_list
API easier to use by being more consistent.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 Documentation/technical/api-string-list.txt |    4 +-
 builtin/apply.c                             |    2 +-
 builtin/fast-export.c                       |    4 +-
 builtin/fetch.c                             |    8 ++--
 builtin/fmt-merge-msg.c                     |   18 +++++-----
 builtin/log.c                               |   20 ++++++------
 builtin/receive-pack.c                      |    2 +-
 builtin/remote.c                            |   46 +++++++++++++-------------
 builtin/rerere.c                            |    2 +-
 builtin/shortlog.c                          |    2 +-
 notes.c                                     |    6 ++--
 remote.c                                    |    2 +-
 revision.c                                  |    4 +-
 string-list.c                               |    2 +-
 string-list.h                               |    2 +-
 transport-helper.c                          |    4 +-
 16 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 6d8c24b..3f575bd 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -38,8 +38,8 @@ struct string_list list;
 int i;
 
 memset(&list, 0, sizeof(struct string_list));
-string_list_append("foo", &list);
-string_list_append("bar", &list);
+string_list_append(&list, "foo");
+string_list_append(&list, "bar");
 for (i = 0; i < list.nr; i++)
 	printf("%s\n", list.items[i].string)
 ----
diff --git a/builtin/apply.c b/builtin/apply.c
index c5c6d10..12ef9ea 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3394,7 +3394,7 @@ static void add_name_limit(const char *name, int exclude)
 {
 	struct string_list_item *it;
 
-	it = string_list_append(name, &limit_by_name);
+	it = string_list_append(&limit_by_name, name);
 	it->util = exclude ? NULL : (void *) 1;
 }
 
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index c6dd71a..9fe25ff 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -438,7 +438,7 @@ static void get_tags_and_duplicates(struct object_array *pending,
 			/* handle nested tags */
 			while (tag && tag->object.type == OBJ_TAG) {
 				parse_object(tag->object.sha1);
-				string_list_append(full_name, extra_refs)->util = tag;
+				string_list_append(extra_refs, full_name)->util = tag;
 				tag = (struct tag *)tag->tagged;
 			}
 			if (!tag)
@@ -464,7 +464,7 @@ static void get_tags_and_duplicates(struct object_array *pending,
 		}
 		if (commit->util)
 			/* more than one name for the same object */
-			string_list_append(full_name, extra_refs)->util = commit;
+			string_list_append(extra_refs, full_name)->util = commit;
 		else
 			commit->util = full_name;
 	}
diff --git a/builtin/fetch.c b/builtin/fetch.c
index bb8337a..6eb1dfe 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -746,7 +746,7 @@ static int get_one_remote_for_fetch(struct remote *remote, void *priv)
 {
 	struct string_list *list = priv;
 	if (!remote->skip_default_update)
-		string_list_append(remote->name, list);
+		string_list_append(list, remote->name);
 	return 0;
 }
 
@@ -765,8 +765,8 @@ static int get_remote_group(const char *key, const char *value, void *priv)
 		int space = strcspn(value, " \t\n");
 		while (*value) {
 			if (space > 1) {
-				string_list_append(xstrndup(value, space),
-						   g->list);
+				string_list_append(g->list,
+						   xstrndup(value, space));
 			}
 			value += space + (value[space] != '\0');
 			space = strcspn(value, " \t\n");
@@ -788,7 +788,7 @@ static int add_remote_or_group(const char *name, struct string_list *list)
 		if (!remote_is_configured(name))
 			return 0;
 		remote = remote_get(name);
-		string_list_append(remote->name, list);
+		string_list_append(list, remote->name);
 	}
 	return 1;
 }
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 4420425..bc3c5e6 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -82,7 +82,7 @@ static int handle_line(char *line)
 
 	item = unsorted_string_list_lookup(&srcs, src);
 	if (!item) {
-		item = string_list_append(src, &srcs);
+		item = string_list_append(&srcs, src);
 		item->util = xcalloc(1, sizeof(struct src_data));
 		init_src_data(item->util);
 	}
@@ -93,19 +93,19 @@ static int handle_line(char *line)
 		src_data->head_status |= 1;
 	} else if (!prefixcmp(line, "branch ")) {
 		origin = line + 7;
-		string_list_append(origin, &src_data->branch);
+		string_list_append(&src_data->branch, origin);
 		src_data->head_status |= 2;
 	} else if (!prefixcmp(line, "tag ")) {
 		origin = line;
-		string_list_append(origin + 4, &src_data->tag);
+		string_list_append(&src_data->tag, origin + 4);
 		src_data->head_status |= 2;
 	} else if (!prefixcmp(line, "remote branch ")) {
 		origin = line + 14;
-		string_list_append(origin, &src_data->r_branch);
+		string_list_append(&src_data->r_branch, origin);
 		src_data->head_status |= 2;
 	} else {
 		origin = src;
-		string_list_append(line, &src_data->generic);
+		string_list_append(&src_data->generic, line);
 		src_data->head_status |= 2;
 	}
 
@@ -118,7 +118,7 @@ static int handle_line(char *line)
 		sprintf(new_origin, "%s of %s", origin, src);
 		origin = new_origin;
 	}
-	string_list_append(origin, &origins)->util = sha1;
+	string_list_append(&origins, origin)->util = sha1;
 	return 0;
 }
 
@@ -176,10 +176,10 @@ static void shortlog(const char *name, unsigned char *sha1,
 		strbuf_ltrim(&sb);
 
 		if (!sb.len)
-			string_list_append(sha1_to_hex(commit->object.sha1),
-					   &subjects);
+			string_list_append(&subjects,
+					   sha1_to_hex(commit->object.sha1));
 		else
-			string_list_append(strbuf_detach(&sb, NULL), &subjects);
+			string_list_append(&subjects, strbuf_detach(&sb, NULL));
 	}
 
 	if (count > limit)
diff --git a/builtin/log.c b/builtin/log.c
index f068583..7cb9317 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -535,13 +535,13 @@ static void add_header(const char *value)
 		len--;
 
 	if (!strncasecmp(value, "to: ", 4)) {
-		item = string_list_append(value + 4, &extra_to);
+		item = string_list_append(&extra_to, value + 4);
 		len -= 4;
 	} else if (!strncasecmp(value, "cc: ", 4)) {
-		item = string_list_append(value + 4, &extra_cc);
+		item = string_list_append(&extra_cc, value + 4);
 		len -= 4;
 	} else {
-		item = string_list_append(value, &extra_hdr);
+		item = string_list_append(&extra_hdr, value);
 	}
 
 	item->string[len] = '\0';
@@ -566,13 +566,13 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "format.to")) {
 		if (!value)
 			return config_error_nonbool(var);
-		string_list_append(value, &extra_to);
+		string_list_append(&extra_to, value);
 		return 0;
 	}
 	if (!strcmp(var, "format.cc")) {
 		if (!value)
 			return config_error_nonbool(var);
-		string_list_append(value, &extra_cc);
+		string_list_append(&extra_cc, value);
 		return 0;
 	}
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
@@ -959,7 +959,7 @@ static int to_callback(const struct option *opt, const char *arg, int unset)
 	if (unset)
 		string_list_clear(&extra_to, 0);
 	else
-		string_list_append(arg, &extra_to);
+		string_list_append(&extra_to, arg);
 	return 0;
 }
 
@@ -968,7 +968,7 @@ static int cc_callback(const struct option *opt, const char *arg, int unset)
 	if (unset)
 		string_list_clear(&extra_cc, 0);
 	else
-		string_list_append(arg, &extra_cc);
+		string_list_append(&extra_cc, arg);
 	return 0;
 }
 
@@ -1251,7 +1251,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
 	if (in_reply_to) {
 		const char *msgid = clean_message_id(in_reply_to);
-		string_list_append(msgid, rev.ref_message_ids);
+		string_list_append(rev.ref_message_ids, msgid);
 	}
 	rev.numbered_files = numbered_files;
 	rev.patch_suffix = fmt_patch_suffix;
@@ -1298,8 +1298,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 				    && (!cover_letter || rev.nr > 1))
 					free(rev.message_id);
 				else
-					string_list_append(rev.message_id,
-							   rev.ref_message_ids);
+					string_list_append(rev.ref_message_ids,
+							   rev.message_id);
 			}
 			gen_message_id(&rev, sha1_to_hex(commit->object.sha1));
 		}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 08bc089..d634b5a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -534,7 +534,7 @@ static void check_aliased_updates(struct command *commands)
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		struct string_list_item *item =
-			string_list_append(cmd->ref_name, &ref_list);
+			string_list_append(&ref_list, cmd->ref_name);
 		item->util = (void *)cmd;
 	}
 	sort_string_list(&ref_list);
diff --git a/builtin/remote.c b/builtin/remote.c
index 70ecf3d..6699bc5 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -94,7 +94,7 @@ static int opt_parse_track(const struct option *opt, const char *arg, int not)
 	if (not)
 		string_list_clear(list, 0);
 	else
-		string_list_append(arg, list);
+		string_list_append(list, arg);
 	return 0;
 }
 
@@ -181,7 +181,7 @@ static int add(int argc, const char **argv)
 	strbuf_addf(&buf, "remote.%s.fetch", name);
 
 	if (track.nr == 0)
-		string_list_append("*", &track);
+		string_list_append(&track, "*");
 	for (i = 0; i < track.nr; i++) {
 		if (add_branch(buf.buf, track.items[i].string,
 				name, mirror, &buf2))
@@ -278,11 +278,11 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 			while (space) {
 				char *merge;
 				merge = xstrndup(value, space - value);
-				string_list_append(merge, &info->merge);
+				string_list_append(&info->merge, merge);
 				value = abbrev_branch(space + 1);
 				space = strchr(value, ' ');
 			}
-			string_list_append(xstrdup(value), &info->merge);
+			string_list_append(&info->merge, xstrdup(value));
 		} else
 			info->rebase = git_config_bool(orig_key, value);
 	}
@@ -319,14 +319,14 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 	for (ref = fetch_map; ref; ref = ref->next) {
 		unsigned char sha1[20];
 		if (!ref->peer_ref || read_ref(ref->peer_ref->name, sha1))
-			string_list_append(abbrev_branch(ref->name), &states->new);
+			string_list_append(&states->new, abbrev_branch(ref->name));
 		else
-			string_list_append(abbrev_branch(ref->name), &states->tracked);
+			string_list_append(&states->tracked, abbrev_branch(ref->name));
 	}
 	stale_refs = get_stale_heads(states->remote, fetch_map);
 	for (ref = stale_refs; ref; ref = ref->next) {
 		struct string_list_item *item =
-			string_list_append(abbrev_branch(ref->name), &states->stale);
+			string_list_append(&states->stale, abbrev_branch(ref->name));
 		item->util = xstrdup(ref->name);
 	}
 	free_refs(stale_refs);
@@ -375,8 +375,8 @@ static int get_push_ref_states(const struct ref *remote_refs,
 			continue;
 		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
 
-		item = string_list_append(abbrev_branch(ref->peer_ref->name),
-					  &states->push);
+		item = string_list_append(&states->push,
+					  abbrev_branch(ref->peer_ref->name));
 		item->util = xcalloc(sizeof(struct push_info), 1);
 		info = item->util;
 		info->forced = ref->force;
@@ -411,7 +411,7 @@ static int get_push_ref_states_noquery(struct ref_states *states)
 
 	states->push.strdup_strings = 1;
 	if (!remote->push_refspec_nr) {
-		item = string_list_append("(matching)", &states->push);
+		item = string_list_append(&states->push, "(matching)");
 		info = item->util = xcalloc(sizeof(struct push_info), 1);
 		info->status = PUSH_STATUS_NOTQUERIED;
 		info->dest = xstrdup(item->string);
@@ -419,11 +419,11 @@ static int get_push_ref_states_noquery(struct ref_states *states)
 	for (i = 0; i < remote->push_refspec_nr; i++) {
 		struct refspec *spec = remote->push + i;
 		if (spec->matching)
-			item = string_list_append("(matching)", &states->push);
+			item = string_list_append(&states->push, "(matching)");
 		else if (strlen(spec->src))
-			item = string_list_append(spec->src, &states->push);
+			item = string_list_append(&states->push, spec->src);
 		else
-			item = string_list_append("(delete)", &states->push);
+			item = string_list_append(&states->push, "(delete)");
 
 		info = item->util = xcalloc(sizeof(struct push_info), 1);
 		info->forced = spec->force;
@@ -447,7 +447,7 @@ static int get_head_names(const struct ref *remote_refs, struct ref_states *stat
 	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
 				    fetch_map, 1);
 	for (ref = matches; ref; ref = ref->next)
-		string_list_append(abbrev_branch(ref->name), &states->heads);
+		string_list_append(&states->heads, abbrev_branch(ref->name));
 
 	free_refs(fetch_map);
 	free_refs(matches);
@@ -511,8 +511,8 @@ static int add_branch_for_removal(const char *refname,
 	if (prefixcmp(refname, "refs/remotes")) {
 		/* advise user how to delete local branches */
 		if (!prefixcmp(refname, "refs/heads/"))
-			string_list_append(abbrev_branch(refname),
-					   branches->skipped);
+			string_list_append(branches->skipped,
+					   abbrev_branch(refname));
 		/* silently skip over other non-remote refs */
 		return 0;
 	}
@@ -521,7 +521,7 @@ static int add_branch_for_removal(const char *refname,
 	if (flags & REF_ISSYMREF)
 		return unlink(git_path("%s", refname));
 
-	item = string_list_append(refname, branches->branches);
+	item = string_list_append(branches->branches, refname);
 	item->util = xmalloc(20);
 	hashcpy(item->util, sha1);
 
@@ -546,7 +546,7 @@ static int read_remote_branches(const char *refname,
 
 	strbuf_addf(&buf, "refs/remotes/%s", rename->old);
 	if (!prefixcmp(refname, buf.buf)) {
-		item = string_list_append(xstrdup(refname), rename->remote_branches);
+		item = string_list_append(rename->remote_branches, xstrdup(refname));
 		symref = resolve_ref(refname, orig_sha1, 1, &flag);
 		if (flag & REF_ISSYMREF)
 			item->util = xstrdup(symref);
@@ -832,7 +832,7 @@ static int append_ref_to_tracked_list(const char *refname,
 	memset(&refspec, 0, sizeof(refspec));
 	refspec.dst = (char *)refname;
 	if (!remote_find_tracking(states->remote, &refspec))
-		string_list_append(abbrev_branch(refspec.src), &states->tracked);
+		string_list_append(&states->tracked, abbrev_branch(refspec.src));
 
 	return 0;
 }
@@ -980,7 +980,7 @@ static int add_push_to_show_info(struct string_list_item *push_item, void *cb_da
 		show_info->width = n;
 	if ((n = strlen(push_info->dest)) > show_info->width2)
 		show_info->width2 = n;
-	item = string_list_append(push_item->string, show_info->list);
+	item = string_list_append(show_info->list, push_item->string);
 	item->util = push_item->util;
 	return 0;
 }
@@ -1460,10 +1460,10 @@ static int get_one_entry(struct remote *remote, void *priv)
 
 	if (remote->url_nr > 0) {
 		strbuf_addf(&url_buf, "%s (fetch)", remote->url[0]);
-		string_list_append(remote->name, list)->util =
+		string_list_append(list, remote->name)->util =
 				strbuf_detach(&url_buf, NULL);
 	} else
-		string_list_append(remote->name, list)->util = NULL;
+		string_list_append(list, remote->name)->util = NULL;
 	if (remote->pushurl_nr) {
 		url = remote->pushurl;
 		url_nr = remote->pushurl_nr;
@@ -1474,7 +1474,7 @@ static int get_one_entry(struct remote *remote, void *priv)
 	for (i = 0; i < url_nr; i++)
 	{
 		strbuf_addf(&url_buf, "%s (push)", url[i]);
-		string_list_append(remote->name, list)->util =
+		string_list_append(list, remote->name)->util =
 				strbuf_detach(&url_buf, NULL);
 	}
 
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 0048f9e..980d542 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -59,7 +59,7 @@ static void garbage_collect(struct string_list *rr)
 		cutoff = (has_rerere_resolution(e->d_name)
 			  ? cutoff_resolve : cutoff_noresolve);
 		if (then < now - cutoff * 86400)
-			string_list_append(e->d_name, &to_remove);
+			string_list_append(&to_remove, e->d_name);
 	}
 	for (i = 0; i < to_remove.nr; i++)
 		unlink_rr_item(to_remove.items[i].string);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 86d32fb..0a9681b 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -115,7 +115,7 @@ static void insert_one_record(struct shortlog *log,
 		}
 	}
 
-	string_list_append(buffer, item->util);
+	string_list_append(item->util, buffer);
 }
 
 static void read_from_stdin(struct shortlog *log)
diff --git a/notes.c b/notes.c
index f379681..d4e0df2 100644
--- a/notes.c
+++ b/notes.c
@@ -838,7 +838,7 @@ static int string_list_add_one_ref(const char *path, const unsigned char *sha1,
 {
 	struct string_list *refs = cb;
 	if (!unsorted_string_list_has_string(refs, path))
-		string_list_append(path, refs);
+		string_list_append(refs, path);
 	return 0;
 }
 
@@ -851,7 +851,7 @@ void string_list_add_refs_by_glob(struct string_list *list, const char *glob)
 		if (get_sha1(glob, sha1))
 			warning("notes ref %s is invalid", glob);
 		if (!unsorted_string_list_has_string(list, glob))
-			string_list_append(glob, list);
+			string_list_append(list, glob);
 	}
 }
 
@@ -983,7 +983,7 @@ void init_display_notes(struct display_notes_opt *opt)
 	assert(!display_notes_trees);
 
 	if (!opt || !opt->suppress_default_notes) {
-		string_list_append(default_notes_ref(), &display_notes_refs);
+		string_list_append(&display_notes_refs, default_notes_ref());
 		display_ref_env = getenv(GIT_NOTES_DISPLAY_REF_ENVIRONMENT);
 		if (display_ref_env) {
 			string_list_add_refs_from_colon_sep(&display_notes_refs,
diff --git a/remote.c b/remote.c
index 43f00f1..afbba47 100644
--- a/remote.c
+++ b/remote.c
@@ -1710,7 +1710,7 @@ struct ref *get_stale_heads(struct remote *remote, struct ref *fetch_map)
 	info.ref_names = &ref_names;
 	info.stale_refs_tail = &stale_refs;
 	for (ref = fetch_map; ref; ref = ref->next)
-		string_list_append(ref->name, &ref_names);
+		string_list_append(&ref_names, ref->name);
 	sort_string_list(&ref_names);
 	for_each_ref(get_stale_heads_cb, &info);
 	string_list_clear(&ref_names, 0);
diff --git a/revision.c b/revision.c
index 5403581..52379e1 100644
--- a/revision.c
+++ b/revision.c
@@ -1312,8 +1312,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		else
 			strbuf_addstr(&buf, "refs/notes/");
 		strbuf_addstr(&buf, arg+13);
-		string_list_append(strbuf_detach(&buf, NULL),
-				   revs->notes_opt.extra_notes_refs);
+		string_list_append(revs->notes_opt.extra_notes_refs,
+				   strbuf_detach(&buf, NULL));
 	} else if (!strcmp(arg, "--no-notes")) {
 		revs->show_notes = 0;
 		revs->show_notes_given = 1;
diff --git a/string-list.c b/string-list.c
index 7b616ae..9b023a2 100644
--- a/string-list.c
+++ b/string-list.c
@@ -148,7 +148,7 @@ void print_string_list(const struct string_list *p, const char *text)
 		printf("%s:%p\n", p->items[i].string, p->items[i].util);
 }
 
-struct string_list_item *string_list_append(const char *string, struct string_list *list)
+struct string_list_item *string_list_append(struct string_list *list, const char *string)
 {
 	ALLOC_GROW(list->items, list->nr + 1, list->alloc);
 	list->items[list->nr].string =
diff --git a/string-list.h b/string-list.h
index 4a30e9d..680d600 100644
--- a/string-list.h
+++ b/string-list.h
@@ -35,7 +35,7 @@ struct string_list_item *string_list_insert_at_index(struct string_list *list,
 struct string_list_item *string_list_lookup(struct string_list *list, const char *string);
 
 /* Use these functions only on unsorted lists: */
-struct string_list_item *string_list_append(const char *string, struct string_list *list);
+struct string_list_item *string_list_append(struct string_list *list, const char *string);
 void sort_string_list(struct string_list *list);
 int unsorted_string_list_has_string(struct string_list *list, const char *string);
 struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
diff --git a/transport-helper.c b/transport-helper.c
index 0381de5..191fbf7 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -727,10 +727,10 @@ static int push_refs_with_export(struct transport *transport,
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
 		if (private && !get_sha1(private, sha1)) {
 			strbuf_addf(&buf, "^%s", private);
-			string_list_append(strbuf_detach(&buf, NULL), &revlist_args);
+			string_list_append(&revlist_args, strbuf_detach(&buf, NULL));
 		}
 
-		string_list_append(ref->name, &revlist_args);
+		string_list_append(&revlist_args, ref->name);
 
 	}
 
-- 
1.7.0.4
