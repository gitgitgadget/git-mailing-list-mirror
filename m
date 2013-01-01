From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] format-patch: pick up branch description when no ref
 is specified
Date: Tue, 01 Jan 2013 12:38:40 -0800
Message-ID: <7v38ykbpv3.fsf@alter.siamese.dyndns.org>
References: <1357032655-21103-1-git-send-email-pclouds@gmail.com>
 <1357032655-21103-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 21:39:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq8cN-0004Du-J9
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 21:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449Ab3AAUip convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2013 15:38:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53325 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460Ab3AAUio convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jan 2013 15:38:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A523B932;
	Tue,  1 Jan 2013 15:38:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cCLkC5PK6F2v
	ik9soHm8PlBmWns=; b=hHR/P7TUfIiKEUudX4qx02gLXo9XYGGBLjSFmdYHEnft
	elX4Pind3WpftTJknDzY3PmdMcNCPT80rY+qhbAmHpNZ6lX0mxUcg5b4J5j+fwsv
	2qTRYbdHILhET23QzWAE0pz/GtzO0n4yNslPtDYObRycbyNVt7sY70AghWL8wTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LDtx/C
	nQc/r1HQPSoxZCEZdwPyWPmMq2e0EZe9kQCckR1n6jk7BnS7D2R1GBcVHOgXXjkJ
	eLtlzfp7cBmx4fpqFRWjVhJ8DmIlaOYbTjJYgpGb3iz9d3Z+W8FZA0tW+qVOWcSA
	djaz8zeaSraoxLTQ3rozOOqcy1Wzw/trz8HHM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C922B931;
	Tue,  1 Jan 2013 15:38:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F377B92F; Tue,  1 Jan 2013
 15:38:42 -0500 (EST)
In-Reply-To: <1357032655-21103-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 1 Jan
 2013 16:30:54 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B268F2E-5453-11E2-9BC4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212437>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> find_branch_name() fails to detect "format-patch --cover-letter -3"
> where no command line arguments are given and HEAD is automatically
> added.

Nicely spotted.

That is not the only case that takes this codepath, though.

    $ git format-patch --cover-letter master..

will also give you the same (if you say it without "..", which is
the more normal invocation of the command, then the caller already
know you meant the current branch and this function is not called).

And in that case you will have two tokens on cmdline.nr, one for
"master.."  to show where he bottom is, and the other for the
implied "HEAD"; I do not think this patch is a sufficient solution
for the more general cases, but on the other hand I do not know how
much it matters.

> -	if (positive < 0)
> +	if (positive < 0) {
> +		/*
> +		 * No actual ref from command line, but "HEAD" from
> +		 * rev->def was added in setup_revisions()
> +		 * e.g. format-patch --cover-letter -12
> +		 */

That comment does not describe "positive < 0" case, but belongs to
the conditional added in this patch, no?

> +		if (!rev->cmdline.nr &&
> +		    rev->pending.nr =3D=3D 1 &&
> +		    !strcmp(rev->pending.objects[0].name, "HEAD")) {
> +			const char *ref;
> +			ref =3D resolve_ref_unsafe("HEAD", branch_sha1, 1, NULL);
> +			if (ref && !prefixcmp(ref, "refs/heads/"))
> +				return xstrdup(ref + strlen("refs/heads/"));
> +		}
>  		return NULL;
> +	}
>  	strbuf_addf(&buf, "refs/heads/%s", rev->cmdline.rev[positive].name)=
;
>  	branch =3D resolve_ref_unsafe(buf.buf, branch_sha1, 1, NULL);
>  	if (!branch ||
