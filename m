From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 10/19] git-submodule.sh: convert test -a/-o to && and
 ||
Date: Tue, 20 May 2014 16:39:50 +0200
Message-ID: <537B6936.2080101@viscovery.net>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com> <1400593832-6510-11-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: jrnieder@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 16:40:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmlCy-0002ie-Da
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 16:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbaETOj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 10:39:56 -0400
Received: from so.liwest.at ([212.33.55.23]:34112 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753491AbaETOjz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 10:39:55 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WmlCo-00068V-R2; Tue, 20 May 2014 16:39:51 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5B28816613;
	Tue, 20 May 2014 16:39:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <1400593832-6510-11-git-send-email-gitter.spiros@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249686>

Am 5/20/2014 15:50, schrieb Elia Pinto:
>  			# If we don't already have a -f flag and the submodule has never been checked out
> -			if test -z "$subsha1" -a -z "$force"
> +			if test -z "$subsha1" || test -z "$force"

Should not be ||, but &&!

>  		while read mod_src mod_dst sha1_src sha1_dst status sm_path
>  		do
>  			# Always show modules deleted or type-changed (blob<->module)
> -			test $status = D -o $status = T && echo "$sm_path" && continue
> +			{
> +			test "$status" = D ||
> +			test "$status" = T
> +			} &&
> +			echo "$sm_path"
> +			&& continue

As Matthieu noted, this is incorrect. It's not just a style violation,
it's a syntax error. Why did your test runs not hickup on that?

In this case you could even leave the original code structure without
changing the meaning:

			test $status = D || test $status = T && echo "$sm_path" && continue

But a better idiom is
			case "$status" in
			[DT])
				printf '%s\n' "$sm_path" &&
				continue
			esac

> @@ -1233,7 +1238,7 @@ cmd_status()
>  			say "U$sha1 $displaypath"
>  			continue
>  		fi
> -		if test -z "$url" || ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
> +		if test -z "$url" || ! test -d "$sm_path"/.git || test -f "$sm_path"/.git

Wrong grouping. This could be more correct (I didn't test):

		if test -z "$url" ||
			{
				! test -d "$sm_path"/.git &&
				! test -f "$sm_path"/.git
			}

-- Hannes
