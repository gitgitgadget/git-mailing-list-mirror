From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make sure diff-helper can tell rename/copy in the new
 diff-raw format.
Date: Wed, 25 May 2005 17:55:51 -0700
Message-ID: <7v7jhmhkko.fsf@assigned-by-dhcp.cox.net>
References: <7vfywe769d.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505230736180.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 02:54:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db6da-0006SE-Sl
	for gcvg-git@gmane.org; Thu, 26 May 2005 02:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVEZA4E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 20:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVEZA4E
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 20:56:04 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:54183 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261630AbVEZAzw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 20:55:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526005550.KVAS8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 May 2005 20:55:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505230736180.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 23 May 2005 07:49:01 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> ... But the thing is,
LT> that's actually what I _want_, because I was planning on writing a tool
LT> that applies patches that applies them all-or-nothing.

I was going through past messages and realized I missed this
part of your message.  Now I think I understand what git-apply
program is all about.

There is one thing [*1*] currently missing from diff-patch
output for your plan to fully work.

A type change, like a file turning into a symlink, is currently
something built-in diff punts.  Your earlier response to "What
about modified and type changed" question suggests that you
would want it to be expressed as a delete and a create, so I
imagine that the "diff --git" output for this diff-raw:

    :100644 120000 abcdef... abcdef... T	frotz	frotz

you would want to see output as this:

    diff --git a/frotz b/frotz
    deleted file mode 100644
    --- frotz
    +++ /dev/null
    @@ -1 +0,0 @@
    -rezrov
    \ No newline at end of file
    diff --git a/frotz b/frotz
    new file mode 120000
    --- /dev/null
    +++ frotz
    @@ -0,0 +1 @@
    +rezrov
    \ No newline at end of file

Even simpler for me is not to do this "splitting a filepair into
create and delete", and have diff compare the two blobs
directly, though that would make a patch that does not make
sense to humans:

    diff --git a/frotz b/frotz
    old mode 100644
    new mode 120000
    ... diff between readlink and file contents if any ...

A tree turning into a file and vice versa is something you are
already taking care of in diff-tree when feeding the diffcore,
and diff-cache and diff-files do not even see tree objects to
begin with, so tree-to-file is something that will never be fed
to the output routine as a matched filepair, and you will always
get a delete/create pair with the current code.  I am fairly
certain, therefore, tree-to-file is not a problem.  Only symlink
vs file case is problematic with the current output routine.


[Footnote]

*1* Strictly speaking, there is another.  Changes in tree object
are not shown, either.  This however will not be a problem for
git-apply, because as long as the files underneath are handled
correctly you will end up with the right tree.

