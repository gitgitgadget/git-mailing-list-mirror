From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and other commit links ideas)
Date: Tue, 25 Apr 2006 00:29:48 -0700
Message-ID: <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
	<e2kgga$d7q$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jnareb@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 25 09:30:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYHzi-0000wz-2t
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 09:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWDYH3v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 03:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWDYH3v
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 03:29:51 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:23494 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751367AbWDYH3v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 03:29:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060425072950.KUDX18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Apr 2006 03:29:50 -0400
To: git@vger.kernel.org
In-Reply-To: <e2kgga$d7q$1@sea.gmane.org> (Jakub Narebski's message of "Tue,
	25 Apr 2006 08:44:08 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19132>

Jakub Narebski <jnareb@gmail.com> writes:

> Additionally for each of those cases we have to consider how to compute the
> link and which commands should be modified, which commands can make use of
> the link and should be modified, should the link be to commit, tag, tree or
> blob, what we want to do with link when pulling/pushing/cloning into
> another repository and which commands should be modified. Not only use case
> scenarios.

This last paragraph is a very good suggestion.  The alleged "use
cases" are just laudary list of wishes, if they are not
accompanied by descriptions on what the modified data structure
and added attribute _means_ and how they are _used_.

Here is a related but not necessarily competing idle thought.

How about an ability to "attach" arbitrary objects to commit
objects?  The commit object would look like:

    tree 0aaa3fecff73ab428999cb9156f8abc075516abe
    parent 5a6a8c0e012137a3f0059be40ec7b2f4aa614355
    parent e1cbc46d12a0524fd5e710cbfaf3f178fc3da504
    related a0e7d36193b96f552073558acf5fcc1f10528917 key
    related 0032d548db56eac9ea09b4ba05843365f6325b85 cherrypick
    author Junio C Hamano <junkio@cox.net> 1145943079 -0700
    committer Junio C Hamano <junkio@cox.net> 1145943079 -0700

    Merge branch 'pb/config' into next

    * pb/config:
      Deprecate usage of git-var -l for getting config vars list
      git-repo-config --list support

The format of "related" attribute is, keyword "related", SP, 40-byte
hexadecimal object name, SP, and arbitrary sequence of bytes
except LF and NUL.  Let's call this arbitrary sequence of bytes
"the nature of relation".

The semantics I would attach to these "related" links are as
follows:

 * To the "core" level git, they do not mean anything other than
   "you must to have these objects, and objects reachable from
   them, if you are going to have this commit and claim your
   repository is without missing objects".

That means "git-rev-list --objects" needs to list these objects
(and if they are tags, commits, and trees, then what are
reachable from them), and "git-fsck" needs to consider these
related objects and objects reachable from them are reachable
from this commit.  NOTHING ELSE NEEDS TO BE DONE by the core
(obviously, cat-file needs to show them, and commit-tree needs to
record them, but that goes without saying).

Then porcelains can agree on what different kinds of nature of
relation mean and do sensible things.  The earlier "omit the
cherry-picked ones" example I gave can examine "cherrypick".
