From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] difftool: Do not remove temporary files on error
Date: Wed, 25 Jul 2012 11:28:58 -0700
Message-ID: <CAJDDKr5CcOo9Oewim9V1Kr8NoCoaSy9BE=esMvXxdtDZAJ_VUg@mail.gmail.com>
References: <1343196876-59195-1-git-send-email-davvid@gmail.com>
	<7vlii7dbuy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 20:29:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su6KY-0001KP-6E
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 20:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514Ab2GYS3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 14:29:00 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:37040 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab2GYS27 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 14:28:59 -0400
Received: by vcbfk26 with SMTP id fk26so853238vcb.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GBHzWg53CyVLQ+eAjhQmdUrff6umOZdC1TUyVjUmbhw=;
        b=tkdVjcyjN1o9tF5hdM8bN/QvK/VHGMItR0Kb9wnUUdlbOh4AhMYjcDrZPqx1zhfGWe
         6R0mmxz7S2caRYo/q2c0fjlN6iq5jbggw2B0pDd8M+wUocKS6NUqT7SP0nvunGkzM/wY
         6Cs2AX9rFs5w5Cd9sSc3PdywyS+CuII6vhP/8kNHJOyKWszSVzezCKZCCbjf/+7XCMEC
         gz4OBjztQCHUh9ZQrcN3UzLiXdgxeNCUbvF3GSFQmdtBVUtGpmnu7Lm/lvCvSbqy8kzY
         yRo8mo4HliGbL4NHefuVRFbv9hloHzw4IVWRajoDVq36uMz7FO0NguKmmne9YZIBvX6g
         lobA==
Received: by 10.52.90.144 with SMTP id bw16mr16470916vdb.129.1343240938567;
 Wed, 25 Jul 2012 11:28:58 -0700 (PDT)
Received: by 10.52.114.67 with HTTP; Wed, 25 Jul 2012 11:28:58 -0700 (PDT)
In-Reply-To: <7vlii7dbuy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202184>

On Wed, Jul 25, 2012 at 9:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> Keep the temporary directory around when either compare() or
>> the difftool returns a non-zero exit status.
>>
>> Tell the user about the location of the temporary files so that
>> they can recover from the failure.
>>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>> ---
>>  git-difftool.perl | 36 ++++++++++++++++++++++++++----------
>>  1 file changed, 26 insertions(+), 10 deletions(-)
>>
>> diff --git a/git-difftool.perl b/git-difftool.perl
>> index 10d3d97..f4f7d4a 100755
>> --- a/git-difftool.perl
>> +++ b/git-difftool.perl
>> @@ -18,7 +18,7 @@ use File::Copy;
>>  use File::Compare;
>>  use File::Find;
>>  use File::stat;
>> -use File::Path qw(mkpath);
>> +use File::Path qw(mkpath rmtree);
>>  use File::Temp qw(tempdir);
>>  use Getopt::Long qw(:config pass_through);
>>  use Git;
>> @@ -119,7 +119,7 @@ sub setup_dir_diff
>>       exit(0) if (length($diffrtn) == 0);
>>
>>       # Setup temp directories
>> -     my $tmpdir = tempdir('git-difftool.XXXXX', CLEANUP => 1, TMPDIR => 1);
>> +     my $tmpdir = tempdir('git-difftool.XXXXX', CLEANUP => 0, TMPDIR => 1);
>>       my $ldir = "$tmpdir/left";
>>       my $rdir = "$tmpdir/right";
>>       mkpath($ldir) or die $!;
>> @@ -257,7 +257,7 @@ sub setup_dir_diff
>>               }
>>       }
>>
>> -     return ($ldir, $rdir, @working_tree);
>> +     return ($ldir, $rdir, $tmpdir, @working_tree);
>>  }
>>
>>  sub write_to_file
>> @@ -349,20 +349,23 @@ sub main
>>  sub dir_diff
>>  {
>>       my ($extcmd, $symlinks) = @_;
>> -
>>       my $rc;
>> +     my $error = 0;
>>       my $repo = Git->repository();
>> -
>>       my $workdir = find_worktree($repo);
>> -     my ($a, $b, @worktree) = setup_dir_diff($repo, $workdir, $symlinks);
>> +     my ($a, $b, $tmpdir, @worktree) =
>> +             setup_dir_diff($repo, $workdir, $symlinks);
>> +
>>       if (defined($extcmd)) {
>>               $rc = system($extcmd, $a, $b);
>>       } else {
>>               $ENV{GIT_DIFFTOOL_DIRDIFF} = 'true';
>>               $rc = system('git', 'difftool--helper', $a, $b);
>>       }
>> -
>> -     exit($rc | ($rc >> 8)) if ($rc != 0);
>> +     if ($rc != 0) {
>> +             dir_diff_tmpdir_warning($tmpdir);
>> +             exit($rc | ($rc >> 8));
>> +     }
>
> Hrm.
>
> What does a non-zero exit code from these "compare two trees" diff
> tools (e.g. "diff -r a/ b/") mean?  Isn't "there are difference
> between the two trees" the usual meaning?  And we treat that as a
> failure and make the user clean up after us?
>
> The patch is not making things any worse with respect to that point,
> so I'd queue it as-is, but it smells like a fishy design decision to
> me.

This is true.  We do have mergetool.<tool>.trustExitCode, but I don't
think that's really what we want here.

I'm slightly on the fence about this.  The "do not cleanup" mode was
really added to deal with compare() returning -1 (which should be
extremely rare, if not non-existent in practice), and we'd be making
things worse by leaving junk around for the common case.

I personally think this should be redone so that we leave files around
for the compare() == -1 failure case only.


>
>>       # If the diff including working copy files and those
>>       # files were modified during the diff, then the changes
>> @@ -377,16 +380,29 @@ sub dir_diff
>>               if ($diff == 0) {
>>                       next;
>>               } elsif ($diff == -1 ) {
>> -                     my $errmsg = "warning: could not compare ";
>> +                     my $errmsg = "warning: Could not compare ";
>>                       $errmsg += "'$b/$file' with '$workdir/$file'\n";
>>                       warn $errmsg;
>> +                     $error = 1;
>>               } elsif ($diff == 1) {
>>                       copy("$b/$file", "$workdir/$file") or die $!;
>>                       my $mode = stat("$b/$file")->mode;
>>                       chmod($mode, "$workdir/$file") or die $!;
>>               }
>>       }
>> -     exit(0);
>> +     if ($error) {
>> +             dir_diff_tmpdir_warning($tmpdir);
>> +     } else {
>> +             rmtree($tmpdir);
>> +     }
>> +     exit($error);
>> +}
>> +
>> +sub dir_diff_tmpdir_warning
>> +{
>> +     my ($tmpdir) = @_;
>> +     warn "warning: Temporary files exist in '$tmpdir'.\n";
>> +     warn "warning: You may want to cleanup or recover these.\n";
>>  }
>>
>>  sub file_diff



-- 
David
