From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fix handle leak in builtin-pack-objects
Date: Wed, 19 Nov 2008 09:31:39 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811190917020.27509@xanadu.home>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com>
 <4923FE58.3090503@viscovery.net>
 <alpine.LFD.2.00.0811190753420.27509@xanadu.home>
 <49240F6D.3030203@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 15:33:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2o73-0005G5-R8
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 15:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbYKSObr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 09:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbYKSObr
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 09:31:47 -0500
Received: from relais.videotron.ca ([24.201.245.36]:65337 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbYKSObq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 09:31:46 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KAL005T94CRX9D0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 19 Nov 2008 09:31:40 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <49240F6D.3030203@viscovery.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101347>

On Wed, 19 Nov 2008, Johannes Sixt wrote:

> Nicolas Pitre schrieb:
> > On Wed, 19 Nov 2008, Johannes Sixt wrote:
> > 
> >> Alex Riesen schrieb:
> >>> The opened packs seem to stay open forever.
> >> In my MinGW port I have the patch below that avoids that t5303 fails
> >> because of a pack file that remains open. (Open files cannot be replaced
> >> on Windows.) I had hoped that your patch would help, but it does not.
> >> Something else still keeps the pack file open. Can anything be done about
> >> that?
> >>
> >> -- Hannes
> >>
> >> From: Johannes Sixt <j6t@kdbg.org>
> >> Date: Mon, 17 Nov 2008 09:25:19 +0100
> >> Subject: [PATCH] t5303: Do not overwrite an existing pack
> >>
> ...
> > Acked-by: Nicolas Pitre <nico@cam.org>
> 
> Thanks, but I should have mentioned that at this time this patch was just
> meant for exposition, not inclusion.

Well, I'd include it right away since it is fundamentally the right 
thing to do.

> I'd prefer a solution to the problem that the pack file remains open. Do
> you have an idea where git-pack-objects keeps the pack file open, even
> with Alex's two patches applied?

That's not the issue.

The test is using pack-objects to overwrite a pack file, but to do so 
pack-objects has to open and read from the pack file about to be 
overwritten.  This is just wrong even if it happens to work by luck on 
Linux.

It is on purpose that the pack files are kept open.  This is to minimize 
the number of open() and mmap()/read() operations between successive 
object reads.  Those are not leaked file handles since they get closed 
when new packs are opened and the number of concurrent opened packs 
reaches a certain limit.


Nicolas
