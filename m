From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] commit: add function to unparse a commit and its parents
Date: Tue, 19 May 2009 00:14:01 -0700
Message-ID: <7vfxf18szq.fsf@alter.siamese.dyndns.org>
References: <20090517153307.6403.73576.>
	<20090517153647.6403.44036.chriscool@tuxfamily.org>
	<7v3ab3exht.fsf@alter.siamese.dyndns.org>
	<200905190616.30132.chriscool@tuxfamily.org>
	<7vws8d8y8i.fsf@alter.siamese.dyndns.org>
	<m3r5ylk347.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 19 09:14:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6JWi-000554-Tk
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 09:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbZESHOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 03:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752744AbZESHOB
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 03:14:01 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:40619 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbZESHOB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 03:14:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090519071402.HUPP25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 19 May 2009 03:14:02 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id tKE11b0024aMwMQ03KE1mV; Tue, 19 May 2009 03:14:01 -0400
X-Authority-Analysis: v=1.0 c=1 a=4Mj9RkLmTmMA:10 a=wsYAPnAVpiQA:10
 a=pGLkceISAAAA:8 a=Ngk9f2QB3E7FFquQu_AA:9 a=jG-h5BUAakSYNvHDSevG729QmmsA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <m3r5ylk347.fsf@localhost.localdomain> (Jakub Narebski's message of "Mon\, 18 May 2009 23\:35\:45 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119498>

Jakub Narebski <jnareb@gmail.com> writes:

> First, I have always thought that you cannot push arbitrary SHA-1
> (arbitrary commits) in git; you can only push via refs. Isn't it true?

No.

> Second, the "refs/replace" mechanism has the advantage over grafts
> that it is sanely transferrable. Whether "04a8c^2"^{replaced} exists
> on remote side depends on if other side has the same replacement, or
> if you push replacements in the same push.

The reason why replace mechanism could be cleaner than grafts is because
reachability traversal and transfer do not obey replacements, and local
ancestry traversal will if there are refs/replace entries.

So "git log" and friends will obey refs/replace/*, but between
a repository that replaces a commit and another that doesn't, they will
transfer history without replace entries getting in the way.  Whatever
04a8c^2 resolves to with replacements, the _real_ history between that
commit and whatever the tips of refs on the other side has is
transferred, and that commit will update the 'master' branch on the other
side.

If the other side sees it as the second parent of 04a8c is a different
matter.  If refs/replace hierarchy is shared between the repositories, it
will; otherwise it won't.  And the beauty of the replace mechanism is,
unlike grafts, because object transfer will always be done using _real_
history, you can sanely sync refs/replace hierarchy between the
repositories via push or fetch.  During the push of the 04a8c^2 object,
the other side does not have to worry about the presense/absense of
replace that changes the interpretation of that notation on either end.
The exact same underlying history is transferred with or without the
replacement objects.
