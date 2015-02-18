From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] builtin/push.c: make push_default a static variable
Date: Wed, 18 Feb 2015 15:03:41 -0500
Message-ID: <20150218200340.GA11861@peff.net>
References: <20150216054550.GA24611@peff.net>
 <20150216054754.GB25088@peff.net>
 <20150217104628.GA25978@peff.net>
 <xmqqsie4300s.fsf@gitster.dls.corp.google.com>
 <20150217182324.GA12816@peff.net>
 <xmqqzj8cyyip.fsf@gitster.dls.corp.google.com>
 <20150218185007.GA7257@peff.net>
 <xmqqh9uj2g25.fsf@gitster.dls.corp.google.com>
 <20150218192518.GA7891@peff.net>
 <xmqq4mqj2e4j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Olszewski <cxreg@pobox.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 21:03:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOAqa-0006z6-DO
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 21:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbbBRUDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 15:03:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:50705 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751527AbbBRUDn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 15:03:43 -0500
Received: (qmail 6677 invoked by uid 102); 18 Feb 2015 20:03:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 14:03:42 -0600
Received: (qmail 20677 invoked by uid 107); 18 Feb 2015 20:03:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 15:03:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2015 15:03:41 -0500
Content-Disposition: inline
In-Reply-To: <xmqq4mqj2e4j.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264062>

On Wed, Feb 18, 2015 at 11:50:20AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Feb 18, 2015 at 11:08:34AM -0800, Junio C Hamano wrote:
> > ...
> >> Not very strongly either way.  Seeing the above does not bother me
> >> too much, but I do not know how I would feel when I start seeing
> >> 
> >> 	val = git_config_book(k, v);
> >> 	flip_bool(val, &flags, TRANSPORT_PUSH_FOLLOW_TAGS);
> >> 
> >> often.  Not having to make sure that the bit constant whose name
> >> tends to get long is not misspelled is certainly a plus.
> >
> > I think it would be even nicer as:
> >
> >   git_config_bits(k, v, &flags, TRANSPORT_PUSH_FOLLOW_TAGS);
> 
> Maybe.  I do not feel very strongly either way.

So I started to prepare a patch for this, because I wanted to see how it
would look. It's below in case you are curious, but note that it doesn't
compile, and that is does something a bit dangerous. So I think I am
giving up on this line of thought. Read on if you're curious.

The sticking point is the type of the bit-field. If it is:

    void flip_bits(int set_or_clear, int *field, int bits);

then we cannot pass a pointer to "unsigned field". We can pass unsigned
bits, but note that we might lose the 32nd (or 64th) bit.

We can do this instead:

    void flip_bits(int set_or_clear, void *field, unsigned bits);

But of course we will end up dereferencing "void *field" as "unsigned *".
I suspect if field is originally an "int" it works fine on most
platforms, but isn't legal according to the standard. Much worse,
though: if your original field is a different size, it's even less
likely to work. Passing a "char *" may set bits in random adjacent
memory (depending on your endianness), and an "unsigned long *" may set
bits in the wrong part of the variable. And because of the "void *", we
get no compiler warnings. :)

Add on top that we may want to use this for C bit-fields, whose address
cannot legally be taken (and this is why it does not compile).

So besides adding type-specific bit-flippers (yuck), I think the only
way to do it universally would be with a macro.  Which I think tips it
over the "too gross, just write it out" line.

---
diff --git a/archive-tar.c b/archive-tar.c
index 0d1e6bd..3c794e2 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -352,10 +352,7 @@ static int tar_filter_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 	if (!strcmp(type, "remote")) {
-		if (git_config_bool(var, value))
-			ar->flags |= ARCHIVER_REMOTE;
-		else
-			ar->flags &= ~ARCHIVER_REMOTE;
+		git_config_bits(var, value, &ar->flags, ARCHIVER_REMOTE);
 		return 0;
 	}
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d816587..073445e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2216,10 +2216,8 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 	if (!strcmp(k, "pack.writebitmaphashcache")) {
-		if (git_config_bool(k, v))
-			write_bitmap_options |= BITMAP_OPT_HASH_CACHE;
-		else
-			write_bitmap_options &= ~BITMAP_OPT_HASH_CACHE;
+		git_config_bits(k, v, &write_bitmap_options,
+				BITMAP_OPT_HASH_CACHE);
 	}
 	if (!strcmp(k, "pack.usebitmaps")) {
 		use_bitmap_index = git_config_bool(k, v);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5878986..9d4eb24 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -53,10 +53,7 @@ static int mark_ce_flags(const char *path, int flag, int mark)
 	int namelen = strlen(path);
 	int pos = cache_name_pos(path, namelen);
 	if (0 <= pos) {
-		if (mark)
-			active_cache[pos]->ce_flags |= flag;
-		else
-			active_cache[pos]->ce_flags &= ~flag;
+		flip_bits(mark, &active_cache[pos]->ce_flags, flag);
 		active_cache[pos]->ce_flags |= CE_UPDATE_IN_BASE;
 		cache_tree_invalidate_path(&the_index, path);
 		active_cache_changed |= CE_ENTRY_CHANGED;
diff --git a/cache.h b/cache.h
index f704af5..957f150 100644
--- a/cache.h
+++ b/cache.h
@@ -1316,6 +1316,18 @@ extern int sha1_object_info_extended(const unsigned char *, struct object_info *
 /* Dumb servers support */
 extern int update_server_info(int);
 
+/*
+ * Either set or clear "bits" from "field", based on
+ * whether or not "set_or_clear" is set.
+ */
+static inline void flip_bits(int set_or_clear, void *field, unsigned bits)
+{
+	if (set_or_clear)
+		*(unsigned *)field |= bits;
+	else
+		*(unsigned *)field &= ~bits;
+}
+
 /* git_config_parse_key() returns these negated: */
 #define CONFIG_INVALID_KEY 1
 #define CONFIG_NO_SECTION_OR_NAME 2
@@ -1385,6 +1397,12 @@ struct config_include_data {
 #define CONFIG_INCLUDE_INIT { 0 }
 extern int git_config_include(const char *name, const char *value, void *data);
 
+static inline int git_config_bits(const char *name, const char *value, void *field, unsigned bits)
+{
+	flip_bits(git_config_bool(name, value), field, bits);
+	return 0;
+}
+
 /*
  * Match and parse a config key of the form:
  *
diff --git a/column.c b/column.c
index 786abe6..21c9765 100644
--- a/column.c
+++ b/column.c
@@ -281,12 +281,8 @@ static int parse_option(const char *arg, int len, unsigned int *colopts,
 
 		if (opts[i].mask)
 			*colopts = (*colopts & ~opts[i].mask) | opts[i].value;
-		else {
-			if (set)
-				*colopts |= opts[i].value;
-			else
-				*colopts &= ~opts[i].value;
-		}
+		else
+			flip_bits(set, colopts, opts[i].value);
 		return 0;
 	}
 
diff --git a/combine-diff.c b/combine-diff.c
index 91edce5..ad52b77 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -581,12 +581,9 @@ static int make_hunks(struct sline *sline, unsigned long cnt,
 	unsigned long i;
 	int has_interesting = 0;
 
-	for (i = 0; i <= cnt; i++) {
-		if (interesting(&sline[i], all_mask))
-			sline[i].flag |= mark;
-		else
-			sline[i].flag &= ~mark;
-	}
+	for (i = 0; i <= cnt; i++)
+		flip_bits(interesting(&sline[i], all_mask),
+			  &sline[i].flag, mark);
 	if (!dense)
 		return give_context(sline, cnt, num_parent);
 
diff --git a/diff.c b/diff.c
index d1bd534..53b9481 100644
--- a/diff.c
+++ b/diff.c
@@ -3585,22 +3585,17 @@ static int parse_diff_filter_opt(const char *optarg, struct diff_options *opt)
 
 	for (i = 0; (optch = optarg[i]) != '\0'; i++) {
 		unsigned int bit;
-		int negate;
+		int positive = 1;
 
 		if ('a' <= optch && optch <= 'z') {
-			negate = 1;
+			positive = 0;
 			optch = toupper(optch);
-		} else {
-			negate = 0;
 		}
 
 		bit = (0 <= optch && optch <= 'Z') ? filter_bit[optch] : 0;
 		if (!bit)
 			return optarg[i];
-		if (negate)
-			opt->filter &= ~bit;
-		else
-			opt->filter |= bit;
+		flip_bits(positive, &opt->filter, bit);
 	}
 	return 0;
 }
diff --git a/parse-options.c b/parse-options.c
index 80106c0..47c169c 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -100,17 +100,11 @@ static int get_value(struct parse_opt_ctx_t *p,
 		return (*(parse_opt_ll_cb *)opt->callback)(p, opt, unset);
 
 	case OPTION_BIT:
-		if (unset)
-			*(int *)opt->value &= ~opt->defval;
-		else
-			*(int *)opt->value |= opt->defval;
+		flip_bits(!unset, opt->value, opt->defval);
 		return 0;
 
 	case OPTION_NEGBIT:
-		if (unset)
-			*(int *)opt->value |= opt->defval;
-		else
-			*(int *)opt->value &= ~opt->defval;
+		flip_bits(unset, opt->value, opt->defval);
 		return 0;
 
 	case OPTION_COUNTUP:
diff --git a/revision.c b/revision.c
index 66520c6..85cb245 100644
--- a/revision.c
+++ b/revision.c
@@ -554,10 +554,8 @@ static int compact_treesame(struct rev_info *revs, struct commit *commit, unsign
 		if (nth_parent != 0)
 			die("compact_treesame %u", nth_parent);
 		old_same = !!(commit->object.flags & TREESAME);
-		if (rev_same_tree_as_empty(revs, commit))
-			commit->object.flags |= TREESAME;
-		else
-			commit->object.flags &= ~TREESAME;
+		flip_bits(rev_same_tree_as_empty(revs, commit),
+			  &commit->object.flags, TREESAME);
 		return old_same;
 	}
 
@@ -578,10 +576,8 @@ static int compact_treesame(struct rev_info *revs, struct commit *commit, unsign
 	if (--st->nparents == 1) {
 		if (commit->parents->next)
 			die("compact_treesame parents mismatch");
-		if (st->treesame[0] && revs->dense)
-			commit->object.flags |= TREESAME;
-		else
-			commit->object.flags &= ~TREESAME;
+		flip_bits(st->treesame[0] && revs->dense,
+			  &commit->object.flags, TREESAME);
 		free(add_decoration(&revs->treesame, &commit->object, NULL));
 	}
 
@@ -609,10 +605,8 @@ static unsigned update_treesame(struct rev_info *revs, struct commit *commit)
 			} else
 				irrelevant_change |= !st->treesame[n];
 		}
-		if (relevant_parents ? relevant_change : irrelevant_change)
-			commit->object.flags &= ~TREESAME;
-		else
-			commit->object.flags |= TREESAME;
+		flip_bits(!(relevant_parents ? relevant_change : irrelevant_change),
+			  &commit->object.flags, TREESAME);
 	}
 
 	return commit->object.flags & TREESAME;
diff --git a/unpack-trees.c b/unpack-trees.c
index be84ba2..9089c5b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -248,10 +248,8 @@ static int apply_sparse_checkout(struct index_state *istate,
 {
 	int was_skip_worktree = ce_skip_worktree(ce);
 
-	if (ce->ce_flags & CE_NEW_SKIP_WORKTREE)
-		ce->ce_flags |= CE_SKIP_WORKTREE;
-	else
-		ce->ce_flags &= ~CE_SKIP_WORKTREE;
+	flip_bits(ce->ce_flags & CE_NEW_SKIP_WORKTREE,
+		  &ce->ce_flags, CE_SKIP_WORKTREE);
 	if (was_skip_worktree != ce_skip_worktree(ce)) {
 		ce->ce_flags |= CE_UPDATE_IN_BASE;
 		istate->cache_changed |= CE_ENTRY_CHANGED;
@@ -982,10 +980,7 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 		if (select_flag && !(ce->ce_flags & select_flag))
 			continue;
 
-		if (!ce_stage(ce))
-			ce->ce_flags |= skip_wt_flag;
-		else
-			ce->ce_flags &= ~skip_wt_flag;
+		flip_bits(!ce_stage(ce), &ce->ce_flags, skip_wt_flag);
 	}
 
 	/*
diff --git a/ws.c b/ws.c
index ea4b2b1..6c5f4bd 100644
--- a/ws.c
+++ b/ws.c
@@ -30,14 +30,14 @@ unsigned parse_whitespace_rule(const char *string)
 		int i;
 		size_t len;
 		const char *ep;
-		int negated = 0;
+		int positive = 1;
 
 		string = string + strspn(string, ", \t\n\r");
 		ep = strchrnul(string, ',');
 		len = ep - string;
 
 		if (*string == '-') {
-			negated = 1;
+			positive = 0;
 			string++;
 			len--;
 		}
@@ -47,10 +47,8 @@ unsigned parse_whitespace_rule(const char *string)
 			if (strncmp(whitespace_rule_names[i].rule_name,
 				    string, len))
 				continue;
-			if (negated)
-				rule &= ~whitespace_rule_names[i].rule_bits;
-			else
-				rule |= whitespace_rule_names[i].rule_bits;
+			flip_bits(positive, &rule,
+				  whitespace_rule_names[i].rule_bits);
 			break;
 		}
 		if (strncmp(string, "tabwidth=", 9) == 0) {
