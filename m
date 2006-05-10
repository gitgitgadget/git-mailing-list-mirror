From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fix diff-delta bad memory access
Date: Wed, 10 May 2006 12:01:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605101159160.3718@g5.osdl.org>
References: <Pine.LNX.4.64.0605101216360.24505@localhost.localdomain>
 <Pine.LNX.4.64.0605100953090.3718@g5.osdl.org>
 <Pine.LNX.4.64.0605101311020.24505@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 10 21:03:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fdtxm-0007tV-8V
	for gcvg-git@gmane.org; Wed, 10 May 2006 21:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWEJTDG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 15:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWEJTDG
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 15:03:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15802 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964800AbWEJTDF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 May 2006 15:03:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4AJ20tH009284
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 10 May 2006 12:02:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4AJ1wYe021830;
	Wed, 10 May 2006 12:01:59 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0605101311020.24505@localhost.localdomain>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19893>



Btw, Nico, that rabin hash code is _extremely_ confusing.

The hash entry pointers point to "data + RABIN_WINDOW", and then to make 
things even _more_ confusing, the hash calculation code is actually offset 
by one, so it will have computed the hash with

	val = ((val << 8) | data[i]) ^ T[val >> RABIN_SHIFT];

where "i" goes from _1_ to RABIN_WINDOW instead of 0..WINDOW-1.

So, if I read that correctly, the "entry->ptr" actually points not to the 
beginning of the data that was hashed, or even the end, but literally to 
the last byte of the data that was hashed in that window.

Isn't that just _really_ confusing?

Or is there some sense to this?

			Linus
