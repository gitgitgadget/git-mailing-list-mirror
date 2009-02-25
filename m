From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Files different for me
Date: Wed, 25 Feb 2009 10:51:16 -0800
Message-ID: <7v4oyi2vvf.fsf@gitster.siamese.dyndns.org>
References: <450196A1AAAE4B42A00A8B27A59278E709E047DE@EXCHANGE.trad.tradestation.com>
 <alpine.LFD.2.00.0902250957260.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 25 19:53:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcOsH-0002bV-Bd
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 19:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbZBYSvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 13:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754864AbZBYSvZ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 13:51:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50991 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbZBYSvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 13:51:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 298BF9DF3B;
	Wed, 25 Feb 2009 13:51:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 77F2E9DF38; Wed,
 25 Feb 2009 13:51:18 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0902250957260.3111@localhost.localdomain>
 (Linus Torvalds's message of "Wed, 25 Feb 2009 10:04:22 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4C11CF32-036D-11DE-B0CE-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111478>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> If your changes do not touch any of the files that the "git pull" updates, 
> then everything is fine. The pull will just work, and your changes will 
> still exists in your tree. This is not an accident - git was very much 
> designed to work that way, because it's a common usage case for me.
>
> I often have some trivial small changes in my tree (like a pending change 
> to the top-level Makefile for the next version number that I just haven't 
> committed yet - just a reminder to myself that I'm soon about to release 
> another -rc). And I still want to continue to do "git pull" to fetch 
> stuff, or even "git am -s" to apply patches.
>
> HOWEVER. If the pull actually wants to modify a file that you have changed 
> (ie that same file was changed in the remote), then "git pull" will fail 
> gracefully after having done the fetch, saying something like
>
> 	Entry 'file-name' not uptodate. Cannot merge.
>
> and at that point you have to decide whethe you want to commit the change, 
> "stash" it, or just undo it. Or whether you don't want to do the merge 
> yet because you're still working on your own changes, and don't want the 
> distraction.

I've been repeating the above to new people to save you time, but recently
I noticed one thing.

The handling of a case where a pull decides to go ahead (because it does
not have to touch the Makefile you have your codename updates in) but does
not complete with real conflicts, is not as graceful as the other two
cases (merge refusing to run at all without touching anything, or merge
completes cleanly and makes a commit).

You will be left with:

 - Paths that have local changes (index matches HEAD but work tree does
   not match the index --- like your Makefile);

 - Paths cleanly merged (index and HEAD are different but work tree
   already matches the index);

 - Unmerged paths (index has higher stage entries with <<</===/>>> files
   in the work tree);

You, I and experienced users know what to do.  Deal *only* with the last
kind, mark them with "git add" after you are done with each of them, and
make sure you do not say "-a" when committing the result, to exclude the
first kind from the merge result.

I've been wondering if we can make this safer for others.
