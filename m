From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 1/3] teach log --no-walk=unsorted, which avoids sorting
Date: Tue, 28 Aug 2012 23:15:54 -0700
Message-ID: <1346220956-25034-2-git-send-email-martinvonz@gmail.com>
References: <50289e50.8458320a.7d31.3c46SMTPIN_ADDED@gmr-mx.google.com>
 <1346220956-25034-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 08:17:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6bax-0006yY-1a
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 08:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340Ab2H2GRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 02:17:23 -0400
Received: from mail-wi0-f202.google.com ([209.85.212.202]:64644 "EHLO
	mail-wi0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab2H2GQw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 02:16:52 -0400
Received: by wibhr14 with SMTP id hr14so12027wib.1
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 23:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=e3qjdfZBA8aKUbJAWIR1waq5qdyf8HZdY/aC2A46UEk=;
        b=P73Y8ObcfS9UT9Ku4lVx1GUbeq38GySmqe8pgKqYO1TBd3syf55Gdyt1Rtbns9XcpH
         c/HAFLZ6cJk6Wg+FdDOEshnTW21qGDoe8Ccg3IqQpanNkC+DlWkXIbpforc/RLGlVXHa
         /vFFR1MvcNzyoECKU5lOJpMX6GdasIzVDCiNVpgVrwbiE0tJmPS6e9syP9Bo6gxxm95W
         4L+fasrBVWlYml5DhNq2GO737UH8BBWLVAdOqvkd9+grXv2PNrffB62S338yHEsMjLO9
         BK01qA70Ae8a1HOYB57X0I9332/J6JSUPdpPILvFz4NBWrcVDkaz2gohmA1YIRhaaR0h
         2mcA==
Received: by 10.180.88.195 with SMTP id bi3mr112032wib.3.1346221010534;
        Tue, 28 Aug 2012 23:16:50 -0700 (PDT)
Received: by 10.180.88.195 with SMTP id bi3mr112025wib.3.1346221010494;
        Tue, 28 Aug 2012 23:16:50 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id fa8si1097117wid.1.2012.08.28.23.16.50
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 28 Aug 2012 23:16:50 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id EA17F20004E;
	Tue, 28 Aug 2012 23:16:49 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 58821C2AB1; Tue, 28 Aug 2012 23:16:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1346220956-25034-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQmbN3GwtJR5ueBsLy9SBlfNVnMzdZKPzNL0XKIqhXMS6dtR2KqnY051F/sfRSZnDjqeEwtQG2jPMiyawVyxclh2wiShfvjJGDWaEmPaqLmeZ9n5gkTf0PxwOiLUVvwium/BQBqQqFSZTL7xmLoeO1qAXEltW34yKs5Z9uATX7zmJXm1bH2iW5EfnC7ghapacHDDHm6S
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204467>

When 'git log' is passed the --no-walk option, no revision walk takes
place, naturally. Perhaps somewhat surprisingly, however, the provided
revisions still get sorted by commit date. So e.g 'git log --no-walk
HEAD HEAD~1' and 'git log --no-walk HEAD~1 HEAD' give the same result
(unless the two revisions share the commit date, in which case they
will retain the order given on the command line). As the commit that
introduced --no-walk (8e64006 (Teach revision machinery about
--no-walk, 2007-07-24)) points out, the sorting is intentional, to
allow things like

 git log --abbrev-commit --pretty=oneline --decorate --all --no-walk

to show all refs in order by commit date.

But there are also other cases where the sorting is not wanted, such
as

 <command producing revisions in order> |
       git log --oneline --no-walk --stdin

To accomodate both cases, leave the decision of whether or not to sort
up to the caller, by allowing --no-walk={sorted,unsorted}, defaulting
to 'sorted' for backward-compatibility reasons.

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 Documentation/rev-list-options.txt | 12 ++++++++----
 builtin/log.c                      |  2 +-
 builtin/revert.c                   |  2 +-
 revision.c                         | 18 +++++++++++++++---
 revision.h                         |  6 +++++-
 t/t4202-log.sh                     | 10 ++++++++++
 6 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index def1340..5436eba 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -636,10 +636,14 @@ These options are mostly targeted for packing of git repositories.
 	Only useful with '--objects'; print the object IDs that are not
 	in packs.
 
---no-walk::
-
-	Only show the given revs, but do not traverse their ancestors.
-	This has no effect if a range is specified.
+--no-walk[=(sorted|unsorted)]::
+
+	Only show the given commits, but do not traverse their ancestors.
+	This has no effect if a range is specified. If the argument
+	"unsorted" is given, the commits are show in the order they were
+	given on the command line. Otherwise (if "sorted" or no argument
+	was given), the commits are show in reverse chronological order
+	by commit time.
 
 --do-walk::
 
diff --git a/builtin/log.c b/builtin/log.c
index ecc2793..20838b1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -456,7 +456,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
 	rev.always_show_header = 1;
-	rev.no_walk = 1;
+	rev.no_walk = REVISION_WALK_NO_WALK_SORTED;
 	rev.diffopt.stat_width = -1; 	/* Scale to real terminal size */
 
 	memset(&opt, 0, sizeof(opt));
diff --git a/builtin/revert.c b/builtin/revert.c
index 82d1bf8..42ce399 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -193,7 +193,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		struct setup_revision_opt s_r_opt;
 		opts->revs = xmalloc(sizeof(*opts->revs));
 		init_revisions(opts->revs, NULL);
-		opts->revs->no_walk = 1;
+		opts->revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
 		if (argc < 2)
 			usage_with_options(usage_str, options);
 		memset(&s_r_opt, 0, sizeof(s_r_opt));
diff --git a/revision.c b/revision.c
index 442a945..66ba2e6 100644
--- a/revision.c
+++ b/revision.c
@@ -1300,7 +1300,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk") ||
 	    !strcmp(arg, "--bisect") || !prefixcmp(arg, "--glob=") ||
 	    !prefixcmp(arg, "--branches=") || !prefixcmp(arg, "--tags=") ||
-	    !prefixcmp(arg, "--remotes="))
+	    !prefixcmp(arg, "--remotes=") || !prefixcmp(arg, "--no-walk="))
 	{
 		unkv[(*unkc)++] = arg;
 		return 1;
@@ -1695,7 +1695,18 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	} else if (!strcmp(arg, "--not")) {
 		*flags ^= UNINTERESTING;
 	} else if (!strcmp(arg, "--no-walk")) {
-		revs->no_walk = 1;
+		revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
+	} else if (!prefixcmp(arg, "--no-walk=")) {
+		/*
+		 * Detached form ("--no-walk X" as opposed to "--no-walk=X")
+		 * not allowed, since the argument is optional.
+		 */
+		if (!strcmp(arg + 10, "sorted"))
+			revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
+		else if (!strcmp(arg + 10, "unsorted"))
+			revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
+		else
+			return error("invalid argument to --no-walk");
 	} else if (!strcmp(arg, "--do-walk")) {
 		revs->no_walk = 0;
 	} else {
@@ -2117,10 +2128,11 @@ int prepare_revision_walk(struct rev_info *revs)
 		}
 		e++;
 	}
-	commit_list_sort_by_date(&revs->commits);
 	if (!revs->leak_pending)
 		free(list);
 
+	if (revs->no_walk != REVISION_WALK_NO_WALK_UNSORTED)
+		commit_list_sort_by_date(&revs->commits);
 	if (revs->no_walk)
 		return 0;
 	if (revs->limited)
diff --git a/revision.h b/revision.h
index cb5ab35..a95bd0b 100644
--- a/revision.h
+++ b/revision.h
@@ -41,6 +41,10 @@ struct rev_cmdline_info {
 	} *rev;
 };
 
+#define REVISION_WALK_WALK 0
+#define REVISION_WALK_NO_WALK_SORTED 1
+#define REVISION_WALK_NO_WALK_UNSORTED 2
+
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -62,7 +66,7 @@ struct rev_info {
 	/* Traversal flags */
 	unsigned int	dense:1,
 			prune:1,
-			no_walk:1,
+			no_walk:2,
 			show_all:1,
 			remove_empty_trees:1,
 			simplify_history:1,
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 71be59d..bd83355 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -178,11 +178,21 @@ test_expect_success 'git log --no-walk <commits> sorts by commit time' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git log --no-walk=sorted <commits> sorts by commit time' '
+	git log --no-walk=sorted --oneline 5d31159 804a787 394ef78 > actual &&
+	test_cmp expect actual
+'
+
 cat > expect << EOF
 5d31159 fourth
 804a787 sixth
 394ef78 fifth
 EOF
+test_expect_success 'git log --no-walk=unsorted <commits> leaves list of commits as given' '
+	git log --no-walk=unsorted --oneline 5d31159 804a787 394ef78 > actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git show <commits> leaves list of commits as given' '
 	git show --oneline -s 5d31159 804a787 394ef78 > actual &&
 	test_cmp expect actual
-- 
1.7.11.1.104.ge7b44f1
