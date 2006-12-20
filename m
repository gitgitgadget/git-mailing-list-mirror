X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rev-list: Add a new option --skip.
Date: Tue, 19 Dec 2006 17:09:33 -0800
Message-ID: <7vbqlznzjm.fsf@assigned-by-dhcp.cox.net>
References: <20061219205422.GA17864@localhost>
	<7v1wmvpmef.fsf@assigned-by-dhcp.cox.net> <em9oi5$72t$1@sea.gmane.org>
	<20061220002906.GB17864@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 01:09:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061220002906.GB17864@localhost> (Robert Fitzsimons's message
	of "Wed, 20 Dec 2006 00:29:06 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34881>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwpxi-00087m-6u for gcvg-git@gmane.org; Wed, 20 Dec
 2006 02:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932795AbWLTBJf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 20:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932815AbWLTBJf
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 20:09:35 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:41296 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932795AbWLTBJe (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 20:09:34 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220010933.BKFL19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Tue, 19
 Dec 2006 20:09:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 0p8s1W00K1kojtg0000000; Tue, 19 Dec 2006
 20:08:52 -0500
To: Robert Fitzsimons <robfitz@273k.net>
Sender: git-owner@vger.kernel.org

Robert Fitzsimons <robfitz@273k.net> writes:

> diff --git a/builtin-rev-list.c b/builtin-rev-list.c
> index fb7fc92..432f901 100644
> --- a/builtin-rev-list.c
> +++ b/builtin-rev-list.c
> @@ -246,6 +248,10 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  			read_revisions_from_stdin(&revs);
>  			continue;
>  		}
> +		if (!strncmp(arg, "--skip=", 7)) {
> +			skip = atoi(arg + 7);
> +			continue;
> +		}
>  		usage(rev_list_usage);
>  
>  	}

Hmph....

I am having a hard time convincing myself that this is a feature
that is a narrow special case for rev-list and does not belong
to the generic revision traversal machinery.

That is, would people expect that 'log' family allow the to say:

	$ git log --skip=10 -4 master

Declaring this as a special case for rev-list is certainly safer
(no risk to harm the revision machinery which is quite central
part of git), but if you define and initialize the new field
next to max_count, it makes me feel that it should somehow be
handled at the same layer.

In other words,...

---

 revision.c |   46 ++++++++++++++++++++++++++++++++--------------
 revision.h |    1 +
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/revision.c b/revision.c
index 993bb66..aa63d10 100644
--- a/revision.c
+++ b/revision.c
@@ -524,6 +524,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->prefix = prefix;
 	revs->max_age = -1;
 	revs->min_age = -1;
+	revs->skip_count = -1;
 	revs->max_count = -1;
 
 	revs->prune_fn = NULL;
@@ -760,6 +761,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->max_count = atoi(arg + 12);
 				continue;
 			}
+			if (!strncmp(arg, "--skip=", 7)) {
+				revs->skip_count = atoi(arg + 7);
+				continue;
+			}
 			/* accept -<digit>, like traditional "head" */
 			if ((*arg == '-') && isdigit(arg[1])) {
 				revs->max_count = atoi(arg + 1);
@@ -1123,23 +1128,11 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 			   commit->buffer, strlen(commit->buffer));
 }
 
-struct commit *get_revision(struct rev_info *revs)
+static struct commit *get_revision_1(struct rev_info *revs)
 {
-	struct commit_list *list = revs->commits;
-
-	if (!list)
+	if (!revs->commits)
 		return NULL;
 
-	/* Check the max_count ... */
-	switch (revs->max_count) {
-	case -1:
-		break;
-	case 0:
-		return NULL;
-	default:
-		revs->max_count--;
-	}
-
 	do {
 		struct commit_list *entry = revs->commits;
 		struct commit *commit = entry->item;
@@ -1206,3 +1199,28 @@ struct commit *get_revision(struct rev_info *revs)
 	} while (revs->commits);
 	return NULL;
 }
+
+struct commit *get_revision(struct rev_info *revs)
+{
+	struct commit *c = NULL;
+
+	if (0 < revs->skip_count) {
+		while ((c = get_revision_1(revs)) != NULL) {
+			if (revs->skip_count-- <= 0)
+				break;
+		}
+	}
+
+	/* Check the max_count ... */
+	switch (revs->max_count) {
+	case -1:
+		break;
+	case 0:
+		return NULL;
+	default:
+		revs->max_count--;
+	}
+	if (c)
+		return c;
+	return get_revision_1(revs);
+}
diff --git a/revision.h b/revision.h
index 3adab95..81f522c 100644
--- a/revision.h
+++ b/revision.h
@@ -75,6 +75,7 @@ struct rev_info {
 	struct grep_opt	*grep_filter;
 
 	/* special limits */
+	int skip_count;
 	int max_count;
 	unsigned long max_age;
 	unsigned long min_age;
