From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bug in git log
Date: Tue, 2 May 2006 08:26:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605020817060.4086@g5.osdl.org>
References: <20060502075122.GA8203@spinlock.ch> <7virooomve.fsf@assigned-by-dhcp.cox.net>
 <20060502134158.GC4592@spinlock.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 02 17:27:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FawmT-0004WX-SP
	for gcvg-git@gmane.org; Tue, 02 May 2006 17:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWEBP0z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 11:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWEBP0z
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 11:26:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964882AbWEBP0y (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 11:26:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k42FQetH017141
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 2 May 2006 08:26:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k42FQdQe003538;
	Tue, 2 May 2006 08:26:39 -0700
To: Matthias Kestenholz <lists@irregular.ch>
In-Reply-To: <20060502134158.GC4592@spinlock.ch>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19423>



On Tue, 2 May 2006, Matthias Kestenholz wrote:
> 
> The "double dash" problem is not a big deal since it only happens
> with the deprecated shellscript-version of whatchanged.

Simple enough to fix. Appended.

The problem was that "git-rev-parse --no-flags --no-revs" will show _just_ 
the filenames from the argument list. That means that it will also remove 
the "--" from the original. That's all well and proper, but 
git-whatchanged had a bug, and it wouldn't separate the filename arguments 
from the flags by adding its own "--".

That bug didn't matter back when we didn't check the parsing all that 
carefully. It does now.

> Does anyone get some output with the following command? That was the
> bug I tried to report (sorry for my bad/convoluted english)
> 
> $ git log -- unresolve.c

Now, this returns empty, and it actually does that for a reason.

Along the main path, "unresolve.c" has never existed. The modern 
"git-whatchanged" (and "git log") is a bit different from the old 
big-whatchanged.

The old git-whatchanged would go through _every_ commit, because it 
literally did

	git-rev-list | git-diff-tree --stdin -- <paths>

and thus the revision list was generated without _any_ regard for the 
paths - and every single commit shows up, whether it is relevant or not.

The new revision is based on the revision parsing thing, and the semantics 
are a bit different: it semantically does the equivalent of

	git-rev-list <paths> | git-diff-tree --stdin -- <paths>

which limits the revision list too on the paths.

And yes, "git log" does the same.

See the discussion a few weeks ago about "path limiting broken", and my 
patch that suggested a "--no-prune-merges" flag:

	http://www.gelato.unsw.edu.au/archives/git/0604/19180.html

which gives more of an explanation.

		Linus

--
diff --git a/git-whatchanged.sh b/git-whatchanged.sh
index 1fb9feb..bb73cff 100755
--- a/git-whatchanged.sh
+++ b/git-whatchanged.sh
@@ -24,5 +24,5 @@ rev_list_args=$(git-rev-parse --sq --def
 diff_tree_args=$(git-rev-parse --sq --no-revs --no-flags "$@") &&
 
 eval "git-rev-list $count $rev_list_args" |
-eval "git-diff-tree --stdin --pretty -r $diff_tree_flags $diff_tree_args" |
+eval "git-diff-tree --stdin --pretty -r $diff_tree_flags -- $diff_tree_args" |
 LESS="$LESS -S" ${PAGER:-less}
