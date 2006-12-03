X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Thoughts about memory requirements in traversals [Was: Re: [RFC] Submodules in GIT]
Date: Sun, 03 Dec 2006 12:10:08 +0100
Organization: At home
Message-ID: <ekubag$6km$2@sea.gmane.org>
References: <20061130170625.GH18810@admingilde.org> <200612030307.26429.Josef.Weidendorfer@gmx.de> <20061203024655.GD26668@spearce.org> <200612030421.18662.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 3 Dec 2006 11:10:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 58
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33105>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqpF3-00062I-Dj for gcvg-git@gmane.org; Sun, 03 Dec
 2006 12:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935817AbWLCLKc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 06:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935814AbWLCLKc
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 06:10:32 -0500
Received: from main.gmane.org ([80.91.229.2]:41696 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935817AbWLCLKb (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 06:10:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GqpEh-0003U0-Fd for git@vger.kernel.org; Sun, 03 Dec 2006 12:10:20 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 03 Dec 2006 12:10:19 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 03 Dec 2006
 12:10:19 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Josef Weidendorfer wrote:

> On Sunday 03 December 2006 03:46, Shawn Pearce wrote:
>> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
>>> Thinking even one step further:
>>> Would it make sense to define an encoding format for the content of
>>> commit and tree objects inside of packs, where the SHA1 is replaced by
>>> the offset of the object in this pack?
>>> As exactly the SHA1 is the least compressable thing, this could promise
>>> quite a benefit.
>> [...]
>> 
>> This means that when we start to write out a commit we need to know
>> the offset to the tree that commit references.  But git-pack-objects
>> sorts object by type: commit, tree, blob (I forget where tags go,
>> but they aren't important in this context).  So generally *all*
>> commits appear before the first tree.  So when we write out the first
>> commit we need to know exactly how many bytes every commit will need
>> (compressed mind you) in this pack so we can determine the position
>> of the first tree.  Now do this for every commit and every tree
>> that those commits use...  yes, its a lot of work to precompute
>> and store all offsets before you even write out the first byte.
> 
> Yes, it looks like a hen-and-egg problem, but IMHO you can
> handle it nicely with another redirection, i.e. a table you build
> up while repacking the file, and storing this table at the end.
> 
> You simply sequentially renumber any object SHA, starting from 0
> in the order you see them. You can do two renumberings, one for
> the objects contained in the original pack (1), and one for the
> external ones (2). Put these new numbers (with a bit distinguishing
> (1) and (2)) as replacement into commit/tree objects.
> At the end, you have the new offsets for objects in (1). Put
> redirection tables for (1) [new number -> new offset]
> and (2) [other new number->SHA1 of external object] at the end
> of the new pack.
> This way, you effectivly have removed all incompressable SHAs from
> the pack file aside from one entry in the redirection tables for
> each external object.
> 
> The only problem I see is how to decode the objects, i.e. how to
> get the original SHA1 from an offset: we can not recalculate the
> SHA1 from the object content as we changed the content itself.
> But there should be a way to store the SHA1 in front of the object
> somehow, perhaps it is already given by the current format? 
> 
> Am I missing something here?

Doesn't this idea clash with the object and delta reusing for repack?
Hmmm... perhaps with the two indirect tables it wouldn't, only
the tables would need to be recalculated... or perhaps it would because
of offset clashes.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

