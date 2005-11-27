From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 6/8] ls-tree: work from subdirectory.
Date: Sun, 27 Nov 2005 11:00:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511271049090.13959@g5.osdl.org>
References: <Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy83cdu7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511251953081.13959@g5.osdl.org>
 <7voe477n4i.fsf_-_@assigned-by-dhcp.cox.net> <7vpson4tqi.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511260855560.13959@g5.osdl.org> <7vr792fnta.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511270949540.13959@g5.osdl.org> <20051127182244.GK22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 27 20:00:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgRl9-0003xG-DC
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 20:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVK0TAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 14:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVK0TAU
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 14:00:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51408 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750763AbVK0TAT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 14:00:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jARJ0BnO026976
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 27 Nov 2005 11:00:11 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jARJ099A030633;
	Sun, 27 Nov 2005 11:00:10 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051127182244.GK22159@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12817>



On Sun, 27 Nov 2005, Petr Baudis wrote:

> Dear diary, on Sun, Nov 27, 2005 at 07:01:37PM CET, I got a letter
> where Linus Torvalds <torvalds@osdl.org> said that...
> > If you use "-r", it acts the way you'd expect. If you _don't_ use "-r", it 
> > acts strangely, but very consistently with git-diff-tree: it only ever 
> > shows the _first_ part of a pathname. So
> > 
> > 	git-ls-tree HEAD drivers/char/
> > 
> > should show just one entry: "drivers". While adding a "-r" should show all 
> > files under drivers (and the trees leading up to it).
> > 
> > And yes, you're right. That's a much bigger change by my suggested diff, 
> > and more likely to cause confusion.
> 
> Ugh. That's really weird. Wouldn't a better approach be to fix
> git-ls-files to behave more sanely? (That is, listing the entry for
> drivers/char instead of drivers?)

Well, it's not actually confusing if you see a path spec for what it is: 
it's not a filename, it's a _pattern_.

So you should always do

	git-ls-tree -r pattern

(and yes, we could even hardcode "-r", because git-ls-tree without it 
really is a pretty strange thing).

The _real_ strangeness in "git-ls-tree" is that it shows the tree nodes at 
all, which no other git tool does when it recurses. 

To get more a "git-ls-files" approach, this trivial patch (on top of my 
previous one) enables recursion (and right now you can't disable it any 
way), and doesn't show partial trees.

I could make it work much more like git-ls-files, in that it could accept 
wildcards. Something like

	git-ls-tree HEAD '*.c'

would show all C files (recursively), the same way git-ls-files does for 
the index.

Hmm?

		Linus

----
diff --git a/ls-tree.c b/ls-tree.c
index 598b729..cf0dbbc 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -11,7 +11,7 @@
 static int line_termination = '\n';
 #define LS_RECURSIVE 1
 #define LS_TREE_ONLY 2
-static int ls_options = 0;
+static int ls_options = LS_RECURSIVE;
 
 static const char ls_tree_usage[] =
 	"git-ls-tree [-d] [-r] [-z] <tree-ish> [path...]";
@@ -19,16 +19,15 @@ static const char ls_tree_usage[] =
 static int show_tree(unsigned char *sha1, const char *base, int baselen, const char *pathname, unsigned mode, int stage)
 {
 	const char *type = "blob";
-	int retval = 0;
 
 	if (S_ISDIR(mode)) {
-		type = "tree";
 		if (ls_options & LS_RECURSIVE)
-			retval = READ_TREE_RECURSIVE;
+			return READ_TREE_RECURSIVE;
+		type = "tree";
 	}
 
 	printf("%06o %s %s\t%.*s%s%c", mode, type, sha1_to_hex(sha1), baselen, base, pathname, line_termination);
-	return retval;
+	return 0;
 }
 
 int main(int argc, const char **argv)
