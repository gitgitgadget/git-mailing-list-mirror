From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] attr: more matching optimizations from .gitignore
Date: Wed, 10 Oct 2012 14:50:52 -0700
Message-ID: <7vwqyy9etf.fsf@alter.siamese.dyndns.org>
References: <7vd30si665.fsf@alter.siamese.dyndns.org>
 <1349864466-28289-1-git-send-email-pclouds@gmail.com>
 <7v626iatt9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 23:51:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM4BG-0003PV-QP
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 23:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756663Ab2JJVu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 17:50:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51172 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755199Ab2JJVuz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2012 17:50:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E7F78DD8;
	Wed, 10 Oct 2012 17:50:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CHB1nvcKqHlq
	DulQE+LQ2ql2rr4=; b=s5Zc7dgy3xBj7rhBwHPQwki8IjxXc+N7V7q1dLjTgQxN
	TOkngVhvpsKmjqEM5+glZ6YUt3cZ56gs8FiIJp0mAxDJCJkXkwStZbO08PzVgKX5
	AZdPcZallAAAHSvLNHrW5ztyqTn28NkgHsvv2I20qHl0Bmm4HgzLqAcbiaPnJyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VVrZxI
	cwTQs0oBwqBcMIXX4ckS4mjwpzI/TAK21SgU6GJ7VNZ/abppps8/V+pgiunaq0WJ
	O0HizSum+NaHU1wQ+oiawV/SVOI8y/kJFF10l8c4lOL9owe/DR+RdDCQiJrwiwEk
	wWv1E8+Wnf0uHFFFtqzdoaGz0UKTNVo1/D29E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A3D28DD7;
	Wed, 10 Oct 2012 17:50:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 988AC8DD3; Wed, 10 Oct 2012
 17:50:54 -0400 (EDT)
In-Reply-To: <7v626iatt9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 10 Oct 2012 14:41:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90F5F48C-1324-11E2-8959-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207447>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>>    @@ -690,16 +689,18 @@ static int path_matches(const char *pathnam=
e, int pathlen,
>>     	 * contain the trailing slash
>>     	 */
>>    =20
>>    -	if (pathlen < baselen ||
>>    +	if (pathlen < baselen + 1 ||
>>     	    (baselen && pathname[baselen] !=3D '/') ||
>>    -	    strncmp(pathname, base, baselen))
>>    +	    strncmp_icase(pathname, base, baselen))
>
> Shouldn't the last comparison be
>
> 	strncmp_icase(pathname, base, baselen + 1)
>
> instead, if you are trying to match this part from dir.c where
> baselen does count the trailing slash?
>
> 		if (pathlen < x->baselen ||
> 		    (x->baselen && pathname[x->baselen-1] !=3D '/') ||
> 		    strncmp_icase(pathname, x->base, x->baselen))
> 			continue;
>
> In other words, relative to what was queued to 'pu', something like
> this instead....

Aaaaand,... it doesn't work and breaks t0003.sh.  Sigh...
