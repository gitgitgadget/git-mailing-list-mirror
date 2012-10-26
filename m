From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH 1/2] Teach --recursive to submodule sync
Date: Fri, 26 Oct 2012 13:19:58 -0400
Message-ID: <508AC63E.6010502@cisco.com>
References: <507EF86C.4050807@web.de> <1351034141-2641-1-git-send-email-hordp@cisco.com> <1351034141-2641-2-git-send-email-hordp@cisco.com> <5089BBE1.3040107@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, phil.hord@gmail.com, Jeff King <peff@peff.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Oct 26 19:30:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRnjX-0004mO-6T
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 19:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965475Ab2JZR35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 13:29:57 -0400
Received: from bgl-iport-2.cisco.com ([72.163.197.26]:21499 "EHLO
	bgl-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965441Ab2JZR34 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 13:29:56 -0400
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Oct 2012 13:29:55 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3160; q=dns/txt; s=iport;
  t=1351272596; x=1352482196;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=Ow1hKWpHmMvpj2dRgTr9vPlF61+o0D8P+U5W25/iSoU=;
  b=ioLX8vRy9MgjwUf/lzn7re4L3ekEHF1wVMUcryP90If9DQbsGwIiyu7X
   3BwtsMY6+X7LxcYQeG0PjLs8d8uCiXVNIgxy1SHdt1QnqW6p3+qsjxiSz
   1C1NOkYuPMEz3d9wfe4+GcEQgbaFt5tFfrovEfWYwRrvtdHDDmZlndIIV
   Q=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ap4EAMDEilBIo8UY/2dsb2JhbABEw0eCHgEBAQQSAWUBEAsYCRYPCQMCAQIBRQYNAQUCAQEeh2SdA6AYi3EVhlkDlXOFZohtgWuDC4FAHw
X-IronPort-AV: E=Sophos;i="4.80,654,1344211200"; 
   d="scan'208";a="19688797"
Received: from vla196-nat.cisco.com (HELO bgl-core-2.cisco.com) ([72.163.197.24])
  by bgl-iport-2.cisco.com with ESMTP; 26 Oct 2012 17:20:04 +0000
Received: from [64.100.104.96] (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by bgl-core-2.cisco.com (8.14.5/8.14.5) with ESMTP id q9QHK2CW031033;
	Fri, 26 Oct 2012 17:20:02 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <5089BBE1.3040107@web.de>
X-Enigmail-Version: 1.4.5
X-TagToolbar-Keys: D20121026131958307
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208467>


Jens Lehmann wrote:
> Am 24.10.2012 01:15, schrieb Phil Hord:
>> The submodule sync command was somehow left out when
>> --recursive was added to the other submodule commands.
>>
>> Teach sync to handle the --recursive switch by recursing
>> when we're in a submodule we are sync'ing.
>>
>> Change the report during sync to show submodule-path
>> instead of submodule-name to be consistent with the other
>> submodule commands and to help recursed paths make sense.
>>
>> Signed-off-by: Phil Hord <hordp@cisco.com>
> This makes perfect sense to me. Two things though:
>
> First it would be nice to initialize orig_flags like all the other
> call sites do:
>
> @@ -1003,6 +1003,7 @@ cmd_status()
>  #
>  cmd_sync()
>  {
> +	orig_flags=
>  	while test $# -ne 0
>  	do
>  		case "$1" in
>
>> ---
>>  git-submodule.sh | 18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index ab6b110..6dd2338 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -11,7 +11,7 @@ USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <r
>>     or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
>>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
>>     or: $dashless [--quiet] foreach [--recursive] <command>
>> -   or: $dashless [--quiet] sync [--] [<path>...]"
>> +   or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
>>  OPTIONS_SPEC=
>>  . git-sh-setup
>>  . git-sh-i18n
>> @@ -1008,7 +1008,9 @@ cmd_sync()
>>  		case "$1" in
>>  		-q|--quiet)
>>  			GIT_QUIET=1
>> -			shift
>> +			;;
>> +		--recursive)
>> +			recursive=1
>>  			;;
>>  		--)
>>  			shift
>> @@ -1021,6 +1023,8 @@ cmd_sync()
>>  			break
>>  			;;
>>  		esac
>> +		orig_flags="$orig_flags $(git rev-parse --sq-quote "$1")"
>> +		shift
>>  	done
>>  	cd_to_toplevel
>>  	module_list "$@" |
>> @@ -1051,7 +1055,7 @@ cmd_sync()
>>  
>>  		if git config "submodule.$name.url" >/dev/null 2>/dev/null
>>  		then
>> -			say "$(eval_gettext "Synchronizing submodule url for '\$name'")"
>> +			say "$(eval_gettext "Synchronizing submodule url for '\$prefix\$sm_path'")"
>>  			git config submodule."$name".url "$super_config_url"
>>  
>>  			if test -e "$sm_path"/.git
>> @@ -1061,6 +1065,14 @@ cmd_sync()
>>  				cd "$sm_path"
>>  				remote=$(get_default_remote)
>>  				git config remote."$remote".url "$sub_origin_url"
>> +
>> +				if test -n "$recursive"
>> +				then
>> +				(
>> +					prefix="$prefix$sm_path/"
>> +					eval cmd_sync "$orig_args"
> This should read 'eval cmd_sync "$orig_flags"'. I think you copied that
> from cmd_status(), where this is also incorrect, I just sent a patch to
> correct that one.

Yes, thanks for catching that.  I think I should add a test for that
except I notice that sync doesn't take any other flags useful for passing.

v2 is on the way.

>> +				)
>> +			fi
>>  			)
>>  			fi
>>  		fi
>>
