X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 21:18:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610272109500.3849@g5.osdl.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <4540CA0C.6030300@tromer.org>
 <Pine.LNX.4.64.0610271310450.3849@g5.osdl.org> <7v3b99e87c.fsf@assigned-by-dhcp.cox.net>
 <20061028034206.GA14044@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 28 Oct 2006 04:18:35 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061028034206.GA14044@spearce.org>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30363>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdfeQ-00025Z-8P for gcvg-git@gmane.org; Sat, 28 Oct
 2006 06:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751767AbWJ1ESV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 00:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbWJ1ESV
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 00:18:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59567 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1751767AbWJ1ESV (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 00:18:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9S4I8Po014486
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 27
 Oct 2006 21:18:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9S4I7Yj014689; Fri, 27 Oct
 2006 21:18:08 -0700
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org



On Fri, 27 Oct 2006, Shawn Pearce wrote:
> 
> So a reader-writer lock is preferred over
> a non-locking solution such as I posted in
> http://article.gmane.org/gmane.comp.version-control.git/30288 ?
> 
> Not to mention that such a solution would also fix the -d issue
> Linus points out above.

Be very careful.

There's a good reason why git doesn't use locking, and tends to use the 
"create file exclusively and move over the old version after having tested 
that the old version is still relevant" approach.

Two _major_ issues:

 - just about any other locking algorithm simply doesn't work on some 
   filesystems. And then you're just royally screwed.

 - I want to be able to push out, regardless of whether there is somebody 
   (or millions of somebodies) reading the repository at the same time. So 
   locking is not acceptable for "normal operations" at all - at most this 
   would be a "keep a repack from interfering with another repack" kind of 
   thing.

I would MUCH rather we just rename the index/pack file to something that 
git can _use_, but that "git repack -a -d" won't remove. In other words, 
rather than locking, it would be much better to just use a naming rule: 
when we download a new pack, the new pack will be called

	new-pack-<SHA1ofobjectlist>.pack
	new-pack-<SHA1ofobjectlist>.idx

and we just make the rule that "git repack -a -d" will only ever touch 
packs that are called just "pack-*.{pack|idx}", and never anything else.

It really is that simple. Allow normal git object opens to open the 
"temporary file" naming version too (so that you can install the refs 
before the rename, and all the objects will be visible), but don't allow 
"git repack" to remove packs that are in the process of being installed.

Race removed, and no locking really needed. At most, we might need to be 
able to match up a "new-pack-*.idx" file with a "pack-*.pack" file when we 
open pack-files, simply because we can't rename two files atomically, so 
the pack-file and index file would potentially exist with "different" 
names for a short window. 

That kind of small semantic changes are _way_ better than introducing 
locking, which will inevitably have much worse error cases (not working, 
stale locks, inability to push because something is really slow, or any 
number of other problems).

