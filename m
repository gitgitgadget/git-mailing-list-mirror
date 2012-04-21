From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v14 8/9] difftool: teach difftool to handle directory diffs
Date: Sat, 21 Apr 2012 16:07:36 -0700
Message-ID: <CAJDDKr4AuTHX2LSFuw4g2fWsE3M+A2EcX9bXx6yDRebvAMx_1g@mail.gmail.com>
References: <1334940988-8940-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, ramsay@ramsay1.demon.co.uk
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 01:07:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLjP4-00043e-B7
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 01:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569Ab2DUXHh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Apr 2012 19:07:37 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56471 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab2DUXHh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Apr 2012 19:07:37 -0400
Received: by yhmm54 with SMTP id m54so5675216yhm.19
        for <git@vger.kernel.org>; Sat, 21 Apr 2012 16:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=NMwVYhtRnNBB8VJ/Zq+pdAV/j/llvalsL8z/QpP9804=;
        b=Jjkp0mqjRb/I1TiEgohWk+CnjXmcW90NCfGGaX5nPG8thUvQdtnANfeSDO+qz0o3rL
         lgMvrELWTSP1CpL+7ncokVeMgtkujYb/GAB6DuLtKIrV4KvyBuGvI8E158MB/8iFyh9b
         CzkT2LPEcdZtfVV9l9NybU6tz8240i6rQFMOBNEbtFcJC+n6zdlyfPYdX9hU8017FV2L
         IPFZ/FyyBurnLtSP9EUAswY9vGTx3wtlPwBlRf/g6fdnQs6eMSZpUfzu0u82tM34Iigf
         nIrnQp2VdKC/Ol4SPxtX5qgEpLeOwCjaqJXthi2YSFIlhsSld0fAV4A+Cw5CQ2vy7QM5
         PQVw==
Received: by 10.236.161.3 with SMTP id v3mr4520708yhk.128.1335049656418; Sat,
 21 Apr 2012 16:07:36 -0700 (PDT)
Received: by 10.147.128.8 with HTTP; Sat, 21 Apr 2012 16:07:36 -0700 (PDT)
In-Reply-To: <1334940988-8940-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196062>

On Fri, Apr 20, 2012 at 9:56 AM, Tim Henigan <tim.henigan@gmail.com> wr=
ote:
> [snip]
> +
> +sub setup_dir_diff
> +{
> + =C2=A0 =C2=A0 =C2=A0 # Run the diff; exit immediately if no diff fo=
und
> + =C2=A0 =C2=A0 =C2=A0 # 'Repository' and 'WorkingCopy' must be expli=
citly set to insure that
> + =C2=A0 =C2=A0 =C2=A0 # if $GIT_DIR and $GIT_WORK_TREE are set in EN=
V, they are actually used
> + =C2=A0 =C2=A0 =C2=A0 # by Git->repository->command*.
> + =C2=A0 =C2=A0 =C2=A0 my $diffrepo =3D Git->repository(Repository =3D=
> $repo_path, WorkingCopy =3D> $workdir);
> + =C2=A0 =C2=A0 =C2=A0 my $diffrtn =3D $diffrepo->command_oneline('di=
ff', '--raw', '--no-abbrev', '-z', @ARGV);
> + =C2=A0 =C2=A0 =C2=A0 exit(0) if (length($diffrtn) =3D=3D 0);
> +
> + =C2=A0 =C2=A0 =C2=A0 if ($diffrtn =3D~ /::/) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print "Combined di=
ff formats ('-c' and '--cc') are not supported in directory diff mode.\=
n";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 # Setup temp directories
> + =C2=A0 =C2=A0 =C2=A0 my $tmpdir =3D tempdir('git-diffall.XXXXX', CL=
EANUP =3D> 1, TMPDIR =3D> 1);
> + =C2=A0 =C2=A0 =C2=A0 my $ldir =3D "$tmpdir/left";
> + =C2=A0 =C2=A0 =C2=A0 my $rdir =3D "$tmpdir/right";
> + =C2=A0 =C2=A0 =C2=A0 mkpath($ldir) or die $!;
> + =C2=A0 =C2=A0 =C2=A0 mkpath($rdir) or die $!;
> +
> + =C2=A0 =C2=A0 =C2=A0 # Build index info for left and right sides of=
 the diff
> + =C2=A0 =C2=A0 =C2=A0 my $submodule_mode =3D "160000";
> + =C2=A0 =C2=A0 =C2=A0 my $symlink_mode =3D "120000";
> + =C2=A0 =C2=A0 =C2=A0 my $null_mode =3D "0" x 6;
> + =C2=A0 =C2=A0 =C2=A0 my $null_sha1 =3D "0" x 40;
> + =C2=A0 =C2=A0 =C2=A0 my $lindex =3D "";
> + =C2=A0 =C2=A0 =C2=A0 my $rindex =3D "";

Super super tiny nit....

When reading Perl I expect to see DQ used only when $variable
interpolation is used.  Can we use ' instead of " for these strings in
the re-roll to address Junio's notes?
--=20
David
