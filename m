From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH 4/6] rebase: --rewrite-{refs,heads,tags} to pull refs
 along with branch
Date: Mon, 27 Jun 2011 12:11:39 -0400
Message-ID: <4E08ABBB.9060009@cisco.com>
References: <cover.1309133817.git.greg@quora.com> <c2d11ffe876a540b6fad46e2ecc57a24018cfb73.1309133817.git.greg@quora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Greg Price <price@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Jun 27 18:12:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbEQT-0007lP-MW
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 18:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545Ab1F0QMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 12:12:37 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:37621 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301Ab1F0QMf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 12:12:35 -0400
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jun 2011 12:12:35 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1709; q=dns/txt;
  s=iport; t=1309191155; x=1310400755;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=kdHlliRKc0cEXBrUB93AqnWP1QiA38Gva1TYmz2CzAU=;
  b=fOy/3R4/N/wCuhEf5GENgUEbgQT4Mq+VmaSuJKNj6V220+u677o8cI1H
   mWpBSslr+hjHZlFFL5X2WzSpboUqfzm0JPiROUKtlhpfYfqsKcjrCuXiA
   hIKy6Z6N4MyOqMg0Wg2fA5VSk9dkHU3uQTlPEtwhpsH6EG8LlN6/Pq39Q
   s=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAEmqCE6tJV2c/2dsb2JhbABSEKced6sGnXKGMASSA4RuinZT
X-IronPort-AV: E=Sophos;i="4.65,432,1304294400"; 
   d="scan'208";a="288387634"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by sj-iport-4.cisco.com with ESMTP; 27 Jun 2011 16:11:34 +0000
Received: from [64.100.104.120] (dhcp-64-100-104-120.cisco.com [64.100.104.120])
	by rcdn-core-5.cisco.com (8.14.3/8.14.3) with ESMTP id p5RGBX09018889;
	Mon, 27 Jun 2011 16:11:33 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <c2d11ffe876a540b6fad46e2ecc57a24018cfb73.1309133817.git.greg@quora.com>
X-Enigmail-Version: 1.1.2
X-TagToolbar-Keys: D20110627121139129
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176350>

On 11/18/2009 06:51 PM, Greg Price wrote:
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 1bfe6a8..7c365ab 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -38,6 +38,9 @@ git-rebase [-i] --continue | --abort | --skip
>  v,verbose!         display a diffstat of what changed upstream
>  q,quiet!           be quiet. implies --no-stat
>  onto=!             rebase onto given branch instead of upstream
> +rewrite-heads!     rewrite intermediate heads on branch
> +rewrite-tags!      rewrite intermediate tags on branch
> +rewrite-refs=!     rewrite intermediate refs matching pattern
>  p,preserve-merges! try to recreate merges instead of ignoring them
>  s,strategy=!       use the given merge strategy
>  no-ff!             cherry-pick all commits, even if unchanged
> @@ -96,6 +99,7 @@ state_dir=
>  # One of {'', continue, skip, abort}, as parsed from command line
>  action=
>  preserve_merges=
> +rebase_refs=
>  autosquash=
>  test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
I think you meant to spell that "rewrite_refs=" instead of "rebase_refs=".

>  
> @@ -246,6 +250,19 @@ do
>  		strategy="$1"
>  		do_merge=t
>  		;;
> +	--rewrite-refs)
> +		shift
> +		rewrite_refs="$rewrite_refs $1"
> +		test -z "$interactive_rebase" && interactive_rebase=implied
> +		;;
> +	--rewrite-heads)
> +		rewrite_refs="$rewrite_refs refs/heads"
> +		test -z "$interactive_rebase" && interactive_rebase=implied
> +		;;
> +	--rewrite-tags)
> +		rewrite_refs="$rewrite_refs refs/tags"
> +		test -z "$interactive_rebase" && interactive_rebase=implied
> +		;;
>  	-n)
>  		diffstat=
>  		;;

Then it matches the rest of the commit.

Phil
