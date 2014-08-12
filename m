From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] blame.c: Add translation to warning about failed revision walk
Date: Tue, 12 Aug 2014 09:57:58 -0700
Message-ID: <xmqqppg563xl.fsf@gitster.dls.corp.google.com>
References: <1407706406-30455-1-git-send-email-stefanbeller@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 18:58:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHFOn-0000Jd-G2
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 18:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbaHLQ6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 12:58:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54485 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753156AbaHLQ6I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 12:58:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B3EF12E925;
	Tue, 12 Aug 2014 12:58:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V5N0N+LLCJmXBiNiFp108Hj8O4o=; b=w70OUg
	ypRScNrfAhPV/yzecN7KAMyK49gcAg3baX0m8HIgN/VOKGsQ0ciQuhSKAVUjp2hc
	TlkTZjSUmsiZDOCYOkamXOfaxrjmcvRcmgO+N+CkVFHktvN/WnCzFnYAf0HXSB4W
	yzuttDvhVNS9beCijnMn7p0uyctBM/L9428ho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=puQzG5zxX4KemN+Oarnjg7W66jSLURsr
	6vyf1/xSa8cxM6DgWLNXMIxFPoQY6+nFH/PGBS9txGgfRWD2VY+Y2ktFJJQQluGb
	mcyg1/WjSgBwcA3H5aE/7RGpkjRnr8eqeXvL69eDlu5cXSSoqvJRX9/RwTpFY+Av
	4r2Kqx3YI1c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A8BAD2E923;
	Tue, 12 Aug 2014 12:58:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 802CA2E916;
	Tue, 12 Aug 2014 12:58:00 -0400 (EDT)
In-Reply-To: <1407706406-30455-1-git-send-email-stefanbeller@gmail.com>
	(Stefan Beller's message of "Sun, 10 Aug 2014 23:33:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D12A2086-2241-11E4-BE2B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255156>

Stefan Beller <stefanbeller@gmail.com> writes:

> blame belonging to the group of
> ancillaryinterrogators and not to plumbinginterrogators
> should have localized error messages?

Unless running under --porcelain option to be driven by scripts, we
expect that we are talking to a human user, so using "_(msg)" is very
much appropriate for that case.

A possibly problematic script might do something like this:

	git blame --porcelain "$1" 2>&1 |
        awk "$awkScript"

and the $awkScript may check the input lines that do not match the
expected pattern the output lines from the command follow and act on
them, though.  _(msg) is unwelcome to such a script [*1*].

I suspect the above problem is likely to be theoretical.  People
would be more sloppy and write this instead:

	git blame --porcelain "$1" |
        awk "$awkScript"

and let the problem pass unnoticed, affecting the later parts of
their processing ;-).  And "_(msg)", not "msg", would help.


[Footnote]

*1* ... and with possible interleaving of output that came to the
standard output and the standard error, such parsing by $awkScript
would not be a reliable way to do this anyway.  A truly careful one
has to be written along the lines of:

	git blame --porcelain "$1" >"$tmp" &&
        awk "$awkScript" <"$tmp"

anyway.

> Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
> ---
>  builtin/blame.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 17d30d0..ca4ba6f 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2700,7 +2700,7 @@ parse_done:
>  	 * uninteresting.
>  	 */
>  	if (prepare_revision_walk(&revs))
> -		die("revision walk setup failed");
> +		die(_("revision walk setup failed"));
>  
>  	if (is_null_sha1(sb.final->object.sha1)) {
>  		o = sb.final->util;
