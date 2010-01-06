From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2010, #01; Mon, 04)
Date: Wed, 06 Jan 2010 09:07:52 -0800
Message-ID: <7vocl7yxef.fsf@alter.siamese.dyndns.org>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org>
 <7vskal5c11.fsf@alter.siamese.dyndns.org>
 <20100106191825.6117@nanako3.lavabit.com>
 <alpine.DEB.1.00.1001061219180.11013@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 06 18:08:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSZMo-00017Y-Gt
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 18:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382Ab0AFRIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 12:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389Ab0AFRII
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 12:08:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47685 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932367Ab0AFRIB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 12:08:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE1578E954;
	Wed,  6 Jan 2010 12:08:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=6Q718Z5l/QsDCO5F/ev6qjqqPkQ=; b=AGgMCy3TgQpMCZ0+9CLD1j4
	EV6gC3wBSvC9Bm5vBrqxdhW08I3QQ2Y1VKLUh02f72oJ+l1Z+iwWHm7KDv/5FNvL
	ltncgrY1e7TyID9xGpbLuKoQJL7eHoM5olqBKhy35DaOWiiwWAz3dLq0axg4/crh
	EdkvsEP/PU6ZkvorJ/dw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=XAu/rJz2iNf6J51IueTHZba/mSJhMgBI7e+wGyoM8nQKinK/e
	NT09uYug31osV/vB/z6ODvmyzd8vUm9DjE8IFkvj/tdLUB9LZOIldZKssn3k1ALw
	FZk2L2OEC4bm6nFvBuJOHRKKBpvBxbOQTGANDFQr+g4h5Y3+zFuEdK6Ei4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 757008E94A;
	Wed,  6 Jan 2010 12:07:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 895AB8E946; Wed,  6 Jan
 2010 12:07:53 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0960582C-FAE6-11DE-B5CF-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136274>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It might be easier to understand like this:
>
> 	case "$1" in
> 	*...*)
> 		left=${1%...*} &&
> 		right=${1#*...} &&
> 		onto="$(git merge-base "${left:-HEAD}" "${right:-HEAD}")" &&
> 		test ! -z "$onto" &&
> 		echo "$onto"
> 	;;
> 	*)
> 		git rev-parse --verify "$1^0"
> 	;;
> 	esac

Double-semicolons should be indented one level deeper.

I think your version may be slightly better (avoids one "expr"), but it
actually was much harder to read your cascade of && that implicitly exits
with non-zero status in the first case arm than the explicit exit status
given by the original patch.

As far as I can tell, both versions inherit the same bug from me when the
user gave us A...B pair that has more than one merge bases.  I think you
need to give --all to merge-base and resurrect the "did we get more than
one" test from her patch.

> Besides, why do you change the "$1" to "$1^0"?

Isn't it a bugfix?

Earlier code wouldn't have caught "--onto $blob_id" as an error, but this
will do so---I actually think it is a good change.

>> diff --git a/git-rebase.sh b/git-rebase.sh
>> index 6503113..43c62c0 100755
>> --- a/git-rebase.sh
>> +++ b/git-rebase.sh
>
> I would separate the patches.  rebase.sh and rebase--interactive.sh are 
> fundamentally different.

I too think splitting into two patches would make sense in this case.  The
patch to git-rebase.sh seems to be a bugfix in the left/right computation;
I am kind of surprised that I haven't triggered it myself so far.

Thanks.
