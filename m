From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Fri, 05 Jan 2007 16:23:53 -0800
Message-ID: <7v3b6pc89y.fsf@assigned-by-dhcp.cox.net>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	<Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
	<7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
	<204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com>
	<7v1wmalez6.fsf@assigned-by-dhcp.cox.net>
	<204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com>
	<7vbqldfg56.fsf@assigned-by-dhcp.cox.net>
	<204011cb0701051133r1ede14a6gd5093a3e7fa88cb5@mail.gmail.com>
	<20070105193958.GE8753@spearce.org>
	<7vtzz5duk1.fsf@assigned-by-dhcp.cox.net>
	<204011cb0701051503m3a431e07qc12662eecc08884f@mail.gmail.com>
	<7v64bldqas.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701051515000.3661@woody.osdl.org>
	<7vac0xc9g8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701051610290.3661@woody.osdl.org>
	<Pine.LNX.4.64.0701051611550.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Lee <chris133@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 01:24:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2zLq-0004jD-8p
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 01:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbXAFAXz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 19:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbXAFAXz
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 19:23:55 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:42936 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbXAFAXy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 19:23:54 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070106002354.QGBD7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jan 2007 19:23:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7cP51W00J1kojtg0000000; Fri, 05 Jan 2007 19:23:05 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701051611550.3661@woody.osdl.org> (Linus
	Torvalds's message of "Fri, 5 Jan 2007 16:15:28 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36059>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 5 Jan 2007, Linus Torvalds wrote:
>> 
>> But it really shouldn't be a problem. 
>
> Basically, this boils down to the same old issue: if you have a fixed 
> access pattern (like SHA1_Update() over the whole buffer), you're actually 
> likely to perform better with a loop of read() calls than with mmap.
>
> So if we ONLY did the SHA1 thing, we shouldn't do mmap, we should just 
> chunk things up into 16kB buffers or something, and read them.

While I have your attention, there is a patch for the sliding
mmap() thing that raises the mmap window to 1GB (which means a
pack smaller than that is mmap'ed in its entirety, whle 2.3GB
pack will be mapped perhaps as three separate chunks) and the
total mmap window to 8GB (and any overflows we LRU out) on
places where sizeof(void*) == 8 (i.e. git compiled for 64-bit).

Currently these limits are 32MB and 256MB respectively on
platforms with real mmap().

Do you have any comments on it?
