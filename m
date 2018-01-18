Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F41201FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 21:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754473AbeARVj5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 16:39:57 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:54709 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbeARVjz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 16:39:55 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id cHubeTexPAp17cHuceDXXs; Thu, 18 Jan 2018 21:39:54 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=O7oGbG_i3egFAOVc8pEA:9
 a=P8_fiZRkf_7v9yzX:21 a=f7Z93Cl4wksFwlcP:21 a=wPNLvfGTeEIA:10
Message-ID: <D8F2BF74F8CF46A3B61EE75301953516@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Jacob Keller" <jacob.keller@gmail.com>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <b9cb2d915aa4ff564b1960ce0352664b1d26eecb.1516225925.git.johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/8] rebase-helper --make-script: introduce a flag to recreate merges
Date:   Thu, 18 Jan 2018 21:39:55 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180118-34, 18/01/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfA3+ppGPKv7zeD0FzKWgtx1Nwnb5D54JJOts/IkaBre8bv0YHYRlwPn2FBuxmp4EiwJmlEWae2Q7nyP/UcqzIPSlEyowO+kQtwRCKPLvmen0tw9MjsDl
 eQbORmtGFL5G8UlkCCyxh6k8NMnXxhAxeX9VLVoOeBCd22d5PeeVHkPiqLGJoAWBEvctUt4JlQtAaD+xkM7+G8108FYxW3Rqmj/JCSvbOgs1NhKqfRq1Sgec
 uja1ZKJDZEvDUj+NlzNgoyt6F+VP37ywHEtW9dZ+lqs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> The sequencer just learned a new commands intended to recreate branch
> structure (similar in spirit to --preserve-merges, but with a
> substantially less-broken design).
>
> Let's allow the rebase--helper to generate todo lists making use of
> these commands, triggered by the new --recreate-merges option. For a
> commit topology like this:
>
> A - B - C
>   \   /
>     D

Could the topology include the predecessor for context. Alo it is easy for 
readers to become confused between the arcs of the graphs and the nodes of 
the graphs, such that we confuse 'commits as patches' with 'commits as 
snapshots'. It might need an 'Aa' distinction between the two types, 
especially around merges and potential evilness.

>
> the generated todo list would look like this:
>
> # branch D
> pick 0123 A
> label branch-point
> pick 1234 D
> label D
>
> reset branch-point
> pick 2345 B
> merge 3456 D C
>
> To keep things simple, we first only implement support for merge commits
> with exactly two parents, leaving support for octopus merges to a later
> patch in this patch series.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> builtin/rebase--helper.c |   4 +-
> sequencer.c              | 343 
> ++++++++++++++++++++++++++++++++++++++++++++++-
> sequencer.h              |   1 +
> 3 files changed, 345 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> index 7daee544b7b..a34ab5c0655 100644
> --- a/builtin/rebase--helper.c
> +++ b/builtin/rebase--helper.c
> @@ -12,7 +12,7 @@ static const char * const builtin_rebase_helper_usage[] 
> = {
> int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
> {
>  struct replay_opts opts = REPLAY_OPTS_INIT;
> - unsigned flags = 0, keep_empty = 0;
> + unsigned flags = 0, keep_empty = 0, recreate_merges = 0;
>  int abbreviate_commands = 0;
>  enum {
>  CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
> @@ -22,6 +22,7 @@ int cmd_rebase__helper(int argc, const char **argv, 
> const char *prefix)
>  struct option options[] = {
>  OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
>  OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
> + OPT_BOOL(0, "recreate-merges", &recreate_merges, N_("recreate merge 
> commits")),
>  OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
>  CONTINUE),
>  OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
> @@ -55,6 +56,7 @@ int cmd_rebase__helper(int argc, const char **argv, 
> const char *prefix)
>
>  flags |= keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
>  flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
> + flags |= recreate_merges ? TODO_LIST_RECREATE_MERGES : 0;
>  flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
>
>  if (command == CONTINUE && argc == 1)
> diff --git a/sequencer.c b/sequencer.c
> index a96255426e7..1bef16647b4 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -23,6 +23,8 @@
> #include "hashmap.h"
> #include "unpack-trees.h"
> #include "worktree.h"
> +#include "oidmap.h"
> +#include "oidset.h"
>
> #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>
> @@ -2785,6 +2787,335 @@ void append_signoff(struct strbuf *msgbuf, int 
> ignore_footer, unsigned flag)
>  strbuf_release(&sob);
> }
>
> +struct labels_entry {
> + struct hashmap_entry entry;
> + char label[FLEX_ARRAY];
> +};
> +
> +static int labels_cmp(const void *fndata, const struct labels_entry *a,
> +       const struct labels_entry *b, const void *key)
> +{
> + return key ? strcmp(a->label, key) : strcmp(a->label, b->label);
> +}
> +
> +struct string_entry {
> + struct oidmap_entry entry;
> + char string[FLEX_ARRAY];
> +};
> +
> +struct label_state {
> + struct oidmap commit2label;
> + struct hashmap labels;
> + struct strbuf buf;
> +};
> +
> +static const char *label_oid(struct object_id *oid, const char *label,
> +      struct label_state *state)
> +{
> + struct labels_entry *labels_entry;
> + struct string_entry *string_entry;
> + struct object_id dummy;
> + size_t len;
> + int i;
> +
> + string_entry = oidmap_get(&state->commit2label, oid);
> + if (string_entry)
> + return string_entry->string;
> +
> + /*
> + * For "uninteresting" commits, i.e. commits that are not to be
> + * rebased, and which can therefore not be labeled, we use a unique
> + * abbreviation of the commit name. This is slightly more complicated
> + * than calling find_unique_abbrev() because we also need to make
> + * sure that the abbreviation does not conflict with any other
> + * label.
> + *
> + * We disallow "interesting" commits to be labeled by a string that
> + * is a valid full-length hash, to ensure that we always can find an
> + * abbreviation for any uninteresting commit's names that does not
> + * clash with any other label.
> + */
> + if (!label) {
> + char *p;
> +
> + strbuf_reset(&state->buf);
> + strbuf_grow(&state->buf, GIT_SHA1_HEXSZ);
> + label = p = state->buf.buf;
> +
> + find_unique_abbrev_r(p, oid->hash, default_abbrev);
> +
> + /*
> + * We may need to extend the abbreviated hash so that there is
> + * no conflicting label.
> + */
> + if (hashmap_get_from_hash(&state->labels, strihash(p), p)) {
> + size_t i = strlen(p) + 1;
> +
> + oid_to_hex_r(p, oid);
> + for (; i < GIT_SHA1_HEXSZ; i++) {
> + char save = p[i];
> + p[i] = '\0';
> + if (!hashmap_get_from_hash(&state->labels,
> +    strihash(p), p))
> + break;
> + p[i] = save;
> + }
> + }
> + } else if (((len = strlen(label)) == GIT_SHA1_RAWSZ &&
> +     !get_oid_hex(label, &dummy)) ||
> +    hashmap_get_from_hash(&state->labels,
> + strihash(label), label)) {
> + /*
> + * If the label already exists, or if the label is a valid full
> + * OID, we append a dash and a number to make it unique.
> + */
> + struct strbuf *buf = &state->buf;
> +
> + strbuf_reset(buf);
> + strbuf_add(buf, label, len);
> +
> + for (i = 2; ; i++) {
> + strbuf_setlen(buf, len);
> + strbuf_addf(buf, "-%d", i);
> + if (!hashmap_get_from_hash(&state->labels,
> +    strihash(buf->buf),
> +    buf->buf))
> + break;
> + }
> +
> + label = buf->buf;
> + }
> +
> + FLEX_ALLOC_STR(labels_entry, label, label);
> + hashmap_entry_init(labels_entry, strihash(label));
> + hashmap_add(&state->labels, labels_entry);
> +
> + FLEX_ALLOC_STR(string_entry, string, label);
> + oidcpy(&string_entry->entry.oid, oid);
> + oidmap_put(&state->commit2label, string_entry);
> +
> + return string_entry->string;
> +}
> +
> +static int make_script_with_merges(struct pretty_print_context *pp,
> +    struct rev_info *revs, FILE *out,
> +    unsigned flags)
> +{
> + int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
> + struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
> + struct strbuf label = STRBUF_INIT;
> + struct commit_list *commits = NULL, **tail = &commits, *iter;
> + struct commit_list *tips = NULL, **tips_tail = &tips;
> + struct commit *commit;
> + struct oidmap commit2todo = OIDMAP_INIT;
> + struct string_entry *entry;
> + struct oidset interesting = OIDSET_INIT, child_seen = OIDSET_INIT,
> + shown = OIDSET_INIT;
> + struct label_state state = { OIDMAP_INIT, { NULL }, STRBUF_INIT };
> +
> + int abbr = flags & TODO_LIST_ABBREVIATE_CMDS;
> + const char *p = abbr ? "p" : "pick", *l = abbr ? "l" : "label",
> + *t = abbr ? "t" : "reset", *b = abbr ? "b" : "bud",
> + *m = abbr ? "m" : "merge";
> +
> + oidmap_init(&commit2todo, 0);
> + oidmap_init(&state.commit2label, 0);
> + hashmap_init(&state.labels, (hashmap_cmp_fn) labels_cmp, NULL, 0);
> + strbuf_init(&state.buf, 32);
> +
> + if (revs->cmdline.nr && (revs->cmdline.rev[0].flags & BOTTOM)) {
> + struct object_id *oid = &revs->cmdline.rev[0].item->oid;
> + FLEX_ALLOC_STR(entry, string, "onto");

"onto" Needs documentation / commit message?


> + oidcpy(&entry->entry.oid, oid);
> + oidmap_put(&state.commit2label, entry);
> + }
> +
> + /*
> + * First phase:
> + * - get onelines for all commits
> + * - gather all branch tips (i.e. 2nd or later parents of merges)
> + * - label all branch tips
> + */
> + while ((commit = get_revision(revs))) {
> + struct commit_list *to_merge;
> + int is_octopus;
> + const char *p1, *p2;
> + struct object_id *oid;
> +
> + tail = &commit_list_insert(commit, tail)->next;
> + oidset_insert(&interesting, &commit->object.oid);
> +
> + if ((commit->object.flags & PATCHSAME))
> + continue;
> +
> + strbuf_reset(&oneline);
> + pretty_print_commit(pp, commit, &oneline);
> +
> + to_merge = commit->parents ? commit->parents->next : NULL;
> + if (!to_merge) {
> + /* non-merge commit: easy case */
> + strbuf_reset(&buf);
> + if (!keep_empty && is_original_commit_empty(commit))
> + strbuf_addf(&buf, "%c ", comment_line_char);
> + strbuf_addf(&buf, "%s %s %s", p,
> +     oid_to_hex(&commit->object.oid),
> +     oneline.buf);
> +
> + FLEX_ALLOC_STR(entry, string, buf.buf);
> + oidcpy(&entry->entry.oid, &commit->object.oid);
> + oidmap_put(&commit2todo, entry);
> +
> + continue;
> + }
> +
> + is_octopus = to_merge && to_merge->next;
> +
> + if (is_octopus)
> + BUG("Octopus merges not yet supported");
> +
> + /* Create a label */
> + strbuf_reset(&label);
> + if (skip_prefix(oneline.buf, "Merge ", &p1) &&
> +     (p1 = strchr(p1, '\'')) &&
> +     (p2 = strchr(++p1, '\'')))
> + strbuf_add(&label, p1, p2 - p1);
> + else if (skip_prefix(oneline.buf, "Merge pull request ",
> +      &p1) &&
> + (p1 = strstr(p1, " from ")))
> + strbuf_addstr(&label, p1 + strlen(" from "));
> + else
> + strbuf_addbuf(&label, &oneline);
> +
> + for (p1 = label.buf; *p1; p1++)
> + if (isspace(*p1))
> + *(char *)p1 = '-';
> +
> + strbuf_reset(&buf);
> + strbuf_addf(&buf, "%s %s", m, oid_to_hex(&commit->object.oid));
> +
> + /* label the tip of merged branch */
> + oid = &to_merge->item->object.oid;
> + strbuf_addch(&buf, ' ');
> +
> + if (!oidset_contains(&interesting, oid))
> + strbuf_addstr(&buf, label_oid(oid, NULL, &state));
> + else {
> + tips_tail = &commit_list_insert(to_merge->item,
> + tips_tail)->next;
> +
> + strbuf_addstr(&buf, label_oid(oid, label.buf, &state));
> + }
> + strbuf_addf(&buf, " %s", oneline.buf);
> +
> + FLEX_ALLOC_STR(entry, string, buf.buf);
> + oidcpy(&entry->entry.oid, &commit->object.oid);
> + oidmap_put(&commit2todo, entry);
> + }
> +
> + /*
> + * Second phase:
> + * - label branch points
> + * - add HEAD to the branch tips
> + */
> + for (iter = commits; iter; iter = iter->next) {
> + struct commit_list *parent = iter->item->parents;
> + for (; parent; parent = parent->next) {
> + struct object_id *oid = &parent->item->object.oid;
> + if (!oidset_contains(&interesting, oid))
> + continue;
> + if (!oidset_contains(&child_seen, oid))
> + oidset_insert(&child_seen, oid);
> + else
> + label_oid(oid, "branch-point", &state);
> + }
> +
> + /* Add HEAD as implict "tip of branch" */
> + if (!iter->next)
> + tips_tail = &commit_list_insert(iter->item,
> + tips_tail)->next;
> + }
> +
> + /*
> + * Third phase: output the todo list. This is a bit tricky, as we
> + * want to avoid jumping back and forth between revisions. To
> + * accomplish that goal, we walk backwards from the branch tips,
> + * gathering commits not yet shown, reversing the list on the fly,
> + * then outputting that list (labeling revisions as needed).
> + */
> + fprintf(out, "%s onto\n", l);
> + for (iter = tips; iter; iter = iter->next) {
> + struct commit_list *list = NULL, *iter2;
> +
> + commit = iter->item;
> + if (oidset_contains(&shown, &commit->object.oid))
> + continue;
> + entry = oidmap_get(&state.commit2label, &commit->object.oid);
> +
> + if (entry)
> + fprintf(out, "\n# Branch %s\n", entry->string);
> + else
> + fprintf(out, "\n");
> +
> + while (oidset_contains(&interesting, &commit->object.oid) &&
> +        !oidset_contains(&shown, &commit->object.oid)) {
> + commit_list_insert(commit, &list);
> + if (!commit->parents) {
> + commit = NULL;
> + break;
> + }
> + commit = commit->parents->item;
> + }
> +
> + if (!commit)
> + fprintf(out, "%s\n", b);
> + else {
> + const char *to = NULL;
> +
> + entry = oidmap_get(&state.commit2label,
> +    &commit->object.oid);
> + if (entry)
> + to = entry->string;
> +
> + if (!to || !strcmp("onto", to))
> + fprintf(out, "%s\n", b);
> + else {
> + strbuf_reset(&oneline);
> + pretty_print_commit(pp, commit, &oneline);
> + fprintf(out, "%s %s %s\n",
> + t, to, oneline.buf);
> + }
> + }
> +
> + for (iter2 = list; iter2; iter2 = iter2->next) {
> + struct object_id *oid = &iter2->item->object.oid;
> + entry = oidmap_get(&commit2todo, oid);
> + /* only show if not already upstream */
> + if (entry)
> + fprintf(out, "%s\n", entry->string);
> + entry = oidmap_get(&state.commit2label, oid);
> + if (entry)
> + fprintf(out, "%s %s\n", l, entry->string);
> + oidset_insert(&shown, oid);
> + }
> +
> + free_commit_list(list);
> + }
> +
> + free_commit_list(commits);
> + free_commit_list(tips);
> +
> + strbuf_release(&label);
> + strbuf_release(&oneline);
> + strbuf_release(&buf);
> +
> + oidmap_free(&commit2todo, 1);
> + oidmap_free(&state.commit2label, 1);
> + hashmap_free(&state.labels, 1);
> + strbuf_release(&state.buf);
> +
> + return 0;
> +}
> +
> int sequencer_make_script(FILE *out, int argc, const char **argv,
>    unsigned flags)
> {
> @@ -2795,11 +3126,16 @@ int sequencer_make_script(FILE *out, int argc, 
> const char **argv,
>  struct commit *commit;
>  int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
>  const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
> + int recreate_merges = flags & TODO_LIST_RECREATE_MERGES;
>
>  init_revisions(&revs, NULL);
>  revs.verbose_header = 1;
> - revs.max_parents = 1;
> - revs.cherry_pick = 1;
> + if (recreate_merges)
> + revs.cherry_mark = 1;
> + else {
> + revs.max_parents = 1;
> + revs.cherry_pick = 1;
> + }
>  revs.limited = 1;
>  revs.reverse = 1;
>  revs.right_only = 1;
> @@ -2823,6 +3159,9 @@ int sequencer_make_script(FILE *out, int argc, const 
> char **argv,
>  if (prepare_revision_walk(&revs) < 0)
>  return error(_("make_script: error preparing revisions"));
>
> + if (recreate_merges)
> + return make_script_with_merges(&pp, &revs, out, flags);
> +
>  while ((commit = get_revision(&revs))) {
>  strbuf_reset(&buf);
>  if (!keep_empty && is_original_commit_empty(commit))
> diff --git a/sequencer.h b/sequencer.h
> index 81f6d7d393f..11d1ac925ef 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -48,6 +48,7 @@ int sequencer_remove_state(struct replay_opts *opts);
> #define TODO_LIST_KEEP_EMPTY (1U << 0)
> #define TODO_LIST_SHORTEN_IDS (1U << 1)
> #define TODO_LIST_ABBREVIATE_CMDS (1U << 2)
> +#define TODO_LIST_RECREATE_MERGES (1U << 3)
> int sequencer_make_script(FILE *out, int argc, const char **argv,
>    unsigned flags);
>
> -- 
> 2.15.1.windows.2.1430.ga56c4f9e2a9
>
> 

