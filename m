From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] path.c: new (identical) list for worktree v1
Date: Wed, 27 Jan 2016 14:18:00 -0800
Message-ID: <xmqqbn867jl3.fsf@gitster.mtv.corp.google.com>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
	<1453808685-21235-1-git-send-email-pclouds@gmail.com>
	<1453808685-21235-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, max@max630.net, git@drmicha.warpmail.net,
	Jens.Lehmann@web.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 23:18:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOYPi-0003Fs-3N
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 23:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934350AbcA0WSF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2016 17:18:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754606AbcA0WSE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2016 17:18:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D8B093E2A7;
	Wed, 27 Jan 2016 17:18:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jpSzylasoqMJ
	Y9GZ7DK4y2VN17g=; b=lomxBpWYGBh1gvomdyv1VWFuCZ2zUBPR1XjnH/9DRiC/
	WuIXxpKm1gchV2DidJ+r32aO8WTWTF+5o6qDBJPK2QPTftwkNLc+SRjaAZRjMM+y
	aGL6hz5QjWHlVeIo0TlQPBENQrWs/FaMnpQEJU/bqlPAV+keWoqtqXJDwfP+lWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=swT8hc
	o8UZZZ3Orm7JmlPghmIj4Vljw2n2yC4BariqTx5UHlHfOBxFDQPgoorDL4EXIqUD
	Utp+oGseaJjF3N+bxXk9XbpK9+LG7t+IC5lLSr2SxcTEgXUzBQUJq6JIkwV+GtVS
	kdZi3ZO7u8ZnGXxSNPAbAF0moLy4CfRctJdh4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D16DA3E2A4;
	Wed, 27 Jan 2016 17:18:02 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4CA1C3E2A2;
	Wed, 27 Jan 2016 17:18:02 -0500 (EST)
In-Reply-To: <1453808685-21235-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 26
 Jan 2016 18:44:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D48A1D8E-C543-11E5-90C1-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +static struct common_dir common_list_v1[] =3D {
> +	...
> +};
> +
> +static struct common_dir *get_common_list(void)
> +{
> +	switch (repository_format_worktree_version) {
> +	case 0: return common_list_v0;
> +	case 1: return common_list_v1;

Why not an array whose elements are these common_list_v$N[]
instead of "switch"?  I.e.

static struct common_dir **common_list_version[] =3D {
	common_list_v0,
        common_list_v1,
};

static struct common_dir *get_common_list(void)
{
	int i =3D repository_format_worktree_version;
	if (i < ARRAY_SIZE(common_list_version))
		return common_list_version[i];
	die("I dunno about version %d", i);
}
