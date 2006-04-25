From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Wed, 26 Apr 2006 11:18:59 +1200
Message-ID: <444EAE63.1070006@vilain.net>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>	<e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jnareb@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 26 01:19:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYWoV-0000pr-8w
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 01:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWDYXTT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 19:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWDYXTT
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 19:19:19 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:2945 "EHLO watts.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932307AbWDYXTT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 19:19:19 -0400
Received: by watts.utsl.gen.nz (Postfix, from userid 65534)
	id 9F49C4FA6; Wed, 26 Apr 2006 11:19:10 +1200 (NZST)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by watts.utsl.gen.nz (Postfix) with ESMTP id A4B5E1D7A;
	Wed, 26 Apr 2006 11:19:00 +1200 (NZST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19178>

Junio C Hamano wrote:

>Here is a related but not necessarily competing idle thought.
>
>How about an ability to "attach" arbitrary objects to commit
>objects?  The commit object would look like:
>
>    tree 0aaa3fecff73ab428999cb9156f8abc075516abe
>    parent 5a6a8c0e012137a3f0059be40ec7b2f4aa614355
>    parent e1cbc46d12a0524fd5e710cbfaf3f178fc3da504
>    related a0e7d36193b96f552073558acf5fcc1f10528917 key
>    related 0032d548db56eac9ea09b4ba05843365f6325b85 cherrypick
>    author Junio C Hamano <junkio@cox.net> 1145943079 -0700
>    committer Junio C Hamano <junkio@cox.net> 1145943079 -0700
>  
>

I agree with the criticisms of the patchset, and I think this is
probably a more comprehensive and less ambiguous solution. I originally
thought that the use cases were close enough together that they could be
called the same thing, but I see now that they are not.

IMHO one important goal is to stop "parent" from meaning anything other
than:

1. for a regular commit, the base for this change. The change consists
of the differences between the two trees.
2. for a "merge", the merge parents for this change. The change consists
of all differences between the index merges (allowing duplicate blobs at
each location) and the final merged tree.

If you were to, for a moving merge head, just record the previous merge
as a "parent", then it would make it difficult to look at the commit
history to figure out which parent links represent the last merge, and
which represent the merge bases.

This suggestion fixes that problem nicely, while being nice and flexible
for solving the other problems too.

>    Merge branch 'pb/config' into next
>
>    * pb/config:
>      Deprecate usage of git-var -l for getting config vars list
>      git-repo-config --list support
>
>The format of "related" attribute is, keyword "related", SP, 40-byte
>hexadecimal object name, SP, and arbitrary sequence of bytes
>except LF and NUL.  Let's call this arbitrary sequence of bytes
>"the nature of relation".
>
>The semantics I would attach to these "related" links are as
>follows:
>
> * To the "core" level git, they do not mean anything other than
>   "you must to have these objects, and objects reachable from
>   them, if you are going to have this commit and claim your
>   repository is without missing objects".
>  
>

This is essentially correct, however you have already described a use
case where you want the behaviour to be to lose the previous commit chain:

>The reason I do not include the previous head when I reconstruct
>"pu" is because I explicitly *want* to drop history -- not
>having to carry forward a failed experiment is what is desired
>there.  Otherwise I would manage "pu" just like I currently do
>"next" and "master".  So this is not a justification to add
>something new.
>  
>

In this case, I think that there are types of relations that are more
along the lines of "don't bother following this link by default, but
warn/fail if it is unavailable depending on the user preferences".

git-fsck could then have options to prune (or archive) certain types of
optional relations. This way people can still record complete history if
they like. And people who want to mark portions of history as bad (such
as, violating copyright law) have a clear way to state that intent.

>That means "git-rev-list --objects" needs to list these objects
>(and if they are tags, commits, and trees, then what are
>reachable from them), and "git-fsck" needs to consider these
>related objects and objects reachable from them are reachable
>from this commit.  NOTHING ELSE NEEDS TO BE DONE by the core
>(obviously, cat-file needs to show them, and commit-tree needs to
>record them, but that goes without saying).
>  
>

Ok, I'll investigate that.

>Then porcelains can agree on what different kinds of nature of
>relation mean and do sensible things.  The earlier "omit the
>cherry-picked ones" example I gave can examine "cherrypick".
>  
>

Sounds good. Let things evolve.

Sam.
