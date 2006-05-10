From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git
Date: Wed, 10 May 2006 09:48:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605100919250.3718@g5.osdl.org>
References: <7viroezi8s.fsf@assigned-by-dhcp.cox.net> <864pzyh4x0.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0605092142050.3718@g5.osdl.org>
 <Pine.LNX.4.64.0605101012250.24505@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 10 18:49:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdrsD-0004oW-F8
	for gcvg-git@gmane.org; Wed, 10 May 2006 18:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWEJQtO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 12:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWEJQtO
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 12:49:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64912 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964908AbWEJQtO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 May 2006 12:49:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4AGmvtH003992
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 10 May 2006 09:48:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4AGmtao018274;
	Wed, 10 May 2006 09:48:56 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0605101012250.24505@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19888>



On Wed, 10 May 2006, Nicolas Pitre wrote:
> 
> When linking with Electric Fence I can reproduce the segfault on Linux 
> as well.
> 
> Looking into it now.

Yeah, I get 

	#0  0x1000bfe4 in create_delta (index=0xf7d758a0, trg_buf=0xf7d72eb8, trg_size=327, delta_size=0xffb422b4, 
	    max_size=143) at diff-delta.c:308
	#1  0x10005734 in try_delta (trg=0xf7fdbfa0, src=0xf7fdbf94, src_index=0xf7d758a0, max_depth=10)
	    at pack-objects.c:1049
	#2  0x10005b04 in find_deltas (list=0xf7e32f54, window=11, depth=10) at pack-objects.c:1128
	#3  0x10005ca0 in prepare_pack (window=10, depth=10) at pack-objects.c:1161
	#4  0x1000677c in main (argc=3, argv=0xffb436e4) at pack-objects.c:1359

ie the "entry" chain seems to be corrupt in create_delta.

Actually, it's not even the chain: it's the very first entry:

	(gdb) p index->hash[i]
	$2 = (struct index_entry *) 0xf7d7385c
	(gdb) p entry
	$3 = (struct index_entry *) 0xf7d7385c

and it's not a random value - it looks perfectly valid. As do all the 
other index hash entries. It's just that the index hash entries seem to 
all have been freed, so accessing them causes a SIGSEV!

			Linus
