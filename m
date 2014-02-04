From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 5/5] setup: Don't dereference in-tree symlinks for absolute paths
Date: Mon, 03 Feb 2014 16:05:08 -0800
Message-ID: <xmqq1tzjbv4b.fsf@gitster.dls.corp.google.com>
References: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
	<1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
	<1391358940-17373-6-git-send-email-martinerikwerner@gmail.com>
	<CACsJy8DX8bh2cAx+a_cJafAOYB7Ly=y28jAGo1L8NEmkWaZv=Q@mail.gmail.com>
	<20140203131700.GA15607@mule>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, richih@debian.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	David Kastrup <dak@gnu.org>
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 01:05:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WATW6-0003h5-Jp
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 01:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbaBDAF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 19:05:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53841 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464AbaBDAFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 19:05:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FB33699EC;
	Mon,  3 Feb 2014 19:05:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y7+JJAP9oc1ISGQrt3ka8IWLjnY=; b=Jw+3js
	WGPga4tjXp2ilXRA9LfJAeppbi1H8kPp34GwQ+6nkBEbhKNnSfRFWeP2T+aNHo7s
	qdv2GNH/QwkASBR5huy8ODLaPUICr4KBuUTdZorUbharUim5hwMoono/dIrHU1IM
	pFkWNebwXhT/676f6Z6DREjYlXJWCFI2Frvmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lu4Jd+B6WtqR52gUwQ2ZO20x0/W6sWyh
	axZ80bfUkw7fE/Ony4kWosfSOOy1FoSUT6yaFcshuhh8rUj/jFJ6JOGJvXIdtIiw
	ptkS6f1YQ5sJoq9Z58SbsYL1THZw9XSED0Rid85vHwHcnAoOuAlR9N1gK8VrxjjI
	9tuA388L1lQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C53C699DC;
	Mon,  3 Feb 2014 19:05:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 825F8699DA;
	Mon,  3 Feb 2014 19:05:10 -0500 (EST)
In-Reply-To: <20140203131700.GA15607@mule> (Martin Erik Werner's message of
	"Mon, 3 Feb 2014 14:17:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 035BC746-8D30-11E3-853F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241501>

Martin Erik Werner <martinerikwerner@gmail.com> writes:

> Then it seems like one could get rid of npath completely:

Yes.  And you need to remove its definition as well to avoid "unused
variable" warning.

Will queue with an obvious fix-up.

Thanks.

>
> diff --git a/setup.c b/setup.c
> index 230505c..dd120cd 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -88,21 +88,17 @@ char *prefix_path_gently(const char *prefix, int len,
>  	if (is_absolute_path(orig)) {
>  		char *npath;
>  
> -		npath = xmalloc(strlen(path) + 1);
> +		sanitized = xmalloc(strlen(path) + 1);
>  		if (remaining_prefix)
>  			*remaining_prefix = 0;
> -		if (normalize_path_copy_len(npath, path, remaining_prefix)) {
> -			free(npath);
> +		if (normalize_path_copy_len(sanitized, path, remaining_prefix)) {
> +			free(sanitized);
>  			return NULL;
>  		}
> -		if (abspath_part_inside_repo(npath)) {
> -			free(npath);
> +		if (abspath_part_inside_repo(sanitized)) {
> +			free(sanitized);
>  			return NULL;
>  		}
> -
> -		sanitized = xmalloc(strlen(npath) + 1);
> -		strcpy(sanitized, npath);
> -		free(npath);
>  	} else {
>  		sanitized = xmalloc(len + strlen(path) + 1);
>  		if (len)
>
> at the cost of 'sanitized' always being the length of path, regardless
> if it's shorter, or even a NUL string.
>
> --
> Martin Erik Werner <martinerikwerner@gmail.com>
