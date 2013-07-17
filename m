From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] request-pull: improve error message for invalid revision args
Date: Wed, 17 Jul 2013 10:06:21 -0700
Message-ID: <7vr4ex6rqq.fsf@alter.siamese.dyndns.org>
References: <20130716104648.GA13275@bottich>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Dirk Wallenstein <halsmit@t-online.de>
X-From: git-owner@vger.kernel.org Wed Jul 17 19:06:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzVBM-0007vQ-S0
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 19:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756536Ab3GQRGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 13:06:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53325 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755884Ab3GQRGY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 13:06:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E311731B2B;
	Wed, 17 Jul 2013 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CQ14MBvV/6A1eOoXQXyhPn/A5cY=; b=tPKARW
	Z6HlVve2VhYMCQvEnJGCPcFDGsE7Alj+/hBXxxa6HVpaCdCYC/eHOtiSmEB1r9Qr
	bsy2gHWwSr9vMHPXU00YwqiCg+1PcgVE7rdAteTS5CjtFnIoNymtqlfZ4gtdgfXm
	imIYoKcFkv5GyzvJjzXicax0YX/R0kN7M4VnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WkcEPj7MsWVRbL9yrnUt0VHcVW8fOZr6
	zwgLmfGfGSXoXp37zQTyR+u1xWGEI4Y45sw6k47jfwlpYmKRZBNunZMWRTzEjfpR
	PI1HlBp4uxDN1zXC6zG4k2CQ/UiJYvGUxweTWcS57GZ3Dn1ye3Euz5QBRU5hJG9h
	prtmML6fCNM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7E5E31B2A;
	Wed, 17 Jul 2013 17:06:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32AAA31B26;
	Wed, 17 Jul 2013 17:06:23 +0000 (UTC)
In-Reply-To: <20130716104648.GA13275@bottich> (Dirk Wallenstein's message of
	"Tue, 16 Jul 2013 12:46:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35446AEA-EF03-11E2-AD8F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230635>

Dirk Wallenstein <halsmit@t-online.de> writes:

> When an invalid revision is specified, the error message is:
>
>     fatal: Needed a single revision
>
> This is misleading because, you might think there is something wrong
> with the command line as a whole.
>
> Now the user gets a more meaningful error message, showing the invalid
> revision.
>
> Signed-off-by: Dirk Wallenstein <halsmit@t-online.de>
> ---
>
> Notes:
>     I assume, it is not worth the trouble to even try to change the message from
>     rev-parse for this.  People might parse the messages, which is probably why
>     this message still exists.

You are right---such a change will break existing scripts, so it is
not just "not worth the trouble" but is actively wrong to change the
error message.

>  git-request-pull.sh | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/git-request-pull.sh b/git-request-pull.sh
> index d566015..f38f0f9 100755
> --- a/git-request-pull.sh
> +++ b/git-request-pull.sh
> @@ -51,8 +51,18 @@ fi
>  tag_name=$(git describe --exact "$head^0" 2>/dev/null)
>  
>  test -n "$base" && test -n "$url" || usage
> -baserev=$(git rev-parse --verify "$base"^0) &&
> -headrev=$(git rev-parse --verify "$head"^0) || exit
> +
> +baserev=$(git rev-parse --verify "$base"^0 2>/dev/null)

Use "--quiet" instead?

> +if test -z "$baserev"
> +then
> +    die "fatal: Not a valid revision: $base"
> +fi
> +
> +headrev=$(git rev-parse --verify "$head"^0 2>/dev/null)
> +if test -z "$headrev"
> +then
> +    die "fatal: Not a valid revision: $head"
> +fi
>  
>  merge_base=$(git merge-base $baserev $headrev) ||
>  die "fatal: No commits in common between $base and $head"
