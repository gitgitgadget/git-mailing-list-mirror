From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Isolate If-Modified-Since handling in gitweb
Date: Wed, 21 Mar 2012 12:22:44 -0700
Message-ID: <7vmx7921yz.fsf@alter.siamese.dyndns.org>
References: <20120321140429.GA28721@odin.tremily.us>
 <201203211755.07121.jnareb@gmail.com>
 <20120321173824.GA31490@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Wed Mar 21 20:22:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAR7V-00070j-3n
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 20:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656Ab2CUTWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 15:22:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61397 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755034Ab2CUTWr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 15:22:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73C495F0E;
	Wed, 21 Mar 2012 15:22:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Neakp+KrcUpxaEbzvaTKdVbwWI4=; b=ZzzEkf
	R2bwbutZVWkcqFO/hf0GyTIbevNojZRw14urSh79g9+bpxszXo+3PQAzsXJ/UQR4
	DrM1m2EP4Vt1itrmx8KXkUfqxtf+nm4hrfv3tllZwzP0tXBXyOlAKQ8lmhIfY+Mh
	hcri06kp2VDZ694gErcF02Pw53TxanUnNvwB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JEBOBbsDRspzzud8mXiveLrxm3XkNelF
	ovBoc+gYk9nhdzG4tLb6+2ZZGsCiHT/IaRs4s88kUIvBjAl9TV3Z8rranYaEqwca
	mZEqrs/1VWGqIbqYsVbShyoeK01gIt6XR8eG3+ETG3x3ECgSsJAHJdD/5rdkpo70
	aWmtsyTID9o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B76B5F0D;
	Wed, 21 Mar 2012 15:22:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F261D5F0C; Wed, 21 Mar 2012
 15:22:45 -0400 (EDT)
In-Reply-To: <20120321173824.GA31490@odin.tremily.us> (W. Trevor King's
 message of "Wed, 21 Mar 2012 13:38:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3D11A4E4-738B-11E1-BC92-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193600>

"W. Trevor King" <wking@drexel.edu> writes:

>> I think it would be better to add initial tests with refactoring, and
>> snapshot specific tests with snapshot support, e.g.:
>> 
>>   1/2: gitweb: Refactor If-Modified-Since handling and add tests
>>   2/2: gitweb: Add If-Modified-Since support for snapshots
>
> But the new tests would be for the new functionality (i.e. snapshot
> support), so they wouldn't belong in the general refactoring commit.

Then you are planning to split it in a wrong way.

As I said, I do not think it matters that much for a small patch like
this, but if the plan is to make the part to create i-m-s helper function
as a standalone "refactoring" patch, then what Jakub outlined is the right
way to go about it.

In the first patch, you create i-m-s helper and update the existing code
that can use the helper, without changing anything else. Do not touch
snapshot code in this patch, if the current code does not support i-m-s in
snapshot.  And in the same patch, add tests for codepaths that use i-m-s
to make sure your refactoring did not break them.  In other words, if you
remove the change to gitweb/ from the first patch and apply only the
changes to the tests, the resulting new tests should pass with the current
code that has i-m-s support inline without the i-m-s helper.  And if you
add back your change to gitweb/ for the refactoring, the test should still
pass.

And then in the second patch, you update the snapshot code and whatever
else that can use i-m-s helper to support i-m-s.  You can add tests to
protect the new feature from future breakages in this patch.
