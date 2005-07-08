From: Junio C Hamano <junkio@cox.net>
Subject: Re: patches to support working without the object database
Date: Fri, 08 Jul 2005 12:34:40 -0700
Message-ID: <7vpstt6qi7.fsf@assigned-by-dhcp.cox.net>
References: <42CE5764.9010405@gmail.com>
	<7vwto16t6h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 01:40:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dr2Rm-0006SW-9C
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 01:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbVGHTim (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 15:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbVGHTfk
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 15:35:40 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:20432 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262813AbVGHTem (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2005 15:34:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050708193441.BXBC19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 8 Jul 2005 15:34:41 -0400
To: Bryan Larsen <bryan.larsen@gmail.com>
In-Reply-To: <7vwto16t6h.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Fri, 08 Jul 2005 11:36:54 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Replying to myself...

JCH> While you are at it, you might also want to add an option to
JCH> write-blob to specify the type of the object you are hashing, so
JCH> that would make [*1*]:

JCH>     git-write-blob [-n] [-t <type>] <file>...

JCH> [Footnote]

JCH> *1* I considered this instead:

JCH>     git-write-blob [-n | -t <type>] <file>...

JCH> which means that if you specify type then -n is implied.  But
JCH> making -t independent would let you have inverse of
JCH> git-cat-file; a silly example:

JCH>     $ git-cat-file -t $FOO
JCH>     tree
JCH>     $ git-cat-file tree $FOO >tmp1
JCH>     $ FOO1=$(git-write-blob -t tree tmp1)

JCH> If we go this route, we may also want to rename it to
JCH> write-object, but I would want to have it as a separate patch
JCH> after this series settles down.

Come to think of it, there is only one in-tree user of
write-blob remaining.  Renaming it to hash-object, changing the
default behaviour to just hash without storing and instead give
it --write (or just -w) flag would make more sense.  Without -t,
the type should default to "blob".

Then, the above stupid example would then become:

    $ git-cat-file -t $FOO
    tree
    $ git-cat-file tree $FOO >tmp1
    $ FOO1=$(git-hash-object -t tree tmp1)

And the only in-tree user git-cvsimport-script would be changed to:

--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -683,7 +683,7 @@ while(<CVS>) {
 		$fn =~ s#^/+##;
 		my ($tmpname, $size) = $cvs->file($fn,$rev);
 		print "".($init ? "New" : "Update")." $fn: $size bytes.\n" if $opt_v;
-		open my $F, '-|', "git-write-blob $tmpname"
+		open my $F, '-|', "git-hash-object -w $tmpname"
 			or die "Cannot create object: $!\n";
 		my $sha = <$F>;
 		chomp $sha;
