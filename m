From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] update-ref: support multiple simultaneous updates
Date: Fri, 30 Aug 2013 15:51:43 -0700
Message-ID: <xmqqbo4eyeps.fsf@gitster.dls.corp.google.com>
References: <cover.1377784597.git.brad.king@kitware.com>
	<cover.1377885441.git.brad.king@kitware.com>
	<ba564b6566b54d780a24355ca893294d814d8d24.1377885441.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 00:51:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFXXk-0007qk-Dn
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 00:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756389Ab3H3Wvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 18:51:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50875 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755096Ab3H3Wvr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 18:51:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68A233DE29;
	Fri, 30 Aug 2013 22:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/HxMh2ooi+pcQ9F6p8GwVVEMgDQ=; b=hEgQvZ
	Hihd4v5UmLRXcx8yZ2EH2iYPfxTW5PU/hR0nc9IlDF+qDoYTBfuWwVyHbZ8vOSxv
	DzUOh0IXSGjDJ0bD1UcZa92cJCD2l87ZxLrMNv2i3UPFOGWuaFiAbR0F+1CfRgiP
	Oj9dYNx5XKnUVC0WbbmgEYq3JnZXuFUpS2cTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NLBSf2yekp03Phy1PgcVly5PYSTPJ185
	gj7ls6XpslSuyXOTK2WGxr8n+4U8+Hq2eKlzU7pygSFr/6kmTjWft+3HDi+0GKV/
	x+5vpL1jJDuP5HDemcneYGLPknSN8qs0jrGcNOl0ns0S8XbJRyY/H9gzZuVuM2UY
	Air/7GwoUU4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 518693DE27;
	Fri, 30 Aug 2013 22:51:46 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F24F3DE26;
	Fri, 30 Aug 2013 22:51:45 +0000 (UTC)
In-Reply-To: <ba564b6566b54d780a24355ca893294d814d8d24.1377885441.git.brad.king@kitware.com>
	(Brad King's message of "Fri, 30 Aug 2013 14:12:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BEE7F024-11C6-11E3-9E04-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233479>

Brad King <brad.king@kitware.com> writes:

> Add a --stdin signature to read update instructions from standard input
> and apply multiple ref updates together.  Use an input format that
> supports any update that could be specified via the command-line,
> including object names like 'branch:path with space'.
>
> Signed-off-by: Brad King <brad.king@kitware.com>
> ---
>  Documentation/git-update-ref.txt |   21 ++++++-
>  builtin/update-ref.c             |  121 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 140 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
> index 0df13ff..295d0bb 100644
> --- a/Documentation/git-update-ref.txt
> +++ b/Documentation/git-update-ref.txt
> @@ -8,7 +8,7 @@ git-update-ref - Update the object name stored in a ref safely
>  SYNOPSIS
>  --------
>  [verse]
> -'git update-ref' [-m <reason>] (-d <ref> [<oldvalue>] | [--no-deref] <ref> <newvalue> [<oldvalue>])
> +'git update-ref' [-m <reason>] (-d <ref> [<oldvalue>] | [--no-deref] <ref> <newvalue> [<oldvalue>] | --stdin)
>  
>  DESCRIPTION
>  -----------
> @@ -58,6 +58,25 @@ archive by creating a symlink tree).
>  With `-d` flag, it deletes the named <ref> after verifying it
>  still contains <oldvalue>.
>  
> +With `--stdin`, update-ref reads instructions from standard input and
> +performs all modifications together.  Empty lines are ignored.
> +Each non-empty line is parsed as whitespace-separated arguments.
> +Use single-quotes to enclose whitespace and backslashes and an
> +unquoted backslash to escape a single quote.

That is somewhat unusual.

When we need to deal with arbitrary strings (like pathnames), other
parts of the system usually give the user two interfaces, --stdin
with and without -z, and the strings are C-quoted when run without
the -z option, and terminated with NUL when run with the -z option.

> +Specify updates with
> +lines of the form:
> +
> +	[--no-deref] [--] <ref> <newvalue> [<oldvalue>]

What is -- doing here?  refs given to update-ref begin with refs/
(otherwise it is HEAD), no?
