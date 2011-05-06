From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] tests: teach verify_parents to check for extra
 parents
Date: Fri, 06 May 2011 14:34:11 -0700
Message-ID: <7vzkmzy0mk.fsf@alter.siamese.dyndns.org>
References: <20110503090351.GA27862@elie> <4DC1CE16.5030808@dailyvoid.com>
 <7vsjsuc704.fsf@alter.siamese.dyndns.org> <20110506205441.GA20182@elie>
 <20110506210021.GC20182@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Grubb <devel@dailyvoid.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 23:34:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QISfL-0001Qr-Co
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 23:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932864Ab1EFVeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 17:34:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34546 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932843Ab1EFVeW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 17:34:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8458E5D2D;
	Fri,  6 May 2011 17:36:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EYl/mYcLfyG0AJhIaPOhCs3yHHU=; b=xmpGlz
	/Gvw0qXS49iUi8FC1sYAdCwbb/Lh00WaMFdtbL+zDbhKu0GGAlS9WMR3VxuczmKz
	RUAmbFXNOv1D7s1EBHDlBfuidZgTNmxkM/74YwC1KCjIzUrQq/Uc/jT242aVpPp3
	4t2F7LWJbtiRL2TCCDUYbJc0qM4gySddiebLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LmcUh84eDdErnvjEcMfU7d6XDeo5S7wI
	2enx/Cs8Xe6IuP8Qok0fByJ1qoNVYozmSLfztmAYaD2lVRcPFFxB8VcAL2RWeo+U
	YQcAFd6AJptWL5y6capkYNy192IYM/GmazLCnvu/aKry35lzGa9KMvCPEmGJ/pAG
	cMZq71xXJUk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 51D7C5D29;
	Fri,  6 May 2011 17:36:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 320C85D27; Fri,  6 May 2011
 17:36:16 -0400 (EDT)
In-Reply-To: <20110506210021.GC20182@elie> (Jonathan Nieder's message of
 "Fri, 6 May 2011 16:00:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E255C250-7828-11E0-B725-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173012>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Currently verify_parents only makes sure that the earlier parents of
> HEAD match the commits given, and does not care if there are more
> parents.  This makes it harder than one would like to check that, for
> example, parent reduction works correctly when making an octopus.
>
> Fix it by checking that HEAD^(n+1) is not a valid commit name.
> Noticed while working on a new test that was supposed to create a
> fast-forward one commit ahead but actually created a merge.
>
> Reported-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  t/t7600-merge.sh |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index c665acd..9af748a 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -89,6 +89,7 @@ verify_parents () {
>  		i=$(expr $i + 1) ||
>  		return 1
>  	done &&
> +	test_must_fail git rev-parse --verify HEAD^$(($# + 1)) &&

Isn't $i at this point the same as that complex $(()) line noise?

>  	test_cmp parents.expected parents.actual
>  }
