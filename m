From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] Segfault in git rev-list --first-parent --bisect
Date: Fri, 22 Aug 2008 22:20:13 -0700
Message-ID: <7v7ia848aa.fsf@gitster.siamese.dyndns.org>
References: <32541b130808222020v146e015dm8a98a005ad3e76a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git ML" <git@vger.kernel.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 07:21:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWlYy-0003ds-Sp
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 07:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbYHWFUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 01:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbYHWFUU
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 01:20:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbYHWFUU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 01:20:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7CFAB6A0B6;
	Sat, 23 Aug 2008 01:20:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9E5466A0B5; Sat, 23 Aug 2008 01:20:15 -0400 (EDT)
In-Reply-To: <32541b130808222020v146e015dm8a98a005ad3e76a7@mail.gmail.com>
 (Avery Pennarun's message of "Fri, 22 Aug 2008 23:20:31 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2CEAFA20-70D3-11DD-B985-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93420>

"Avery Pennarun" <apenwarr@gmail.com> writes:

>     $ git rev-list --first-parent --bisect 5109c91 ^d798a2bfe094
>     Segmentation fault

Totally untested, usefulness fairly unknown.

 builtin-rev-list.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git c/builtin-rev-list.c w/builtin-rev-list.c
index 893762c..aab198f 100644
--- c/builtin-rev-list.c
+++ w/builtin-rev-list.c
@@ -530,19 +530,23 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		return best_bisection_sorted(list, nr);
 }
 
+#define BISECT_FIND_ALL 01
+#define BISECT_FIRST_PARENT_ONLY 02
 static struct commit_list *find_bisection(struct commit_list *list,
 					  int *reaches, int *all,
-					  int find_all)
+					  int flag)
 {
 	int nr, on_list;
 	struct commit_list *p, *best, *next, *last;
 	int *weights;
+	int find_all = flag & BISECT_FIND_ALL;
+	int first_parent_only = flag & BISECT_FIRST_PARENT_ONLY;
 
 	show_list("bisection 2 entry", 0, 0, list);
 
 	/*
 	 * Count the number of total and tree-changing items on the
-	 * list, while reversing the list.
+	 * list, while reversing the list and removing.
 	 */
 	for (nr = on_list = 0, last = NULL, p = list;
 	     p;
@@ -557,6 +561,8 @@ static struct commit_list *find_bisection(struct commit_list *list,
 		if (!(flags & TREESAME))
 			nr++;
 		on_list++;
+		if (first_parent_only && p->item->parents)
+			p->item->parents->next = NULL;
 	}
 	list = last;
 	show_list("bisection 2 sorted", 0, nr, list);
@@ -656,9 +662,13 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	if (bisect_list) {
 		int reaches = reaches, all = all;
+		int flag = 0;
+		if (bisect_find_all)
+			flag |= BISECT_FIND_ALL;
+		if (revs.first_parent_only)
+			flag |= BISECT_FIRST_PARENT_ONLY;
+		revs.commits = find_bisection(revs.commits, &reaches, &all, flag);
 
-		revs.commits = find_bisection(revs.commits, &reaches, &all,
-					      bisect_find_all);
 		if (bisect_show_vars) {
 			int cnt;
 			char hex[41];
