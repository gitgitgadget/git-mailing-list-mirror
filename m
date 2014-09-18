From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rev-parse: honor --quiet when asking for reflog dates that do not exist
Date: Thu, 18 Sep 2014 09:12:44 -0700
Message-ID: <xmqqmw9wq54z.fsf@gitster.dls.corp.google.com>
References: <1410928530-21595-1-git-send-email-davvid@gmail.com>
	<1410928530-21595-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Fabian Ruch <bafain@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 18:12:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUeKC-00025v-DX
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 18:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756770AbaIRQMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 12:12:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63945 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756469AbaIRQMr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 12:12:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8ED113AF76;
	Thu, 18 Sep 2014 12:12:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kePjFT6W2/mTWig6UNAKKcl+z0A=; b=jJa+SY
	Mm2GNhxrj3clx9ELi6QRSOtxskHOsMt2zXkLL6B9dkIbLzXokWmLnkuSTjgAVMA+
	3M0F6KcEzyu6Rl+zqfH37c6eVwLRlGOKIMoPcuqqUYVwQbp8AtQ+8EHT2OmYmFps
	OAh83bWWiOKyr4szuYcUqolmkzzFoEGgo7iss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ud176UsBG7cva0pz9QtIC5RuBVdECk3E
	Tn/lIeQxbetzaBl+lezb4V6JPmQMQcP91G+L9bofRLWCeLManlKvLclQvYvMNWaD
	DPVhG/bITxJipU1sNcPH7RUPVWjmT4UOJlorRyNNHd0AvgBKMTg5ofNJeUWg4qeB
	z9r1HhFg7qA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 803D03AF75;
	Thu, 18 Sep 2014 12:12:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DD7663AF72;
	Thu, 18 Sep 2014 12:12:45 -0400 (EDT)
In-Reply-To: <1410928530-21595-2-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Tue, 16 Sep 2014 21:35:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A07359EC-3F4E-11E4-8C91-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257263>

David Aguilar <davvid@gmail.com> writes:

> @@ -514,8 +514,11 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
>  
>  	if (warn_ambiguous_refs &&
>  	    (refs_found > 1 ||
> -	     !get_short_sha1(str, len, tmp_sha1, GET_SHA1_QUIETLY)))
> -		warning(warn_msg, len, str);
> +	     !get_short_sha1(str, len, tmp_sha1, GET_SHA1_QUIETLY))) {
> +		if (!(flags & GET_SHA1_QUIETLY)) {
> +			warning(warn_msg, len, str);
> +		}
> +	}

Hmph, wouldn't it be simpler to read and understand if it were done
this way instead?

-	if (warn_ambiguous_refs &&
+	if (warn_ambiguous_refs && !(flags & GET_SHA1_QUIETLY) &&
 	    (refs_found > 1 || !get_short_sha1(...)))
		waqrning(...);
