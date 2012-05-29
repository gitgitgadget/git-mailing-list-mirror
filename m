From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] exclude: do strcmp as much as possible before
 fnmatch
Date: Tue, 29 May 2012 11:03:13 -0700
Message-ID: <7v8vga6f1a.fsf@alter.siamese.dyndns.org>
References: <1338035474-4346-1-git-send-email-pclouds@gmail.com>
 <1338035474-4346-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 20:03:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZQlL-0005KU-V9
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 20:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748Ab2E2SDQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 May 2012 14:03:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63070 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754517Ab2E2SDP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 May 2012 14:03:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E344087B5;
	Tue, 29 May 2012 14:03:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GFpYtXtlJtjF
	cAX8uqmBPLnlmU4=; b=KgAXLDY8eblJvujdkX+6TQspKDPiI+hKDEE4gd+XYdgn
	PytOLQ4FaOO75qZshic0S+bnvu/Y6Au5Gt1nMIVckq2XIf3z7C6vEUIVOvm1uO2L
	aF70etmLJJ2/dyU6rjIhIGxIyAazOACnpDq7CzkYZCDE2S9cW3uBO5IOYxhUJZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vi/7Av
	ORL8TBZsCWCsoeDbsslmCBnKEmsMv3b/RjkDJ/L3DluMM3ub1hZIEanqjLtmkqIg
	kyS4cNgTzHtMZH9DW6yChIHR6JfYHoeedBJyAryAhCrWlDKGRurRGlDuY8lWtpiK
	twa5QnFwB0ofp22j+fhhU2DiGKkdmtn1P9AMM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA59487B4;
	Tue, 29 May 2012 14:03:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7113187B2; Tue, 29 May 2012
 14:03:14 -0400 (EDT)
In-Reply-To: <1338035474-4346-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 26 May
 2012 19:31:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F84A9F2-A9B8-11E1-8559-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198744>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> this also avoids calling fnmatch() if the non-wildcard prefix is
> longer than basename
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  dir.c | 41 +++++++++++++++++++++++++++--------------
>  dir.h |  2 +-
>  2 files changed, 28 insertions(+), 15 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 8535cf2..50d744f 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -295,9 +295,11 @@ int match_pathspec_depth(const struct pathspec *=
ps,
>  	return retval;
>  }
> =20
> +const char *wildcards =3D "*?[{\\";

Elsewhere in this file, the logic to notice the non-wildcard part of
the pathspec uses is_glob_special().  Shouldn't the new code that
use this do the same?
