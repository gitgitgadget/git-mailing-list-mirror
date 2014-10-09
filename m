From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH v1] rebase -m: Use empty tree base for parentless commits
Date: Thu, 09 Oct 2014 21:55:38 +0200
Message-ID: <5436E83A.7070603@gmail.com>
References: <5434312E.6040407@redhat.com>	<bf0e177fbaac91f8c55526729e580fade9f0f395.1412879523.git.bafain@gmail.com> <xmqq1tqh6p3y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 21:55:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcJoR-0000Kd-O8
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 21:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbaJITzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 15:55:44 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:52426 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbaJITzn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 15:55:43 -0400
Received: by mail-lb0-f182.google.com with SMTP id z11so1781891lbi.41
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 12:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=w5gnKSwSJ52Pj7avJkn6Ow6IHf4eF8CAXOSne6OUiho=;
        b=x2ErbY6nq4l0977gU7QggB05BuqrX1vJ6kBMDlNYdNEH9vGwnDJW+RChRpI8sDBSs3
         c/vNz/yhEXC4BETXK6KzvVWB78c8w7ZLHkcOQ9q2jSMYxgni0Rbf8y1c4yai7e1KTit2
         XyoZXzt5X7kUw3Qdc0Tg5vNCtTvybeN137N/ZmU6OhGY0Gf7XPJRSuOBwAwNdd0wb/be
         mK0NrbqRnf3J78ujiAMXMg8g9KQ4gR0V+exA69dupm/FrUtgVb8oqIrtTJl4hUHSDj0H
         4W43u3KWFRuR2FtNVafGjq5qLw6FgBACEXuY/TzG8oeDJUaowvUI3tGM7xaKOX3+HYjh
         iUPQ==
X-Received: by 10.152.9.37 with SMTP id w5mr20810698laa.28.1412884540280;
        Thu, 09 Oct 2014 12:55:40 -0700 (PDT)
Received: from client.googlemail.com (putty.olf.sgsnet.se. [46.239.119.252])
        by mx.google.com with ESMTPSA id ug7sm1205452lac.48.2014.10.09.12.55.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2014 12:55:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <xmqq1tqh6p3y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 10/09/2014 09:05 PM, Junio C Hamano wrote:
> Fabian Ruch <bafain@gmail.com> writes:
>> diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
>> index d3fb67d..3f754ae 100644
>> --- a/git-rebase--merge.sh
>> +++ b/git-rebase--merge.sh
>> @@ -67,7 +67,13 @@ call_merge () {
>>  		GIT_MERGE_VERBOSITY=1 && export GIT_MERGE_VERBOSITY
>>  	fi
>>  	test -z "$strategy" && strategy=recursive
>> -	eval 'git-merge-$strategy' $strategy_opts '"$cmt^" -- "$hd" "$cmt"'
>> +	base=$(git rev-list --parents -1 $cmt | cut -d ' ' -s -f 2 -)
>> +	if test -z "$base"
>> +	then
>> +		# the empty tree sha1
>> +		base=4b825dc642cb6eb9a060e54bf8d69288fbee4904
>> +	fi
>> +	eval 'git-merge-$strategy' $strategy_opts '"$base" -- "$hd" "$cmt"'
> 
> This looks wrong.

Ok.

> The interface to "git-merge-$strategy" is designed in such a way
> that each strategy should be capable of taking _no_ base at all.

The merge strategies "resolve" and "octopus" seem to refuse to run if no
base is specified. The former silently exits if no bases are given and
the latter dies saying "Unable to find common commit".

> See how unquoted $common is given to git-merge-$strategy in
> contrib/examples/git-merge.sh, i.e.
> 
>     eval 'git-merge-$strategy '"$xopt"' $common -- "$head_arg" "$@"'
> 
> where common comes from
> 
> 	common=$(git merge-base ...)
> 
> which would be empty when you are looking at disjoint histories.
> 
> Also rev-list piped to cut is too ugly to live in our codebase X-<.

Is there a better way to get the parents list from a shell script then?
I stole the construct from git-rebase--interactive.sh which uses it to
check for rewritten parents when preserving merges.

> Wouldn't it be sufficient to do something like this instead?
> 
> 	eval 'git-merge-$strategy' $strategy_opts \
>         	$(git rev-parse --quiet --verify "$cmt^") -- "$hd" "$cmt"

Yes, for the "recursive" strategies this seems to have the exact same
behaviour as it inserts the empty tree in case git-merge-base returns an
empty list. Nice, we would get rid of both the magic number and the cut.

Regards,
   Fabian
