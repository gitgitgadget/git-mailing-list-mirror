From: Junio C Hamano <gitster@pobox.com>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Tue, 18 Dec 2007 14:20:25 -0800
Message-ID: <7vejdjy79y.fsf@gitster.siamese.dyndns.org>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201>
	<20071218204623.GC2875@steel.home>
	<200712182224.28152.jnareb@gmail.com>
	<alpine.LFD.0.9999.0712181347140.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dana How <danahow@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 23:21:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4koM-0002My-Jh
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 23:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299AbXLRWUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 17:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754754AbXLRWUs
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 17:20:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63831 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282AbXLRWUs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 17:20:48 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F96556E2;
	Tue, 18 Dec 2007 17:20:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7987B403E;
	Tue, 18 Dec 2007 17:20:28 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0712181347140.21557@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 18 Dec 2007 13:53:20 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68831>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 18 Dec 2007, Jakub Narebski wrote:
>> 
>> What cwd? <path> in <tree-ish>:<path> syntax is "relative" to <tree-ish>.
>> IMHO "<tree-ish>:<path>" should be considered (and is considered) as
>> one object: current working directory doesn't matter at all there,
>> contrary to "<tree-ish> -- <pathspec>" where it is natural that <pathspec>
>> is relative to current working directory.
>
> Indeed.
>
> The <treeish>:<path> syntax *is* relative, but it's relative to the exact 
> *treeish* that is given. It has nothing what-so-ever to do with the 
> current working directory, since the user has explicitly given an exact 
> tree object, and trying to fake that out would be actively wrong.
>
> That said, I can kind of understand the wish for something like this, and 
> I suspect that we could make the "commit->tree" translation take the 
> current path into account. In other words, maybe we should have something 
> like this:
>
> 	/*
> 	 * This sequence currently works
> 	 */
> 	[torvalds@woody git]$ git rev-parse HEAD
> 	f9c5a80cdf2265f2df7712fad9f1fb7ef68b4768
>
> 	[torvalds@woody git]$ git rev-parse HEAD^{tree}
> 	051fb0c0dff4371f97f8ad9407f9f1fd335b1682
>
> 	[torvalds@woody git]$ git rev-parse HEAD^{tree}:t
> 	49d8bcd7a2df5c17193b1d002c4a8489d4fa990c
>
> 	/*
> 	 * .. but this would be new
> 	 */
> 	[torvalds@woody git]$ cd t
> 	[torvalds@woody t]$ git rev-parse HEAD^{tree}
> 	49d8bcd7a2df5c17193b1d002c4a8489d4fa990c
>
> where the magic is *not* done by any "SHA1 path lookup" at all, but is 
> simply done by the commit->tree lookup. At least at that point it would 
> make logical sense (although it would probably be quite painful to 
> implement).

It is not just painful to implement.

Although I can buy that purely from the user (read: people who do not
know how the world works) experience point of view, you have to be extra
careful if you do this.  There are existing codepaths that take a string
that names a treeish from the end user, appends "^{tree}" to that
string, and passes the result to get_sha1() to obtain a tree object name
they want to operate on (the alternative is parse_tree_indirect() but it
forces them to go through the object layer).  You will need to update
these callers to keep them working from subdirectories.
