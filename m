From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Tue, 19 Feb 2013 08:16:58 -0500
Message-ID: <CAM9Z-nnWE9LeHaefKdju_p=_he7aJcOunGf1Ms6K=vEXgxS25w@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
	<7vehgqzc2p.fsf@alter.siamese.dyndns.org>
	<7va9rezaoy.fsf@alter.siamese.dyndns.org>
	<7vsj56w5y9.fsf@alter.siamese.dyndns.org>
	<9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
	<CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
	<CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
	<CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
	<CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
	<CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 14:17:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7n4V-00032E-W5
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 14:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758164Ab3BSNQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 08:16:59 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:48117 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757410Ab3BSNQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 08:16:58 -0500
Received: by mail-ie0-f178.google.com with SMTP id c13so8228997ieb.23
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 05:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=469ubzNFkm3TCP1cQpEs4nIBgtXxQONqzH6UgZj0BiA=;
        b=hqrb9d/cfiJj+vGFE2Ac9v/B/mGmuOyuXKpMBdEj/zateaamWihUtVAMHxt9EXURJO
         NLk0N98p5/AcgAZXGr4SVGl4WCojlnutPpl1r4h+Bzf3+1p4XvDKhxEI56cNRjIplrWU
         dur4hcF2V9p66jwZEaO/gQsgJnnAymGPcgc55BVDHaxLqJV+0wkSc4sBLlzsv4TNEVff
         /dnGEwbSPZR4vHnZTQcJjvG67cCFPQBDefyaxx1JNyoQipRRZvkxCtS4RU+c3jQxLu4Q
         j+pAlHKrf4adc1oInLYkqlzb+lc1a9C8fTGRAatjGtW9w8T6MRZGx5e1Sd9x3w+8PnJv
         ig0w==
X-Received: by 10.50.37.164 with SMTP id z4mr861680igj.38.1361279818537; Tue,
 19 Feb 2013 05:16:58 -0800 (PST)
Received: by 10.42.173.70 with HTTP; Tue, 19 Feb 2013 05:16:58 -0800 (PST)
In-Reply-To: <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216613>

On Sun, Feb 10, 2013 at 12:24 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Feb 10, 2013 at 12:10 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> Finn notes in the commit message that it offers no speedup, because
>> .gitignore files in every directory still have to be read.  I think
>> this is silly: we really should be caching .gitignore, and touching it
>> only when lstat() reports that the file has changed.
>> ...
>> Really, the elephant in the room right now seems to be .gitignore.
>> Until that is fixed, there is really no use of writing this inotify
>> daemon, no?  Can someone enlighten me on how exactly .gitignore files
>> are processed?
>
> .gitignore is a different issue. I think it's mainly used with
> read_directory/fill_directory to collect ignored files (or not-ignored
> files). And it's not always used (well, status and add does, but diff
> should not). I think wee need to measure how much mass lstat
> elimination gains us (especially on big repos) and how much
> .gitignore/.gitattributes caching does. I don't think .gitignore has
> such a big impact though. strace on git.git tells me "git status"
> issues about 2500 lstat calls, and just 740 open+getdents calls (on
> total 3800 syscalls). I will think if we can do something about
> .gitignore/.gitattributes.
> --
> Duy

Duy,
Did your testing turn up anything about the amount of time spent
parsing the .gitignore/.gitattributes files? Not the syscall count,
but the actual time spent running the parser (which I presume is
largely CPU-bound). The other notable bit of information to know would
be how much time is spent applying what has been parsed out of those
files to the content of the tree. Both will give a clear signal of the
prominence of those segments of code versus others elsewhere in the
"git stat" flow path. That information will tell us more clearly what,
if anything, it is worth keeping a cache of and what form that cache
should take.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
