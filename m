X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: problem in unpack-trees.c
Date: Mon, 4 Dec 2006 12:36:04 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0612041214590.1867@scrub.home>
References: <Pine.LNX.4.64.0612022125530.1867@scrub.home>
 <7vodqkq956.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 4 Dec 2006 11:36:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: roman@scrub.home
In-Reply-To: <7vodqkq956.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33191>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrC7T-0006d8-Qd for gcvg-git@gmane.org; Mon, 04 Dec
 2006 12:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936091AbWLDLgR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 06:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936094AbWLDLgR
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 06:36:17 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:56226 "EHLO
 scrub.xs4all.nl") by vger.kernel.org with ESMTP id S936091AbWLDLgP (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 06:36:15 -0500
Received: from roman (helo=localhost) by scrub.xs4all.nl with local-esmtp
 (Exim 3.36 #1 (Debian)) id 1GrC7A-0007Zf-00; Mon, 04 Dec 2006 12:36:04 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 4 Dec 2006, Junio C Hamano wrote:

> Roman Zippel <zippel@linux-m68k.org> writes:
> 
> > I looked into it and the problem is during the "git-read-tree --reset" 
> > step and it seems that the local df_conflict_entry variable of 
> > unpack_trees() survives past that function. If you check in 
> > add_cache_entry() it's called with this variable and only because 
> > verify_path() fails it's not added to the tree on the other archs, but on 
> > m68k the data on the stack is a bit different and thus verify_path() 
> > succeeds and the stack variable is added to the tree and later saved.
> 
> I am very puzzled about this.
> 
> You are correct that the address of the df_conflict_entry is
> assigned to "struct unpack_trees_options *o" in unpack_trees(),
> and add_cache_entry() are called from many places in the call
> chain that starts from that function.  And these call sites do
> rely on the conflict_entry to have a NUL name to prevent
> add_cache_entry from adding the entry to the index.  Which feels
> like a hack, but it should get the job done while it is running.

Ok, I see, I wasn't sure that this part was really intentional.

> On my x86-64 box with gcc 4 (i.e. "#define FLEX_ARRAY /* empty */"
> is used,
> 
>         #include "cache.h"
> 
>         int
>         main(int ac, char **av)
>         {
>                 printf("sz %zu\n", sizeof(struct cache_entry));
>                 printf("of %zu\n", offsetof(struct cache_entry, name));
>                 memset(&dfc, 0, sizeof(dfc));
>         }
> 
> size of "struct cache_entry" is 64 while the offset of name
> member is 62, so I am luckily getting two bytes of room for
> memset to fill and cause name[] to be properly NUL terminated.
> If the alignment requirement of the platform is smaller, we may
> be overstepping the struct when we access its name[] member.

Yes, on m68k both values are the same and thus name is not initialized.
Your patch should do the trick, I'll give it a try.

