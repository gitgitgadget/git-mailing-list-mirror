From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Fri, 11 Jan 2008 16:37:52 -0800
Message-ID: <7v3at3280v.fsf@gitster.siamese.dyndns.org>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org>
	<34F43A68-6041-42BE-85BD-3EF971875C0F@sb.org>
	<alpine.LFD.1.00.0801111356000.3148@woody.linux-foundation.org>
	<200801120026.01930.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 01:38:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDUOY-0005ua-2F
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 01:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761709AbYALAiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 19:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758276AbYALAiN
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 19:38:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62029 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757416AbYALAiN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 19:38:13 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AFEB3C23;
	Fri, 11 Jan 2008 19:38:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 73EC33C21;
	Fri, 11 Jan 2008 19:38:04 -0500 (EST)
In-Reply-To: <200801120026.01930.robin.rosenberg@dewire.com> (Robin
	Rosenberg's message of "Sat, 12 Jan 2008 00:26:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70236>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Could we just have a lookup table index extension for identifying the 
> duplicates (when checking is enabled using core configuration option #3324)? 
> That table would keep a mapping from a normalized form (maybe include 
> canonical encoding while we're at it) to the actual octet sequence(s) used.

I would agree that the index extension, if we ever are going to
do this, would be the right place to store this information, at
the single repository level.

However, this opens up a can of worms.  What's the canonical key
should be?  If you want to protect yourself from a unicode
normalizing filesystem, you would use one canonicalization,
while if you want to protect from a case losing filesystem you
would use another?  Or do we at the same time downcase and NFD
normalize at the same time and be done with it?

And where should the configuration be stored?  If a project
wants to be interoperable across Linux and vfat, for example,
that canonicalization needs to be enabled in repositories of all
participants, be they on Linux or vfat, so that people on Linux
can be prevented from creating and register two files xt_mark.c
and xt_MARK.c in the same directory, so that people who extract
the source on vfat won't have troubles.

Which means the information needs to be in-tree.  But that
should not be in .gitattributes (which by definition is for
per-path things).
