X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Better symbolic link support in "tree" view
Date: Wed, 6 Dec 2006 00:06:43 +0100
Message-ID: <200612060006.44155.jnareb@gmail.com>
References: <1165256780505-git-send-email-jnareb@gmail.com> <200612052227.56770.jnareb@gmail.com> <7vk616ezu5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 23:04:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UV5nIjd/vaE2Lp0FKmRn2RF45Xf5AvC3o9bPqU9lcpij6OXJu/5nEwf/28bYhQ3SiFM82l1BqQ9UOAvPDoTonnHroxkAwTo9cG4o9SU17ORgL6HKMLYyPRsn8HLdnGiry2D0XauZI1AWjzggbAEoaAwVKWuDYqrODtf9lMRo+dc=
User-Agent: KMail/1.9.3
In-Reply-To: <7vk616ezu5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33387>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrjLA-0003YA-6C for gcvg-git@gmane.org; Wed, 06 Dec
 2006 00:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967139AbWLEXEl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 18:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967131AbWLEXEl
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 18:04:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:55978 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S967139AbWLEXEk (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec
 2006 18:04:40 -0500
Received: by ug-out-1314.google.com with SMTP id 44so10490uga for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 15:04:38 -0800 (PST)
Received: by 10.78.17.1 with SMTP id 1mr9481069huq.1165359878486; Tue, 05 Dec
 2006 15:04:38 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 11sm35274628hug.2006.12.05.15.04.37; Tue, 05 Dec
 2006 15:04:38 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Junio C Hamano wrote:
>>> ...
>>> I think " -> link_target" is fine, but I do not know if it is
>>> useful (while I do not think it is wrong) to make the value that
>>> would have been returned from readlink() into an href, even when
>>> it points at something inside the same revision.
>>
>> I have added this bit (making symbolic link target symlink) because 
>> otherwise there is no way, besides hand-munging the URL, to go to the 
>> link target.
> 
> I can read what you wrote it does.
> 
> For one thing, the user is tracking the symbolic link itself,
> not the contents of the file or directory the link points at.
> For that "tracked symlink", where it points at is the important
> content, not what the file that is pointed at happens to contain
> in the same revision.
> 
> If you have to open an extra object while drawing the list, I do
> not think it is worth doing it.
> 
> In order to show " -> link_target", you have to read the
> contents of the blob.  I think that overhead to read one extra
> blob is probably an acceptable tradeoff for convenience.

Especially that it is done _only_ if there exist symbolic link
entry in a tree.
 
> But if you want to make it a link into the same tree, you would
> need to check if link_target path exists and if it is a blob or
> tree to produce an appropriate tree_view/blob_view link (I
> haven't read your code but that is the natural thing to do).
> 
> That would involve in reading a few more tree objects (depending
> on how deep the target is in the tree), and I do not think it is
> worth doing it while drawing a list.  After you prepared dozens
> of such links, the user would click at most one of them and 
> leaves the page; your cycles to draw those unclicked links were
> wasted.

Actually this requires only one call to git-ls-tree

  $ git ls-tree $hash_base -- $target_path

Internally this mean reading a few more tree objects, but in gitweb
the cost of fork is what (I think) dominates.

> If you wanted to do this, a better way would be to have a new
> view that takes a commit/tree object and a path from the top of
> the repository, and shows either "no such path in that tree" or
> "here is the view for that object, by the way it was a blob."
> page.  Then your list drawing would still need to open each
> symlink blob to show " -> link_target", and need to check if it
> goes outside the repository (I would assume you are handling
> relative links as well),

I handle _only_ relative links. There is no way to treat absolute links 
leading within repository (well, there is, but absoulte links depends 
on position of repository in the filesystem, and that is usually bad 
idea... unless absolute link is not to file within repository). The 
link is "normalized" to path from the top of the tree/top of repository 
tree (dealing with /./, /../, and // in the way).

>                          but you do not need to do expensive 
> ls-tree step one per symlink on the page.  The href attr of the
> A element " -> link_target" would point at that "universal
> object view" with the link_target pathname (that is, the blob
> contents) and the commit/tree object name (h or hb I do not know
> which) and you will spend cycles to run ls-tree only when the
> user actually asks to follow that link.
> 
> In other words, I think trying to be lazy is extremely important
> while drawing a big list.

Well, that is certainly another solution. I'm not sure if distinction 
between checking if link target exists (and getting target type while 
at it) and providing link to perhaps "no such patch in that tree" page 
is worth %feature... well, I guess it is not.

I'll split the patch into two: first to read link target and show it in 
"tree" view _without_ hyperlink, and later perhaps either your or mine 
solution (most probably yours), depending on feedback.

-- 
Jakub Narebski
