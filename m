From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] git-count-objects: Fix a disk-space under-estimate on
 Cygwin
Date: Tue, 24 Nov 2009 20:07:41 +0000
Message-ID: <4B0C3D0D.60309@ramsay1.demon.co.uk>
References: <4B059280.40902@ramsay1.demon.co.uk> <7vd43d8yva.fsf@alter.siamese.dyndns.org> <7vlji17i02.fsf@alter.siamese.dyndns.org> <4B072D98.6020101@ramsay1.demon.co.uk> <7veinrnym4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 21:10:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND1io-0007ig-Uc
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 21:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932869AbZKXUJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 15:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932903AbZKXUJf
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 15:09:35 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:65508 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932541AbZKXUJb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Nov 2009 15:09:31 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1ND1hg-00045f-aT; Tue, 24 Nov 2009 20:09:37 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7veinrnym4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133590>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> I haven't tried this patch, but I think you may need to add something like
>> the following (*not tested*):
>>
>> --- >8 ---
>> diff --git a/compat/cygwin.c b/compat/cygwin.c
>> index b4a51b9..7e9edec 100644
>> --- a/compat/cygwin.c
>> +++ b/compat/cygwin.c
>> @@ -53,6 +53,7 @@ static int do_stat(const char *file_name, struct stat *buf, stat_fn_t cygstat)
>>  		buf->st_size = (off_t)fdata.nFileSizeLow;
>>  #endif
>>  		buf->st_blocks = size_to_blocks(buf->st_size);
>> +		buf->st_blksize = 512;
>>  		filetime_to_timespec(&fdata.ftLastAccessTime, &buf->st_atim);
>>  		filetime_to_timespec(&fdata.ftLastWriteTime, &buf->st_mtim);
>>  		filetime_to_timespec(&fdata.ftCreationTime, &buf->st_ctim);
>> --- >8 ---
> 
> Doesn't this contradict with everything you said?

Err... no :-D

Note that my suggested addition to your patch is in the core.filemode == false
code path, and so does not affect the "disk-space under-estimate" problem at all.

[To be clear: the "disk-space under-estimate" problem only happens when
core.filemode == true and the regular cygwin lstat()/stat() functions are used.
When core.filemode == false, the code in compat/cygwin.c (namely cygwin_lstat()
and cygwin_stat()) will (most likely) be called instead. These functions use
WIN32 api calls to implement equivalent, but presumably faster, versions of the
stat functions]

> You are forcing st_blksize to 512 but still return the same old st_blocks;
> I do not understand what that would achieve.

Well, as I said, I haven't tested your patch, or my suggested addition, so I could
well be wrong... but what I aimed to achieve was to:

    - avoid "undefined behaviour" in on_disk_bytes(), since the value in
      st_blksize would otherwise be undefined (ie whatever happened to be
      on the stack-frame of the count_objects() function).
    - initialize the st_blksize field with a value consistent with the
      st_blocks field, which is derived from the st_size field, as the
      number of 512-byte blocks. (see the context line just before the
      + line in the above diff, along with the size_to_blocks macro)
    - return the same answer from this code as before.

Note that the answer returned from this core.filemode == false code path
is different to the core.filemode == true code path. Which is why I *slightly*
prefer my original patch.

HTH.

ATB,
Ramsay Jones
