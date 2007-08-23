From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking perms/ownership
Date: Thu, 23 Aug 2007 15:08:25 -0700
Message-ID: <7vtzqpsy3q.fsf@gitster.siamese.dyndns.org>
References: <1187716461.5986.71.camel@beauty>
	<20070821134030.b763e9d3.seanlkml@sympatico.ca>
	<1187817948.5986.159.camel@beauty>
	<alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
	<1187905879.5986.199.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Josh England" <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Fri Aug 24 00:08:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOKqz-0004EL-4d
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 00:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762477AbXHWWIe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 18:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760262AbXHWWIe
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 18:08:34 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:42412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758578AbXHWWId (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 18:08:33 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C398612710A;
	Thu, 23 Aug 2007 18:08:49 -0400 (EDT)
In-Reply-To: <1187905879.5986.199.camel@beauty> (Josh England's message of
	"Thu, 23 Aug 2007 15:51:19 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56538>

"Josh England" <jjengla@sandia.gov> writes:

> Looking at the index struct, it already has fields in it for file mode
> uid and gid (woohoo!).

I can see that storing textual names in gitattributes and having
the root user run git so that it can chown(), would work.

But this is only about checkout.  After you chown a file in the
work tree and run update-index, next write-tree would not record
it, as there is no place in tree objects to record uid/gid.
You would need to arrange so that a matching change is made in
the gitattributes file if you go that route.

If you had:

	etc/*		owner=root
        etc/frotz	owner=nobody

in gitattributes, and you did a checkout.  You chown etc/nitfol
with "chown printer etc/nitfol".  Somebody needs to add a line

	etc/nitfol	owner=printer

to gitattributes before you make the commit.  Maybe the chown
was not about etc/nitfol but about making etc/frotz owned by
root.  Then you would, instead of adding the etc/nitfol line,
remove existing etc/frotz line so that earlier glob would
capture and express the idea of making everything owned by
root.  I suspect this would get rather tricky quickly.

Of course, you would need to worry about resolving merge
conflicts of gitattributes file, too.
