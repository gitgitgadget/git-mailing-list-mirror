From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 24/25] prune: strategies for linked checkouts
Date: Wed, 19 Feb 2014 12:32:26 -0800
Message-ID: <xmqq38je9739.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-25-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 21:32:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGDoq-0005ON-AK
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 21:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273AbaBSUcc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 15:32:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36866 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851AbaBSUcb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Feb 2014 15:32:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D9826DC5D;
	Wed, 19 Feb 2014 15:32:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hiAva/GrPTnl
	/Mv8DyavUP8/+aI=; b=yR+EQd4D8JX87IRtFJ/ofBHHKgplvvOA8Sqcnf23S1fT
	jIcHsU83Piyt2oD0KVAUkamwr+pt0FPrkuZHKBXlJelrnx5k4V42sbmrCqBke/6Y
	3ycA3XV9yKCN6ANaPoyTP4Xhoeq/he0xRbgS69nFM+ldINajuqSmv9LP9IaxpVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VOdVYt
	OBSK0SH7PSc+0sb7CEc2U3KtRf+cfZ77HzQDlIWUiJ44OuuS+M8kgCyQPvCvZjNY
	t6ScWrKFGBNlt0S3Kb6MaQ/k1y7rbwLRw6mXxGb+RBbhyNSzP5c7/CFqLhRL4mHi
	52octoA82AJvV//N9Et9DszpxPOfQ4EqspNUw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 316936DC5C;
	Wed, 19 Feb 2014 15:32:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A82596DC57;
	Wed, 19 Feb 2014 15:32:28 -0500 (EST)
In-Reply-To: <1392730814-19656-25-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 18
 Feb 2014 20:40:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F34EE32A-99A4-11E3-B3BF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242408>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

(Only nitpicks during this round of review).

> +	if (get_device_or_die(path) !=3D get_device_or_die(get_git_dir())) =
{
> +		strbuf_reset(&sb);
> +		strbuf_addf(&sb, "%s/locked", sb_repo.buf);
> +		write_file(sb.buf, 1, "located on a different file system\n");
> +		keep_locked =3D 1;
> +	} else {
> +		strbuf_reset(&sb);
> +		strbuf_addf(&sb, "%s/link", sb_repo.buf);
> +		link(sb_git.buf, sb.buf); /* it's ok to fail */

If so, perhaps tell that to the code by saying something like

		(void) link(...);

?

But why is it OK to fail in the first place?  If we couldn't link,
don't you want to fall back to the lock codepath?  After all, the
"are we on the same device?" check is to cope with the case where
we cannot link and that alternate codepath is supposed to be
prepared to handle the "ah, we cannot link" case correctly, no?
