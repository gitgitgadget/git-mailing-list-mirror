From: Peter Voss <info@petervoss.org>
Subject: Re: Submodule using different repository URLs
Date: Mon, 13 Jul 2009 15:33:10 +0200
Message-ID: <9B026405-27EB-4D48-8D08-461D213453C3@petervoss.org>
References: <5BE6F3DC-4B00-4D84-8D0E-41057735483F@petervoss.org> <64652870-CF95-49A7-920A-0F9A6C202B40@petervoss.org> <200907131428.43652.johan@herland.net> <200907131443.25719.johan@herland.net>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jul 13 15:33:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQLem-0005ha-Au
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 15:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911AbZGMNdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 09:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755915AbZGMNdP
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 09:33:15 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:38351 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911AbZGMNdP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 09:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1247491991; l=2384;
	s=domk; d=petervoss.org;
	h=References:Date:Subject:Mime-Version:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:To:From:Cc:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=WI87tWIy0SdMBHKV4QgNOLFTeFA=;
	b=hQwMTsRHrBgTCOHjoQcj1MHpv36SQMqraJAnxnvQM4cw1ZO3LP7xgw0HzGIcAbilfnM
	mmMl/avhmZN8z/23vsIfER2HIx1BXowqiNZPNcMOCE6F85MGv1CC4CyECvvTO3eMWsO1L
	7jatab7gxEsDrFCc0+VNK9pJGwoqKFTcUAc=
X-RZG-AUTH: :JWICemC4fusRF4tAhweiuU4SRqyWF3gXMlHyMhzObhKwDIReNIDrirxOEFeT
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.108]
	(ip-62-143-242-232.unitymediagroup.de [62.143.242.232])
	by post.strato.de (mrclete mo52) (RZmta 18.49)
	with ESMTP id B01cc9l6DCxwcZ ; Mon, 13 Jul 2009 15:33:11 +0200 (MEST)
In-Reply-To: <200907131443.25719.johan@herland.net>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123191>

Hi Johan,

On 13.07.2009, at 14:43, Johan Herland wrote:

> On Monday 13 July 2009, Johan Herland wrote:
>> On Monday 13 July 2009, Peter Voss wrote:
>>> On 13.07.2009, at 12:59, Johan Herland wrote:
>>>> You might be able to pull this off using relative submodule URLs.
>>>
>>> That's a good hint. Unfortunately I can't use this to go up 2
>>> directories. I.e. I can't get from
>>> git@github.com:xxx/mymodule.git
>>> to
>>> git@github.com:yyy/foo.git
>>>
>>> Using the relative URL ../../yyy/foo.git leads to the result:
>>> Clone of 'git@github.com:xxx/yyy/foo.git' into submodule path 'foo'
>>> failed
>>>
>>> So I basically cannot replace the xxx part.
>>
>> This is due to a small bug in git-submodule.sh. In the
>> resolve_relative_url() function, when repeatedly unwrapping '../'s
>> from $url in the while loop, the line remoteurl="${remoteurl%/*}"
>> removes everything _after_ the last slash, which does not work for
>> the git@github.com:xxx part of your URL.
>>
>> This should be relatively easy to fix, although maybe not as
>> straightforwardly trivial as it might seem at first sight.
>>
>> I don't have the time to look into this now, so feel free to take a
>> stab at it.
>
> Here's a first stab at it (TOTALLY UNTESTED). Obviously it needs a
> testcase (typically in t7400-submodule-basic.sh) as well.

And I thought you didn't have time. ;-) Thanks for this patch. I will  
test this out tomorrow.

Thanks,
--Peter

>
>
> Have fun! :)
>
> ...Johan
>
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index ebed711..7d8f7a7 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -27,12 +27,19 @@ resolve_relative_url ()
> 		die "remote ($remote) does not have a url defined in .git/config"
> 	url="$1"
> 	remoteurl=${remoteurl%/}
> +	sep="/"
> 	while test -n "$url"
> 	do
> 		case "$url" in
> 		../*)
> 			url="${url#../}"
> -			remoteurl="${remoteurl%/*}"
> +			newremoteurl="${remoteurl%/*}"
> +			if test "$newremoteurl" = "$remoteurl" -a "$sep" = "/"
> +			then
> +				newremoteurl="${remoteurl%:*}"
> +				sep=":"
> +			fi
> +			remoteurl="$newremoteurl"
> 			;;
> 		./*)
> 			url="${url#./}"
> @@ -41,7 +48,7 @@ resolve_relative_url ()
> 			break;;
> 		esac
> 	done
> -	echo "$remoteurl/${url%/}"
> +	echo "$remoteurl$sep${url%/}"
> }
>
> #
>
>
> -- 
> Johan Herland, <johan@herland.net>
> www.herland.net
