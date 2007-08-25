From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-daemon on NSLU2
Date: Fri, 24 Aug 2007 17:04:55 -0700
Message-ID: <7v1wdscwd4.fsf@gitster.siamese.dyndns.org>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com>
	<20070824062106.GV27913@spearce.org>
	<9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>
	<alpine.LFD.0.999.0708241618070.16727@xanadu.home>
	<9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com>
	<9e4733910708241506h6eecc11ge41b1dc313022b4b@mail.gmail.com>
	<fanmmk$f5q$1@sea.gmane.org>
	<9e4733910708241646x7b285574t94c3d7eb32bb60c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 02:05:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOj9E-0006H8-Nn
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 02:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654AbXHYAFA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 20:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755177AbXHYAFA
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 20:05:00 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:34652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955AbXHYAFA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 20:05:00 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id BE701127C09;
	Fri, 24 Aug 2007 20:05:18 -0400 (EDT)
In-Reply-To: <9e4733910708241646x7b285574t94c3d7eb32bb60c9@mail.gmail.com>
	(Jon Smirl's message of "Fri, 24 Aug 2007 19:46:50 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56615>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> On 8/24/07, Jakub Narebski <jnareb@gmail.com> wrote:
>> There was idea to special case clone (just concatenate the packs, the
>> receiving side as someone told there can detect pack boundaries; do not
>> forget to pack loose objects, first), instead of using generic fetch --all
>> for clone, bnut no code. Code speaks louder than words (although if someone
>> would provide details of pack boundary detection...)
>
> A related concept, initial clone of a repository does the equivalent
> of repack -a on the repo before transmitting it. Why aren't we saving
> those results by switching the repo onto the new pack file? Then the
> next clone that comes along won't have to do anything but send the
> file.

If the majority of the access to your repository is the initial
clone request, then it might be a worthwhile thing to do.  In
fact didn't we use to have such a "pre-prepared pack" support?

But I do not think "majority is initial clone" is the norm.
Even among the people who does an "initial clone" (from the
end-user perspective), what they do may not be the initial full
clone your special hack helps (and that was one of the reasons
we dropped the pre-prepared pack support --- "been there, done
that" to some extent).

 - If your client "clone"s only a single branch by doing:

	$ git init
	$ git remote add origin $remote_url
        $ git pull origin master

   the set of objects you need to send would be different
   (slightly smaller) than the normal clone.

 - Another example would be a client that uses --reference:

	$ git clone --reference neigh.git git://yourbox/repo.git

   which would give you a request that is different from the
   usual initial full clone request.
