From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 8/9 v11] difftool: teach difftool to handle directory diffs
Date: Tue, 10 Apr 2012 11:01:22 -0400
Message-ID: <CAFouetiBMK+WWU9yOLaO5SLyUO1K_S-YW0LTt5tE5UTcMM8K=w@mail.gmail.com>
References: <1333567265-23986-1-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr76eMiA4rOHQhar3aToVThDfbc8Ki5tr2PGU_UpDMAVeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ramsay@ramsay1.demon.co.uk
To: David Aguilar <davvid@gmail.com>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 10 17:01:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHcZT-0000y4-UT
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 17:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758942Ab2DJPBX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Apr 2012 11:01:23 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53106 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758931Ab2DJPBW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2012 11:01:22 -0400
Received: by iagz16 with SMTP id z16so7453854iag.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=kJJQ/jzFgbFuywDjZfopPwxHJKJwoTB0uHR93B6+MdM=;
        b=VIRPcoaThWO65Mv54FJ/oRrnqQWdYFcAzp+LBsfpEVs8pwbxqUeGwEcvh0s4pSRpqi
         a5lS1JVmge0Os6gwOXl5EBJbreHcZLpaK0s5xPs1LJ6bYGd+8hL6Ifn/ad5pRistiU7S
         RzUP59OXee01UZXbKFWU+tbN/UmjBhurO9r2LZw7S8MpVC+ZShQkX9pcCatoakc+jSIw
         uHip5SuLpvF1fOqRi6TawJJj/WFYlWh2YcUGuGCvnpJzOxN67kpdjlbkGLbOZXZxBgtp
         e/H/RSl2Mem5Rbq5MHFnTPbg8JEB3kcTelROgvOWryp48FBYE3n5aq71mAnMqmfytj/I
         qLEw==
Received: by 10.50.207.5 with SMTP id ls5mr2717780igc.51.1334070082315; Tue,
 10 Apr 2012 08:01:22 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Tue, 10 Apr 2012 08:01:22 -0700 (PDT)
In-Reply-To: <CAJDDKr76eMiA4rOHQhar3aToVThDfbc8Ki5tr2PGU_UpDMAVeA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195092>

Hi David,

Thank you for the review.  I am working on the changes you suggested,
but want to discuss one of them:

On Mon, Apr 9, 2012 at 8:14 AM, David Aguilar <davvid@gmail.com> wrote:
> On Wed, Apr 4, 2012 at 12:21 PM, Tim Henigan <tim.henigan@gmail.com> =
wrote:
>> +
>> + =C2=A0 =C2=A0 =C2=A0 # If the diff including working copy files an=
d those
>> + =C2=A0 =C2=A0 =C2=A0 # files were modified during the diff, then t=
he changes
>> + =C2=A0 =C2=A0 =C2=A0 # should be copied back to the working tree
>> + =C2=A0 =C2=A0 =C2=A0 my $repo =3D Git->repository();
>> + =C2=A0 =C2=A0 =C2=A0 my $workdir =3D $repo->repo_path() . "/..";
>
> Does this work when $GIT_WORK_TREE / core.worktree are defined?

I had not considered this case and the existing code will certainly
ignore alternate work tree locations.  To fix the problem, I plan to
add something like this:

+sub find_worktree
+{
+       my $worktree;
+       my $env_worktree =3D $ENV{GIT_WORK_TREE};
+       my $core_worktree =3D Git::config('core.worktree');
+
+       if (length($env_worktree) > 0) {
+               $worktree =3D $env_worktree;
+       } elsif (length($core_worktree) > 0) {
+               $worktree =3D $core_worktree;
+       } else {
+               my $repo =3D Git->repository();
+               $worktree =3D $repo->repo_path() . "/..";
+       }
+
+       return $worktree;
+}

Does this look like a reasonable solution?  I don't typically use
'$GIT_WORK_TREE' or 'core.worktree'.  The above function works for me,
but I would appreciate some feedback before I send the next revision
of the patch (v12!).

Thanks,
Tim
