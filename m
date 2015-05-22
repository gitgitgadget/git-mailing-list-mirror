From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Troubleshoot clone issue to NFS.
Date: Fri, 22 May 2015 07:16:54 +0700
Message-ID: <CACsJy8BULBJ=cL1+4TFX_7tYSCFL3MNEz1Ay0YGqx8W_8=nwAg@mail.gmail.com>
References: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
 <CACsJy8Cs6GcRQ-kgnSqwxP4MPHfds9qiir1_O1hc5cZ+0QP-EA@mail.gmail.com> <7FAE15F0A93C0144AD8B5FBD584E1C5519759641@C111KXTEMBX51.ERF.thomson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: steve.norman@thomsonreuters.com
X-From: git-owner@vger.kernel.org Fri May 22 02:17:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvaeY-0000d7-6c
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 02:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015AbbEVAR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 20:17:26 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33515 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755969AbbEVARZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 20:17:25 -0400
Received: by igbpi8 with SMTP id pi8so24187396igb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 17:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=I3t6BFpWKzRR5uWDuLQHPBXRiBmXc321kSG5cMGObjk=;
        b=bXXaEwPk7RJVjTFw41sHHW3bY+eJdksXxCBKdg4aowMsRfil8c9H6sbDG3/CJBsguW
         8RL9xQQAK85av4NLLlxDU4GyaWdMELHjg2G5pOy7OGuIRxDkmrqwCH1skUu3RbHqvgvc
         BxDtLZoM49toIU/FCRBPJnzUPxWK9fi2XJ6NfYd1xWi1AUjcEVIgbS6ADkcFpZG2FYgd
         560cMJPIKeXeKeH6jTbWvU6JYEATpi8si0iMYjHmmg61BU7Th9iIzqCcBidAE/T/E/29
         f+z/FsOOmLXSA6jsI1LNk8cERQkYZF0neX3uV4Y2yxS/Wfgnqzvh8fc041VKFeJmFbrZ
         wDvg==
X-Received: by 10.42.200.8 with SMTP id eu8mr6387100icb.65.1432253844492; Thu,
 21 May 2015 17:17:24 -0700 (PDT)
Received: by 10.107.181.136 with HTTP; Thu, 21 May 2015 17:16:54 -0700 (PDT)
In-Reply-To: <7FAE15F0A93C0144AD8B5FBD584E1C5519759641@C111KXTEMBX51.ERF.thomson.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269675>

On Thu, May 21, 2015 at 10:53 PM,  <steve.norman@thomsonreuters.com> wrote:
> On Thu, May 21, 2015a at 9:31 PM, Duy Nguyen [mailto:pclouds@gmail.com], did scribble:
>> > In case an object is not found pack directory is re-read again, which
>> > might cause some increased load on nfs.
>> > has_sha1_file() not finding the object should not happen often..
>>
>> That last statement is probably very wrong, but I have no time to test this
>> now. In index-pack, there is a has_sha1_file() for file collision test. That call
>> on a fresh clone would fail for _every_ object in the
>> (new) pack and the cost of reprepare pack files could be sky high...
>
> Confirmed with bisect that it is that commit:
>
> ~/git $ git bisect bad
> 45e8a7487339c0f0ea28244ef06851308d07387c is the first bad commit
> commit 45e8a7487339c0f0ea28244ef06851308d07387c
> Author: Jeff King <peff@peff.net>
> Date:   Fri Aug 30 15:14:13 2013 -0400
>
> I have an strace for that build but it is 153 megabytes so I probably shouldn't attach, but the call summary is below:
>
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
>  93.71   39.670084         103    386835      2171 futex
>   3.16    1.338572           7    190550       181 open
>   1.56    0.658786          18     37450         3 read
>   0.62    0.262740           2    141390           pread
>   0.41    0.171526           5     37313         9 write
>   0.18    0.076166           0    188859    188835 access
>   0.11    0.047941           0    374712           getdents
>   0.11    0.045174          11      4067      3910 lstat
>   0.06    0.023630           0    190425           close
>   0.04    0.017995           6      2975         1 fstat
>   0.02    0.007668        1917         4           wait4
>   0.01    0.004150           1      5065           madvise
>   0.01    0.003548           0     16090         8 recvfrom
>   0.00    0.001872           0      8048           select
>   0.00    0.001870          11       173         1 mkdir
>   0.00    0.000872           0      8055           poll
>   0.00    0.000262          22        12        12 readlink
>   0.00    0.000185           0      1217      1146 stat
>   0.00    0.000158           0       457           mprotect
>   0.00    0.000074           0       298           mmap
>   0.00    0.000069           1       109         8 rt_sigreturn
>   0.00    0.000047           0       159           brk
>   0.00    0.000021           1        17           getcwd
>   0.00    0.000000           0        42         3 lseek
>   0.00    0.000000           0        92           munmap
>   0.00    0.000000           0        35           rt_sigaction
>   0.00    0.000000           0         9           rt_sigprocmask
>   0.00    0.000000           0         8         3 ioctl
>   0.00    0.000000           0        11           pipe
>   0.00    0.000000           0         3           dup
>   0.00    0.000000           0         8           dup2
>   0.00    0.000000           0         6           setitimer
>   0.00    0.000000           0        11         1 socket
>   0.00    0.000000           0         8         7 connect
>   0.00    0.000000           0         8           sendto
>   0.00    0.000000           0         2           recvmsg
>   0.00    0.000000           0         1           bind
>   0.00    0.000000           0         1           getsockname
>   0.00    0.000000           0         3         1 getpeername
>   0.00    0.000000           0         2           setsockopt
>   0.00    0.000000           0         2           getsockopt
>   0.00    0.000000           0         8           clone
>   0.00    0.000000           0         5           execve
>   0.00    0.000000           0         3           uname
>   0.00    0.000000           0       100           fcntl
>   0.00    0.000000           0         2           fsync
>   0.00    0.000000           0        13           chdir
>   0.00    0.000000           0        14           rename
>   0.00    0.000000           0         2           link
>   0.00    0.000000           0         5           unlink
>   0.00    0.000000           0         2           symlink
>   0.00    0.000000           0         9           chmod
>   0.00    0.000000           0         6           getrlimit
>   0.00    0.000000           0         2           sysinfo
>   0.00    0.000000           0         8           getuid
>   0.00    0.000000           0         1           statfs
>   0.00    0.000000           0         5           arch_prctl
>   0.00    0.000000           0         1           gettid
>   0.00    0.000000           0         5           set_tid_address
>   0.00    0.000000           0        13           set_robust_list
> ------ ----------- ----------- --------- --------- ----------------
> 100.00   42.333410               1594736    196300 total
>
> Is there anything else I can provide or test?

In builtin/index-pack.c, replace the line "collision_test_needed =
has_sha1_file(sha1);" with "collision_test_needed = 0;". Security is
compromised but for this test it should be ok. Then clone again. I
hope the new number gets down close to v1.8.4.1.
-- 
Duy
