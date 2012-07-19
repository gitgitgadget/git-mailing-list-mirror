From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/2] difftool: only copy back files modified during
 directory diff
Date: Thu, 19 Jul 2012 01:11:54 -0700
Message-ID: <CAJDDKr4Q+nQapO0aAQmmpj_guR=_tXwareWsn020BckZR5V+uA@mail.gmail.com>
References: <1340912395-16990-1-git-send-email-tim.henigan@gmail.com>
	<7vbok35i5s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 10:12:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrlqE-0007qX-Of
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 10:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731Ab2GSIMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 04:12:00 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64144 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab2GSILz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 04:11:55 -0400
Received: by vbbff1 with SMTP id ff1so1729330vbb.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 01:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yH/4dFn0LcnDPJ7EpRoVVeCAcmhaclykbWhLoL6JsGQ=;
        b=0QpXVnt9LbbnnQKyYeUuOhG+S6XwCh+oVJxptJ8b9N5uLmHlBEGLiDXWGm1emYKP+Q
         1a2AW5EIsQxPf2wzmbCGPuKVK4Q6j5+SSgB8S0FPdSuxxea4qR090rJLsaWBD9zwJ4lK
         4ymh5Jhg1lJRz5Jnq5uAjySZ5IduEYvsRRRXlj6TTpOMHf9uzI3Sf9YhM024Uq44DPtl
         vO2h8ATsBO2CNDnyMlIJuwFA1PiVglCQsYviTKNtTWF11P+It2D/H+EL68QLIDoVdxMd
         7/UJi13G4szv2h/+YhPCNwFBxAGVx44/rTQMJCc3wgJCpiT3wDHBEAcIEBSklR2CulIi
         HpuQ==
Received: by 10.52.90.144 with SMTP id bw16mr361137vdb.129.1342685514230; Thu,
 19 Jul 2012 01:11:54 -0700 (PDT)
Received: by 10.52.114.67 with HTTP; Thu, 19 Jul 2012 01:11:54 -0700 (PDT)
In-Reply-To: <7vbok35i5s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201727>

On Thu, Jun 28, 2012 at 12:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
>> When 'difftool --dir-diff' is used to compare working tree files,
>> it always copies files from the tmp dir back to the working tree
>> when the diff tool is closed, even if the files were not modified
>> by the diff tool.
>>
>> This causes the file timestamp to change. Files should only be
>> copied from the tmp dir back to the working copy if they were
>> actually modified.
>>
>> Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
>> ---
>>
>> This patch must be applied after commit 304970d on next (diff-no-index:
>> exit(1) if 'diff --quiet <repo file> <external file>' finds changes).
>> because it relies on 'git diff --quiet' to compare files outside the
>> repository.
>>
>>
>>  git-difftool.perl | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-difftool.perl b/git-difftool.perl
>> index ae1e052..679a56d 100755
>> --- a/git-difftool.perl
>> +++ b/git-difftool.perl
>> @@ -336,8 +336,11 @@ if (defined($dirdiff)) {
>>       # files were modified during the diff, then the changes
>>       # should be copied back to the working tree
>>       for my $file (@working_tree) {
>> -             copy("$b/$file", "$workdir/$file") or die $!;
>> -             chmod(stat("$b/$file")->mode, "$workdir/$file") or die $!;
>> +             if ((-e "$b/$file") &&
>> +                 (system('git', 'diff', '--quiet', "$b/$file", "$workdir/$file") != 0)) {
>
> Why waste cycles to spawn "git diff" when you only want to find if
> they are byte-for-byte identical *and* when you are importing many
> perl modules from File::* already into the script?
>
>> +                     copy("$b/$file", "$workdir/$file") or die $!;
>> +                     chmod(stat("$b/$file")->mode, "$workdir/$file") or die $!;
>> +             }
>>       }
>>  } else {
>>       if (defined($prompt)) {


Hey Tim,

I think what Junio is alluding to here is that we should probably use
File::Compare[1] here instead of shelling out to git.  I hope that
helps.

Let me know if you need any help getting this patch into shape.

Thanks,
-- 
David

[1] http://perldoc.perl.org/File/Compare.html
