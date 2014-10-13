From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH v1] rebase -m: Use empty tree base for parentless commits
Date: Mon, 13 Oct 2014 20:43:51 +0200
Message-ID: <543C1D67.80501@gmail.com>
References: <5434312E.6040407@redhat.com>	<bf0e177fbaac91f8c55526729e580fade9f0f395.1412879523.git.bafain@gmail.com> <xmqq1tqh6p3y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 20:44:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdkbA-0003I0-Qc
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 20:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336AbaJMSn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 14:43:57 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:33152 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797AbaJMSn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 14:43:56 -0400
Received: by mail-la0-f42.google.com with SMTP id mk6so7256472lab.29
        for <git@vger.kernel.org>; Mon, 13 Oct 2014 11:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KS/N7yZtFv4i6dXqRRwxWYA828Iry06No+WNhrW1eHI=;
        b=TiAsdzcOPxKdanb9QT5giS7bfKIlq2gz3t6PvezG3ev29mBVCvjChOdrXsBQVeNC1z
         dOwsJYEX7hJ89qo3YNt1Px9zYi4lXiEQz4fJRL0UAphB0HplbbDkSsAfH+pZqkdImMEw
         3VomLCTzLW/oJgPHfWzImt2OhGqFanRV9JmAwAYgGoyJ5NxO0r5Ks+YF+pbwX3Aogn6h
         4rC8VdNDmPJBLAbIIedYGSbTdrUxGACN8mqyWUe1dyE1IZ5HOYhtyNy1RvVNZAyZyGmS
         R5ys/OQKLJOFfUigRv4ip7L/WKm4nYYK8ZJacejZgmy4A9RCmtmsJ49UGYqzDNNxW3Rb
         bQXw==
X-Received: by 10.152.161.231 with SMTP id xv7mr301218lab.43.1413225835013;
        Mon, 13 Oct 2014 11:43:55 -0700 (PDT)
Received: from client.googlemail.com (putty.olf.sgsnet.se. [46.239.119.252])
        by mx.google.com with ESMTPSA id v7sm4809342lbp.44.2014.10.13.11.43.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2014 11:43:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <xmqq1tqh6p3y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano writes:
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
> 
> The interface to "git-merge-$strategy" is designed in such a way
> that each strategy should be capable of taking _no_ base at all.

Ok, but doesn't this use of the git-merge-$strategy interface (as shown
in the example below) apply only to the case where one wants to merge
two histories by creating a merge commit? When a merge commit is being
created, the documentation states that git-merge abstracts from the
commit history considering the _total change_ since a merge base on each
branch.

In contrast, here (i.e., in the case of git-rebase--merge) we care about
how the changes introduced by the _individual commits_ are applied.
Therefore, don't we want to be explicit about the "base" and tell
git-merge-$strategy exactly which changes it should merge into the
current head?

The codebase has always been doing this both for git-rebase--merge and
git-cherry-pick. What leads to the reported bug is that the latter
covers the case where the commit object has no parents but the former
doesn't. Root commits are handled by git-cherry-pick (and should be by
git-rebase--merge) using an explicit "base" for the same reason why
$cmt^ is given.

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

If there are still objections to the patch because of the magic number
and the cut, it might be worth considering an implementation of
git-rebase--merge using git-cherry-pick's merge strategy option.

   Fabian
