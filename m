From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use nonrelative paths instead of absolute paths for
 cloned repositories
Date: Fri, 06 Jun 2008 09:45:24 -0700
Message-ID: <7viqwmv7ff.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0806052244300.19665@iabervon.org>
 <alpine.DEB.1.00.0806060422310.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Greg KH <greg@kroah.com>,
	Andrew Klossner <andrew@cesa.opbu.xerox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 18:46:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4f5J-0004i2-6q
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 18:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758221AbYFFQph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 12:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755875AbYFFQph
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 12:45:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415AbYFFQpg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 12:45:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6C39D1EFE;
	Fri,  6 Jun 2008 12:45:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9D42C1CDE; Fri,  6 Jun 2008 12:45:26 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806060422310.21190@racer> (Johannes
 Schindelin's message of "Fri, 6 Jun 2008 04:23:01 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FB1B2DC6-33E7-11DD-A56F-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84088>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 5 Jun 2008, Daniel Barkalow wrote:
>
>> Particularly for the "alternates" file, if one will be created, we want 
>> a path that doesn't depend on the current directory, but we want to 
>> retain any symlinks in the path as given and any in the user's view of 
>> the current directory when the path was given.
>
> I have to say that I do not follow why the symlinks should be trusted any 
> more than the absolute paths.

Thanks, Daniel.

I am obviously in favor of fixing this regression before 1.5.6, and the
introduction of make_nonrelative_path() for the use of clone alone is
probably the least impact and safe solution in the short term after -rc1.

In the longer term, we would inevitably face "when should one use
nonrelative and when should one use absolute?" and we would eventually
have to answer it.  It may turn out that many current users of "absolute"
are better off using "nonrelative", but I suspect we won't get rid of
"absolute" completely, because one of the reasons it avoids symlinks at
great lengths is so that it can check the containment relationships
between paths reliably (e.g. "is this path outside the repository, in
which case we should refuse to add it to the index, and we use --no-index
without being asked when running "diff"").

But using "absolute" for containment comparison is one thing.  Storing the
result of "absolute" is quite another.

We've already learned to love a similar crazyness somebody's system has on
this list.  If you want to check if the user string is equivalent to a
path you stored in the filesystem, you compare them after normalizing and
that is a sensible approach.  Storing path after normalizing, which would
be different form than what the user originally used to create, is not so
sane and leads to all sorts of pain.  Ending up storing the output from
"absolute" in info/alternates is just like giving normalized sequence back
from readdir(3) on such a system.
