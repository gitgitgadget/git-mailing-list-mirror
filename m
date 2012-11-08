From: Uri Moszkowicz <uri@4refs.com>
Subject: Re: Long clone time after "done."
Date: Thu, 8 Nov 2012 17:35:08 -0600
Message-ID: <CAMJd5AQOH=uu1c3enr5fES+Bw4FHZuP++J7-aCM2B+f_G3YMtg@mail.gmail.com>
References: <CAMJd5AQBbnFqT5xrFuPOEsJevwDE=jUgBVFZ5KqTZk5zv5+NOw@mail.gmail.com>
 <CAMJd5ASL1UPfzUmfXqACuYuGhXQjJLqbsjq7dfpRpF4K-hZFtA@mail.gmail.com>
 <20121108155607.GD15560@sigill.intra.peff.net> <CAMJd5AQ24u11BH6rMAHvR95N4ys6KHfEQKD1uLzr+=TDgN_69Q@mail.gmail.com>
 <20121108203332.GQ15560@sigill.intra.peff.net> <CAMJd5ARLCk_WQTbyLciv0LnrMa_J0YstNsrq-hLYM5DXiO0hLA@mail.gmail.com>
 <20121108221128.GA11186@sigill.intra.peff.net> <CAMJd5ATX5Ru9Orp2t3p39q7tsNRfGjqDYGnf4-9QYNSTpQ-YuA@mail.gmail.com>
 <20121108223319.GA11734@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 00:35:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWbdP-0000ve-GM
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 00:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757266Ab2KHXfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 18:35:30 -0500
Received: from mx71.nozonenet.com ([204.14.89.24]:57405 "EHLO
	mail3.nozonenet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751425Ab2KHXf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 18:35:29 -0500
Received: (qmail 5848 invoked by uid 399); 8 Nov 2012 18:35:29 -0500
Received: from mail-ie0-f174.google.com (smtp@4refs.com@209.85.223.174)
  (de-)crypted with TLSv1: RC4-SHA [128/128] DN=unknown
  by mail3.nozonenet.com with ESMTPSAM; 8 Nov 2012 18:35:29 -0500
X-Originating-IP: 209.85.223.174
X-Sender: smtp@4refs.com
Received: by mail-ie0-f174.google.com with SMTP id k13so5126687iea.19
        for <git@vger.kernel.org>; Thu, 08 Nov 2012 15:35:28 -0800 (PST)
Received: by 10.50.12.138 with SMTP id y10mr70270igb.58.1352417728606; Thu, 08
 Nov 2012 15:35:28 -0800 (PST)
Received: by 10.64.28.231 with HTTP; Thu, 8 Nov 2012 15:35:08 -0800 (PST)
In-Reply-To: <20121108223319.GA11734@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209196>

I tried on the local disk as well and it didn't help. I managed to
find a SUSE11 machine and tried it there but no luck so I think we can
eliminate NFS and OS as significant factors now.

I ran with perf and here's the report:

ESC[31m    69.07%ESC[m              git  /lib64/libc-2.11.1.so
                                         [.] memcpy
ESC[31m    12.33%ESC[m              git
<prefix>/git-1.8.0.rc2.suse11/bin/git                           [.]
blk_SHA1_Block
ESC[31m     5.11%ESC[m              git
<prefix>/zlib/local/lib/libz.so.1.2.5                           [.]
inflate_fast
ESC[32m     2.61%ESC[m              git
<prefix>/zlib/local/lib/libz.so.1.2.5                           [.]
adler32
ESC[32m     1.98%ESC[m              git  /lib64/libc-2.11.1.so
                                         [.] _int_malloc
ESC[32m     0.86%ESC[m              git  [kernel]
                                         [k] clear_page_c

Does this help? Machine has 396GB of RAM if it matters.

On Thu, Nov 8, 2012 at 4:33 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Nov 08, 2012 at 04:16:59PM -0600, Uri Moszkowicz wrote:
>
>> I ran "git cat-file commit some-tag" for every tag. They seem to be
>> roughly uniformly distributed between 0s and 2s and about 2/3 of the
>> time seems to be system. My disk is mounted over NFS so I tried on the
>> local disk and it didn't make a difference.
>>
>> I have only one 1.97GB pack. I ran "git gc --aggressive" before.
>
> Ah. NFS. That is almost certainly the source of the problem. Git will
> aggressively mmap. I would not be surprised to find that RHEL4's NFS
> implementation is not particularly fast at mmap-ing 2G files, and is
> spending a bunch of time in the kernel servicing the requests.
>
> Aside from upgrading your OS or getting off of NFS, I don't have a lot
> of advice.  The performance characteristics you are seeing are so
> grossly off of what is normal that using git is probably going to be
> painful. Your 2s cat-files should be more like .002s. I don't think
> there's anything for git to fix here.
>
> You could try building with NO_MMAP, which will emulate it with pread.
> That might fare better under your NFS implementation. Or it might be
> just as bad.
>
> -Peff
