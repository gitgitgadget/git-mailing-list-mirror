From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Calculating tree nodes
Date: Mon, 03 Sep 2007 21:28:41 -0700
Message-ID: <7vmyw3835y.fsf@gitster.siamese.dyndns.org>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>
	<20070904025153.GS18160@spearce.org>
	<9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
	<Pine.LNX.4.64.0709040439070.28586@racer.site>
	<9e4733910709032054y4407ce62o6b21935502bfacdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 06:28:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISQ22-0001ps-3V
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 06:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbXIDE2t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 00:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbXIDE2t
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 00:28:49 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:34118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbXIDE2s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 00:28:48 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id EE91A12CA37;
	Tue,  4 Sep 2007 00:29:04 -0400 (EDT)
In-Reply-To: <9e4733910709032054y4407ce62o6b21935502bfacdb@mail.gmail.com>
	(Jon Smirl's message of "Mon, 3 Sep 2007 23:54:00 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57520>

"Jon Smirl" <jonsmirl@gmail.com> writes:

>> Yes.  For performance reasons, since a simple commit would kill you in any
>> reasonably sized repo.
>
> That's not an obvious conclusion. A new commit is just a series of
> edits to the previous commit. Start with the previous commit, edit it,
> delta it and store it. Storing of the file objects is the same. Why
> isn't this scheme fast than the current one?

I think you seem to be forgetting about tree comparison.

With a large project that has a reasonable directory structure
(i.e. not insanely narrow), a commit touches isolated subparts
of the whole tree.  Think of an architecture specific patch to
the Linux kernel touching only include/asm-i386 and arch/i386
directories.

Being able to cull an entire subdirectory (e.g. drivers/ which
has 5700 files underneath) by only looking at the tree SHA-1 of
the containing tree is a _HUGE_ win.

And this is not just about two tree comparison.  When you say:

	git log v2.6.20 -- arch/i386/

what you are seeing is a simplified history that consists of
commits that touch only these paths.  How would we determine if
a commit touch these paths efficiently?  By comparing the "i386"
entry in tree objects for $commit^:arch and $commit:arch.  You
do not have to look inside arch/i386/ trees to see if any of the
330 files in it is different.  You just check a single SHA-1
pair.
