From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/48] t6036: Add differently resolved modify/delete
 conflict in criss-cross test
Date: Mon, 18 Jul 2011 16:38:12 -0700
Message-ID: <7vhb6jdusb.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-9-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 01:38:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QixOG-0002ph-Jl
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 01:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376Ab1GRXiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 19:38:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37301 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297Ab1GRXiO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 19:38:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2501341BC;
	Mon, 18 Jul 2011 19:38:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=mwzeNokn+y002NgDI5eH3WN7wD8=; b=UjCid2JA4q84ci4yj2pr
	+QHUeiUKIGBmof6ulJ/0UDhPome/1ZD5aqZHxx3j4AqxLDDu5mnIK3kKPCtBP0mL
	nrPuN31XiF+/oyE0b/KquuCgbl3YvENHLglffhfYXei0W7DdkWMm1GWL5w45io7b
	B7Lg2HG3ZgoQC3fMPW1QgrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=rsm9kKQOaFz4n2nMtLix9vKPCO4feJVjP6UA10rVHiByX5
	3IUY08SdrqTXwnGZukB+VAJf2ctIr0fGEkKWBifUR5ib9/1NxW0vCA4in/bRPJFj
	QolsyB0CRH3SyQuAqGNpTUQIwmlJ/5pcwr3wfSPVu0HkHp0rGfFrbX/qwAtnk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B52941BB;
	Mon, 18 Jul 2011 19:38:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A538541BA; Mon, 18 Jul 2011
 19:38:13 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 010C1436-B197-11E0-8F95-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177416>

Elijah Newren <newren@gmail.com> writes:

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t6036-recursive-corner-cases.sh |   83 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 83 insertions(+), 0 deletions(-)
>
> diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
> index 319b6fa..52d2ecf 100755
> --- a/t/t6036-recursive-corner-cases.sh
> +++ b/t/t6036-recursive-corner-cases.sh
> @@ -231,4 +231,87 @@ test_expect_success 'git detects differently handled merges conflict' '
>  	test $(git rev-parse :1:new_a) = $(git hash-object merged)
>  '
>  
> +#
> +# criss-cross + modify/delete:
> +#
> +#      B   D
> +#      o---o
> +#     / \ / \
> +#  A o   X   ? F
> +#     \ / \ /
> +#      o---o
> +#      C   E
> +#
> +#   Commit A: file with contents 'A\n'
> +#   Commit B: file with contents 'B\n'
> +#   Commit C: file not present
> +#   Commit D: file with contents 'B\n'
> +#   Commit E: file not present
> +#
> +# Now, when we merge commits D & E, does git detect the conflict?

Starting from A, upper branch wants to have B instead of A while the lower
branch wants the path gone, so it should result in a modify/delete conflict.

  s/# Now,.*$/Merging commits D & E should result in modify/delete conflict./
