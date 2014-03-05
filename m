From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 24/27] prune: strategies for linked checkouts
Date: Wed, 05 Mar 2014 12:07:44 -0800
Message-ID: <xmqqd2i0h0j3.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-25-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 21:07:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLI6b-0000lT-8h
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 21:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756496AbaCEUHt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2014 15:07:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43691 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755717AbaCEUHs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2014 15:07:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C43B6F93C;
	Wed,  5 Mar 2014 15:07:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DeLBLYx3eKgA
	ailKnL2gPYPi8NY=; b=tA7903BDxVCmSDZa0UPONJYqC1VVdA+Z6Max3EwcHwBy
	y/sbDN/pTTwO20geuAb0xfTkxGMswhlugZho0czgebRdQNdO/ndpczDomr2lXsxd
	99dahQkSuCEDPdI5mGKq4Zcne++UXyzkfBVK5llHZtJQAKK/QXdzExcpu7R/ZaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QqWiAb
	YDeMsgfR9nZPTf1iL/jBmir0GpIDAzyVb48E1ymsMB3fpD6/fl9yjZZ0Wpp5iRWx
	n4CS89FDUHjhD/x5oEPaSl27yLWcSXmswhWBRywu8FjCGzr+SxcsPNfYQLeH6GOB
	bC/c8+TEdXSAr9KIvHDi2SYroA3BArlcl9EUg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E6E16F93B;
	Wed,  5 Mar 2014 15:07:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F0A76F93A;
	Wed,  5 Mar 2014 15:07:47 -0500 (EST)
In-Reply-To: <1393675983-3232-25-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 1 Mar
 2014 19:13:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D2210B26-A4A1-11E3-AA60-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243475>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +	if (get_device_or_die(path) !=3D get_device_or_die(get_git_dir())) =
{
> +		strbuf_reset(&sb);
> +		strbuf_addf(&sb, "%s/locked", sb_repo.buf);
> +		write_file(sb.buf, 1, "located on a different file system\n");
> +		keep_locked =3D 1;
> +	} else {
> +		strbuf_reset(&sb);
> +		strbuf_addf(&sb, "%s/link", sb_repo.buf);
> +		(void)link(sb_git.buf, sb.buf);
> +	}

Just in case you did not realize, casting the return away with
(void) will not squelch this out of the compiler:

    builtin/checkout.c: In function 'prepare_linked_checkout':
    builtin/checkout.c:947:3: error: ignoring return value of 'link', d=
eclared with attribute warn_unused_result [-Werror=3Dunused-result]

It still feels fishy to see "we attempt to link but we do not care
if it works or not" to me, with or without the "unused result"
issue.
