From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf: allocate enough space when strbuf_setlen() is
 called first time
Date: Tue, 26 Apr 2011 14:51:50 -0700
Message-ID: <7vhb9kd6kp.fsf@alter.siamese.dyndns.org>
References: <1303820660-744-1-git-send-email-pclouds@gmail.com>
 <7vaafdexsp.fsf@alter.siamese.dyndns.org> <4DB738A1.8020706@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
	<pclouds@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Apr 26 23:52:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEqB4-0003Lp-C3
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 23:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932888Ab1DZVwH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2011 17:52:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091Ab1DZVwF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 17:52:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 58A3453D3;
	Tue, 26 Apr 2011 17:54:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=78kOoqiJmPky
	pnWV2R0p1WWFaeE=; b=yWMZrqymJV/Xm95waxWU05JybIQ6dcRqktoAKIx8/ZgY
	TqtGGanYYMkBuoLtcGMV4l/gWvb7WYhZJ/xsKztWaCg7VRml+skLfr0yFDyLWqGh
	24YlptjGJriAAQ4FlIsy90VJoAOOk/aPkivd1nSQD1wkL0gzCfws6OS5jinM7oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qIHyhO
	sQHXez0muTiw9bQCN3eGLXvjOBxdPmJNbHqpj4gk9c6fEOcgHuuYKdrdaDzQcxao
	ZuoL0582LfhqgQHpNTxjFewMdLROOqbQvkOE7nVVLIO86pPrUhM+hKFSpFAAP/MY
	R0sAW9vVh8sJ7SXOIN9xpugm/h5IJBKz3Vv0E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1EA6953D2;
	Tue, 26 Apr 2011 17:54:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B63CE53D1; Tue, 26 Apr 2011
 17:53:54 -0400 (EDT)
In-Reply-To: <4DB738A1.8020706@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Tue, 26 Apr 2011 23:26:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B14B9BA2-704F-11E0-82FE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172129>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> How about something like this instead?  The call to strbuf_grow() was
> introduced in a8f3e2219 when there was no strbuf_slopbuf buffer that
> nowadays makes sure we always have a place to write an initial NUL.
> We can take it out again now, simplifying the code and hopefully
> avoiding future confusion.

Thanks; I think that makes sense.

It further may make sense to turn the assert into BUG() though, to clar=
ify
what kind of programming error we are trying to catch.  Perhaps like:

>  static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
> +	assert(len < (sb->alloc ? sb->alloc : 1));

	if (len < (sb->alloc ? sb->alloc : 1))
		die("programming error: using strbuf_setlen() to extend a strbuf");

>  	sb->len =3D len;
>  	sb->buf[len] =3D '\0';
>  }
