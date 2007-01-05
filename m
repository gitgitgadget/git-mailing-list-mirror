From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Fri, 05 Jan 2007 15:09:15 -0800
Message-ID: <7v64bldqas.fsf@assigned-by-dhcp.cox.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jan 06 00:09:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2yBd-0002Uf-KI
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 00:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbXAEXJR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 18:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbXAEXJR
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 18:09:17 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:57093 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbXAEXJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 18:09:16 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105230915.ZSVT3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jan 2007 18:09:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7b8T1W0021kojtg0000000; Fri, 05 Jan 2007 18:08:27 -0500
To: "Chris Lee" <chris133@gmail.com>
In-Reply-To: <204011cb0701051503m3a431e07qc12662eecc08884f@mail.gmail.com>
	(Chris Lee's message of "Fri, 5 Jan 2007 15:03:26 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36042>

"Chris Lee" <chris133@gmail.com> writes:

> On 1/5/07, Junio C Hamano <junkio@cox.net> wrote:
>> Subject: [PATCH] builtin-prune: memory diet.
>>
>> Somehow we forgot to turn save_commit_buffer off while walking
>> the reachable objects.  Releasing the memory for commit object
>> data that we do not use matters for large projects (for example,
>> about 90MB is saved while traversing linux-2.6 history).
>
> Is git-verify-pack supposed to mmap the entire packfile? Because the
> version I have maps 2.3GB into RAM and keeps it there until it's done.

Yes -- we need to hash the whole thing as well as doing other
checks on it.  Sliding mmap() in "next" will mmap that in chunks
of 32MB or 1GB, but its needing to read every byte of it does
not change.

The problem Linus pointed out was that your SHA1_Update()
implementations may not be prepared to hash the whole 2.3GB in
one go.  The one in "master" (and "maint", although I haven't
done a v1.4.4.4 maintenance release yet) calls SHA1_Update()
in chunks to work around that potential issue.
