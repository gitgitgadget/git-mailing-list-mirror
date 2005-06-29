From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] denser delta header encoding
Date: Tue, 28 Jun 2005 22:21:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506282217010.19755@ppc970.osdl.org>
References: <Pine.LNX.4.63.0506290021050.1667@localhost.localdomain>
 <7vmzp9kbcf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 07:14:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnUtc-000453-Et
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 07:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVF2FU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 01:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVF2FU1
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 01:20:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12196 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262425AbVF2FTr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2005 01:19:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5T5JVjA021850
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Jun 2005 22:19:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5T5JVgn021123;
	Tue, 28 Jun 2005 22:19:31 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzp9kbcf.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 28 Jun 2005, Junio C Hamano wrote:
>
> Linus, please do not apply this as is.

Argh. Too late.

> There are code other than what Nico updated with this patch in
> sha1_file.c that also need updating, that count the number of
> bytes in the delta-patch result by reading from the delta
> header.

Hmm.. I tested this (along with my change to make the pack object also 
use the little-endian size encoding) with "gitk" on a packed git archive, 
and with git-unpack-objects. So it can't break _too_ seriously. Is it the 
"git-cat-file -s" thing that gets the wrong answer?

Ahh. I see it. "packed_delta_info()". And it looks like "diff" uses it 
too. Oh, for the copy and rename detection. I don't think I tested that 
part, nope.

> I wonder if we can have a helper function in delta suite
> somewhere (maybe in diff-delta.c):
> 
>     int look_at_delta_header(void **delta_data, ulong delta_size,
>     	                     ulong *src_size, ulong *dst_size)
> 
> that:
> 
>     - checks delta size and barf if it is small;
>     - reads the header and fills src_size and dst_size;
>     - advances *delta_data pointer;
> 
> and have count-delta, patch-delta and sha1_file.c users use it
> consistently.  Nico, what do you think?

Sounds like a good idea.

		Linus
