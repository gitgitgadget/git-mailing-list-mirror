From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Behavior of git rm
Date: Wed, 03 Apr 2013 10:35:52 -0700
Message-ID: <7vli8z5xfr.fsf@alter.siamese.dyndns.org>
References: <1365000624535-7581485.post@n2.nabble.com>
 <20130403155841.GA16885@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jpinheiro <7jpinheiro@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 03 19:36:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNRbm-0003wA-S5
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 19:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762844Ab3DCRf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 13:35:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40132 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758593Ab3DCRf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 13:35:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F76E12B12;
	Wed,  3 Apr 2013 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z+5YsNCylnUZPSbMECczUmX7QwI=; b=Me/Qde
	Bc+wyl91LsrVjfUPPaBh/iBmRfLumN02oJCFwj39sPCGKfKPpASgjBNo/sce308T
	jRCy00t1VIJTWyAPqBGp24GWVYSOvl8rwZYvy9Og87vgAzZG4BGomIaajPH4byQ+
	jCBrwvX8s7860yBzxLTcCC+zqyN+p1CHtwsF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UIpJAj2H/pw7bhqCKBJkXogCVOWjOwzL
	qrj454of9oL3VfNQXaLuPmEMH3t3Vj9GD1T7RaFgpabLOlRRBGnpn0BLi+hegLxJ
	q5X7vy0z9c/QnCS6r1h6SYPVkf4qToDqyu9PsXdmCw/8OIKQrKbg2wOcnMWeG8Yw
	20XNdln0Ycw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23C5A12B11;
	Wed,  3 Apr 2013 17:35:55 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 805EB12B0F; Wed,  3 Apr
 2013 17:35:54 +0000 (UTC)
In-Reply-To: <20130403155841.GA16885@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 3 Apr 2013 11:58:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EFAEB510-9C84-11E2-90E6-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219955>

Jeff King <peff@peff.net> writes:

> Of the two situations, I think the first one is less likely to be
> destructive (noticing that a file is already gone via ENOTDIR), as we
> are only proceeding with the index deletion, and we end up not touching
> the filesystem at all.

Nice to see sound reasoning.

>
> diff --git a/builtin/rm.c b/builtin/rm.c
> index dabfcf6..7b91d52 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -110,7 +110,7 @@ static int check_local_mod(unsigned char *head, int index_only)
>  		ce = active_cache[pos];
>  
>  		if (lstat(ce->name, &st) < 0) {
> -			if (errno != ENOENT)
> +			if (errno != ENOENT && errno != ENOTDIR)

OK.  We may be running lstat() on D/F but there may be D that is not
a directory.  If it is a file, we get ENOTDIR.

By the way, if D is a dangling symlink, we get ENOENT; in such a
case, we report "rm 'D/F'" on the output and remove the index entry.

	$ rm -f .git/index && rm -fr D E
	$ mkdir D && >D/F && git add D && rm -fr D
        $ ln -s erewhon D && git rm D/F && git ls-files
        rm 'D/F'

Also if D is a symlink that point at a directory E, "git rm" does
something interesting.

(1) Perhaps we want a complaint in this case.

	$ rm -f .git/index && rm -fr D E
	$ mkdir D && >D/F && git add D && rm -fr D
	$ mkdir E && ln -s E D && git rm D/F

(2) Perhaps we want to make sure D/F is not beyond a symlink in this
    case.

	$ rm -f .git/index && rm -fr D E
	$ mkdir D && >D/F && git add D && rm -fr D
	$ mkdir E && ln -s E D && date >E/F && git rm D/F


	$ git rm -f D/F

> diff --git a/dir.c b/dir.c
> index 57394e4..f9e7355 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1603,7 +1603,7 @@ int remove_path(const char *name)
>  {
>  	char *slash;
>  
> -	if (unlink(name) && errno != ENOENT)
> +	if (unlink(name) && errno != ENOENT && errno != ENOTDIR)
>  		return -1;

Ditto.

>  
>  	slash = strrchr(name, '/');
