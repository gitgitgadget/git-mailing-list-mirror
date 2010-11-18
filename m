From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] git checkout -b removes MERGE_HEAD
Date: Thu, 18 Nov 2010 10:39:31 -0800
Message-ID: <7vwroabhng.fsf@alter.siamese.dyndns.org>
References: <456aec650e66bba518b8a5ec88c88a6b.squirrel@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Nov 18 19:39:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ9Oe-0001SZ-Nc
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 19:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760120Ab0KRSjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 13:39:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41213 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760103Ab0KRSjk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 13:39:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8468022B8;
	Thu, 18 Nov 2010 13:39:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3cc9O9Ixpm1241DFTVRhObe/vTo=; b=qSTpgL
	jluVCwWNX+lmGqTHGUwnbDC0nOjo3GVZm6KkKpTZOBGQBHapIpb+Cg0V5SXWyfCS
	VopuInftURxadZmWGNmPiL8pAcBxMWBYC6aViYrOCUguMCcuTlKj5T37dF3o0nAR
	y2j92n6GIRW/CU+9yIv0rLBNRApRejb/AHzt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e9ESKfso+3gBXDT0nbhQMhmQlWOXjD8A
	1bQHJVbLnwS7ooEtmvb1m3H8PaDx2BF5wDFhKlJm1/aEmHf6qUEE61hruJtnWqHu
	IAXb66bl17rMtxKKEke1V66WCxLX4OJgeJhYRrCl+D2Tv2VriIBfYaIcYkh08JBp
	8Feg1iYcfrU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F52022B7;
	Thu, 18 Nov 2010 13:39:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5AF0A22A7; Thu, 18 Nov 2010
 13:39:44 -0500 (EST)
In-Reply-To: <456aec650e66bba518b8a5ec88c88a6b.squirrel@artax.karlin.mff.cuni.cz> (Jan
 Hudec's message of "Thu\, 18 Nov 2010 08\:15\:23 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 381176F0-F343-11DF-AE2E-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161702>

"Jan Hudec" <bulb@ucw.cz> writes:

>  - During the testing I found a problem, but it may have already
>    existed on master before the merge.
>  - Therefore I needed to return to clean master, test it and return
>    to the merge. So I thought I'd commit the merge to a temporary
>    branch, test master again and merge the temporary to master if
>    the problem is not from the merge. So I did:
>
>    $ git checkout -b temp
>    $ git commit
>
>    OOPS! It forgot it was a merge.

I think it was an oversight by the author of 91dcdfd (Make "git checkout"
create new branches on demand, 2005-07-11) who forgot that he also did
ef0bfa2 (Remove MERGE_HEAD in "git checkout/reset", 2005-06-21).  The
rationale for the removal of MERGE_HEAD from the earlier commit is:

    [this command] will end up resetting the index to some specific
    head, and any unresolved merge will be forgotten [hence there is no
    point recording the result as a merge].

but when used with -b no such "resetting of the index" happens.

Having said that, changing it not to remove MERGE_HEAD and MERGE_MSG is
probably not sufficient, as MERGE_MSG would likely to already record to
which branch you are recording the merge (I didn't check, though).
