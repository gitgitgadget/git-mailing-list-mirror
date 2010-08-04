From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/6] rerere: let caller decide whether to renormalize
Date: Tue, 3 Aug 2010 22:23:38 -0500
Message-ID: <20100804032338.GF19699@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 05:25:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgUbK-0000hF-9M
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 05:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490Ab0HDDY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 23:24:59 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38509 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133Ab0HDDY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 23:24:57 -0400
Received: by yxg6 with SMTP id 6so1806435yxg.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 20:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=eIZlZ2Ci2q+NW/xJOokJ45HT6/7w+/w+1CuPUYDcuIE=;
        b=ndqlTA/MpEy3i74k06SaDzheZQ7ldtIStcQ+Xrs9on79KxTRCOHbEgmQ+IwrNsZgZw
         xAzv4VmOwJW/GK+cjy6nanA8fsWXkzSQ2YHT650gowDyrKLESLKJp/U3jIVZ9oCFU6Rl
         ugYYzfpheg/5nluZbZibJUvIfIwh40LU856Lw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sbPoZsM/eeCzr383JhqtpQQO0rKqnneWMlZTPJEzJtdXcbDJfIZ7aFsJh6sE40QhJk
         aeDcLnIIzG1/bjWia0q/KCqG3HI5bOgpElQ5bxF7bIVJgemUKk1/ILworGIhuk6AG+hU
         Ma/MQ6887cfifAWVv6GIiZ/DLwI5lEZotfpNk=
Received: by 10.100.209.9 with SMTP id h9mr9218056ang.189.1280892296900;
        Tue, 03 Aug 2010 20:24:56 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id c19sm12887249ana.22.2010.08.03.20.24.54
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 20:24:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100804031935.GA19699@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152560>

Add a RERERE_RENORMALIZE flag to rerere so callers can decide
case-by-case whether the merge is likely to have overlapped with a
change in smudge/clean rules.

This is only a change in internal plumbing.  Many callers do not have
a way to use that setting; this patch does not change that.

NEEDSWORK: this is a step in the wrong direction.  rerere needs
an -s option to use an arbitrary merge strategy and a -X option to
pass arbitrary options to that driver.  And maybe the options used
in a merge should be recorded somewhere to help rerere repeat it.

This treats the renormalize option specially anyway, to support the
existing "git merge" behavior of using -Xrenormalize in its rerere
call when configured to do so.  It reluctant exposes that option in
the rerere command as --renormalize for the sake of experimentation,
too, but it does not advertise it.

Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/commit.c |    4 ++++
 builtin/merge.c  |    7 +++++--
 builtin/rerere.c |    8 ++++++--
 builtin/revert.c |   11 +++++++++--
 rerere.c         |    5 +++--
 rerere.h         |    1 +
 6 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 3d99cf9..56c998f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1377,6 +1377,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		     "new_index file. Check that disk is not full or quota is\n"
 		     "not exceeded, and then \"git reset HEAD\" to recover.");
 
+	/*
+	 * NEEDSWORK: use RERERE_RENORMALIZE after a merge with
+	 * merge.renormalize set
+	 */
 	rerere(0);
 	run_hook(get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
diff --git a/builtin/merge.c b/builtin/merge.c
index b836e9c..823b76b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -822,7 +822,7 @@ static int finish_automerge(struct commit_list *common,
 static int suggest_conflicts(void)
 {
 	FILE *fp;
-	int pos;
+	int pos, flag;
 
 	fp = fopen(git_path("MERGE_MSG"), "a");
 	if (!fp)
@@ -841,7 +841,10 @@ static int suggest_conflicts(void)
 		}
 	}
 	fclose(fp);
-	rerere(allow_rerere_auto);
+	flag = allow_rerere_auto;
+	if (merge_renormalize)
+		flag |= RERERE_RENORMALIZE;
+	rerere(flag);
 	printf("Automatic merge failed; "
 			"fix conflicts and then commit the result.\n");
 	return 1;
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 295fe75..4009c01 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -111,15 +111,19 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
 			"register clean resolutions in index", 1),
+		{ OPTION_BIT, 0, "renormalize-before-merge", &flags, NULL,
+			"simplify conflict hunks for normalization changes",
+			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL,
+			RERERE_RENORMALIZE },
 		OPT_END(),
 	};
 
 	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
 
 	if (autoupdate == 1)
-		flags = RERERE_AUTOUPDATE;
+		flags |= RERERE_AUTOUPDATE;
 	if (autoupdate == 0)
-		flags = RERERE_NOAUTOUPDATE;
+		flags |= RERERE_NOAUTOUPDATE;
 
 	if (argc < 1)
 		return rerere(flags);
diff --git a/builtin/revert.c b/builtin/revert.c
index 853e9e4..c694801 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -338,7 +338,7 @@ static void do_recursive_merge(struct commit *base, struct commit *next,
 	rollback_lock_file(&index_lock);
 
 	if (!clean) {
-		int i;
+		int i, flags;
 		strbuf_addstr(msgbuf, "\nConflicts:\n\n");
 		for (i = 0; i < active_nr;) {
 			struct cache_entry *ce = active_cache[i++];
@@ -354,7 +354,10 @@ static void do_recursive_merge(struct commit *base, struct commit *next,
 		write_message(msgbuf, defmsg);
 		fprintf(stderr, "Automatic %s failed.%s\n",
 			me, help_msg());
-		rerere(allow_rerere_auto);
+		flags = allow_rerere_auto;
+		if (o.renormalize)
+			flags |= RERERE_RENORMALIZE;
+		rerere(flags);
 		exit(1);
 	}
 	write_message(msgbuf, defmsg);
@@ -481,6 +484,10 @@ static int do_pick_commit(void)
 		if (res) {
 			fprintf(stderr, "Automatic %s with strategy %s failed.%s\n",
 				me, strategy, help_msg());
+			/*
+			 * NEEDSWORK: use RERERE_RENORMALIZE after
+			 * a merge with merge.renormalize set
+			 */
 			rerere(allow_rerere_auto);
 			exit(1);
 		}
diff --git a/rerere.c b/rerere.c
index 17dcc3c..8767024 100644
--- a/rerere.c
+++ b/rerere.c
@@ -553,12 +553,13 @@ int setup_rerere(struct string_list *merge_rr, int flags)
 int rerere(int flags)
 {
 	struct string_list merge_rr = { NULL, 0, 0, 1 };
-	int fd;
+	int fd, renormalize;
 
 	fd = setup_rerere(&merge_rr, flags);
 	if (fd < 0)
 		return 0;
-	return do_plain_rerere(&merge_rr, fd, merge_renormalize);
+	renormalize = (flags & RERERE_RENORMALIZE) ? 1 : 0;
+	return do_plain_rerere(&merge_rr, fd, renormalize);
 }
 
 static int rerere_forget_one_path(const char *path, struct string_list *rr)
diff --git a/rerere.h b/rerere.h
index eaa9004..a73555f 100644
--- a/rerere.h
+++ b/rerere.h
@@ -5,6 +5,7 @@
 
 #define RERERE_AUTOUPDATE   01
 #define RERERE_NOAUTOUPDATE 02
+#define RERERE_RENORMALIZE  04
 
 extern int setup_rerere(struct string_list *, int);
 extern int rerere(int);
-- 
1.7.2.1.544.ga752d.dirty
