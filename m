X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/6] Allow pack header preprocessing before
 unpack-objects/index-pack.
Date: Wed, 01 Nov 2006 22:58:30 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611012226260.11384@xanadu.home>
References: <11624187853116-git-send-email-nico@cam.org>
 <7v3b92zpzj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 2 Nov 2006 03:59:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7v3b92zpzj.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30684>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfTjf-00041g-EN for gcvg-git@gmane.org; Thu, 02 Nov
 2006 04:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751678AbWKBD6c (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 22:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbWKBD6c
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 22:58:32 -0500
Received: from relais.videotron.ca ([24.201.245.36]:7475 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1751678AbWKBD6b
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 22:58:31 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8300B7F4DIMHG0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Wed,
 01 Nov 2006 22:58:30 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Wed, 1 Nov 2006, Junio C Hamano wrote:

> Rather nicely done.  I see upto 2/6 are identical to what has
> sitting in "pu" for the past few days, modulo some indentation?

Yes.  I just inserted them in the serie as I didn't see them in pu until 
a very recent pull.

> I wonder how much testing has this series seen, by the way.

It has been tested a bit.  At least until it started behaving 
correctly for me. There might still be bugs remaining, but nothing that 
should screw a repository up. I think it should be good enough for next.

> Also, I wonder what happens after 5/6 errors out.  It dies and
> the caller (typically receive-pack) reports it back, which would
> fail the push (and does not update the refs).  Retrying in such
> a case would probably use the same set of refs on both ends,
> resulting in exactly the same pack...

Well, the purpose of 5/6 is to avoid creating a .keep file if it already 
exists.  This is more a security thing so if you decide to mark one of 
your pack with .keep (say an history pack that doesn't need to be 
repacked) then you don't want a funny git server to send you the same 
pack just for the purpose of overwriting the same .keep file (that could 
be removed right away if it ends up being considered as a lock file).  
This is made more obvious with 6/6 as the .keep file is not removed if 
it was there before.  So this is not actually an error if creating a 
.keep file fails with EEXIST.

As for index-pack dying, it will be reported the same way as 
unpack-objects dying -- no difference there.  Of course if it dies on 
the first push, it is likely to die on all subsequent pushes since the 
condition for that to happen is most probably due to a serious problem 
(out of disk space, corruption in the existing objects in the 
repository, etc).

The pack is put in place with move_temp_to_file() so if a previous 
attempt already stored a pack with the same name before successfully 
updating corresponding refs then the old pack will silently be kept 
since we know both packs contain the same objects when they have the 
same name.  When a pack is moved it is always complete so there 
shouldn't be any (new) instance of repository corruption in normal 
circumbstances even in the presence of index-pack dying.



