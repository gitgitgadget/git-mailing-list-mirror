From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix up diffcore-rename scoring
Date: Mon, 13 Mar 2006 07:38:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603130727350.3618@g5.osdl.org>
References: <Pine.LNX.4.64.0603122223160.3618@g5.osdl.org>
 <7vmzfusuyq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603122256550.3618@g5.osdl.org>
 <Pine.LNX.4.64.0603122316160.3618@g5.osdl.org> <7vzmjupqv0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 16:40:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIp8V-0002Uw-50
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 16:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWCMPi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 10:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWCMPi6
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 10:38:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59106 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751443AbWCMPi6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 10:38:58 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2DFcsDZ007385
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 13 Mar 2006 07:38:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2DFcrZA011093;
	Mon, 13 Mar 2006 07:38:54 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmjupqv0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17564>



On Mon, 13 Mar 2006, Junio C Hamano wrote:
> 
> By the way, the reason the diffcore-delta code in "next" does
> not do every-eight-bytes hash on the source material is to
> somewhat alleviate the problem that comes from not detecting
> copying of consecutive byte ranges.

Yes. However, there are better ways to do that in practice.

The most effective way that is generally used is to not use a fixed 
chunk-size, but use a terminating character, together with a 
minimum/maximum chunksize.

There's a pretty natural terminating character that works well for 
sources: '\n'.

So the natural way to do similarity detection when most of the code is 
line-based is to do the hashing on chunks that follow the rule "minimum of 
<n> bytes, maximum of <2*n> bytes, try to begin/end at a \n".

So if you don't see any '\n' at all (or the only such one is less than <n> 
bytes into your current window), do the hash over a <2n>-byte chunk (this 
takes care of binaries and/or long lines).

This - for source code - allows you to ignore trivial byte offset things, 
because you have a character that is used for synchronization. So you 
don't need to do hashing at every byte in both files - you end up doing 
the hashing only at line boundaries in practice. And it still _works_ for 
binary files, although you effectively need bigger identical chunk-sizes 
to find similarities (for text-files, it finds similarities of size <n>, 
for binaries the similarities need to effectively be of size 3*n, because 
you chunk it up at ~2*n, and only generate the hash at certain offsets in 
the source binary).

		Linus
