From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rerere: fix overeager gc
Date: Mon, 12 Jul 2010 17:40:11 -0700
Message-ID: <7v630k6wpg.fsf@alter.siamese.dyndns.org>
References: <7vlj9lo6w6.fsf@alter.siamese.dyndns.org>
 <1278978124-3035-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jul 13 02:40:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYTXy-0001eG-OH
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 02:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608Ab0GMAk0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 20:40:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34810 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622Ab0GMAkZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jul 2010 20:40:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 16C33C4B93;
	Mon, 12 Jul 2010 20:40:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7iu3kPrb5btc
	vJW17an7yC1+EEs=; b=cOoXKZUMiZLQozIPi4V86O42QDvZufMDCaextkB2OrlF
	BCBZr+9ltJMZ8FVXkus+a1hZxLd78MhuP1KeoDq9gIIqDwBE+wbOpIsVIT4klm+e
	pT7rJjF40h92Mcso2OCMWKPsEB9GUOYdWXi+BsxD4gm1caZ+RLM4daEm8ZHs7XU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tWtjsv
	hZIwGvDO5wiLmSnLMazMvB6yxJqsBdY2xmOfvOyUpAKSB+tiyZm/kXnRD50ir54f
	WJhKiYn1bR3V100NkuTwIB8gZJCVfjjDrjafnJ7z+LUekv+X/f+nk3UVhfSpBQaV
	5uDPJHKW2DNEabnvYux9OSmQGFqq6I8t+PTJ0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D5199C4B92;
	Mon, 12 Jul 2010 20:40:17 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BE25C4B91; Mon, 12 Jul
 2010 20:40:13 -0400 (EDT)
In-Reply-To: <1278978124-3035-2-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Tue\, 13 Jul 2010 01\:42\:04 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3590771E-8E17-11DF-9F3C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150859>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> 'rerere gc' prunes resolutions of conflicted merges that occurred lon=
g
> time ago, and when doing so it takes the creation time of the
> conflicted automerge results into account.  This can cause the loss o=
f
> frequently used conflict resolutions (e.g. long-living topic branches
> are merged into a regularly rebuilt integration branch (think of git'=
s
> pu)) when they become old enough to exceed 'rerere gc's threshold.
>
> To prevent the loss of valuable merge resolutions 'rerere' will (1)
> update the timestamp of the recorded conflict resolution (i.e.
> 'postimage') each time when encountering and resolving the same merge
> conflict, and (2) take this timestamp, i.e. the time of the last usag=
e
> into account when gc'ing.

Thanks.

> +static time_t rerere_last_used_at(const char *name)
> +{
> +	struct stat st;
> +	return stat(rerere_path(name, "postimage"), &st) ? (time_t) 0 : st.=
st_mtime;
> +}

Doesn't has_rerere_resolution() already do a stat on this path?  There =
are
only two allers of the function so it would probably make sense to pass=
 a
pointer to struct stat from the caller to avoid one extra call to stat.
