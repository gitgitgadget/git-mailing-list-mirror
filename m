From: Raja R Harinath <harinath@hurrynot.org>
Subject: Re: [PATCH] Use dev_t for device id (st_dev) from stat in setup_git_directory_gently()
Date: Wed, 14 Jul 2010 06:38:13 +0530
Message-ID: <878w5elvk2.fsf@hariville.hurrynot.org>
References: <1279011720-21424-1-git-send-email-harinath@hurrynot.org>
	<7voceb2jaw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 03:20:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYqeE-0002HU-FU
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 03:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874Ab0GNBUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 21:20:25 -0400
Received: from lo.gmane.org ([80.91.229.12]:57554 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752873Ab0GNBUY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 21:20:24 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OYqe4-0002Ew-GU
	for git@vger.kernel.org; Wed, 14 Jul 2010 03:20:20 +0200
Received: from 117.192.131.222 ([117.192.131.222])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 03:20:20 +0200
Received: from harinath by 117.192.131.222 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 03:20:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 117.192.131.222
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Cancel-Lock: sha1:hpc3ha7PKv0JGCCZWSaDfD7GUCg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150955>

Hi,

Junio C Hamano <gitster@pobox.com> writes:

> Raja R Harinath <harinath@hurrynot.org> writes:
>
>> The original declaration was int, which seems to cause trouble on my
>> machine.  It causes spurious "filesystem boundary" errors when running
>> the testsuite.  The cause seems to be
>>
>>   $ stat -c%d .
>>   2147549952
>>
>> which is too large for a 32-bit int type.
>>
>> Using the correct type, dev_t, solves the issue.  (Because I'm
>> paranoid and forgetful, I checked -- yes, Unix v7 had dev_t.)
>>
>> Other uses of st_dev seem to be reasonably safe.   fill_stat_cache_info
>> truncates it to an 'unsigned int', but that value seems to be used only
>> to validate the cache, and only if USE_STDEV is defined.
>> ---
>
> Makes sense; thanks.
>
> Sign-off?

Signed-off-by: Raja R Harinath <harinath@hurrynot.org>

Do I need to resend?

>>  setup.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/setup.c b/setup.c
>> index 7e04602..87c21f0 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -323,7 +323,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
>>  	const char *gitdirenv;
>>  	const char *gitfile_dir;
>>  	int len, offset, ceil_offset, root_len;
>> -	int current_device = 0, one_filesystem = 1;
>> +	dev_t current_device = 0;
>> +	int one_filesystem = 1;
>>  	struct stat buf;
>>  
>>  	/*
>> -- 
>> 1.7.2.rc2.11.g03e33
