From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] prune_object_dir(): verify that path fits in the temporary buffer
Date: Tue, 17 Dec 2013 10:51:30 -0800
Message-ID: <xmqq8uvjmhu5.fsf@gitster.dls.corp.google.com>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
	<1387287838-25779-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 17 19:51:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vszk3-00015D-D8
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 19:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050Ab3LQSvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 13:51:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38644 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753361Ab3LQSve (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 13:51:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1CA459009;
	Tue, 17 Dec 2013 13:51:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nmzcw9WUQ9n0o8SDGrxmiFNgDVA=; b=fxy9Zg
	X7XliuEawmgI3DCp5TXU+GD4OWHDKVibzCCT8YBL8afBqMGXi+UuAn8QGcVtUbOx
	uLVnJY0zDkCTGMWPMfjRmaqsv58dYgJmsvJqJOxVdu8kemE+JSXotJHHIxiTk+gL
	qKBQ2GSSiX5L3J052DsyK3/QcsvEwqTgYYWco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qi20iIqDrgq+KUsKwnVveUhA15C9JsEG
	FY4ln99Hxyx8UUW7hDCfnMDHfUp/Tv9Zbs8ipoEthNP9TY1ZNC+IntuCHdNLWjy+
	U5QuYJ4G5wrBnNnljf0adMkfCDtFZNQoz0an9iM305a1nC7jjk8Q2d5XjcEtNp/s
	HFAdlajIeJk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE3D159008;
	Tue, 17 Dec 2013 13:51:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CC5759004;
	Tue, 17 Dec 2013 13:51:32 -0500 (EST)
In-Reply-To: <1387287838-25779-3-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 17 Dec 2013 14:43:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3F6E209E-674C-11E3-8311-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239399>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Dimension the buffer based on PATH_MAX rather than a magic number, and
> verify that the path fits in it before continuing.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>
> I don't think that this problem is remotely exploitable, because the
> size of the string doesn't depend on inputs that can be influenced by
> a client (at least not within Git).

This is shrinking the buffer on some platforms where PATH_MAX is
lower than 4k---granted, we will die() with the new check instead of
crashing uncontrolled, but it still feels somewhat wrong.

>  builtin/prune.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/prune.c b/builtin/prune.c
> index 6366917..ae34d04 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -96,7 +96,9 @@ static void prune_object_dir(const char *path)
>  {
>  	int i;
>  	for (i = 0; i < 256; i++) {
> -		static char dir[4096];
> +		static char dir[PATH_MAX + 1];
> +		if (strlen(path) + 3 > PATH_MAX)
> +			die("impossible object directory");
>  		sprintf(dir, "%s/%02x", path, i);
>  		prune_dir(i, dir);
>  	}
