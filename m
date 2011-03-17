From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git stash: status from current dir not top dir?
Date: Thu, 17 Mar 2011 19:13:26 +0100
Message-ID: <4D824F46.70107@gmail.com>
References: <4D7A8AC9.1030506@gmail.com> <20110311223232.GA21410@sigill.intra.peff.net> <4D7B358A.5010101@gmail.com> <7v1v2agnww.fsf@alter.siamese.dyndns.org> <4D7E7065.20908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:13:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0Hhe-0007a7-Hy
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 19:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474Ab1CQSNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 14:13:38 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51875 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498Ab1CQSNg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 14:13:36 -0400
Received: by fxm17 with SMTP id 17so2965566fxm.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 11:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=d8QJRE5iUJHjrhpVLR9sfFjnQjq/nHAy7IrKSsaQez0=;
        b=s10+eEcY4GSxOVtDkrXrvrJqFeuTYPykWXS0I3Yc+3pLv943HT9ePRVo8rqmYjUKfR
         UxtEgd5C4jbIPeo2fchhHXp5YsuVYF84pYccPIyJhveHerEhniweEGu2/62Da9nds47t
         XKIhcVk9ZzFltXNyspuRRgEVZauL97rE6C0fQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Hb5Yehm/wANCv8e48YmqDulqfnWare7dLM1ZHBZNvvSkbDwXISFKFvzmfDrtTesrM8
         b6c5RzdVDrFEhwU1CpL5H7uUo/pHmYxI/QlqiaNEdO9jhS4gM5JVcTHPx9kdbXe4hjkV
         0RxrTdUPxa9pQxrnNr9adzy6+SmINCvEHDUbc=
Received: by 10.223.56.220 with SMTP id z28mr112221fag.11.1300385615011;
        Thu, 17 Mar 2011 11:13:35 -0700 (PDT)
Received: from [192.168.1.101] (abkz18.neoplus.adsl.tpnet.pl [83.7.193.18])
        by mx.google.com with ESMTPS id e23sm1054141faa.18.2011.03.17.11.13.32
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Mar 2011 11:13:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <4D7E7065.20908@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169252>

W dniu 14.03.2011 20:45, Piotr Krukowiecki pisze:
> Right. Wrote a test but it fails mysteriously. Looks like a debug output
> is added when test is run as "sh t3903-stash.sh" (the "Merging Version" etc).
> No such output when "git apply" is run by hand.

To recap the problem was that "git stash apply" run during tests printed some
debug messages as shown below. In result I could not compare its output with
expected "git status" output.


> Not sure what to do with it?

I found out it was caused by 
    GIT_MERGE_VERBOSITY=5
in test-lib.sh

It was introduced in 8d0fc48f2730 with comment:
    Its really nice to be able to run a test with -v and automatically
    see the "debugging" dump from merge-recursive, especially if we
    are actually trying to debug merge-recursive.

Now I don't know how should I handle this:

    1. unset it just before "git stash apply" in my test
       A safe, local change

    2. remove it from test-lib.sh
       The variable changed git behaviour - might impact tests, should it be
       set by default?

    3. add new option in test-lib.sh to set it (--merge-verbosity?)
       Also looks safe, but still some tests would fail with it
       (which would be mentioned in the option documentation)

    4. change test-lib.sh to set it only when --verbose/--debug is passed
       This seems to be the intention, but test results would be different
       with those options (some tests would fail)!

First three choices look more or less sensible.


> With --verbose I see:
> 
> [...]
> [master b27a2bc] subdir
>  Author: A U Thor <author@example.com>
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 subdir/subfile1
> Saved working directory and index state WIP on master: b27a2bc subdir
> HEAD is now at b27a2bc subdir
> --- ../output	2011-03-14 19:39:42.473685001 +0000
> +++ ../expect	2011-03-14 19:39:42.489685001 +0000
> @@ -1,9 +1,3 @@
> -Merging Version stash was based on with Stashed changes
> -Merging:
> -virtual Version stash was based on
> -virtual Stashed changes
> -found 1 common ancestor(s):
> -virtual 13419d0b4f5b097f61dde4c911de99a154f8286f
>  # On branch master
>  # Changes not staged for commit:
>  #   (use "git add <file>..." to update what will be committed)
> not ok - 41 stash apply shows status same as git status (relative to current directory)
> 
> 
> ---8<---
> From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
> Date: Mon, 14 Mar 2011 20:19:36 +0100
> Subject: [PATCH] Add test: git stash shows status relative to current dir
> 
> 
> Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
> ---
>  t/t3903-stash.sh |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 6fd560c..3682f1c 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -556,4 +556,19 @@ test_expect_success 'stash branch should not drop the stash if the branch exists
>  	git rev-parse stash@{0} --
>  '
>  
> +test_expect_success 'stash apply shows status same as git status (relative to current directory)' '
> +	git stash clear &&
> +	echo 1 > subdir/subfile1 &&
> +	echo 2 > subdir/subfile2 &&
> +	git add subdir/subfile1 &&
> +	git commit -m subdir &&
> +	cd subdir &&
> +	echo x > subfile1 &&
> +	echo x > ../file &&
> +	git stash &&
> +	git stash apply > ../output &&
> +	git status > ../expect &&
> +	test_cmp ../output ../expect
> +'
> +
>  test_done


-- 
Piotr Krukowiecki
