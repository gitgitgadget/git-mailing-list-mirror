Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A7BE1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 13:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933109AbdCaNvr (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 09:51:47 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:56951 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933015AbdCaNvn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 09:51:43 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue102
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MQNsy-1chnr92h3M-00TmzL; Fri, 31
 Mar 2017 15:51:35 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH v3 3/4] name-rev: provide debug output
Date:   Fri, 31 Mar 2017 15:51:23 +0200
Message-Id: <21cf9d6f55d17463ab6eccdd78d57cf4a1b8e9e1.1490967948.git.git@grubix.eu>
X-Mailer: git-send-email 2.12.2.739.gfc3eb97820
In-Reply-To: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com>
References: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <cover.1490967948.git.git@grubix.eu>
References: <cover.1490967948.git.git@grubix.eu>
X-Provags-ID: V03:K0:XfQwr7dT6hYkFbfl8m75v/cTjBE1UJ+e9Zojhe4DH1v0gH0M4n0
 8xCyUXfZChkc+L/X4WJDrL2vel9C8hjAB70KoGzTGiuzFEqwC15ngd9OhM8f9MAHY214P0l
 hJ5eBbmXaA5hPLleYmqSF/DuyuQtvbgb9UTRiCV6AYYKjWZ5HuBTvUIAuFaWQDsN1wdOWlw
 VgS1S9PVA/ocNAQ69vBHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AbQCy2YAk2g=:w2WXFc8M9q7EjacookmlCi
 WqX49/hiV7RF6xtXk8T4VvUV4Sgf8jzIeMfk0YXMUmLc8Mg8vrfnNrqAbkU+EoZiLb0pLmlCj
 /sKnhsLuQSAg789mq8AS4JgkXWg6JZbkVqyUnY1/pfs5NLCRz2VoR3xvzjZaftPAqeCAUX+2F
 49ynQWWctdnqK5Uqs4NEUYC12BP3V0R5O7MPeMD3nDStislvtdIFGpHxRzAIGZ+sEOpLmDgaF
 75Fp6IsvLeYupMP2ZPPY+NnJ45J9aWyQpXZPiQWxBQn9XXJeAkCIALcgyE6jex14ZsSimGa+Q
 T5XRDrt0KY+yxHBCp3+g5F9D50HRNPukXYrJdIyrk4pscfA2MHplVohi15ZzQAP4MnlF2quvs
 jekasDh9+ef905fnagfW/lRN/Y2mM1mcrOWkUyM6ylbsEA1HEGmjXnnaeq/CFVz8IPs65FYkE
 Tjn/AFRHAM7kmnUkTUQfxok+tPklLklSlZw3lViGK/XHnnWdeTHfMVOe+8fHGgc9pWHkjmolC
 HMHt2ZXhuDYJr8YtILlk3AIZ0w1ndRUSovdW/O21vq22O1wBhkFEhA97HHaIwQv0W8zSJ/N5b
 k0gnAVz4vgCuu+zTJCgYBwWVv1i0iKCBzo7ZkO+LvojKQq0S+cXY9E8aV6R2OcfShdpjyh+Vi
 VPiU1kCw8H14WFpKkYCCfn2c60C/Oq/fXUGEfSzFIew4ZOBT6YtT+slAiPWdXLuAnnZA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, `git describe --contains --debug` does not create any debug
output because it does not pass the flag down to `git name-rev`, which
does not know that flag.

Teach the latter that flag, so that the former can pass it down (in
the following commit).

The output is patterned after that of `git describe --debug`, with the
following differences:

describe loops over all args to describe, then over all possible
descriptions; name-rev does it the other way round. Therefore, we need
to amend each possible description by the arg that it is for (and we
leave out the "searching to describe" header).

The date cut-off for name-rev kicks in way more often than the candidate
number cut-off of describe, so we do not clutter the output with the
cut-off.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 Documentation/git-name-rev.txt |  5 ++++
 builtin/name-rev.c             | 64 +++++++++++++++++++++++++++++++++---------
 2 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index e8e68f528c..fd78ee86e8 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -42,6 +42,11 @@ OPTIONS
 --all::
 	List all commits reachable from all refs
 
+--debug::
+	Verbosely display information about the searching strategy
+	being employed to standard error.  The symbolic name will still
+	be printed to standard out.
+
 --stdin::
 	Transform stdin by substituting all the 40-character SHA-1
 	hexes (say $hex) with "$hex ($rev_name)".  When used with
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index bf7ed015ae..51302a79ba 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -18,6 +18,10 @@ typedef struct rev_name {
 
 static long cutoff = LONG_MAX;
 
+static const char *prio_names[] = {
+	N_("head"), N_("lightweight"), N_("annotated"),
+};
+
 /* How many generations are maximally preferred over _one_ merge traversal? */
 #define MERGE_TRAVERSAL_WEIGHT 65535
 
@@ -59,10 +63,19 @@ static int is_better_name(struct rev_name *name,
 	return 0;
 }
 
+struct name_ref_data {
+	int tags_only;
+	int name_only;
+	int debug;
+	struct string_list ref_filters;
+	struct string_list exclude_filters;
+	struct object_array *revs;
+};
+
 static void name_rev(struct commit *commit,
 		const char *tip_name, unsigned long taggerdate,
 		int generation, int distance, int from_tag,
-		int deref)
+		int deref, struct name_ref_data *data)
 {
 	struct rev_name *name = (struct rev_name *)commit->util;
 	struct commit_list *parents;
@@ -75,6 +88,7 @@ static void name_rev(struct commit *commit,
 
 	if (deref) {
 		tip_name = xstrfmt("%s^0", tip_name);
+		from_tag += 1;
 
 		if (generation)
 			die("generation: %d, but deref?", generation);
@@ -87,6 +101,36 @@ static void name_rev(struct commit *commit,
 	} else if (is_better_name(name, tip_name, taggerdate,
 				  generation, distance, from_tag)) {
 copy_data:
+		if (data->debug) {
+			int i;
+			static int label_width = -1;
+			static int name_width = -1;
+			if (label_width < 0) {
+				int w;
+				for (i = 0; i < ARRAY_SIZE(prio_names); i++) {
+					w = strlen(_(prio_names[i]));
+					if (label_width < w)
+						label_width = w;
+				}
+			}
+			if (name_width < 0) {
+				int w;
+				for (i = 0; i < data->revs->nr; i++) {
+					w = strlen(data->revs->objects[i].name);
+					if (name_width < w)
+						name_width = w;
+				}
+			}
+			for (i = 0; i < data->revs->nr; i++)
+				if (!oidcmp(&commit->object.oid,
+					    &data->revs->objects[i].item->oid))
+					fprintf(stderr, " %-*s %8d %-*s %s~%d\n",
+						label_width,
+						_(prio_names[from_tag]),
+						distance, name_width,
+						data->revs->objects[i].name,
+						tip_name, generation);
+		}
 		name->tip_name = tip_name;
 		name->taggerdate = taggerdate;
 		name->generation = generation;
@@ -112,11 +156,11 @@ static void name_rev(struct commit *commit,
 
 			name_rev(parents->item, new_name, taggerdate, 0,
 				 distance + MERGE_TRAVERSAL_WEIGHT,
-				 from_tag, 0);
+				 from_tag, 0, data);
 		} else {
 			name_rev(parents->item, tip_name, taggerdate,
 				 generation + 1, distance + 1,
-				 from_tag, 0);
+				 from_tag, 0, data);
 		}
 	}
 }
@@ -146,13 +190,6 @@ static const char *name_ref_abbrev(const char *refname, int shorten_unambiguous)
 	return refname;
 }
 
-struct name_ref_data {
-	int tags_only;
-	int name_only;
-	struct string_list ref_filters;
-	struct string_list exclude_filters;
-};
-
 static struct tip_table {
 	struct tip_table_entry {
 		unsigned char sha1[20];
@@ -236,7 +273,6 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 	}
 
 	add_to_tip_table(oid->hash, path, can_abbreviate_output);
-
 	while (o && o->type == OBJ_TAG) {
 		struct tag *t = (struct tag *) o;
 		if (!t->tagged)
@@ -253,7 +289,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 			taggerdate = ((struct commit *)o)->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
 		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
-			 from_tag, deref);
+			 from_tag, deref, data);
 	}
 	return 0;
 }
@@ -383,7 +419,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
 	struct object_array revs = OBJECT_ARRAY_INIT;
 	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
-	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
+	struct name_ref_data data = { 0, 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
 	struct option opts[] = {
 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only names (no SHA-1)")),
 		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
@@ -393,6 +429,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 				   N_("ignore refs matching <pattern>")),
 		OPT_GROUP(""),
 		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
+		OPT_BOOL(0, "debug", &data.debug, N_("debug search strategy on stderr")),
 		OPT_BOOL(0, "stdin", &transform_stdin, N_("read from stdin")),
 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
 		OPT_BOOL(0, "always",     &always,
@@ -458,6 +495,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 
 	if (cutoff)
 		cutoff = cutoff - CUTOFF_DATE_SLOP;
+	data.revs = &revs;
 	for_each_ref(name_ref, &data);
 
 	if (transform_stdin) {
-- 
2.12.2.739.gfc3eb97820

