From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT 06/28] Fix and simplify the do_get_patch function.
Date: Wed, 7 May 2014 22:44:58 +0200
Message-ID: <CAP=KgsSTX-z4Z2qqDNtSRUwk9XT0dQ8Do3noesB=UgNRBye-ig@mail.gmail.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
	<1395387126-13681-7-git-send-email-cederp@opera.com>
	<20140323170932.GH1661@meili.valhalla.31bits.net>
	<CAP=KgsQtJb3t1c7qK8reO6nzMJppoV-zooK16ZZcWmCirAr3ew@mail.gmail.com>
	<20140506190830.GJ1655@meili.valhalla.31bits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed May 07 22:45:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8i8-0008Vs-6T
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbaEGUpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:45:00 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:57765 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbaEGUo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:44:59 -0400
Received: by mail-ig0-f172.google.com with SMTP id uy17so8216822igb.11
        for <git@vger.kernel.org>; Wed, 07 May 2014 13:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6B1iK1KAi88ecsYXjq13QJThN+WCNDm0d9LeSBlJoGs=;
        b=SlxoyquhBWvBZFUhpKiyuvXQ3dAfU/OvU/69S6RL4QSLpwSbMhdgf+tuuQjdOK3k8W
         DeGSScBfY5+FfTo2NVctPKHD7cbjf577KuvyczCXS2UMdRgqyI4d45yGxm2upUpa5Eg9
         /Cg4ZGv5nIYh+baL49PdIqMDjQybRswuNAGKWRBC1N2ds9lgMVjqUG+wV9FU6G2j5Cmz
         gLVTlWaydFSPMcxwDfsI9FrjaQE3LiE5hd7pRivdS3+1kNtLovQLVH3+6rBRJVLwRTDD
         rO0RkXXLVckvjiV6MGUMfIbhxBGzRz+Y2sD4Sk8nEezIXVIFRC3J0l6rLFFCXwOqOraq
         q/yA==
X-Gm-Message-State: ALoCoQklBfDv5S47Zt9PEJMsk8nt7z/KPxPYbNr40YR1c//oVl6QnSTzRKfZZnO+2sSVkxG9e404
X-Received: by 10.50.66.143 with SMTP id f15mr48116103igt.18.1399495498843;
 Wed, 07 May 2014 13:44:58 -0700 (PDT)
Received: by 10.43.89.66 with HTTP; Wed, 7 May 2014 13:44:58 -0700 (PDT)
In-Reply-To: <20140506190830.GJ1655@meili.valhalla.31bits.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248366>

n Tue, May 6, 2014 at 9:08 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> On Sun, Mar 23, 2014 at 10:03:48PM +0100, Per Cederqvist wrote:
>> On Sun, Mar 23, 2014 at 6:09 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
>>
>> > On Fri, Mar 21, 2014 at 08:31:44AM +0100, Per Cederqvist wrote:
>> >> When extracting the patch, we only want the actual patches.  We don't
>> >> want the "---" delimiter.  Simplify the extraction by simply deleting
>> >> everything before the first "diff " line.  (Use sed instead of awk to
>> >> simplify the code.)
>> >>
>> >> Without this patch, "guilt fold" and "guilt push" sometimes fails if
>> >> guilt.diffstat is true.
>
> Hrm, I just did a test and guilt-push seems to work with a patch such as:
>
> aoeuaoeu
> this is
> ---
> not a patch!
> ---
>  foo |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/foo b/foo
> index e69de29..203a557 100644
> --- a/foo
> +++ b/foo
> @@ -0,0 +1 @@
> +aoue
>
> What sort of thing breaks fold/push?

This sequence breaks:

  mkdir guiltdemo
  cd guiltdemo
  git init
  git commit --allow-empty -mstart
  guilt init
  git config guilt.diffstat true
  guilt new empty-1
  guilt new empty-2
  guilt pop
  guilt fold empty-2
  guilt pop
  guilt push

That is, create two empty patches, fold them together, pop them, and try to push
the combined (still empty) patch.

The last command fails with:

  Applying patch..empty-1
  fatal: unrecognized input
  To force apply this patch, use 'guilt push -f'

At this point, the patch series consists of a single patch, empty-1,
which contains
the five characters "-", "-", "-", newline, newline.

The 06 patch (Added test cases for "guilt fold".) contains a test case
for this issue.
Which opens a style issue. When you fix a bug, should you:

 - commit the bug fix first and the test case later, so that "git bisect" always
   finds commits where "make test" works, or
 - commit the test case first, and the bug fix later, so that it is more obvious
   that you are actually fixing a pre-existing bug, or
 - commit the test case and the bug fix in the same commit?

In this series I have committed bug fixes first and test cases later, but
I'm not convinced that is the right thing to do.

> ...
>> >> diff --git a/guilt b/guilt
>> >> index 8701481..c59cd0f 100755
>> >> --- a/guilt
>> >> +++ b/guilt
>> >> @@ -332,12 +332,7 @@ do_make_header()
>> >>  # usage: do_get_patch patchfile
>> >>  do_get_patch()
>> >>  {
>> >> -     awk '
>> >> -BEGIN{}
>> >> -/^(diff |---$|--- )/ {patch = 1}
>> >> -patch == 1 {print $0}
>> >> -END{}
>> >> -' < "$1"
>> >> +     sed -n '/^diff /,$p' < "$1"
>> >
>> > So, the thought behind this mess was to allow minimal patches to work.  The
>> > 'diff' line is *not* required by patch(1)!
>>
>> I see. I can see that this is sometimes useful, even though I think
>> it is more important that guilt actually works with the patches itself
>> creates.
>
> Fair enough.  I'm convinced that we should assume that all patches start
> with 'diff '.
>
> ...
>> I had to solve a similar problem when I wrote my utility for diffing two
>> diff files (https://git.lysator.liu.se/pdiffdiff). Based on the experience
>> I got doing that, I propose this new do_get_patch function:
> ...
>>
>> The idea is to collect lines that *might* start the patch in
>> patchheader. Once we detect the start of the patch (via a
>> line that matches "--- " or any of the mode change lines)
>> we print the patcheader and the current line. If we get a
>> line that neither looks like a patchheader nor starts a patch,
>> we discard the patcheader. This is the case of a commit
>> message with a line that starts with "diff ".
>>
>> The function above solves the issue with lines that
>> start with "diff " in the commit message.  On the other
>> hand, it introduces the same issue for lines that start
>> with for instance "old mode ".
>
> Hrm.  I'm open to revisiting the get-patch/get-header functions to address
> the ambiguity issues in the future.

Postponing that for the future seems like a good plan. I think
there are three possible ways to deal with the problem.

 - Store the commit message, diffstat, and diffs in separate files.
   I don't like this option, as it would make it a lot less convenient
   to work with the patch files.

 - Add a quoting mechanism, so that you need to write ">diff" or
   ">---" instead of just "diff" or "---" if you want to include those
   characters at the start of the line in a commit message.

 - Ignore the problem. This is what guilt has done in the past,
   and I see no reason why it needs to change *in this patch series*.

>> Actually, a smaller change that probably fixes the
>> issue with diffstat is to replace
>>
>> /^(diff |---$|--- )/ {patch = 1}
>>
>> witih
>>
>> /^(diff |--- )/ {patch = 1}
>>
>> as the problem with the original implementation is that
>> the "---\n" line that starts the diffstat should not start
>> the patch.
>
> (Thinking out loud...) I suppose there are three portions to a patch file...
>
> (1) the description
> (2) optional diffstat
> (3) the patch
>
> You just convinced me that the patch should start with '^diff '.  Currently,
> the diffstat begins with '^---$'.  Sadly, the description can contain what
> looks like the beginning of a diffstat or a patch.  In the case of
> do_get_patch, we're only interested in the patch, so we can just look for
> '^diff ' (because garbage before the diff itself seems to be ignored by
> git).  (If we wanted to allow patches without the 'diff ' line, we'd need
> '^(diff |--- )'.)
>
> I feel like I'm missing something.
>
> Jeff.

Today, I think the most reasonable thing to do is simply remove the
"---$". After all, we want the patch, not the diffstat + patch.  So this
patch would look like this:

diff --git a/guilt b/guilt
index 8701481..3fc524e 100755
--- a/guilt
+++ b/guilt
@@ -334,7 +334,7 @@ do_get_patch()
 {
     awk '
 BEGIN{}
-/^(diff |---$|--- )/ {patch = 1}
+/^(diff |--- )/ {patch = 1}
 patch == 1 {print $0}
 END{}
 ' < "$1"

    /ceder
