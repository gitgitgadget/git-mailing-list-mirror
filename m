From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commit performance, or lack thereof
Date: Sat, 22 Aug 2009 19:20:22 -0700
Message-ID: <7vvdkf1dax.fsf@alter.siamese.dyndns.org>
References: <m3r5v39zzz.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: James Cloos <cloos@jhcloos.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 06:18:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf4XB-00031F-2P
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 06:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbZHWESE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 00:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbZHWESD
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 00:18:03 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59891 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbZHWESB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 00:18:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3722915550;
	Sat, 22 Aug 2009 22:20:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GWLOqeHUzxe39f/2AL79KUUNQDc=; b=x9Koo1
	ZNjZDTb7P3gkhrPrlApdpbCxLjCC0lsLEuHZ75DQzHVhp2MNRa9dFoe7IB+LUaVI
	4u9Fk0V08B6z3YJfbYsPGVGkPvyaFAixui1+yPzWUAunJLO0KVZau0kH4aMiSly9
	XLoT1NesxursO98KZdFaDjvRlb1PNXK+JSUOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zf97YV6TA7euacW60TRB8NcQe3OYt61x
	GnybYn1UiCJ9gA97NaSC9O925aHkFa/KF20OCDiAOcymxo5Ge+kitsQNk/QSZGnw
	JclIIik4oibAMODiJ6ZVfNuKEfeDjqkufIaeyaxN/0WLChYEW0OARTmFJGqrlHi4
	rzC07eiCTcU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 112DC1554F;
	Sat, 22 Aug 2009 22:20:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62EB41554E; Sat, 22 Aug
 2009 22:20:24 -0400 (EDT)
In-Reply-To: <m3r5v39zzz.fsf@lugabout.jhcloos.org> (James Cloos's message of
 "Sat\, 22 Aug 2009 19\:42\:32 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 88739ADC-8F8B-11DE-AC26-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126842>

James Cloos <cloos@jhcloos.com> writes:

> Starting in the kernel tree, if one edits and adds a single file and
> then commits it w/o specifying the file name as an argument to commit,
> ...
> OTOH, if one does specify the filename as an argument to commit,...

When you do:

    git add something && git commit

the commit step is just "write the index out as a tree, create a commit
object to wrap that tree object".  It never has to look at your work tree
and is a very cheap operation.

On the other hand, if you do:

    some other random things && git commit pathspec

the commit step involves a lot more operations.  It has to do:

    - create a temporary index from HEAD (i.e. ignore the modification to
      the real index you did so far with your earlier "git add");

    - rehash all the paths in the work tree that matches the pathspec and
      add them to that temporary index; and finally

    - write the temporary index out as a tree, create a commit object to
      wrap that tree object.

The second step has to go to your work tree, and if you have a slow disk,
or your buffer cache is cold, you naturally have to pay.

So it is not surprising at all if you observe that the latter takes more
time and resource than the former, although there could be something wrong
in your set-up that you need to spend 300M for it.  It is fundamentally a
more expensive operation.


    
