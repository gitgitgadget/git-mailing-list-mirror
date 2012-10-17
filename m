From: Uri Moszkowicz <uri@4refs.com>
Subject: Re: error: git-fast-import died of signal 11
Date: Wed, 17 Oct 2012 15:06:10 -0500
Message-ID: <CAMJd5AS92QtPyJ0sFWSQYtd-SSoZLHtR_NidRTBuNzaxv9t94A@mail.gmail.com>
References: <CAMJd5ATv5XfTK++4=Rs+RUkgb7F-ssrz2Lrch_WxvxZt+yF33A@mail.gmail.com>
 <CAMJd5AQ_vsQBGnMRrZUUqztjYjaHkU0_FOteNpEvE8NTrPPvQQ@mail.gmail.com> <507D0A53.1030707@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 17 22:06:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOZt6-000707-K2
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 22:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253Ab2JQUGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 16:06:33 -0400
Received: from mx71.nozonenet.com ([204.14.89.24]:38045 "EHLO
	mail3.nozonenet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753588Ab2JQUGc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 16:06:32 -0400
Received: (qmail 22724 invoked by uid 399); 17 Oct 2012 16:06:31 -0400
Received: from mail-ie0-f174.google.com (smtp@4refs.com@209.85.223.174)
  (de-)crypted with TLSv1: RC4-SHA [128/128] DN=unknown
  by mail3.nozonenet.com with ESMTPSAM; 17 Oct 2012 16:06:31 -0400
X-Originating-IP: 209.85.223.174
X-Sender: smtp@4refs.com
Received: by mail-ie0-f174.google.com with SMTP id k13so12510548iea.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 13:06:30 -0700 (PDT)
Received: by 10.50.95.167 with SMTP id dl7mr2756896igb.8.1350504390753; Wed,
 17 Oct 2012 13:06:30 -0700 (PDT)
Received: by 10.64.15.7 with HTTP; Wed, 17 Oct 2012 13:06:10 -0700 (PDT)
In-Reply-To: <507D0A53.1030707@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207938>

Hi Michael,
Looks like the changes to limit solved the problem. I didn't verify if
it was the stacksize or descriptors but one of those. Final repository
size was 14GB from a 328GB dump file.

Thanks,
Uri

On Tue, Oct 16, 2012 at 2:18 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 10/15/2012 05:53 PM, Uri Moszkowicz wrote:
>> I'm trying to convert a CVS repository to Git using cvs2git. I was able to
>> generate the dump file without problem but am unable to get Git to
>> fast-import it. The dump file is 328GB and I ran git fast-import on a
>> machine with 512GB of RAM.
>>
>> fatal: Out of memory? mmap failed: Cannot allocate memory
>> fast-import: dumping crash report to fast_import_crash_18192
>> error: git-fast-import died of signal 11
>>
>> How can I import the repository?
>
> What versions of git and of cvs2git are you using?  If not the current
> versions, please try with the current versions.
>
> What is the nature of your repository (i.e., why is it so big)?  Does it
> consist of extremely large files?  A very deep history?  Extremely many
> branches/tags?  Extremely many files?
>
> Did you check whether the RAM usage of git-fast-import process was
> growing gradually to fill RAM while it was running vs. whether the usage
> seemed reasonable until it suddenly crashed?
>
> There are a few obvious possibilities:
>
> 0. There is some reason that too little of your computer's RAM is
> available to git-fast-import (e.g., ulimit, other processes running at
> the same time, much RAM being used as a ramdisk, etc).
>
> 1. Your import is simply too big for git-fast-import to hold in memory
> the accumulated things that it has to remember.  I'm not familiar with
> the internals of git-fast-import, but I believe that the main thing that
> it has to keep in RAM is the list of "marks" (references to git objects
> that can be referred to later in the import).  From your crash file, it
> looks like there were about 350k marks loaded at the time of the crash.
>  Supposing each mark is about 100 bytes, this would only amount to 35
> Mb, which should not be a problem (*if* my assumptions are correct).
>
> 2. Your import contains a gigantic object which individually is so big
> that it overflows some component of the import.  (I don't know whether
> large objects are handled streamily; they might be read into memory at
> some point.)  But since your computer had so much RAM this is hardly
> imaginable.
>
> 3. git-fast-import has a memory leak and the accumulated memory leakage
> is exhausting your RAM.
>
> 4. git-fast-import has some other kind of a bug.
>
> 5. The contents of the dumpfile are corrupt in a way that is triggering
> the problem.  This could either be invalid input (e.g., an object that
> is reported to be quaggabytes large), or some invalid input that
> triggers a bug in git-fast-import.
>
> If (1), then you either need a bigger machine or git-fast-import needs
> architectural changes.
>
> If (2), then you either need a bigger machine or git-fast-import and/or
> git needs architectural changes.
>
> If (3), then it would be good to get more information about the problem
> so that the leak can be fixed.  If this is the case, it might be
> possible to work around the problem by splitting the dumpfile into
> several parts and loading them one after the other (outputting the marks
> from one run and loading them into the next).
>
> If (4) or (5), then it would be helpful to narrow down the problem.  It
> might be possible to do so by following the instructions in the cvs2svn
> FAQ [1] for systematically shrinking a test case to smaller size using
> destroy_repository.py and shrink_test_case.py.  If you can create a
> small repository that triggers the same problem, then there is a good
> chance that it is easy to fix.
>
> Michael
> (the cvs2git maintainer)
>
> [1] http://cvs2svn.tigris.org/faq.html#testcase
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
