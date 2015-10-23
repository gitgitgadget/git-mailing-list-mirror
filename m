From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: git-cherry doesn't detect a "copied" commit
Date: Fri, 23 Oct 2015 14:24:18 +0200
Message-ID: <CAC9WiBjub2oBBaM7KxcE2Jv7QgGyvmPzEBU7WcSEk5huGzx+zg@mail.gmail.com>
References: <CAC9WiBhM4edBFCYx35xZJB79AZWo49mkO-Pxnb1q4aLDmBufWQ@mail.gmail.com>
	<20151023105756.GB12622@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Fri Oct 23 14:24:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpbOR-0002rO-HT
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 14:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbbJWMYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 08:24:19 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:32771 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbbJWMYS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 08:24:18 -0400
Received: by igbkq10 with SMTP id kq10so33342376igb.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2015 05:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vLnhqM+0B3n+Lbi3Op/zI894Ir5EgfHY4sKsQ/9gsqE=;
        b=vcmzuwTtqDgkuWQHSsurK8KZJNFFwK6FI9MGjsj8L/C2wbdI6sYg7oj4LMQ0j1SRS5
         SUBZ/5+mqS1gE7y7YNZOwGpgy86DPqnmTQLpoyZCIusrmu738MlyH3tHfuM9O4ix5Gla
         Gcy0cjZTudpPmDWdSxyYMhBAiyQ/ENOipCWxiHkF7n2k6mkvhC/Q7sBmXJo5vBPJNoNL
         fPrrsnAmhh7MZch+efK7XQBh5scv8wirnVozIhIaIrj6GTvjkOLUOg5lDwcLLxtSJ2cb
         iQ6v7q0EKZI8aTHDWNdwT/lpWKsXYBIreO/SIXUk3z+ornrLpaqEVTKX9roDpWsWtDXA
         HAWQ==
X-Received: by 10.50.59.210 with SMTP id b18mr4129782igr.89.1445603058132;
 Fri, 23 Oct 2015 05:24:18 -0700 (PDT)
Received: by 10.79.77.1 with HTTP; Fri, 23 Oct 2015 05:24:18 -0700 (PDT)
In-Reply-To: <20151023105756.GB12622@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280093>

On Fri, Oct 23, 2015 at 12:57 PM, Kevin Daudt <me@ikke.info> wrote:
> On Tue, Oct 20, 2015 at 06:32:12PM +0200, Francis Moreau wrote:
>> Hi,
>>
>> I'm seeing something odd with git-cherry: it doesn't seem to detect
>> that a commit has been cherry-picked from master branch.
>>
>> This happens with the systemd git repository (from github) so it
>> should be fairly simple to reproduce.
>>
>> What I did:
>>
>> $ git --version
>> git version 2.6.0
>> $ git checkout -b foo v210
>> $ git cherry-pick -x 9ea28c55a2488e6cd4a44ac5786f12b71ad5bc9f
>> $ git branch --contains 9ea28c55a2488e6cd4a44ac5786f12b71ad5bc9f
>> master
>> $ git cherry master HEAD
>> + fef60bf34d1b372bea1db2515a8d936386dfc523
>>
>> so git-cherry tells me that the cherry-picked commit has not
>> equivalent in master, which is no the case.
>>
>> What am I missing ?
>>
>
> Let's see:
>
>   $ git show | git patch-id
>   50c9f9548e1fd25401ff9540c82c1d5f9723c3d5 b4c86d2965aaf0736e4ab30be1d1a08931009a08
>
>   $ git show 9ea28c55a2488e6cd4a44ac5786f12b71ad5bc9f | git patch-id
>   a5cfbb542882bd9cbe192b43026354d1f2741673 9ea28c55a2488e6cd4a44ac5786f12b71ad5bc9f
>
> Git patch-id calculates the hash over the diff, and, when gives in this
> case two hashes, first the patch-id and the second the commit hash.
>
> The patch-ids are different, explaining why git cherry does not see them
> as equivalent. If I take a diff of the diff, I notice something:
>
>    diff --git a/src/udev/udevadm-settle.c b/src/udev/udevadm-settle.c
>   -index 927ea2a..65fc35f 100644
>   +index b026155..ea9b078 100644
>    --- a/src/udev/udevadm-settle.c
>    +++ b/src/udev/udevadm-settle.c
>    @@ -41,42 +41,28 @@
>   @@ -1094,7 +1094,7 @@
>                             exit(EXIT_SUCCESS);
>    @@ -102,44 +85,13 @@ static int adm_settle(struct udev *udev, int argc, char *argv[])
>                     default:
>   -                         assert_not_reached("Unknown argument");
>   +                         assert_not_reached("Unkown argument");
>                     }
>    +        }
>
> If you look at the lines with assert_not_reached, it seems there is a
> difference in the context of both diffs, causing the diffs to be
> different.
>
> Hope this helps, Kevin

Thanks Kevin

I was mislead by the git-cherry manpage somehow which says:

    "git-cherry therefore
     detects when commits have been "copied" by means of git-cherry-pick(1),

which is not exactly true.

Isn't there a way to get git-cherry less "strict" ?
I mean in this case most of 90% of the diff is the same, only one line
of context is not identical...

Would it make sense to add a "--fuzz" option which would reduce the
diff context area used to generate the hash ?

Thanks.
-- 
Francis
