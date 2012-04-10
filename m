From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 8/9 v11] difftool: teach difftool to handle directory diffs
Date: Tue, 10 Apr 2012 13:24:52 -0400
Message-ID: <CAFouetijF5vt9r1GfbntJ0BEqoo0FpztkeqrmeN=-6DK1Q_XRA@mail.gmail.com>
References: <1333567265-23986-1-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr76eMiA4rOHQhar3aToVThDfbc8Ki5tr2PGU_UpDMAVeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ramsay@ramsay1.demon.co.uk
To: gitster@pobox.com, David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 19:24:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHeoM-0000s4-HI
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 19:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068Ab2DJRYx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Apr 2012 13:24:53 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61607 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab2DJRYw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2012 13:24:52 -0400
Received: by iagz16 with SMTP id z16so39427iag.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=yqVosiMbLtQP2xmQDBXyXX4Enovg46KKU+VNQzfYzoI=;
        b=M+Do3Tvm+76XAx0HCvPj6roWbH7Kztca065wdSg8A0CsOwpNZZMtwIrynxKBeJB51q
         UeTjeJKkngbXY04dnM2qpbGojc1IItbXE223mlzoOGxVZBhfdkmFfnpLJgQjeMi0pHXF
         jMvx0v3P6DWWX/CwqbTMPTjye6t2Pc4313tLJELMh1r5IiisVpaWJQc3Ur4vG0/n/5Wj
         iYYbRhC27/d/o7SyuiBnzOI0qHhcC/255zFV/LN4o1ZC4Hkhoq+Yq3N2cxY5ncbwbgPS
         nvEVdB+SDRPgKjitUBToUKkTxu6BfohxotrlqTSgB1t3O4CkO6Wi9+BIMst2Mxi9/dEn
         FRLA==
Received: by 10.50.149.131 with SMTP id ua3mr3289210igb.41.1334078692380; Tue,
 10 Apr 2012 10:24:52 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Tue, 10 Apr 2012 10:24:52 -0700 (PDT)
In-Reply-To: <CAJDDKr76eMiA4rOHQhar3aToVThDfbc8Ki5tr2PGU_UpDMAVeA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195108>

On Mon, Apr 9, 2012 at 8:14 AM, David Aguilar <davvid@gmail.com> wrote:
> On Wed, Apr 4, 2012 at 12:21 PM, Tim Henigan <tim.henigan@gmail.com> =
wrote:
>> diff --git a/git-difftool.perl b/git-difftool.perl
>> index d4fe998..5bb01e1 100755
>> --- a/git-difftool.perl
>> +++ b/git-difftool.perl
>> @@ -1,21 +1,29 @@

=2E..snip...

>> + =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_DIR} =3D $repo->repo_path();
>> + =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_INDEX_FILE} =3D "$tmpdir/lindex";
>> + =C2=A0 =C2=A0 =C2=A0 ($inpipe, $ctx) =3D $repo->command_input_pipe=
(qw/update-index -z --index-info/);
>> + =C2=A0 =C2=A0 =C2=A0 print($inpipe $lindex);
>> + =C2=A0 =C2=A0 =C2=A0 $repo->command_close_pipe($inpipe, $ctx);
>> + =C2=A0 =C2=A0 =C2=A0 system(('git', 'checkout-index', '--all', "--=
prefix=3D$ldir/"));

=2E..snip...

>> + =C2=A0 =C2=A0 =C2=A0 # If the diff including working copy files an=
d those
>> + =C2=A0 =C2=A0 =C2=A0 # files were modified during the diff, then t=
he changes
>> + =C2=A0 =C2=A0 =C2=A0 # should be copied back to the working tree
>> + =C2=A0 =C2=A0 =C2=A0 my $repo =3D Git->repository();
>> + =C2=A0 =C2=A0 =C2=A0 my $workdir =3D $repo->repo_path() . "/..";
>
> Does this work when $GIT_WORK_TREE / core.worktree are defined?

Should I also be concerned that the existing code always overrides $GIT=
_DIR?

=46or example, should I squash in the following before calling 'git upd=
ate-index'?

- =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_DIR} =3D $repo->repo_path();
+      if (not defined($ENV{GIT_DIR})) {
+              $ENV{GIT_DIR} =3D $repo->repo_path();
+      }

This seems like the right thing to do, but again I have not used
$GIT_DIR except for the implementation of this script.
