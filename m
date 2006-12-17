X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] revision: introduce ref@{N..M} syntax.
Date: Sat, 16 Dec 2006 22:46:21 -0800
Message-ID: <7vbqm36mv6.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net>
	<3C540990-B78E-405B-ACFF-F558DB776C85@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 17 Dec 2006 06:46:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <3C540990-B78E-405B-ACFF-F558DB776C85@silverinsanity.com> (Brian
	Gernhardt's message of "Sat, 16 Dec 2006 23:35:20 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34677>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvpnI-0006ud-Dc for gcvg-git@gmane.org; Sun, 17 Dec
 2006 07:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752118AbWLQGq0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 01:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbWLQGq0
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 01:46:26 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:43128 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752118AbWLQGqZ (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006
 01:46:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061217064621.TAHA22053.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Sun, 17
 Dec 2006 01:46:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zimZ1V00d1kojtg0000000; Sun, 17 Dec 2006
 01:46:34 -0500
To: Brian Gernhardt <benji@silverinsanity.com>
Sender: git-owner@vger.kernel.org

Brian Gernhardt <benji@silverinsanity.com> writes:

>> ** jc/reflog (Thu Dec 14 15:58:56 2006 -0800) 1 commit
>>  - Teach show-branch how to show ref-log data.
>>
>> A strawman to make reflog data a bit more browsable; it would be
>> useful while recovering from a mistake you made recently.  Not
>> essential and can wait or be dropped if people do not find it
>> useful.
>
> I'd prefer not to add clutter into show-branch.  I use it on a regular
> basis to see what I've added to what topic branch recently,  and to
> look at branches before rebasing.  It also just seems like the  wrong
> place to have that kind of data, although I guess it's more  useful
> for people who do merges more often than I do.

I happen to find it a reasonable way to present how a topic was
rewind and rebuilt, but I think that is I rewind my internal
topic (i.e. the parts that have not been merged into 'next' yet)
all the time.

> What about a "git reflog [<branch>]" command instead?  Would show
> output similar to "git log" (or "git show-branch" for brevity).

This is not a 'git reflog' command, but is another way to show
the tips of reflog entries (use it with 'git show').  I find the
show-branch variant easier to see, but you can judge for
yourself.

This happens to show why pruning while not culling reflog
entries is a bad idea.  If your master@{2} is gone due to rewind
and prune, and master@{0}, master@{1} and master@{3} are still
available, the pattern master@{0..3} would not give you a usable
result.

-- >8 --
This allows you to add between Nth and Mth (inclusive) reflog entries.
"git show master@{1} master@{2} master@{3}" is equivalent to
"git show master@{1..3}".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 revision.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 993bb66..3f1d65e 100644
--- a/revision.c
+++ b/revision.c
@@ -592,6 +592,59 @@ static void prepare_show_merge(struct rev_info *revs)
 	revs->prune_data = prune;
 }
 
+static int parse_digits(const char *p, int len)
+{
+	int accum = 0;
+	while (0 < len--) {
+		int ch = *p++;
+		if ('0' <= ch && ch <= '9')
+			accum = accum * 10 + ch - '0';
+		else
+			return -1;
+	}
+	return accum;
+}
+
+static int list_of_reflog_entries(const char *arg, const char *dotdot,
+				  struct rev_info *revs, int flags)
+{
+	/*
+	 * "ref@{N..M}" -- push them for "git show".
+	 * dotdot points at the first dot
+	 */
+	int n, m, i, added;
+	int len;
+	char *at_brace = strstr(arg, "@{");
+
+
+	if (!at_brace)
+		return 0;
+	len = strlen(arg);
+	if (arg[len-1] != '}')
+		return 0;
+	if ((m = parse_digits(dotdot + 2, len - (dotdot - arg) - 3)) < 0)
+		return 0;
+	if ((n = parse_digits(at_brace + 2, dotdot - at_brace - 2)) < 0)
+		return 0;
+	if (n > m)
+		return 0;
+
+	added = 0;
+	for (i = n; i <= m; i++) {
+		char buf[1024];
+		unsigned char sha1[20];
+
+		snprintf(buf, sizeof(buf), "%.*s@{%d}",
+			 (int) (at_brace - arg), arg, i);
+		if (!get_sha1(buf, sha1)) {
+			/* this is synthetic -- do not check filename */
+			handle_revision_arg(buf, revs, flags, 1);
+			added = 1;
+		}
+	}
+	return added;
+}
+
 int handle_revision_arg(const char *arg, struct rev_info *revs,
 			int flags,
 			int cant_be_filename)
@@ -648,7 +701,13 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 			add_pending_object(revs, &b->object, next);
 			return 0;
 		}
+
 		*dotdot = '.';
+
+		/* It could be ref@{N..M} */
+		if (list_of_reflog_entries(arg, dotdot, revs, flags))
+			return 0;
+
 	}
 	dotdot = strstr(arg, "^@");
 	if (dotdot && !dotdot[2]) {
-- 
1.4.4.2.g83c5
