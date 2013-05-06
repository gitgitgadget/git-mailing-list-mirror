From: John Keeping <john@keeping.me.uk>
Subject: Re: Segfault in git merge-tree (1.8.2.2)
Date: Mon, 6 May 2013 15:29:23 +0100
Message-ID: <20130506142923.GC25912@serenity.lan>
References: <CADEJa-5prhhY-fUHgkk91M8HKWRG3enODS_h7Mq0dgo7V9sYsQ@mail.gmail.com>
 <20130506133937.GB25912@serenity.lan>
 <CADEJa-5-UpkUaNQ=QResY54cH4TvXqiUSeG-jewH+n+HsZqmHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Jacobsen <andreas@andreasjacobsen.com>
X-From: git-owner@vger.kernel.org Mon May 06 16:29:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZMQ2-0006WK-P0
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 16:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431Ab3EFO3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 10:29:30 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:55649 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab3EFO33 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 10:29:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 23982CDA5DA;
	Mon,  6 May 2013 15:29:29 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AiuGuvs6Bpva; Mon,  6 May 2013 15:29:28 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 00EEECDA616;
	Mon,  6 May 2013 15:29:25 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CADEJa-5-UpkUaNQ=QResY54cH4TvXqiUSeG-jewH+n+HsZqmHA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223453>

On Mon, May 06, 2013 at 04:13:28PM +0200, Andreas Jacobsen wrote:
> Sure, here you go, this time built from the HEAD I found on github
> (7d3ccdffb5d28970dd7a4d177cfcca690ccd0c22) with:
> 
> NO_GETTEXT=1 make prefix=/usr/local/Cellar/git/HEAD CC=cc CFLAGS='-O0
> -g' install (this is homebrew's setup, but I built it manually rather
> than using the recipe.)
> 
> And the gdb output:
> 
> (gdb) set args merge-tree 027058e6ac8d03e029c4e1455bf90f63cd20e65b
> FETCH_HEAD master
> (gdb) run
> Starting program: /usr/local/bin/git merge-tree
> 027058e6ac8d03e029c4e1455bf90f63cd20e65b FETCH_HEAD master
> Reading symbols for shared libraries +++++.............................. done
> 
> Program received signal EXC_BAD_ACCESS, Could not access memory.
> Reason: KERN_INVALID_ADDRESS at address: 0x0000000000000000
> 0x000000010006f1a3 in add_merge_entry (entry=0x100432ba0) at
> builtin/merge-tree.c:24
> 24 *merge_result_end = entry;

Thanks.  I have an idea of what's going on, but the set up is in an
earlier pass and it only fails the next time it gets into
add_merge_entry.

Can you try adding the following patch on top?  Hopefully the added
debug is in the right caller, otherwise the new assert at the top will
point us to the right one.

-- >8 --
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index ec49917..8eebab7 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -23,6 +23,7 @@ static void add_merge_entry(struct merge_list *entry)
 {
 	*merge_result_end = entry;
 	merge_result_end = &entry->next;
+	assert(merge_result_end);
 }
 
 static void merge_trees_recursive(struct tree_desc t[3], const char *base, int df_conflict);
@@ -267,6 +268,12 @@ static void unresolved(const struct traverse_info *info, struct name_entry n[3])
 	if (n[0].mode && !S_ISDIR(n[0].mode))
 		entry = link_entry(1, info, n + 0, entry);
 
+	if (!entry) {
+		fprintf(stderr, "n[0].mode = %d\nn[1].mode = %d\nn[2].mode = %d\n",
+			n[0].mode, n[1].mode, n[2].mode);
+		assert(FALSE);
+	}
+
 	add_merge_entry(entry);
 }
 
