From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Am able to delete a file with no trace in the log
Date: Tue, 2 Jun 2009 20:03:31 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906022000040.4880@localhost.localdomain>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net> <20090602213439.GA7584@coredump.intra.peff.net> <alpine.LFD.2.01.0906021439030.4880@localhost.localdomain> <7vfxeidqoz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 05:04:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBgm4-00014A-9P
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 05:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbZFCDEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 23:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbZFCDEP
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 23:04:15 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46246 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752420AbZFCDEO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2009 23:04:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5333WVZ003548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Jun 2009 20:03:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5333VDA017015;
	Tue, 2 Jun 2009 20:03:31 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vfxeidqoz.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120578>



On Tue, 2 Jun 2009, Junio C Hamano wrote:
> 
> Sorry, but I do not quite understand this comment.  REV_TREE_NEW can be
> treated differently from REV_TREE_DIFFERENT but that only happens if you
> know about --remove-empty option, and no scripted (and later converted to
> C) Porcelain uses that option by default.

It's not REV_TREE_NEW, but the other way around, ie when the commit has no 
contents but the parent _does_ have contents, maybe we shouldn't then look 
at another parent and say "no content", and then match that other parent 
(resulting in no difference).

IOW, we are in the situation where one parent gets REV_TREE_SAME, but gets 
it for a totally pointless reason, namely that neither that parent nor the 
eventual merge has anything at all in that path. In that case, we simplify 
towards the parent that results in the smallest diff - which in this case 
is "nothing there at all".

Now, that is often the _right_ thing to do, since if it was meant to be 
deleted in that branch, then we'll eventually hit the delete commit, and 
see it as a nice removal. But it does make it really hard to see this case 
of "unintentional delete"

		Linus
