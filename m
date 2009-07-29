From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Demonstrate bugs when a directory is replaced with a
 symlink.
Date: Wed, 29 Jul 2009 01:33:29 -0700
Message-ID: <7v4osvyjl2.fsf@alter.siamese.dyndns.org>
References: <1248819198-13921-1-git-send-email-james.e.pickens@intel.com>
 <1248819198-13921-2-git-send-email-james.e.pickens@intel.com>
 <4A70062A.4040008@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Pickens <james.e.pickens@intel.com>, git@vger.kernel.org,
	gitster@pobox.com, Kjetil Barvik <barvik@broadpark.no>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 10:34:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW4bc-0002rm-6E
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 10:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbZG2Idi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 04:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbZG2Idi
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 04:33:38 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40683 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbZG2Idh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 04:33:37 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8533218C9E;
	Wed, 29 Jul 2009 04:33:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0CD7A18C9D; Wed,
 29 Jul 2009 04:33:30 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 82ECCBC6-7C1A-11DE-B230-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124323>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> +test_expect_failure 'checkout should not delete a/b-2/c/d' '
>> +	git checkout -b temp HEAD^ &&
>> +	test -f a/b-2/c/d
>> +'
>> +
>> +test_expect_failure 'merge should not delete a/b-2/c/d' '
>> +	echo x > a/x &&
>> +	git add a/x &&
>> +	git commit -m x &&
>> +	git merge master &&
>> +	test -f a/b-2/c/d
>> +'
>> +
>> +test_done
>
> Isn't the failure of the second test caused by that of the first one?
> a/b-2/c/d is gone from the worktree, and master does not touch it, so
> the merge leaves the worktree version (non-existent) as is.

To avoid that impression the second test should probably have been written
to start from a clean slate, using "reset --hard" or something.

Kjetil's patch actually fixes the first one, but the second one will still
show breakage.

I wonder if the breakage is in recursive merge or in the generic read-tree
three-way merge code.  I highly suspect that using "git merge -s resolve"
would make the test pass.  Historically recursive merge is known to be
careless in many corner cases.
