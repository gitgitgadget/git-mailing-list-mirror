From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-revover-tags-script
Date: Sun, 17 Jul 2005 18:13:36 -0700
Message-ID: <7v64v8j4qn.fsf@assigned-by-dhcp.cox.net>
References: <m1u0iuo63i.fsf@ebiederm.dsl.xmission.com>
	<7vr7dy9rw4.fsf@assigned-by-dhcp.cox.net>
	<m1psthomf0.fsf@ebiederm.dsl.xmission.com>
	<7voe91jmc6.fsf@assigned-by-dhcp.cox.net>
	<m1hdetnfjq.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 03:14:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuKCZ-0001UJ-AH
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 03:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVGRBNj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 21:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVGRBNj
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 21:13:39 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:53185 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261471AbVGRBNi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 21:13:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050718011335.XZAQ550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Jul 2005 21:13:35 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m1hdetnfjq.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's message of "Sun, 17 Jul 2005 18:06:33 -0600")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> There are a couple pieces of your example that disturb me.

Did you actually think I suggested you to make that into a
script that cannot be configured?  No, it was Junio acquiring a
habit from Linus to give a rough outline in a code form in his
e-mail client.

In another message, you said:

> Actually looking a little deeper unless I have misread
> the code git-fetch-pack at least will only ask for commit
> objects so git fetch will never return a tag object.

I thought so but then I tried it and actually it does seem to
work as expected (well, it is Linus code so it has to be perfect
;-).  I created an empty directory and ran the following script.
It creates two commits, tags the later commit to
".git/refs/tags/one", and shows the list of objects the
upload-pack (the peer git-fetch-pack talks to) decides to pack
and send to the puller that has the first commit only.  The
first git-rev-list shows one extra object compared to the second
one; the difference is the named tag that is being asked.


------------
#!/bin/sh

rm -fr .git
git-init-db
zero_tree=$(git-write-tree)
echo "base tree $zero_tree"
zero_commit=$(
	echo Empty tree as the base |
	git-commit-tree $zero_tree
)
echo "base commit $zero_commit"

echo >a
git-update-cache --add a
one_tree=$(git-write-tree)
echo "one tree $one_tree"
one_commit=$(
	echo Add one file |
	git-commit-tree $one_tree -p $zero_commit
)
echo "one commit $one_commit"

tagger=$(git-var GIT_COMMITTER_IDENT)
echo "object $one_commit
type commit
tag tag-one
tagger $tagger

just a tag." | git-mktag >.git/refs/tags/one
echo "one tag `cat .git/refs/tags/one`"

echo "*** reachable from one tag but not from zero"
git-rev-list --objects tags/one ^$zero_commit

echo "*** reachable from one commit but not from zero"
git-rev-list --objects $one_commit ^$zero_commit
