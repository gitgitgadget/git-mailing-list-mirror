From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-revover-tags-script
Date: Sun, 17 Jul 2005 11:53:29 -0700
Message-ID: <7voe91jmc6.fsf@assigned-by-dhcp.cox.net>
References: <m1u0iuo63i.fsf@ebiederm.dsl.xmission.com>
	<7vr7dy9rw4.fsf@assigned-by-dhcp.cox.net>
	<m1psthomf0.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 20:54:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuEGq-0004XQ-SE
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 20:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVGQSxf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 14:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVGQSxf
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 14:53:35 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:55939 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261308AbVGQSxb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 14:53:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050717185330.AVW8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Jul 2005 14:53:30 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> What we care about are the tag objects, those are the only kind
> that are verifiable and usable remotely.  
>
> Now that I know we do not pull tags currently with any of the
> optimized transports, I would suggest taking the list of commit
> objects we are transporting and for each commit look in the
> remote repo/refs/tags and transferring every tag object we can find
> that refers to that commit.

I do not think it is particularly a good idea to fetch a tag
that refers to a commit when the user asks only for that commit
(e.g. the user said "the head of this remote branch I am
tracking", and the head happened to have been tagged).  Yes, it
may be convenient, but retrieving the commit chain and
retrieving tags are conceptually separate issues.  A tag does
not necessarily refer to a commit, so your reverse index does
not make sense for a tag pointing at a blob, for example.

I think if we have discovery mechanism of remote tags/heads, we
do not need anything else.  You _could_ say something like:

    $ git-list-remote --tags linux-2.6
    9e734775f7c22d2f89943ad6c745571f1930105f	v2.6.12-rc2
    26791a8bcf0e6d33f43aef7682bdb555236d56de	v2.6.12
    ...
    a339981ec18d304f9efeb9ccf01b1f04302edf32	v2.6.13-rc3
    $ git-list-remote --tags linux-2.6 |
      while read sha1 tag;
      do
          git fetch linux-2.6 tag $tag
      done

and you are done.  We did not use the reverse index, nor we used
the --all-tags flag to git-fetch-script.  You do not even need
git-list-remote if you are willing to wget a=summary output from
gitweb and parse the bottom of the page ;-).

The above may not exactly work for linux-2.6 repository because
I think the "tag" form of git-fetch-script may expect to find a
tag that resolves to a commit object and there is the oddball
v2.6.11-tree tag, but you got the general idea.
