From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] setup: Fix windows path buffer over-stepping
Date: Thu, 24 Apr 2014 11:37:38 -0700
Message-ID: <xmqqsip2vaj1.fsf@gitster.dls.corp.google.com>
References: <1398344769-32564-1-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 20:38:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdOX0-0008ST-T3
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 20:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758879AbaDXShs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 14:37:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59364 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758725AbaDXShm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 14:37:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C4458051A;
	Thu, 24 Apr 2014 14:37:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MeaUYp4pC4+b5JIdTBxhrW+9MAc=; b=prH8Gg
	oPO9x+d2V6YyRkLJ5eZW+g041d4OJQVCMqW7FLGXNCbOLbb/mrBQ2WMcpftkyDtZ
	Li80Mz7nP2TLz2MsrwRe+fqMXgetSSmU3rEqJn7ELc2ALzIA848ZCXKt2geTnULw
	4wwsMmkn5hgfN9QhiFIHwAyfqB7rzu2Oekz7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SYDVfya810ssMyzRtXVayRCSHHljyiOM
	YujjlJkP3j210FXo4qtS2/oPArzssFWfxM2tZQcazXM8gKfVL+5HicDsTOL5QkwP
	Cb6xMQpPMPX9gfx2yk0rKm1LBMCa1DsjjASZ9dA69FwY+T01zvQRlsw9gpzqsmTg
	zjAF/p72p6o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21DEE80519;
	Thu, 24 Apr 2014 14:37:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2A3680517;
	Thu, 24 Apr 2014 14:37:39 -0400 (EDT)
In-Reply-To: <1398344769-32564-1-git-send-email-martinerikwerner@gmail.com>
	(Martin Erik Werner's message of "Thu, 24 Apr 2014 15:06:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 83BCD8F6-CBDF-11E3-9E76-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246991>

Martin Erik Werner <martinerikwerner@gmail.com> writes:

> Fix a buffer over-stepping issue triggered by providing an absolute path
> that is similar to the work tree path.
>
> abspath_part_inside_repo() may currently increment the path pointer by
> offset_1st_component() + wtlen, which is too much, since
> offset_1st_component() is a subset of wtlen.
>
> For the *nix-style prefix '/', this does (by luck) not cause any issues,
> since offset_1st_component() is 1 and there will always be a '/' or '\0'
> that can "absorb" this.
>
> In the case of DOS-style prefixes though, the offset_1st_component() is
> 3 and this can potentially over-step the string buffer. For example if
>
>     work_tree = "c:/r"
>     path      = "c:/rl"
>
> Then wtlen is 4, and incrementing the path pointer by (3 + 4) would
> end up 2 bytes outside a string buffer of length 6.
>
> Similarly if
>
>     work_tree = "c:/r"
>     path      = "c:/rl/d/a"
>
> Then (since the loop starts by also incrementing the pointer one step),
> this would mean that the function would miss checking if "c:/rl/d" could
> be the work_tree, arguably this is unlikely though, since it would only
> be possible with symlinks on windows.
>
> Fix this by simply avoiding to increment by offset_1st_component() and
> wtlen at the same time.
>
> Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
> ---
>
> This is a follow-up on 655ee9e mw/symlinks which is currently merged into
> master, prospective for git v2.0.0, the issue only affects v2.0.0-rc0.

Thanks for a fix and from a cursory read of the surrounding code, I
think the patch makes sense.

I appreciate your doing so before the breakage hits a released
version very much.


>  setup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 613e3b3..0a22f8b 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -29,7 +29,7 @@ static int abspath_part_inside_repo(char *path)
>  		return -1;
>  	wtlen = strlen(work_tree);
>  	len = strlen(path);
> -	off = 0;
> +	off = offset_1st_component(path);
>  
>  	/* check if work tree is already the prefix */
>  	if (wtlen <= len && !strncmp(path, work_tree, wtlen)) {
> @@ -45,7 +45,7 @@ static int abspath_part_inside_repo(char *path)
>  		off = wtlen;
>  	}
>  	path0 = path;
> -	path += offset_1st_component(path) + off;
> +	path += off;
>  
>  	/* check each '/'-terminated level */
>  	while (*path) {
