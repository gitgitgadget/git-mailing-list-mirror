From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote: fix status with branch...rebase=preserve
Date: Mon, 09 Dec 2013 13:16:50 -0800
Message-ID: <xmqqmwk9wwql.fsf@gitster.dls.corp.google.com>
References: <1386421717-27698-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephen Haberman <stephen@exigencecorp.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Jay Soffian <jaysoffian@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 22:16:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq8CI-00054q-ED
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 22:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761506Ab3LIVQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 16:16:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34647 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349Ab3LIVQy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 16:16:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B2FC59702;
	Mon,  9 Dec 2013 16:16:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G3ujjiLkjGTmFU5GA9twq1H/VbQ=; b=KWnddK
	m8rtpXJXcJs/T0w3JyTHxuEMfTW8UnxnoEN29OKJV7o9OdEgoG9fuiIL6CFYVQmo
	tYcfVmDSRp0k609j89lHjKWZiedOPgn+cxRp53czEjahXqOyMVSRN6BULUa3zA5x
	GHsgGFUPP0Hb6XV0UW3uUupf3t7eYqciG4gV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b0O02Rhy5oVYGq7sDCPPB2o54LfZF2d0
	UTA2qF1x5f4TabJTqawHfRc+3u+prAuc/pbFEA44N4ZD9/hSG4Zo5lMRteKlNBGF
	lqjdwOQdfXe8EM50MTnRwBHnyBsgyJpYUHcybNMZyyNqAbLuli7RSSngI6gw4s4X
	getxAI3eNs8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3818C59701;
	Mon,  9 Dec 2013 16:16:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FD9859700;
	Mon,  9 Dec 2013 16:16:52 -0500 (EST)
In-Reply-To: <1386421717-27698-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 7 Dec 2013 07:08:37 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 392E5748-6117-11E3-86FB-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239104>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Commit 66713ef (pull: allow pull to preserve merges when rebasing)
> didn't include an update so 'git remote status' parses branch.<name>.rebase=preserve
> correctly, let's do that.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/remote.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 4e14891..5e4ab66 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -309,8 +309,13 @@ static int config_read_branches(const char *key, const char *value, void *cb)
>  				space = strchr(value, ' ');
>  			}
>  			string_list_append(&info->merge, xstrdup(value));
> -		} else
> -			info->rebase = git_config_bool(orig_key, value);
> +		} else {
> +			int v = git_config_maybe_bool(orig_key, value);
> +			if (v >= 0)
> +				info->rebase = v;
> +			else if (!strcmp(value, "preserve"))
> +				info->rebase = 1;
> +		}

Looks correct.  Do we want to add a test?

>  	}
>  	return 0;
>  }
