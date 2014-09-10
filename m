From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] fsck: check tag objects' headers
Date: Wed, 10 Sep 2014 10:52:38 -0700
Message-ID: <xmqqfvfzgy6x.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
	<cover.1410356761.git.johannes.schindelin@gmx.de>
	<alpine.DEB.1.00.1409101553020.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 10 19:52:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRm4Z-0007TM-Mq
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 19:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbaIJRwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 13:52:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54475 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304AbaIJRwp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 13:52:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 38C9E3729E;
	Wed, 10 Sep 2014 13:52:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NmX909/fMOS7Ip1aumtEqrypbrE=; b=FKQeQS
	5gGxDfIqhtHLhnklYut3B/g+5L2qvZsaQ3E956lfQmFhmIV5s1HgjP7K9FsvFG/2
	GOqS6r6XQRDcSF/WqE28nvpAWARE02CVENygUKc4SScmkpZYttW2Y+gL4wUW+MTS
	24t1wzO+zYaybWmZSDmOHp8jLl+uQN/3RUDdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d/6KatjYjmIEStuqws/wSIHvwksGJDTx
	LkbJr7a7wULzY0I2nXMnRprrD6B65jTfctKMhgMHaHutlDzzTferhKa/4E69TaHQ
	IGLDdKjw66K4/oTqQwIn2hAaKoVyu0BHrizZQmuir/rFuOtUkTBi13Jzsjb1l+Ke
	mikKecdpJrc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2EC003729D;
	Wed, 10 Sep 2014 13:52:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A54CA3729C;
	Wed, 10 Sep 2014 13:52:39 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1409101553020.990@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Wed, 10 Sep 2014 15:53:04 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 41AB6FF8-3913-11E4-990E-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256758>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +	if (!skip_prefix(buffer, "tag ", &buffer)) {
> +		ret = error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'tag' line");
> +		goto done;
> +	}
> +	eol = strchr(buffer, '\n');
> +	if (!eol) {
> +		ret = error_func(&tag->object, FSCK_ERROR, "invalid format - unexpected end after 'type' line");
> +		goto done;
> +	}
> +	strbuf_addf(&sb, "refs/tags/%.*s", (int)(eol - buffer), buffer);
> +	if (check_refname_format(sb.buf, 0))
> +		error_func(&tag->object, FSCK_WARN, "invalid 'tag' name: %s", buffer);
> +	buffer = eol + 1;
> +
> +	if (!skip_prefix(buffer, "tagger ", &buffer)) {
> +		/* early tags do not contain 'tagger' lines; warn only */
> +		error_func(&tag->object, FSCK_WARN, "invalid format - expected 'tagger' line");
> +	}
> +	ret = fsck_ident(&buffer, &tag->object, error_func);

Shouldn't this relate to the above conditional, to skip ident check
on early tags that lack tagger lines?

> +
> +done:
> +	free(to_free);

strbuf_release(&sb) here?

> +	return ret;
> +}
> +
