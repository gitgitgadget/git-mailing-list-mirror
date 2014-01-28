From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rev-parse: Check argc before using argv[i+1]
Date: Tue, 28 Jan 2014 13:43:56 -0800
Message-ID: <xmqqmwiflr37.fsf@gitster.dls.corp.google.com>
References: <CAJL_ekuMJByFDVLMCYD4fo9EQy3LKdohsw25WfHqJv9M=3S9Kw@mail.gmail.com>
	<1390944060-783-1-git-send-email-dhsharp@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Sharp <dhsharp@google.com>
X-From: git-owner@vger.kernel.org Tue Jan 28 22:44:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8GSG-0001Fx-0H
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 22:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612AbaA1VoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jan 2014 16:44:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50039 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755212AbaA1VoG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jan 2014 16:44:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A356E68A59;
	Tue, 28 Jan 2014 16:44:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kkrCzV7yo/M7eztAhZoh7TIJ6vA=; b=fmN8w5
	p7gCcclHXQiigCJx4Zy8aYJSB+PHm9TeNmSqUlIeyxtV9bSHlBAEh5hKU6p3Z96B
	8gzd4XnJ96sOLhH3D0DVRpyCT71M/66k/szUaYHmDQP49jwsB4R5UnI8jDMbjJoD
	pUUzUd1KU6Vi7Joe22iL1+M7etyUk0P0d1pd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kCr3wv7a8NlHPTgBIR+LiLcvYlhmIbwy
	UHCA45Hzi57Qc+TjXO0Al7NPBo8ek/TElB7NK7FLDiXJSqk+UnJ+IvYvpKnkQGFJ
	uJUkpYo+oCx3DfVtVc76HXKzIlBI2jcUqt3xMijxAc5oIdtXA0yIp5xZqqKou8aU
	nVAHxd+5WRE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6721E68A58;
	Tue, 28 Jan 2014 16:44:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9AF5368A57;
	Tue, 28 Jan 2014 16:43:59 -0500 (EST)
In-Reply-To: <1390944060-783-1-git-send-email-dhsharp@google.com> (David
	Sharp's message of "Tue, 28 Jan 2014 13:21:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4BD2BAAE-8865-11E3-BDAD-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241193>

David Sharp <dhsharp@google.com> writes:

> Without this patch, git-rev-parse --prefix, --default, or
> --resolve-git-dir, without a value argument, would result in a segfault.
> Instead, die() with a message.

When I sent the review message, I actually was on the fence between
checking i vs argc and checking the nullness myself.  I realize,
after seeing the actual patch below, that we are protecting against
picking up a NULL and blindly passing it on in the codepaths that
follow, so the updated code does look a lot better, at least to me.

Thanks.

>
> Signed-off-by: David Sharp <dhsharp@google.com>
> ---
>  builtin/rev-parse.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index aaeb611..45901df 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -547,15 +547,17 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				continue;
>  			}
>  			if (!strcmp(arg, "--default")) {
> -				def = argv[i+1];
> -				i++;
> +				def = argv[++i];
> +				if (!def)
> +					die("--default requires an argument");
>  				continue;
>  			}
>  			if (!strcmp(arg, "--prefix")) {
> -				prefix = argv[i+1];
> +				prefix = argv[++i];
> +				if (!prefix)
> +					die("--prefix requires an argument");
>  				startup_info->prefix = prefix;
>  				output_prefix = 1;
> -				i++;
>  				continue;
>  			}
>  			if (!strcmp(arg, "--revs-only")) {
> @@ -738,9 +740,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				continue;
>  			}
>  			if (!strcmp(arg, "--resolve-git-dir")) {
> -				const char *gitdir = resolve_gitdir(argv[i+1]);
> +				const char *gitdir = argv[++i];
>  				if (!gitdir)
> -					die("not a gitdir '%s'", argv[i+1]);
> +					die("--resolve-git-dir requires an argument");
> +				gitdir = resolve_gitdir(gitdir);
> +				if (!gitdir)
> +					die("not a gitdir '%s'", argv[i]);
>  				puts(gitdir);
>  				continue;
>  			}
