From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/8] gitweb: Extract print_sidebyside_diff_lines()
Date: Wed, 04 Apr 2012 14:47:29 -0700
Message-ID: <7vsjgj6ufi.fsf@alter.siamese.dyndns.org>
References: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com>
 <1333569433-3245-5-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 23:47:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFY3M-0000pf-FU
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 23:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757205Ab2DDVrf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 17:47:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45079 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757100Ab2DDVrd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2012 17:47:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D34DF3E1E;
	Wed,  4 Apr 2012 17:47:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KKBPACKf6drL
	M3eKuISunrtme4U=; b=AV+suWHPa7+Pkw3k24v1nSl48QymJC7uTyXycDjgZbnS
	eGYq7h9ymUEQYdV2nKr80fDOzw01TbH195z9U50YeaOi98B0WJToIuo7jmsB5zL2
	kfuiX0SmsnNobCPs54h/UtRvVtIBQnXuQY5XHE1Qx5Fxgxov+B4G4bInZVOIJGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OoqfO4
	y4B1AIlcXZkfE6TWxvj5Vy604enHmAYb4v6EO6gKtU+6FoCNRnIQv0ATVPY5a7dq
	nrQnjNLTM/PI9ahRHWMTwypXuXGRBFaOqa3BarK1CQ2zMUdSNtF8v13BRqrmy5Az
	G7HxdTEWrxks1Mvs9bV4FlQcietVZn0LPo3xQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA1743E1D;
	Wed,  4 Apr 2012 17:47:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 329103E1C; Wed,  4 Apr 2012
 17:47:32 -0400 (EDT)
In-Reply-To: <1333569433-3245-5-git-send-email-michal.kiedrowicz@gmail.com>
 (=?utf-8?Q?=22Micha=C5=82?= Kiedrowicz"'s message of "Wed, 4 Apr 2012
 21:57:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C83D40FE-7E9F-11E1-871D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194749>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> +	if (!@$add) {
> +		# pure removal
> +...
> +	} elsif (!@$rem) {
> +		# pure addition
> +...
> +	} else {
> +		# assume that it is change
> +		print join '',

I know this is not a new problem, but if your patch hunk has both '-' a=
nd
'+' lines, what's there to "assume" that it is a change?  Isn't it alwa=
ys?


> -		# empty add/rem block on start context block, or end of chunk
> -		if ((@rem || @add) && (!$class || $class eq 'ctx')) {
> -...
> +		## print from accumulator when have some add/rem lines or end
> +		# of chunk (flush context lines)
> +		if (((@rem || @add) && $class eq 'ctx') || !$class) {

This seems to change the condition.  Earlier, it held true if (there is
anything to show), and (class is unset or equal to ctx).  The new code
says something different.  Also can $class be undef, and if so, doesn't
it trigger comparison between undef and 'ctx' by having !$class check a=
t
the end of || chain?
