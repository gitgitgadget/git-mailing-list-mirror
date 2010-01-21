From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv11 20/20] builtin-gc: Teach the new --notes option to 
 garbage-collect notes
Date: Thu, 21 Jan 2010 12:01:14 -0800
Message-ID: <7vtyufp6r9.fsf@alter.siamese.dyndns.org>
References: <1263762277-31419-1-git-send-email-johan@herland.net>
 <1263762277-31419-21-git-send-email-johan@herland.net>
 <780e0a6b1001211127u6304546ej4e5bffbceca12e0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jan 21 21:01:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY3Df-0006pT-OC
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 21:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949Ab0AUUB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 15:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753256Ab0AUUB0
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 15:01:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37858 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103Ab0AUUBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 15:01:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 79D84926C2;
	Thu, 21 Jan 2010 15:01:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y874TEDjta0ghxxiz6yP/i3QsqI=; b=gDmd5C
	Hcd+UKaT/+Or4Tx4kqLn/jPerFQu1pvc9dFqtGhUT0oA/LEp1wiqy1rlXHtF5Xu9
	91qdK9ibggoeq+hw3vmdyaEcnGO6Xd5zZFAmTYlLSDzsPlBbQWMi7fwbJ2A6Hd1Q
	TgpVR7zqdI2SoTTcJTcw4mZJ0pzj/hC6RY5Us=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aEPAw/thn6g+sQ2F2j1qS06kj5YjnntJ
	gQLVASWj6vLqpRtQWaWM32oxnSdTvLpNCKh/+5K3eON4OAd/Tp6cKmsN8u8ay8wt
	EKlpA+74zCSDiD+ri7ZVn81UvYEzMAJCd77N/6drYLf63om4jVgtCl/H3cMpYXUS
	/d6k21EP6KM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A687926BF;
	Thu, 21 Jan 2010 15:01:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75858926B8; Thu, 21 Jan
 2010 15:01:16 -0500 (EST)
In-Reply-To: <780e0a6b1001211127u6304546ej4e5bffbceca12e0b@mail.gmail.com>
 (Stephen Boyd's message of "Thu\, 21 Jan 2010 11\:27\:27 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BE24DF52-06C7-11DF-8633-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137687>

Stephen Boyd <bebarino@gmail.com> writes:

> On Sun, Jan 17, 2010 at 1:04 PM, Johan Herland <johan@herland.net> wrote:
>> The new --notes option triggers a call to gc_notes(), which removes note
>> objects that reference non-existing objects.
>>
>
> Shouldn't notes be unconditionally garbage collected? Or maybe there's
> a reason why notes should be treated differently that isn't written
> here.

A few thoughts, inspired by this patch, but on other things around
"notes":

 - This is more about pruning notes regarding objects that are no longer
   availabe from _the tip_ of the notes tree.  It doesn't run (and I am
   not suggesting to make it it to run) filter-branch to eradicate all
   such stale notes from the notes commit ancestry, so in that sense this
   is not really a garbage collection.

 - We would want to have "notes prune" subcommand that lets us do the
   pruning without all the other "gc" operation.  "git gc" would of course
   call the same underlying code "notes prune" would use if we want to
   be able to trigger "notes prune" from it.

 - Because there is no public interface to list objects that are annotated
   with the most recent notes tree, the only thing this pruning affects is
   the look-up overhead of "log --show-notes".  As such, it might be
   better to later add tree rebalancing in "notes prune" and at that
   point, it will become even less about garbage collection and more about
   performance ("notes optimize?").

 - Do we want to have a public interface to list objects that are
   annotated with notes?  "git notes" probably deserves a bit more
   subcommands other than "(edit|show)" to help users, e.g. "list" and
   "remove".

 - If this were "notes optimize" (this is just me thinking aloud), perhaps
   we would want to do this at some key places (e.g. when you
   automatically rebalance the tree).
