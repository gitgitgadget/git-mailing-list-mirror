From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone --dissociate: avoid locking pack files
Date: Wed, 30 Sep 2015 12:42:46 -0700
Message-ID: <xmqqlhbn7ky1.fsf@gitster.mtv.corp.google.com>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
	<20150930192814.GA26154@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Wed Sep 30 21:42:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhNHB-0006t3-FN
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 21:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567AbbI3Tmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 15:42:50 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33952 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbbI3Tms (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 15:42:48 -0400
Received: by padhy16 with SMTP id hy16so49440986pad.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yeg9YaHNpBtyMkqfxTQyr7TM6pBG8BgV7JCkKkhBs9c=;
        b=UCKAN4mQvPVTCYtj7m5kyfuib8jld5aKn/q/hxDqMrpufqGPDxQo0tMY5dlaBM7iMc
         Ik+CCN0H2hy4u1cggqyGIh/utjg4qHsjdi7m8OnkkmgeBfEqoXuDfOcnEBBmUm86OrbC
         Wbe7huho5xJYCOpi6ak+HMI0/2zC0KNlfmiTrR5PUx1dxagii9jAhW1V1kRU3Xe7qkxh
         EEJC/I9XJqKWXRhsSxet7/1cwKSSu3729sOVtmXvU/jogZEr/K3+m4QkLaRW7ldo7cWp
         CJt65REPsxDQW5zasOLWjZHlqxMx/N73dmVVrX99zszRRfDwQaI6vtmPnXV0hFZR4hnm
         i0jQ==
X-Received: by 10.68.137.35 with SMTP id qf3mr6854066pbb.89.1443642167993;
        Wed, 30 Sep 2015 12:42:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2c4a:a656:af73:8140])
        by smtp.gmail.com with ESMTPSA id gv1sm2221514pbc.38.2015.09.30.12.42.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Sep 2015 12:42:47 -0700 (PDT)
In-Reply-To: <20150930192814.GA26154@wheezy.local> (Max Kirillov's message of
	"Wed, 30 Sep 2015 22:28:14 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278861>

Max Kirillov <max@max630.net> writes:

>> +	if (option_dissociate) {
>> +		struct packed_git *p;
>> +
>> +		for (p = packed_git; p; p = p->next) {
>> +			close_pack_windows(p);
>> +			close_pack_index(p);
>> +		}
>>  		dissociate_from_references();
>> +	}
>
> This does not seem to close handles to the pack files
> themseves, does Windows still allow removing the files? I
> probably did not tried that, because I started from handles,
> and discovered mapped files only later.

This is trying to (incompletely) mimic what free_pack_by_name() in
sha1_file.c is doing but for all packs, I think.  I wonder why we do
not have to do other things here that are done over there, like
clearing delta-base-cache, closing pack_fd and decrementing
pack_open_fds, etc.

The right approach may to have a helper in sha1_file.c that closes
and cleans up _all_ packs, and call it from here, instead of having
builtin/clone.c even know about implementation details such as
packed_git is a linked list, etc.

>
>>  	junk_mode = JUNK_LEAVE_REPO;
>>  	err = checkout();
>> diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
>> index ef1779f..2250ef4 100755
>> --- a/t/t5700-clone-reference.sh
>> +++ b/t/t5700-clone-reference.sh
>> @@ -188,5 +188,26 @@ test_expect_success 'clone and dissociate from reference' '
>>  	test_must_fail git -C R fsck &&
>>  	git -C S fsck
>>  '
>> +test_expect_success 'clone, dissociate from partial reference and repack' '
>> +	rm -fr P Q R &&
>> +	git init P &&
>> +	(
>> +		cd P &&
>> +		test_commit one &&
>> +		git repack &&
>> +		test_commit two &&
>> +		git repack
>> +	) &&
>> +	git clone --bare P Q &&
>> +	(
>> +		cd P &&
>> +		git checkout -b second &&
>> +		test_commit three &&
>> +		git repack
>> +	) &&
>> +	git clone --bare --dissociate --reference=P Q R &&
>> +	ls R/objects/pack/*.pack >packs.txt &&
>> +	test_line_count = 1 packs.txt
>> +'
>
> Unless it goes very lowlevel like running lsof of readin
> proc testing this should always pass on Linux, even if the
> issue is not fixed, maybe should be a conditional for
> Windows only?
>
>>  test_done
>> -- 
>> 2.5.3.windows.1.3.gc322723
>> 
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
