From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Wed, 23 May 2007 18:44:13 -0700
Message-ID: <7vps4ryp02.fsf@assigned-by-dhcp.cox.net>
References: <46528A48.9050903@gmail.com>
	<7v7iqz19d2.fsf@assigned-by-dhcp.cox.net>
	<56b7f5510705231655o589de801w88adc1aa6c18162b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 03:44:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr2NN-0005Ax-0B
	for gcvg-git@gmane.org; Thu, 24 May 2007 03:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756954AbXEXBoV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 21:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757257AbXEXBoV
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 21:44:21 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:62849 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756954AbXEXBoU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 21:44:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070524014421.VZAZ12190.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 23 May 2007 21:44:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2pkJ1X00Q1kojtg0000000; Wed, 23 May 2007 21:44:19 -0400
In-Reply-To: <56b7f5510705231655o589de801w88adc1aa6c18162b@mail.gmail.com>
	(Dana How's message of "Wed, 23 May 2007 16:55:27 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48214>

"Dana How" <danahow@gmail.com> writes:

> The packed X too big combination is the problem.  As the
> commit message says,  this could happen if the packs
> came from fast-import,...
> We have three options in this case:
> (1) Drop the object (do not put it in the new pack(s)).
> (2) Pass the object into the new pack(s).
> (3) Write out the object as a new loose object.
>
> Option (1) is unacceptable.  When you call git-repack -a,
> it blindly deletes all the non-kept packs at the end.  So
> the megablobs would be lost.

Ok, I can buy that -- (1) nor (2) are unacceptable and (3) is
the only sane thing to do for a previously packed objects that
exceed the size limit.

Since you have to handle that case _anyway_, I think it makes
sense to always say "Ok, we will write it out if there is no
loose representation already available".

That is, unless somebody smarter than me, like Nico or Shawn,
come up with better ideas to do this ;-).

> ... why did I implement --max-blob-size instead
> of --max-object-size?  I take this to mean that I should use
> the blob size if undeltified, and the delta size if previously deltified?

No, I think the only sensible way for the end user to specify
the size is uncompressed size of the object.  For a blob, that
is the size of checked-out file.  IOW:

	$ git cat-file $type $sha | wc -c

Nothing else would make any sense.
