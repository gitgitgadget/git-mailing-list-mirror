From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there a way to exclude user-specified files or directories
 from  participating in merges?
Date: Tue, 17 Feb 2009 17:05:07 -0800
Message-ID: <7v1vtw367w.fsf@gitster.siamese.dyndns.org>
References: <e38bce640902171649g765275a4n4e86d1d4f4aaf394@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 02:06:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZath-0003a7-4A
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 02:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbZBRBFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 20:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbZBRBFP
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 20:05:15 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43649 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbZBRBFO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 20:05:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B0BB09A9FC;
	Tue, 17 Feb 2009 20:05:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 991F29A9FA; Tue,
 17 Feb 2009 20:05:08 -0500 (EST)
In-Reply-To: <e38bce640902171649g765275a4n4e86d1d4f4aaf394@mail.gmail.com>
 (Brent Goodrick's message of "Tue, 17 Feb 2009 16:49:01 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 31E49182-FD58-11DD-A0A0-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110489>

Brent Goodrick <bgoodr@gmail.com> writes:

> Suppose I create a git repo called central.git on a machine I will
> call "central". In that central.git repo, I put these files:
>
>   work.sh
>   home.sh
>   generic.sh
>
> When I clone the central.git repo on to a different machine I will
> call "work", I want this fileset to be pulled:
>
>   work.sh
>   generic.sh
>
> But not the home.sh file.

You would have one common branch and one branch per deployment.

A common branch would host only common files (e.g. generic.sh file from
your example).  Per deployment branch, e.g. home, would branch from the
common branch (so it starts with some version of generic.sh) and may add
its own private files (e.g. home.sh).

And stick to the following two rules:

 - You make edits to common files only on the common branch.
 - You merge from common to deployment, never the other way.

So at work, you would have a checkout of your work "deployment branch",
and find needs to change things.  It is Ok to edit both work.sh and
generic.sh (without being able to edit both, it would be hard to verify if
the changes would work together) at this time, but don't commit the result
in the work branch.

Save the changes to work.sh away (e.g. "git diff work.sh >P.diff" and then
"git checkout HEAD work.sh"), switch to the common branch, and commit the
changes to the generic file.  Switch back to the deployment branch, merge
the common branch (to pick up the changes to home.sh), reapply the changes
specific to the deployment you saved earlier (e.g. "git apply P.diff"),
tne commit the result.
