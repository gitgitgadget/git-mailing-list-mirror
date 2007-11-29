From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Some git performance measurements..
Date: Wed, 28 Nov 2007 21:17:09 -0800
Message-ID: <7vr6i9y6ju.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 06:17:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxbmN-0004pb-Of
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 06:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbXK2FRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 00:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbXK2FRR
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 00:17:17 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:37092 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbXK2FRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 00:17:16 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 939302EF;
	Thu, 29 Nov 2007 00:17:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1413897EAC;
	Thu, 29 Nov 2007 00:17:34 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 28 Nov 2007 18:49:04 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66503>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Less than a hundredth of a second may not sound much, but when we have 
> 1700+ directories in the kernel trees, doing that for each possible 
> .gitignore file is really really expensive!

The only thing that wants to use excluded() in the unpack_trees()
codepath is the code to allow overwriting an existing, untracked file in
verify_absent().  When we find an untracked file at the same path as we
are just trying to check out a file, we allow overwriting it only if
that file is "ignored".

But the way the unpack_trees_rec() and the gitignore handling in dir.c
are structured currently means we do push/pop exclude-per-directory
stack as we enter and leave a new subdirectory.  We do not do this
lazily on demand.

The newer gitattributes subsystem maintains a similar per-directory data
structure but this is purely done on-demand; until somebody asks "what
are the attrs for this path", we do not read .gitattributes file.  We
should be able to restructure exclude-per-directory code in a similar
way.
