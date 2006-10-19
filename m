From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 17:07:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610181655430.3962@g5.osdl.org>
References: <20061018053647.GA3507@coredump.intra.peff.net>
 <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org> <20061018185225.GU20017@pasky.or.cz>
 <20061018185907.GV20017@pasky.or.cz> <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610181510510.1971@xanadu.home> <20061018191834.GA18829@spearce.org>
 <Pine.LNX.4.64.0610181525410.1971@xanadu.home> <20061018204626.GA19194@spearce.org>
 <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org> <20061018214143.GF19194@spearce.org>
 <7vwt6xxofi.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610181542160.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610181910440.1971@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 02:08:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaLSH-0002zI-2N
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 02:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945917AbWJSAIJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 20:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945918AbWJSAIJ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 20:08:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9865 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945917AbWJSAIH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 20:08:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9J07waX026740
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Oct 2006 17:07:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9J07vCi024104;
	Wed, 18 Oct 2006 17:07:58 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610181910440.1971@xanadu.home>
X-Spam-Status: No, hits=-0.971 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29306>



On Wed, 18 Oct 2006, Nicolas Pitre wrote:
> 
> If you use builtin-unpack-objects.c from next, you'll be able to 
> generate the pack index pretty easily as well, as all the needed info is 
> stored in the obj_list array.  Just need to append objects remaining on 
> the delta_list array to the end of the pack, sort the obj_list by sha1 
> and write the index.

Actually, I've hit an impasse.

The index isn't the problem. The problem is actually writing the resultant 
pack-file itself in one go.

The silly thing is, the pack-file contains the number of entries in the 
header. That's a silly problem, because the _natural_ way to turn a thin 
pack into a normal pack would be to just add the missing objects from the 
local store into the resulting pack. But we don't _know_ how many such 
missing objects there are, until we've gone through the whole source pack. 

So you can't easily do a streaming "write the result as you go along" 
version using that approach.

So there's _another_ way of fixing a thin pack: it's to expand the objects 
without a base into non-delta objects, and keeping the number of objects 
in the pack the same. But _again_, we don't actually know which ones to 
expand until it's too late.

The end result? I can expand them all (I have a patch that does that). Or 
I could leave as deltas the ones I have already seen the base for in the 
pack-file (I don't have that yet, but that should be a SMOP). But I'm not 
very happy with even the latter choice, because it really potentially 
expands things that didn't _need_ expansion, they just got expanded 
because we hadn't seen the base object yet.

So I'll happily send my patches to anybody who wants to try (I don't write 
the index file yet, but it should be easy to add), but I'm getting the 
feeling that "builtin-unpack-objects.c" is the wrong tool to use for this, 
because it's very much designed for streaming.

It would probably be better to start from "index-pack.c" instead, which is 
already a multi-pass thing, and wouldn't have had any of the problems I 
hit. 

Gaah.

> Pretty trivial indeed.

So it's conceptually totally trivial to rewrite a pack-file as another 
pack-file, but at least so far, it's turned out to be less trivial in 
practice (or at least in a single pass, without holding everything in 
memory, which I definitely do _not_ want to do).

So I'm leaving this for today, and perhaps coming back to it tomorrow with 
a fresh eye.

			Linus
