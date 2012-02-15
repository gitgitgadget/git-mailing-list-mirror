From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: [PATCH 1/2] git-svn.perl: perform deletions before anything else
Date: Wed, 15 Feb 2012 12:47:06 -0500
Message-ID: <CAK8d-a+tdK=Jn6D+X=bJmKTzbESPqd8+S2nJr9_sfdb7MhLN1A@mail.gmail.com>
References: <7vzkcrvkfa.fsf@alter.siamese.dyndns.org> <1328820742-4795-1-git-send-email-stevenrwalter@gmail.com>
 <1328820742-4795-2-git-send-email-stevenrwalter@gmail.com>
 <20120212070353.GA30477@dcvr.yhbt.net> <CAK8d-aKJCBq2xpsz65hA4g8oa_szKaofLpkYB3v3_2dd=BAgiQ@mail.gmail.com>
 <20120212234928.GA4513@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: gitster@pobox.com, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Feb 15 18:47:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxix2-0005oa-5N
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 18:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901Ab2BORr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 12:47:27 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64517 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700Ab2BORr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 12:47:26 -0500
Received: by yhoo21 with SMTP id o21so817242yho.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 09:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ncx9gIuRZ78WqxtZ0HcH/InxepMFW34mCNJuYkhQ4+w=;
        b=FSnxo8O8dp7fAD8iXKZVQDDbOYBMieLrm5l60CehvQ3RKFLjCL7l1TRMQlz2jjArge
         EEri61Y0SrbK7HtFla2BdQGL+0tS7sqp3P916Dc6a4V4zHdLWk4v++jNQhSR9RjRCmHg
         R6P/pY1VSZLPR0pXcuidKWqbdF4CWiB/tdaZ8=
Received: by 10.236.157.9 with SMTP id n9mr3975779yhk.96.1329328046234; Wed,
 15 Feb 2012 09:47:26 -0800 (PST)
Received: by 10.100.96.10 with HTTP; Wed, 15 Feb 2012 09:47:06 -0800 (PST)
In-Reply-To: <20120212234928.GA4513@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190841>

On Sun, Feb 12, 2012 at 6:49 PM, Eric Wong <normalperson@yhbt.net> wrote:
> Steven Walter <stevenrwalter@gmail.com> wrote:
>> On Sun, Feb 12, 2012 at 2:03 AM, Eric Wong <normalperson@yhbt.net> wrote:
>> > Steven Walter <stevenrwalter@gmail.com> wrote:
>> >> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
>> >
>> > Thanks, shall I fixup 2/2 and assume you meant to Sign-off on that, too?
>>
>> Yes, thanks
>
> Ugh, I got a bunch of test failures on t9100-git-svn-basic.sh with your
> updated 1/2 and a trivially merged 2/2:
>
> not ok - 7 detect node change from file to directory #2

I believe that "test_must_fail" is incorrect for this case.  "git svn
set-tree" is succeeding, and the git commit is being faithfully
recorded into the svn repository.  If svn will allow us to do it, then
I don't think git-svn should artificially fail in the case.  This is
using svn 1.6.17

What's the oldest version of svn supported by git-svn?  Perhaps if I
retry with that version of svn, I would see a failure.  However, if
libsvn-perl reports the failure correctly, isn't that good enough
behavior?  No need to fail in git-svn before even trying, IMHO.

> not ok - 12 new symlink is added to a file that was also just made executable
> not ok - 13 modify a symlink to become a file
> not ok - 14 commit with UTF-8 message: locale: en_US.UTF-8
> not ok - 16 check imported tree checksums expected tree checksums

The rest of these problems seem to have been cascading failures
resulting from the unexpected success of "git svn set-tree" in test 7.
 This left the git and svn repositories in a different state.  To get
these to pass, I changed later references to "bar/zzz" (which is now a
directory) to use "file" instead.  I also had to update the expected
checksum values for test 16.  Is there a way to validate what the
checksums should be, other than to look at it and say, "yup, the trees
look okay?"

> I would very much appreciate new test cases that can show exactly what's
> fixed by your patches  (esp given the only times I run/use git-svn is
> when reviewing patches).  Thanks!.

In fact test 7 is exactly what I was trying to make work.  The fact
that "git svn set-tree" now succeeds in that case is proof that my
change had the desired effect.  I modified test 7 to verify that
set-tree succeeds and that bar/zzz and bar/zzz/yyy get created in
$SVN_TREE.

Assuming you agree with the above analysis, should I squash the test
changes into my 2/2, or would you prefer a separate patch?
-- 
-Steven Walter <stevenrwalter@gmail.com>
