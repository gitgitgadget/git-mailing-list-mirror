From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] exec_cmd.c: use find_last_dir_sep() for code simplification
Date: Fri, 19 Feb 2016 13:28:15 -0800
Message-ID: <xmqqlh6gbdao.fsf@gitster.mtv.corp.google.com>
References: <1455871488-10460-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git \@ vger . kernel . org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 22:28:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWsb8-0003IK-MN
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 22:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbcBSV2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 16:28:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751683AbcBSV2R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 16:28:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 55CF846369;
	Fri, 19 Feb 2016 16:28:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V/u6OpnuMMgrCRNyToDei6p8Ek4=; b=YXi4RC
	x1cL21ZR6SQ+Kf8dv5yaNnOgjGuRAuS/ZqFrqFtxFQvk2B6dySxLoZjZ0SbyJJBq
	FYpxfCx1xGgtfq5saPp+CN47Af0nBIMOxh3HEb2Nh7VxkmEMHYMyhqoRFijSqrTp
	eLPOKWL44dm0ZHs2mBUOAR+BwwF6bjm6nA9mk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rWO6eO3/buvuoVz049QVSNGFSNs2zukT
	h/nDMQ/QmYYgCpyuOXhayNgH2t2pKKVTcoWK1zCeVkUmAkbqiKfO/MD24ebyOhhb
	lbUrN9XaxUV1Eq+rcHXh6/v79YRlxdoLnYMTjGKkJ6jDxDRi20NFhmwOsBzGVIQ4
	Xiu64FiMQKU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4BE7246368;
	Fri, 19 Feb 2016 16:28:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AA08946364;
	Fri, 19 Feb 2016 16:28:16 -0500 (EST)
In-Reply-To: <1455871488-10460-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Fri, 19 Feb 2016 14:44:48 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B06EA3CA-D74F-11E5-93ED-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286752>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> We are trying to extract dirname from argv0 in the git_extract_argv0_path().
> But in the same time, the <git-compat-util.h> provides find_last_dir_sep()
> to get dirname from a given path.  Let's use it instead of loop for the code
> simplification.
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---

Looks correct.  Thanks.

>  exec_cmd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/exec_cmd.c b/exec_cmd.c
> index e85f0fd..680b257 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -43,12 +43,10 @@ const char *git_extract_argv0_path(const char *argv0)
>  
>  	if (!argv0 || !*argv0)
>  		return NULL;
> -	slash = argv0 + strlen(argv0);
>  
> -	while (argv0 <= slash && !is_dir_sep(*slash))
> -		slash--;
> +	slash = find_last_dir_sep(argv0);
>  
> -	if (slash >= argv0) {
> +	if (slash) {
>  		argv0_path = xstrndup(argv0, slash - argv0);
>  		return slash + 1;
>  	}
