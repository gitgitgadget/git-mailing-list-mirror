From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 8/9 v11] difftool: teach difftool to handle directory diffs
Date: Wed, 11 Apr 2012 02:02:26 -0700
Message-ID: <CAJDDKr7XXqWBRVXhEenWVcE+7526sYVV821Ytty0xbZBvshd-w@mail.gmail.com>
References: <1333567265-23986-1-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr76eMiA4rOHQhar3aToVThDfbc8Ki5tr2PGU_UpDMAVeA@mail.gmail.com>
	<CAFouetijF5vt9r1GfbntJ0BEqoo0FpztkeqrmeN=-6DK1Q_XRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, ramsay@ramsay1.demon.co.uk
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 11:02:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHtRk-0001kJ-Re
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 11:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305Ab2DKJC2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 05:02:28 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62206 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab2DKJC1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 05:02:27 -0400
Received: by yenl12 with SMTP id l12so317160yen.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 02:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=vowUgqtCW6+L/1ap4cnx3HbOebYPrnnH8a0e000mxLw=;
        b=AqLzw7ZyLUBQok9SZSt6cfPI/km/ujvel/uIHYUmkXMS9UvRNM89JJTyrxpconPhVE
         LJiLlbztopTUdQM6MskQB6e1JhMXHNH0LeyULDrh4hc/Thqqbfw8FaNQrj+9VwIMq6iP
         T9NWlwDFmrO+beGVBsZnV2+7phy3wawVcF7kceD7PXXca9t0Bi/Ado5OwKys6B7bhAsV
         H4Nyq3NqAs2sB+Yy8iA7jsJD6SIoegktS4u7SEpKM0RTz+q9eJag3QFG/mQs0l9p/etr
         egmBBW5YQC/Fis4bYU6T/3zDGCmSaudBXzfe/QQNrkclBxcbU9tKNF6s3uYSyjYuHsXK
         Ve7w==
Received: by 10.236.185.10 with SMTP id t10mr12252060yhm.112.1334134946684;
 Wed, 11 Apr 2012 02:02:26 -0700 (PDT)
Received: by 10.147.128.8 with HTTP; Wed, 11 Apr 2012 02:02:26 -0700 (PDT)
In-Reply-To: <CAFouetijF5vt9r1GfbntJ0BEqoo0FpztkeqrmeN=-6DK1Q_XRA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195156>

On Tue, Apr 10, 2012 at 10:24 AM, Tim Henigan <tim.henigan@gmail.com> w=
rote:
> On Mon, Apr 9, 2012 at 8:14 AM, David Aguilar <davvid@gmail.com> wrot=
e:
>> On Wed, Apr 4, 2012 at 12:21 PM, Tim Henigan <tim.henigan@gmail.com>=
 wrote:
>>> diff --git a/git-difftool.perl b/git-difftool.perl
>>> index d4fe998..5bb01e1 100755
>>> --- a/git-difftool.perl
>>> +++ b/git-difftool.perl
>>> @@ -1,21 +1,29 @@
>
> ...snip...
>
>>> + =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_DIR} =3D $repo->repo_path();
>>> + =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_INDEX_FILE} =3D "$tmpdir/lindex";
>>> + =C2=A0 =C2=A0 =C2=A0 ($inpipe, $ctx) =3D $repo->command_input_pip=
e(qw/update-index -z --index-info/);
>>> + =C2=A0 =C2=A0 =C2=A0 print($inpipe $lindex);
>>> + =C2=A0 =C2=A0 =C2=A0 $repo->command_close_pipe($inpipe, $ctx);
>>> + =C2=A0 =C2=A0 =C2=A0 system(('git', 'checkout-index', '--all', "-=
-prefix=3D$ldir/"));
>
> ...snip...
>
>>> + =C2=A0 =C2=A0 =C2=A0 # If the diff including working copy files a=
nd those
>>> + =C2=A0 =C2=A0 =C2=A0 # files were modified during the diff, then =
the changes
>>> + =C2=A0 =C2=A0 =C2=A0 # should be copied back to the working tree
>>> + =C2=A0 =C2=A0 =C2=A0 my $repo =3D Git->repository();
>>> + =C2=A0 =C2=A0 =C2=A0 my $workdir =3D $repo->repo_path() . "/..";
>>
>> Does this work when $GIT_WORK_TREE / core.worktree are defined?
>
> Should I also be concerned that the existing code always overrides $G=
IT_DIR?
> For example, should I squash in the following before calling 'git upd=
ate-index'?
>
> - =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_DIR} =3D $repo->repo_path();
> + =C2=A0 =C2=A0 =C2=A0if (not defined($ENV{GIT_DIR})) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$ENV{GIT_DIR} =3D $=
repo->repo_path();
> + =C2=A0 =C2=A0 =C2=A0}

I think the right thing to do would be to not override GIT_DIR at all.
 I haven't read it deeply enough to know whether it was being
overridden for a specific reason, but I think it should be safe to
leave it as-is.

Git.pm ends up overriding these variables itself anyways when calling c=
ommands.

The GIT_WORK_TREE check should use $repo->wc_path().  Git.pm's already
done all the hard work ;-)
--=20
David
