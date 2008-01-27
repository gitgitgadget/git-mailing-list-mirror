From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix off by one error in prep_exclude.
Date: Sun, 27 Jan 2008 14:34:13 -0800
Message-ID: <7v3asiyk2i.fsf@gitster.siamese.dyndns.org>
References: <47975FE6.4050709@viscovery.net>
	<1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com>
	<alpine.LSU.1.00.0801272043040.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org,
	j.sixt@viscovery.net, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 27 23:35:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJG64-00048C-CW
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 23:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbYA0Wed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 17:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759546AbYA0Wec
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 17:34:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54821 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbYA0Web (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 17:34:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 38A543298;
	Sun, 27 Jan 2008 17:34:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E2023290;
	Sun, 27 Jan 2008 17:34:22 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801272043040.23907@racer.site> (Johannes
	Schindelin's message of "Sun, 27 Jan 2008 20:44:57 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71835>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> but doesn't address the fact that we probably should remove files that 
>> aren't a part of the repository at in the first place.
>
> I am sorry, but I cannot begin to see what this commit tries to 
> accomplish.  Yes, sure, there is an off-by-one error, and your commit 
> message says how that was fixed.  But I miss a description what usage it 
> would affect, i.e. when this bug triggers.
>
> I imagine that you would be as lost as me, reading that commit message 6 
> months from now, trying to understand why that change was made.

Likewise.  The message has somewhat to be desired...

In "struct exclude_stack", prep_exclude() and excluded(), the
convention for a path is to express the length of directory part
including the trailing slash (e.g. "foo" and "bar/baz" will get
baselen=0 and baselen=4 respectively).

The variable current and parameter baselen follow that
convention in the codepath the patch touches.

		else {
			cp = strchr(base + current + 1, '/');
			if (!cp)
				die("oops in prep_exclude");
			cp++;
		}
		stk->prev = dir->exclude_stack;
		stk->baselen = cp - base;

is about coming up with the next value for current (which is
taken from stk->baselen) to dig one more level.

If base="foo/a/boo" and current=4 (i.e. we are looking at
"foo/"), at the point, scanning from (base+current) as Shawn
Bohrer's patch suggests means the scan begins at "a/boo" to find
the next slash.  The existing code skips one letter ('a') and
starts scanning from "/boo".

The only case this microoptimization makes difference is when an
input is malformed and has double-slash (i.e. path component
whose length is zero), like "foo//boo".

Perhaps the "oops part of the issue Johannes found" had a caller
that feeds such an incorrect input?
