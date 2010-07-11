From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about 'branch -d' safety
Date: Sun, 11 Jul 2010 11:41:54 -0700
Message-ID: <7v1vb9hnd9.fsf@alter.siamese.dyndns.org>
References: <20091230065442.6117@nanako3.lavabit.com>
 <m3lj9jknlr.fsf@localhost.localdomain> <20100711065505.GA19606@localhost>
 <201007110916.29567.jnareb@gmail.com> <20100711133730.GA10338@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Jul 11 20:42:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OY1Tu-00029D-GV
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 20:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703Ab0GKSmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 14:42:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754664Ab0GKSmL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 14:42:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E2B7C3842;
	Sun, 11 Jul 2010 14:42:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=gXp6ezSohof9GA7eKk7s2TR2YWg=; b=V4C69TAcMWJbHLergcPsy3K
	mTer9jL32ig1yEfe7cHsiPSBOqHaalpoUr82vM8xsdkB3l7g4I4HJxEDM3BJgzBH
	8Ack3M3LoYyvnEJkf7JOGD8rG6SmVkkyP9DLMa30H3fM3LzW1B8GqIEuuIUe1kjO
	zm6blR8D1RfKqs6Rulfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=pGS8zTWH7/yClwisTt21EMKFOH7OgEr3VFgKgnBDeqVICbU2h
	jxhiKllcGQVJ1dGWr15mSTJr7Z3mwBEGPX+4KWskB5AxxtDGUAly2N4oPuRDs4ie
	P+yTpBrHL4XXBygSRqd3fCazGu/HC6NJZCITBJafaZiz5lCxhICINLgGcc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD4F7C382A;
	Sun, 11 Jul 2010 14:42:03 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8945C3825; Sun, 11 Jul
 2010 14:41:56 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FFA12E10-8D1B-11DF-9FD4-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150782>

Clemens Buchacher <drizzd@aon.at> writes:

> Known issues:
>
>  - The reflog cannot be accessed while the ref does not exist.
>
>  - Older git versions will not resurrect the reflog, and therefore
>    leave the renamed reflog behind.
>
>  - Breaks t7701, because git-expire tries to lock log entries,
>    which fails because ~ is an illegal character for refs.
>
>  - Breaks t9300.

Perhaps a few obvious ones are missing?

 - It is no longer possible to get rid of objects associated with the
   history of a branch by deleting the branch and then running gc.

 - It is no longer possible to trust git that you would start a history of
   a branch afresh when you create one.  If you happened to have an
   unrelated branch with the same name in the past, the new branch
   inherits reflog entries when it shouldn't.

What problem are you guys really trying to solve?


> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 759cf12..65f160e 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -55,6 +55,7 @@ test_expect_success 'object with bad sha1' '
>  	grep "$sha.*corrupt" out &&
>  	rm -f .git/objects/$new &&
>  	git update-ref -d refs/heads/bogus &&
> +	rm -f .git/logs/refs~/heads~/bogus &&
>  	git read-tree -u --reset HEAD
>  '

What is this about???
