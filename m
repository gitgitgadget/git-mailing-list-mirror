From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file descriptor
Date: Fri, 11 Jan 2008 17:08:24 -0800
Message-ID: <7vtzljzw8n.fsf@gitster.siamese.dyndns.org>
References: <4787E981.7010200@nrlssc.navy.mil>
	<4787F1F5.2010905@nrlssc.navy.mil>
	<7vve5z2abv.fsf@gitster.siamese.dyndns.org>
	<47880D18.8030405@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com
To: Brandon Casey <casey@nrlssc.navy.mil>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 02:09:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDUsB-0004ba-V6
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 02:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763486AbYALBIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 20:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763463AbYALBId
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 20:08:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63129 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762707AbYALBIc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 20:08:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 78333305F;
	Fri, 11 Jan 2008 20:08:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B29C305E;
	Fri, 11 Jan 2008 20:08:26 -0500 (EST)
In-Reply-To: <47880D18.8030405@nrlssc.navy.mil> (Brandon Casey's message of
	"Fri, 11 Jan 2008 18:43:04 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70242>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Junio C Hamano wrote:
>> Brandon Casey <casey@nrlssc.navy.mil> writes:
>> 
>>> It's reproduceable for me by amending the commit.
>> 
>> Reliably reproducible?  Can you build with "-O0 -g" and run
>> "commit --amend" under gdb?
>> 
>
> make NO_CURL=1 CFLAGS='-O0 -g'
> Done.
>
> I also moved xmmap into commit.c, and turned the inlined definition
> in git-compat-util.h into a declaration.
>
>
> I set a breakpoint on xmmap(). This is the backtrace on the last entry
> into xmmap() before it die()'ed.
>
> The fstat message at the end is from a call to fstat that I added to
> print out the file size (to compare with mmap length). As you can
> see the fstat also fails with the 'Bad file descriptor' message.
>
> #0  xmmap (start=0x0, length=996168, prot=1, flags=2, fd=6, offset=0)
>     at commit.c:680
> #1  0x080acf30 in use_pack (p=0x8150650, w_cursor=0xffffc0ac, offset=94828, 
>     left=0xffffc06c) at sha1_file.c:748

That's the pack window shuffling code in use_pack().  I presume
your additional fstat is inside xmmap(), so if p->pack_fd is
already closed when this xmmap() call is made, that would
explain the symptom.

	while (packed_git_limit < pack_mapped
		&& unuse_one_window(p, p->pack_fd))
		; /* nothing */
	win->base = xmmap(NULL, win->len,
		PROT_READ, MAP_PRIVATE,
		p->pack_fd, win->offset);

I wonder what's the best way to find out who closes file
descriptor #6 without clearing p->pack_fd that still holds #6?
My reading of unuse_one_window() is that it tried to avoid
closing p->pack_fd, so it may already have been closed when we
get to this codepath.

Shawn, does this ring a bell?
