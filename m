X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: problem in unpack-trees.c
Date: Mon, 04 Dec 2006 01:53:57 -0800
Message-ID: <7vodqkq956.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612022125530.1867@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 09:54:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612022125530.1867@scrub.home> (Roman Zippel's
	message of "Sun, 3 Dec 2006 02:21:39 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33177>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrAWQ-0003lL-4t for gcvg-git@gmane.org; Mon, 04 Dec
 2006 10:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935370AbWLDJx7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 04:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935380AbWLDJx7
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 04:53:59 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:3029 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S935370AbWLDJx6
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 04:53:58 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061204095357.MLRB27894.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Mon, 4
 Dec 2006 04:53:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id uZtP1V0011kojtg0000000; Mon, 04 Dec 2006
 04:53:23 -0500
To: Roman Zippel <zippel@linux-m68k.org>
Sender: git-owner@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> writes:

> I looked into it and the problem is during the "git-read-tree --reset" 
> step and it seems that the local df_conflict_entry variable of 
> unpack_trees() survives past that function. If you check in 
> add_cache_entry() it's called with this variable and only because 
> verify_path() fails it's not added to the tree on the other archs, but on 
> m68k the data on the stack is a bit different and thus verify_path() 
> succeeds and the stack variable is added to the tree and later saved.

I am very puzzled about this.

You are correct that the address of the df_conflict_entry is
assigned to "struct unpack_trees_options *o" in unpack_trees(),
and add_cache_entry() are called from many places in the call
chain that starts from that function.  And these call sites do
rely on the conflict_entry to have a NUL name to prevent
add_cache_entry from adding the entry to the index.  Which feels
like a hack, but it should get the job done while it is running.

But I do not see the o->df_conflict_entry used after unpack_trees()
returns in git-read-tree.

> Using the patch below, you can simulate what's happing on m68k...

The patch does not compile for me (the static definition part),
but it appears that the memset() in question is not clearing the
name field.

Ah....

Oops....

Isn't "struct cache_entry" a structure with a flexible array
member at the end?  I wonder why we have it on the stack to
begin with.

On my x86-64 box with gcc 4 (i.e. "#define FLEX_ARRAY /* empty */"
is used,

        #include "cache.h"

        int
        main(int ac, char **av)
        {
                printf("sz %zu\n", sizeof(struct cache_entry));
                printf("of %zu\n", offsetof(struct cache_entry, name));
                memset(&dfc, 0, sizeof(dfc));
        }

size of "struct cache_entry" is 64 while the offset of name
member is 62, so I am luckily getting two bytes of room for
memset to fill and cause name[] to be properly NUL terminated.
If the alignment requirement of the platform is smaller, we may
be overstepping the struct when we access its name[] member.

