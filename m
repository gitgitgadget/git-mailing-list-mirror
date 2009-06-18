From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fix big left-shifts of unsigned char
Date: Thu, 18 Jun 2009 09:08:35 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906180856420.16802@localhost.localdomain>
References: <E1MFvux-0001ix-I7@fencepost.gnu.org> <alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de> <E1MG32S-0004C6-8A@fencepost.gnu.org> <alpine.LFD.2.01.0906142118250.3305@localhost.localdomain> <E1MH3bD-0004g2-97@fencepost.gnu.org>
 <alpine.LFD.2.01.0906171543120.16802@localhost.localdomain> <alpine.LFD.2.01.0906171654310.16802@localhost.localdomain> <alpine.DEB.1.00.0906181012050.4848@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 18 18:08:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHKAR-0000h8-4G
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 18:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbZFRQIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 12:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbZFRQIh
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 12:08:37 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44777 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751460AbZFRQIg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2009 12:08:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5IG8a4b003326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Jun 2009 09:08:37 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5IG8ZJG025667;
	Thu, 18 Jun 2009 09:08:36 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0906181012050.4848@intel-tinevez-2-302>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.473 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121853>



On Thu, 18 Jun 2009, Johannes Schindelin wrote:
> 
> I wonder if there is a mode of 'sparse' which could spot these buggers.

Hmm. A very quick hack gets me (this is _after_ my patch):

	diffcore-delta.c:53:24: warning: Signed left-shift
	diffcore-delta.c:58:21: warning: Signed left-shift
	diffcore-delta.c:88:21: warning: Signed left-shift

which are all of the type "<< alloc_log", and not very interesting.

	read-cache.c:1155:17: warning: Signed left-shift

This one is "real", and I noticed it in my earlier greps, but we don't 
care (it's the CACHE_EXT_TREE/CACHE_EXT() matching, and it's all done in 
"int", and the only case we care about is a non-signed case anyway)

	imap-send.c:785:52: warning: Signed left-shift
	imap-send.c:1190:35: warning: Signed left-shift

These are both "real", but we're only working on "unsigned" so we don't 
really care.

	builtin-rev-list.c:201:21: warning: Signed left-shift

this is exp2i(), and it returns 'int', and wouldn't work for big left 
shifts anyway.

And just to see that my sparse logic actually worked, _without_ the patch 
I sent to fix left-shifts, I got these:

	base85.c:95:38: warning: Signed left-shift		(fixed)
	diffcore-delta.c:53:24: warning: Signed left-shift
	diffcore-delta.c:58:21: warning: Signed left-shift
	diffcore-delta.c:88:21: warning: Signed left-shift
	delta.h:98:42: warning: Signed left-shift		(fixed)
	delta.h:98:42: warning: Signed left-shift		(dup - inline)
	patch-delta.c:47:63: warning: Signed left-shift		(fixed)
	read-cache.c:1155:17: warning: Signed left-shift
	sha1_file.c:1179:39: warning: Signed left-shift		(fixed)
	delta.h:98:42: warning: Signed left-shift		(dup - inline)
	delta.h:98:42: warning: Signed left-shift		(dup - inline)
	imap-send.c:785:52: warning: Signed left-shift
	imap-send.c:1190:35: warning: Signed left-shift
	builtin-rev-list.c:201:21: warning: Signed left-shift
	builtin-unpack-objects.c:441:39: warning: Signed left-shift (fixed)

just to verify that my sparse checker actually found the ones the patch 
modified.

			Linus
