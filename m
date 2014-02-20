From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/25] Convert git_snpath() to strbuf_git_path()
Date: Thu, 20 Feb 2014 11:44:10 -0800
Message-ID: <xmqqha7t6039.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 20:44:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGZY6-00072l-P5
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 20:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbaBTToT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Feb 2014 14:44:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55939 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412AbaBTToS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Feb 2014 14:44:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B79C6E785;
	Thu, 20 Feb 2014 14:44:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Dvbd57jERduN
	KYnNSrpRU5sYSOQ=; b=GIN+35OtKxCGvhlKZerVlRFAgFpBU3R9PEPLt3Iv9714
	HzpinH4Qu7dFpDqWbZ7wEXWB66xbXsiH35EywBIdTno1f9um8WYD+fYF5w1vcUR8
	Zne1KqY4ihNvm51wQ6O7v+QdfINos1/ry2CDyeGptOGUnvW069pyRarfDCspVdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Z4+Twy
	AAIlICe4OxYliqmTsMQX6kHmUxVaMcOCokuBaANhyrt6Hvp6yH7cUGktvUWKEMJ5
	KAqMO2JhVn2IzUYWW4MDmN0RI4ggL/qIyOJPY1uOVvF+dSP0bIY/NnRlPY9AFZCu
	qGU7Oorb27LDQYGdUQqZI2LEJEI111roa1uw0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 358386E782;
	Thu, 20 Feb 2014 14:44:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FBB76E76F;
	Thu, 20 Feb 2014 14:44:13 -0500 (EST)
In-Reply-To: <1392730814-19656-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 18
 Feb 2014 20:39:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5FD5AF66-9A67-11E3-B5F6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242444>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -2717,17 +2729,19 @@ static int copy_msg(char *buf, const char *ms=
g)
>  	return cp - buf;
>  }
> =20
> -int log_ref_setup(const char *refname, char *logfile, int bufsize)
> +int log_ref_setup(const char *refname, struct strbuf *sb_logfile)
>  {
>  	int logfd, oflags =3D O_APPEND | O_WRONLY;
> +	const char *logfile;
> =20
> -	git_snpath(logfile, bufsize, "logs/%s", refname);
> +	strbuf_git_path(sb_logfile, "logs/%s", refname);
> +	logfile =3D sb_logfile->buf;
>  	if (log_all_ref_updates &&
>  	    (starts_with(refname, "refs/heads/") ||
>  	     starts_with(refname, "refs/remotes/") ||
>  	     starts_with(refname, "refs/notes/") ||
>  	     !strcmp(refname, "HEAD"))) {
> -		if (safe_create_leading_directories(logfile) < 0)
> +		if (safe_create_leading_directories(sb_logfile->buf) < 0)

Other references to logfile in this function are kept as-is, and I
think this line can also stay as-it-was.  That is the whole point of
introducing the local variable logfile and assinging to it upfront
as a synonym, isn't it?
