From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/18] fsck: Offer a function to demote fsck errors to  warnings
Date: Wed, 21 Jan 2015 00:49:35 -0800
Message-ID: <xmqqppa8y0v4.fsf@gitster.dls.corp.google.com>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
	<cover.1421682369.git.johannes.schindelin@gmx.de>
	<a749c4a2542c32dfe256c24000e5556ebb3ce26f.1421682369.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 09:49:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDqys-0003Op-K1
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 09:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbbAUItj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 03:49:39 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63602 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750823AbbAUIth (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 03:49:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E611F26869;
	Wed, 21 Jan 2015 03:49:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IU1SkmdVc3UBlOiK+A0ZotzNM0o=; b=Yzzlvi
	XQaQGuONI/cBxsRriFBA4KNjJ+35aramAWGH0D+BVFmdU+uWkrImWO3qMnv8V9KP
	ifu7elaWWylsWrMImHbK1T0xbqlTM1hDEns8EPNwAQ3Xy+t/BcToQcCGbwX2wjmo
	kObOfCrMCZ1Xj6tKb+BLmvAhQnkVNHOHFhkow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ija8G1FV7b7pM2GAqpGn0rQ6IxUs+Aef
	l2oL6bL8QT+r80bhNBrHxbEbtb1SOr64XYLfT7GOGeVUn5ZgKD3GGpytCFYpX5QN
	T8B006ITJUetiH1qBT4i+k3678RMCthwdg6M42E4zXRzqpTaDbxZIhsAhzlHS+Ux
	D1J/3DwuIzI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DCD0126866;
	Wed, 21 Jan 2015 03:49:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7177D26863;
	Wed, 21 Jan 2015 03:49:36 -0500 (EST)
In-Reply-To: <a749c4a2542c32dfe256c24000e5556ebb3ce26f.1421682369.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 19 Jan 2015 16:50:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6D804DB6-A14A-11E4-AC5B-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262715>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +static inline int substrcmp(const char *string, int len, const char *match)
> +{
> +	int match_len = strlen(match);
> +	if (match_len != len)
> +		return -1;
> +	return memcmp(string, match, len);
> +}

Is this what we call "starts_with()" these days?

> +void fsck_set_severity(struct fsck_options *options, const char *mode)
> +{
> +	int severity = FSCK_ERROR;
> +
> +	if (!options->msg_severity) {
> +		int i;
> +		int *msg_severity = malloc(sizeof(int) * FSCK_MSG_MAX);

xmalloc()?
