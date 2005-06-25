From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: git Tutorial?
Date: Fri, 24 Jun 2005 18:27:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.50.0506241807260.29122-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0506231808560.721-100000@monsoon.he.net>
 <Pine.LNX.4.58.0506232344431.11175@ppc970.osdl.org>
 <Pine.LNX.4.50.0506240842090.24799-100000@monsoon.he.net>
 <Pine.LNX.4.58.0506240910040.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 25 03:21:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlzMN-0005Gc-0X
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 03:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVFYB1u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 21:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263031AbVFYB1u
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 21:27:50 -0400
Received: from digitalimplant.org ([64.62.235.95]:33260 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261287AbVFYB1m
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2005 21:27:42 -0400
Received: from localhost ([127.0.0.9]) by digitalimplant.org for <git@vger.kernel.org>; Fri, 24 Jun 2005 18:27:37 -0700
X-X-Sender: mochel@monsoon.he.net
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506240910040.11175@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


On Fri, 24 Jun 2005, Linus Torvalds wrote:

>
>
> [ git-list cc'd, since these example things might be useful to others ]
>
> On Fri, 24 Jun 2005, Patrick Mochel wrote:

> > The handy things I've noticed missing are the equivalents of
> >
> > - bk changes -u<user> (Great for tracking down a change one did)
>
> You can script it (and if you do so nicely, feel free to send me a
> patch). Here's the magic long-hand version that does something fairly
> close to it:
>
> 	git-rev-list --header HEAD |
> 		grep -z author.*torvalds |
> 		tr '\0\n' '\n:' |
> 		cut -d: -f1 |
> 		git-diff-tree --pretty --stdin -p |
> 		less -S
>
> (That's really hacky, because "cut" and other standard unix tools don't
> like using '\0' as a record separator, but hey, whatever works..)
>
> The above gives the result in "git-whatchanged" format, ie you get the
> patch too. If you don't want to see the patch, give the "-s" flag to
> git-diff-tree instead of the "-p" flag, but if you script it, I'd suggest
> allowing the user to give that as an option to the script.

Ok, it ain't exactly pretty, but it works.

Below is a patch to git-whatchanged that adds some optional parameters to
it that allow users to filter the changesets returned by git-rev-list.

	-a	Specify the author's name.
		This can be any part of the "author" line: the first name,
		the last name, both, the login name, the domain name, or
		the entire email address.

		For example:

		git-whatchanged -a "Linus"
		git-whatchanged -a "Linus Torvalds"
		git-whatchanged -a "torvalds"
		git-whatchanged -a "torvalds@ppc970.osdl.org"
		git-whatchanged -a "@osdl.org"

	-c	Specify the committer's name
		Like the above, this can be any part of the "committer"
		line. For example:

		git-whatchanged -c "Greg"
		git-whatchanged -c "suse.de"
		git-whatchanged -c "gregkh@suse.de"


	And for good measure:

	-s	Specify a person that signed off on a patch.

		git-whatchanged -s "Linus Torvalds"
		git-whatchanged -s "mochel@digitalimplant.org"

		It doesn't support multiple "Signed-off-by" entries.

	They can also be used together:

	git-whatchanged -a mochel@digitalimplant.org -c gregkh@suse.de
	git-whatchanged -a Dunlap -s Torvalds

By default, it still just prints the changeset comments. Passing '-p' will
print the patches.

Please note that my script-fu isn't exactly good, so the patch is probably
done in the worst possible way. Please feel free to rewrite it or simply
just toss it.

Thanks,


	Pat


diff --git a/git-whatchanged b/git-whatchanged
--- a/git-whatchanged
+++ b/git-whatchanged
@@ -1,4 +1,44 @@
 #!/bin/sh
-git-rev-list $(git-rev-parse --default HEAD --revs-only "$@") |
-	git-diff-tree --stdin --pretty -r $(git-rev-parse --no-revs "$@") |
+
+Author=""
+Committer=""
+SignedOffBy=""
+Args=""
+
+while [ $# -gt 0 ] ; do
+
+	echo $1
+case $1 in
+	-a)
+		shift
+		Author="$1"
+		;;
+	-c)
+		shift
+		Committer="$1"
+		;;
+	-s)
+		shift
+		SignedOffBy="$1"
+		;;
+	*)
+		Args="$Args $1"
+		;;
+
+esac
+	shift
+done
+
+filter_cset() {
+	egrep -z "author[[:print:]]+$Author" |
+	egrep -z "committer[[:print:]]+$Committer" |
+	egrep -z "Signed-off-by:[[:print:]]+$SignedOffBy"
+}
+
+
+git-rev-list --header $(git-rev-parse --default HEAD --revs-only "$Args") |
+	filter_cset |
+	tr '\0\n' '\n:' | cut -d: -f1 |
+	git-diff-tree --stdin --pretty $(git-rev-parse --no-revs "$Args") |
 	LESS="$LESS -S" ${PAGER:-less}
+
