From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Add "--show-all" revision walker flag for debugging
Date: Sat, 9 Feb 2008 15:52:12 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802091531220.2896@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 00:53:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNzVk-00083D-9N
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 00:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970AbYBIXwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 18:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755954AbYBIXwl
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 18:52:41 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39479 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755846AbYBIXwk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Feb 2008 18:52:40 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m19NqFxl017505
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 9 Feb 2008 15:52:16 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m19NqCvG003788;
	Sat, 9 Feb 2008 15:52:14 -0800
In-Reply-To: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.717 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73278>



On Sat, 9 Feb 2008, Linus Torvalds wrote:
> 
> So here's a patch that adds a "--show-all" flag to the revision walker, 
> which will make it show uninteresting commits too, and they'll have a '*' 
> in front of them (it also fixes a logic error for !verbose_header for 
> boundary commits - we should show the '-' even if left_right isn't shown).

And here's a slight expansion patch on top of the above

It does:

 - when it actually breaks out due to the "everybody_uninteresting()" 
   case, it adds the uninteresting commits (both the one it's looking at 
   now, and the list of pending ones) to the list

   This way, we really list *all* the commits we've looked at

 - Because we now end up listing commits we may not even have been parsed 
   at all "show_log" and "show_commit" need to protect against commits 
   that don't have a commit buffer entry.

That second part is debatable just how it should work. Maybe we shouldn't 
show such entries at all (with this patch those entries do get shown, they 
just don't get any message shown with them). But I think this is a useful 
case.

		Linus

---
 builtin-rev-list.c |    2 +-
 log-tree.c         |    3 +++
 revision.c         |   11 ++++++++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 5966199..7163116 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -86,7 +86,7 @@ static void show_commit(struct commit *commit)
 	else
 		putchar('\n');
 
-	if (revs.verbose_header) {
+	if (revs.verbose_header && commit->buffer) {
 		struct strbuf buf;
 		strbuf_init(&buf, 0);
 		pretty_print_commit(revs.commit_format, commit,
diff --git a/log-tree.c b/log-tree.c
index dd110ca..e9ba6df 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -282,6 +282,9 @@ void show_log(struct rev_info *opt, const char *sep)
 		}
 	}
 
+	if (!commit->buffer)
+		return;
+
 	/*
 	 * And then the pretty-printed message itself
 	 */
diff --git a/revision.c b/revision.c
index 158727c..76faf4b 100644
--- a/revision.c
+++ b/revision.c
@@ -558,6 +558,12 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 	free_patch_ids(&ids);
 }
 
+static void add_to_list(struct commit_list **p, struct commit *commit, struct commit_list *n)
+{
+	p = &commit_list_insert(commit, p)->next;
+	*p = n;
+}
+
 static int limit_list(struct rev_info *revs)
 {
 	struct commit_list *list = revs->commits;
@@ -579,8 +585,11 @@ static int limit_list(struct rev_info *revs)
 			return -1;
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
-			if (everybody_uninteresting(list))
+			if (everybody_uninteresting(list)) {
+				if (revs->show_all)
+					add_to_list(p, commit, list);
 				break;
+			}
 			if (!revs->show_all)
 				continue;
 		}
