X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: [PATCH] clear error message for clone a gitweb URL
Date: Thu, 09 Nov 2006 09:49:09 +0800
Message-ID: <45528915.8090608@gmail.com>
References: <4551864D.3010301@gmail.com> <7v7iy5sma9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 9 Nov 2006 01:51:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ntLTCIxwNOM8+oqZ+3F4LNuIGkgaGU6lkhUlBiKUlQCHviMkiaYSI4ORLpbiHJO43/5uK3mp0m93U6rBBi0G9ksxlJA6XvkrBrsQTssNea6nem9LXw6iYv82O0GxKLvhu5qBLSZ1/BVUsVAouCCr28Y3MYD1Lrk0KRRk7oSW5lI=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
In-Reply-To: <7v7iy5sma9.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31174>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghz3b-0007JP-Og for gcvg-git@gmane.org; Thu, 09 Nov
 2006 02:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423732AbWKIBuP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 20:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161783AbWKIBuP
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 20:50:15 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:3122 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1161782AbWKIBuN
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 20:50:13 -0500
Received: by wx-out-0506.google.com with SMTP id h27so39406wxd for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 17:50:13 -0800 (PST)
Received: by 10.70.74.6 with SMTP id w6mr570360wxa.1163037012933; Wed, 08 Nov
 2006 17:50:12 -0800 (PST)
Received: from ?192.168.88.85? ( [221.122.47.70]) by mx.google.com with ESMTP
 id 13sm390137wrl.2006.11.08.17.50.10; Wed, 08 Nov 2006 17:50:12 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Liu Yubao <yubao.liu@gmail.com> writes:
> 
>> When clone a gitweb URL, git reports "Can't lock ref", it's not clear for users,
>> this patch adds clear error message for this case.
>>
>> diff --git a/fetch.c b/fetch.c
>> index c426c04..40c5183 100644
>> --- a/fetch.c
>> +++ b/fetch.c
>> @@ -266,6 +266,14 @@ int pull(int targets, char **target, con
>>  		if (!write_ref || !write_ref[i])
>>  			continue;
>>  
>> +		if (*write_ref[i] == '\0') {
>> +			if (strncmp(write_ref_log_details, "http", 4) == 0)
>> +				error("Can't feed empty ref, seems you are fetching from a gitweb URL, "
>> +				      "check it in web browser for git URL.");
>> +			else
>> +				error("Can't feed empty ref");
>> +			goto unlock_and_fail;
> 
> You might have got that error by feeding an URL for gitweb, but
> I do not think the code, even with your additions, knows enough
> to tell that the user's mistake isn't other kinds of errors.
> 
> I am afraid that it would cause the user to waste time going
> wild goose chase if you say "seems you are...".  The phrasing
> makes it sound as if the tool _knows_ with some certainty that
> it is more plausible cause of the error than other kinds, while
> it certainly doesn't.
> 

I agree with you, it's not a fault of fetch.c.

> I think the reason it does not notice the breakage much earlier
> is that git-clone does not notice that gitweb URL gives nonsense
> to requests to "http://host/gitweb.cgi/$project/info/refs", so
> your patch to git-clone.sh is probably touching the right place,
> but I still feel the wording is a bit too strong and definitive
> than it should be.
> 
> Perhaps...
> 
> diff --git a/git-clone.sh b/git-clone.sh
> index 3f006d1..7ae69d9 100755
> --- a/git-clone.sh
> +++ b/git-clone.sh
> @@ -46,15 +46,18 @@ Perhaps git-update-server-info needs to
>  	do
>  		name=`expr "z$refname" : 'zrefs/\(.*\)'` &&
>  		case "$name" in
> -		*^*)	continue;;
> -		esac
> +		*^*)	continue ;;
> +		'')	false ;;
> +		esac &&
>  		if test -n "$use_separate_remote" &&
>  		   branch_name=`expr "z$name" : 'zheads/\(.*\)'`
>  		then
>  			tname="remotes/$origin/$branch_name"
>  		else
>  			tname=$name
> -		fi
> +		fi || {
> +			die "info/refs has nonsense $sha1 $refname, are you pulling from the right repository URL?"
> +		}
>  		git-http-fetch -v -a -w "$tname" "$name" "$1/" || exit 1
>  	done <"$clone_tmp/refs"
>  	rm -fr "$clone_tmp"
> 
It works well. Maybe it's better to say "info/refs has nonsense sha1($sha1) 
