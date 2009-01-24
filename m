From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH (GIT-GUI/CORE BUG)] git-gui: Avoid an infinite rescan
 loop in handle_empty_diff.
Date: Fri, 23 Jan 2009 19:29:08 -0800
Message-ID: <7v7i4lpekb.fsf@gitster.siamese.dyndns.org>
References: <200901240052.58259.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Andy Davey <as.davey@gmail.com>,
	kbro <kevin.broadey@googlemail.com>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 04:30:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQZEM-0004eS-54
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 04:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbZAXD3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 22:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754174AbZAXD3T
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 22:29:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35567 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbZAXD3S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 22:29:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 40FDB1D27A;
	Fri, 23 Jan 2009 22:29:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 32EAC1D273; Fri,
 23 Jan 2009 22:29:10 -0500 (EST)
In-Reply-To: <200901240052.58259.angavrilov@gmail.com> (Alexander Gavrilov's
 message of "Sat, 24 Jan 2009 00:52:57 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2D867A82-E9C7-11DD-8A37-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106949>

Alexander Gavrilov <angavrilov@gmail.com> writes:

>     $ git config core.autocrlf true

This operation, when done in an already populated work tree, invalidates
all the state that is cached in the index, and you would need to adjust
things to the altered reality caused by this operation before doing
anything else.  There are different reasons you would want to flip the
configuration after you have files in your work tree, and depending on the
situation, the correct adjustment would differ.

You may have started a project in this repository, your work tree files
all have CRLF endings that is your platform convention, and after adding
the files to the index (but before making a commit) you may have realized
that you would want to keep your project cross platform, and that may be
the reason you are flipping the configuration.  If that is the case, your
index is already contaminated with CRLF, but your files have the line
ending that is correct (for you).  You would want to remove the index and
"add ." to stage everything again before proceeding, to have the autocrlf
mechanism to correct the line endings in the repository objects.

This would be the best case in one extreme.

On the other hand, you may have cloned a cross platform project from
elsewhere (in other words, your objects and the index have the correct
line ending), the checkout was done without autocrlf and it does not match
the local filesystem convention to use CRLF, and that may be the reason
you are flipping the configuration.  If that is the case, before making
any changes to the work tree files, the right adjustment would be to
remove the index, and "reset --hard" to force a checkout that follows your
autocrlf settings, so that the work tree files are corrected.

This would be the best case in the other end of the extreme.

And there will be different cases in between these extremes.

I think clueful users who flips the configuration from the command line
would know all of the above, know what they want and can tell what the
best course of action would be, but I at the same time wonder if git-gui
should (and if so, can) offer a simple and safe way to help this process
from others.
