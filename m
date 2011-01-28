From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/21] tree_entry_interesting(): support depth limit
Date: Fri, 28 Jan 2011 12:40:21 -0800
Message-ID: <7vd3ngdaoa.fsf@alter.siamese.dyndns.org>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
 <1292425376-14550-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 21:40:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Piv7b-0000Yy-JC
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 21:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721Ab1A1Ukb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 15:40:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab1A1Uka convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jan 2011 15:40:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 240BD408B;
	Fri, 28 Jan 2011 15:41:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0HvaKYOXypD9
	U833YtQi590rkmQ=; b=fzj3klwWTtcbeREuDjMuh9M6FinRSu/6d8LRswisaEr7
	LABClArTH52+YBScKzlvLnBHJ8gKJZzSzddXef0G+0aEGVpGGLnJDbK1UdzdYuPr
	7k4JYI+jZbgoaaVrtw/Zl54WU0JdJOhYcMeebYXipvRcIb3WC3kWNCBYX3ai7/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yRxTr9
	xlk8bAIbj8/1fUNEG7Ojmjvu91aTKnePCJJFHpqf9VUiq5DVW/7ldV/RN1zKvaMX
	5ZbIHHBu1EPzaaVFSrGiXNZKPpmq1Rw9VqOnBRPgbca+7n1ryxBxY6UCTMk1brjl
	w0XjgGOQv1OmPT6DYn/SfeBfSWZKmKM08mFBU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E782E4085;
	Fri, 28 Jan 2011 15:41:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C79BA4082; Fri, 28 Jan 2011
 15:41:12 -0500 (EST)
In-Reply-To: <1292425376-14550-10-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Wed\, 15 Dec
 2010 22\:02\:44 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F3B88728-2B1E-11E0-8325-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165640>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  static const char *get_mode(const char *str, unsigned int *modep)
> @@ -557,8 +558,13 @@ int tree_entry_interesting(const struct name_ent=
ry *entry,
>  	int pathlen, baselen =3D base->len;
>  	int never_interesting =3D -1;
> =20
> -	if (!ps || !ps->nr)
> -		return 1;
> +	if (!ps->nr) {
> +		if (!ps->recursive || ps->max_depth =3D=3D -1)
> +			return 1;
> +		return !!within_depth(base->buf, baselen,
> +				      !!S_ISDIR(entry->mode),
> +				      ps->max_depth);
> +	}

Back in 1d848f6 (tree_entry_interesting(): allow it to say "everything =
is
interesting", 2007-03-21), a new return value "2" was introduced to all=
ow
this function to tell the caller that all the remaining entries in the
tree object the caller is feeding the entries to this function _will_
match.  This was to optimize away expensive pathspec matching done by t=
his
function.

In that version, "no pathspec" case wasn't changed to return 2 but stil=
l
returned 1 ("I tell you that this does not match; call me with the next
entry").  We could have changed it to return 2, but the overhead was on=
ly
a call to a function that checks the number of pathspecs and was not so
bad.

But shouldn't we start returning 2 by now?  It is not that returning 1 =
was
a more correct thing to do to begin with.

When depth check is in effect, the result depends on the mode of the
entry, so we cannot short-circuit by returning 2, but at least we shoul=
d
do so when (max_depth =3D=3D -1), no?
