From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/48] t6036: criss-cross w/
 rename/rename(1to2)/modify+rename/rename(2to1)/modify
Date: Mon, 18 Jul 2011 16:38:32 -0700
Message-ID: <7v39i3durr.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-12-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 01:38:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QixOZ-0002wS-LD
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 01:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546Ab1GRXif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 19:38:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37450 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979Ab1GRXie (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 19:38:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5534C41C4;
	Mon, 18 Jul 2011 19:38:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=RZVtA2XBijvyz2ePx8Dqegw+Lg8=; b=AbtV1Giq3JujQ9Ck6XzH
	F2UzpeWUKBnIMs6U/L4CsTh2TLG6tCXqk5dYWUYAZte5SAn8Lge82mgrBrT6MYLD
	MwHXBpuucThQknWytbC/vNGrQKr0sjK9tegtLv8O5GmWNAz8TVhHgcB++JuxWzGx
	xbC7Hfh8SJJaELfU4kjx8ho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=qBzcuoQ9BFuLiF/IAQhc/9i3boPNEc7WMLW2YX1QlPV2MT
	V1sn3DguqLLE1U1wLsSHNDVt8lknEDgbv8OE7Sdt8UPPXvxdAt/eLxbs4g+zQ4vb
	1cSgtIGBO8DHqPpafrit4awnHQRMB53TWyG6lL/iSM0Jhjl6t5k7U9QTp5pcE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C6E141C3;
	Mon, 18 Jul 2011 19:38:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3ECC41C2; Mon, 18 Jul 2011
 19:38:33 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D1517BE-B197-11E0-BAD3-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177418>

Elijah Newren <newren@gmail.com> writes:

> +# criss-cross with rename/rename(1to2)/modify followed by
> +# rename/rename(2to1)/modify:
> +#
> +#      B   D
> +#      o---o
> +#     / \ / \
> +#  A o   X   ? F
> +#     \ / \ /
> +#      o---o
> +#      C   E
> +#
> +#   Commit A: new file: a
> +#   Commit B: rename a->b, modifying by adding a line
> +#   Commit C: rename a->c
> +#   Commit D: merge B&C, resolving conflict by keeping contents in newname
> +#   Commit E: merge B&C, resolving conflict similar to D but adding another line
> +#
> +# There is a conflict merging B & C, but one of filename not of file
> +# content.  Whoever created D and E chose specific resolutions for that
> +# conflict resolution.  Now, since: (1) there is no content conflict
> +# merging B & C, (2) D does not modify that merged content further, and (3)
> +# both D & E resolve the name conflict in the same way, the modification to
> +# newname in E should not cause any conflicts when it is merged with D.
> +# (Note that this can be accomplished by having the virtual merge base have
> +# the merged contents of b and c stored in a file named a, which seems like
> +# the most logical choice anyway.)

Interesting. I do not necessarily agree with the choice "a", but it feels
sound to say "B and C do not agree what the final pathname should be, but
we know this content was derived from the common A:a so we use one path
whose name is arbitrary in the virtual merge base X between D and E" and
then further let the rename detection to notice that that arbitrary path
gets renamed between X-D to "newname" and X-E also to "newname" to resolve
it as both sides renaming it to the same new name. It is akin to what we
do at the content level, i.e. "B and C do not agree what the final
contents should be, so we leave the conflict marker but that may cancel
out at the final merge stage".

> +test_expect_failure 'handle rename/rename(1to2)/modify followed by what looks like rename/rename(2to1)/modify' '
> +	git checkout D^0 &&
> +
> +	git merge -s recursive E^0 &&
> +
> +	test 1 -eq $(git ls-files -s | wc -l) &&
> +	test 0 -eq $(git ls-files -u | wc -l) &&
> +	test 0 -eq $(git ls-files -o | wc -l) &&
> +
> +	test 8 -eq $(wc -l < newname)

Be a bit more explicit with what you are actually testing. Are you
expecting that the index has a single stage #0 entry for "newname" whose
contents are the same as E?

> +'
>  
>  test_done
