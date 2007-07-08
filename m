From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible BUG in 'git log --parents'
Date: Sun, 08 Jul 2007 00:59:04 -0700
Message-ID: <7vodin2unr.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550707070249i6f3f7288uce1f922686f6e14d@mail.gmail.com>
	<7vps348qzi.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550707070314q3b78ac65p9a8ff3130a7bfaef@mail.gmail.com>
	<e5bfff550707071517o776db380v9f3a68c3e46d9d3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 09:59:24 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7Rfs-00021K-Rh
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 09:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbXGHH7I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 03:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbXGHH7H
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 03:59:07 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:55459 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbXGHH7G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 03:59:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070708075904.RQOC22777.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 8 Jul 2007 03:59:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Lvz41X00H1kojtg0000000; Sun, 08 Jul 2007 03:59:05 -0400
In-Reply-To: <e5bfff550707071517o776db380v9f3a68c3e46d9d3c@mail.gmail.com>
	(Marco Costalba's message of "Sun, 8 Jul 2007 00:17:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51867>

"Marco Costalba" <mcostalba@gmail.com> writes:

> On 7/7/07, Marco Costalba <mcostalba@gmail.com> wrote:
>> On 7/7/07, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>
>> > git-log.  However, I have a slight suspicion that we earlier
>> > decided not to do so on purpose with git-log and for a good
>> > reason.  I do not have much energy left tonight to dig into this
>> > right now, but mailing list log and commit log messages for
>> > rev-list.c, builtin-log.c and builtin-rev-list.c might tell you
>> > more.
>> >
>>
>> I will take a look ...
>>
>
> The commit with the patch for git-rev-list is 884944239f2

That's correct.  And I do not think of a reason for log and
rev-list to behave differently in this case now, so let's change
the behaviour of log.

There still is one thing I am a bit worried about, though.  You
can get the list of true, immediate parents in the raw format
("parent" lines) while getting the list of simplified parents on
the commit line (the topic of this thread).  Aren't there cases
where Porcelains would want to match up which immediate parent
lead to which simplified parent?  Using the illustration from
the commit log mesage of 88494423:

    
                      .---A---.
                     /         \
                    .---*---B---.
                   /    93b74bc  \
       ---*---o---o-----o---C-----o addafaf
          d8f6b34  \             /
                    .---o---D---.
                     \         /
                      .---E---.
                          3815f42
    
If we always show the five simplified parents as the response to
the --parent request, you would get:

  commit addafaf... d8f6b34... 93b74bc... d8f6b34... d8f6b34... 3815f42...
  tree e3be15f54f01e3aa1f8ec830ac87da5f85a23480
  parent 6b94f1e404afc552e5139c4357331843f5be61ad
  parent 93b74bca86f59b8df410b6fd4803b88ee0f304bf
  parent ea726d02e9677a66586d7ffebe97f112ab6dab33
  parent b33aba518456bee97bde1fef4fe17ab6bf401bbe
  parent 6b1ddbdd6e02719ae2be55dc141a176187e5027e

and you can tell 6b94f1e4 (the first immediate parent)
corresponds to d8f6b34, the first simplified parent, while
93b74bc (the second immediate parent) corresponds to 93b74bc
(the second simplified parent).  If we do the duplicate
omission, as we do for rev-list (and not for log as you found
out), you would not be able to tell which branch you can find by
reading the immediate parent list corresponds to what simplified
parent you can find from the --parent output.

But this worry applies to both rev-list and log, and it is no
reason to leave their behaviours different.

-- >8 --
Match "log --parent" output to "rev-list --parent" output.

We updated "rev-list --parent" output to omit duplicated parents
from the output long time ago, but this change was not side-ported
to "git-log".  There is no reason to leave them inconsistent.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

diff --git a/log-tree.c b/log-tree.c
index 8624d5a..24aea6b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -6,13 +6,32 @@
 
 struct decoration name_decoration = { "object names" };
 
+static void clear_tmp_mark(struct commit_list *p)
+{
+	while (p) {
+		struct commit *c = p->item;
+		c->object.flags &= ~TMP_MARK;
+		p = p->next;
+	}
+}
+
 static void show_parents(struct commit *commit, int abbrev)
 {
 	struct commit_list *p;
+
+	/* TMP_MARK is a general purpose flag that can
+	 * be used locally, but the user should clean
+	 * things up after it is done with them.
+	 */
+	clear_tmp_mark(commit->parents);
 	for (p = commit->parents; p ; p = p->next) {
 		struct commit *parent = p->item;
+		if (parent->object.flags & TMP_MARK)
+			continue;
 		printf(" %s", diff_unique_abbrev(parent->object.sha1, abbrev));
+		parent->object.flags |= TMP_MARK;
 	}
+	clear_tmp_mark(commit->parents);
 }
 
 static void show_decorations(struct commit *commit)
