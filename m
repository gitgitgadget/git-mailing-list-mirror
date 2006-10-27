X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 13:23:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610271252390.11384@xanadu.home>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
 <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610261105200.12418@xanadu.home>
 <45413209.2000905@tromer.org> <Pine.LNX.4.64.0610262038320.11384@xanadu.home>
 <20061027014229.GA28407@spearce.org>
 <BAYC1-PASMTP10C050A5FAA4C70AD57679AE040@CEZ.ICE>
 <7viri6i6uu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 27 Oct 2006 17:46:23 +0000 (UTC)
Cc: Sean <seanlkml@sympatico.ca>, Shawn Pearce <spearce@spearce.org>,
	Eran Tromer <git2eran@tromer.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7viri6i6uu.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30337>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdVQf-0004aJ-S7 for gcvg-git@gmane.org; Fri, 27 Oct
 2006 19:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752342AbWJ0RXd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 13:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752343AbWJ0RXd
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 13:23:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49534 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1752340AbWJ0RXc
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 13:23:32 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7T003C61N7ENF0@VL-MO-MR003.ip.videotron.ca> for git@vger.kernel.org; Fri,
 27 Oct 2006 13:23:32 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Thu, 26 Oct 2006, Junio C Hamano wrote:

> I'd almost say "heavy repository-wide operations like 'repack -a
> -d' and 'prune' should operate under a single repository lock",
> but historically we've avoided locks and instead tried to do
> things optimistically and used compare-and-swap to detect
> conflicts, so maybe that avenue might be worth pursuing.
> 
> How about (I'm thinking aloud and I'm sure there will be
> holes -- I won't think about prune for now)...
> 
> * "repack -a -d":
> 
>  (1) initially run show-ref (or "ls-remote .") and store the
>      result in .git/$ref_pack_lock_file;
> 
>  (2) enumerate existing packs;
> 
>  (3) do the usual "rev-list --all | pack-objects" thing; this
>      may end up including more objects than what are reachable
>      from the result of (1) if somebody else updates refs in the
>      meantime;
> 
>  (4) enumerate existing packs; if there is difference from (2)
>      other than what (3) created, that means somebody else added
>      a pack in the meantime; stop and do not do the "-d" part;
> 
>  (5) run "ls-remote ." again and compare it with what it got in
>      (1); if different, somebody else updated a ref in the
>      meantime; stop and do not do the "-d" part;
> 
>  (6) do the "-d" part as usual by removing packs we saw in (2)
>      but do not remove the pack we created in (3);
> 
>  (7) remove .git/$ref_pack_lock_file.
> 
> * "fetch --thin" and "index-pack --stdin":
> 
>  (1) check the .git/$ref_pack_lock_file, and refuse to operate
>     if there is such (this is not strictly needed for
>     correctness but only to give an early exit);

I don't think this is a good idea.  A fetch should always work 
irrespective of any repack taking place.  The fetch really should have 
priority over a repack since it is directly related to the user 
experience.  The repack can fail or produce suboptimal results if a race 
occurs, but the fetch must not fail for such a reason.

>  (2) create a new pack under a temporary name, and when
>      complete, make the pack/index pair .pack and .idx;

Actually this is what already happens if you don't specify a name to 
git-index-pack --stdin.

>  (3) update the refs.

So the actual race is the really small interval between the time the new 
pack+index are moved to .git/objects/pack/ and the moment the refs are 
updated.  In practice this is probably less than a second.  All that is 
needed here is to somehow go back to (2) if that interval occurs between 
(2) and (3).


