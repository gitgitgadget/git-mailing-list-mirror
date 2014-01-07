From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_name: don't resolve refs when core.warnambiguousrefs is false
Date: Tue, 07 Jan 2014 09:24:47 -0800
Message-ID: <xmqqd2k3g0ww.fsf@gitster.dls.corp.google.com>
References: <1389065521-46331-1-git-send-email-brodie@sf.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>
To: Brodie Rao <brodie@sf.io>
X-From: git-owner@vger.kernel.org Tue Jan 07 18:24:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0aOf-0002ID-Sq
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 18:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223AbaAGRYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 12:24:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48297 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201AbaAGRYx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 12:24:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B49A7607AB;
	Tue,  7 Jan 2014 12:24:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ariu8E3GNOhJytsgLvDElumBb0Q=; b=Y3sTFB
	0BZO/s3ztlp0WTvB09CHkReF7G/JpA+hNp/I27Lha3ukCiex6BYJn72m4pX66CDQ
	EFHBrmzJYEswlRVBX1FDhns5XRBXbpd3rRo3ed5hgSVCiyEGyBf2dR5S0QaLkd8i
	U44WQoUy1ZUg2l006MyymIvhH/NwqeYsMiSqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ODpO4CkuwvfM768BLV/y01V86TCGaxao
	hOlg/xtPNzOuv4KY5LlMHjmvhFu7myDxxk+budNL4iFrpFyBypkxmtOEwp5R73Tp
	I6KZOok4WxTv+ni8oRvU4hsOKQqEkZHEztzo0HZcwF638FUximfJA16/ZtuhIv52
	IfxddNx1PO0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33D38607AA;
	Tue,  7 Jan 2014 12:24:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BFEF607A8;
	Tue,  7 Jan 2014 12:24:50 -0500 (EST)
In-Reply-To: <1389065521-46331-1-git-send-email-brodie@sf.io> (Brodie Rao's
	message of "Mon, 6 Jan 2014 19:32:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9D11C33E-77C0-11E3-8FFF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240112>

Brodie Rao <brodie@sf.io> writes:

> This change ensures get_sha1_basic() doesn't try to resolve full hashes
> as refs when ambiguous ref warnings are disabled.
>
> This provides a substantial performance improvement when passing many
> hashes to a command (like "git rev-list --stdin") when
> core.warnambiguousrefs is false. The check incurs 6 stat()s for every
> hash supplied, which can be costly over NFS.
> ---

Needs sign-off.  The patch looks good.

Thanks.

>  sha1_name.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index e9c2999..10bd007 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -451,9 +451,9 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>  	int at, reflog_len, nth_prior = 0;
>  
>  	if (len == 40 && !get_sha1_hex(str, sha1)) {
> -		if (warn_on_object_refname_ambiguity) {
> +		if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
>  			refs_found = dwim_ref(str, len, tmp_sha1, &real_ref);
> -			if (refs_found > 0 && warn_ambiguous_refs) {
> +			if (refs_found > 0) {
>  				warning(warn_msg, len, str);
>  				if (advice_object_name_warning)
>  					fprintf(stderr, "%s\n", _(object_name_msg));
