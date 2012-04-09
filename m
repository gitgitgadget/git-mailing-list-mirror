From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 8/9 v11] difftool: teach difftool to handle directory diffs
Date: Mon, 9 Apr 2012 05:14:49 -0700
Message-ID: <CAJDDKr76eMiA4rOHQhar3aToVThDfbc8Ki5tr2PGU_UpDMAVeA@mail.gmail.com>
References: <1333567265-23986-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, ramsay@ramsay1.demon.co.uk
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 09 14:14:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHDUm-00029F-G2
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 14:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660Ab2DIMOu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Apr 2012 08:14:50 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55560 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab2DIMOt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Apr 2012 08:14:49 -0400
Received: by ghrr11 with SMTP id r11so1739515ghr.19
        for <git@vger.kernel.org>; Mon, 09 Apr 2012 05:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3F6muWyEVjy6GqfjaCjmh5eiuwPmiFgYCM4gBrBAl10=;
        b=n2Qc8kknmGs9bmZatxpGiCo/o6Skii5BlWaq9fmo9q3bILDJRDQwIEjt5fKb3DX1gg
         W7gIwV3SijRqBlq8iv5s6qPOXLlIqQ/A/QLJj237Xmpv3DbsulJ/KuVoeHd/x4ImM+7m
         5quN2ucSp1YVkOhuFzHnol7kJp8uyjNIwbBRX2xlTg54oAX1QRgeE+JoVngbj23iMran
         hmOXNpj73evEqPKEw1Jpn/uVvoWcjPqN0TG7OQdghIGDWc6ubBl+tEMxkNFaM2BNTPHc
         WoYzwE5JPIri2J9zgHSEAqrMlp0+ZVCBMy0SoYakm8o8ePO6pRqkOfMsoN79GeItcTAr
         8InA==
Received: by 10.101.152.34 with SMTP id e34mr1778010ano.13.1333973689108; Mon,
 09 Apr 2012 05:14:49 -0700 (PDT)
Received: by 10.147.128.8 with HTTP; Mon, 9 Apr 2012 05:14:49 -0700 (PDT)
In-Reply-To: <1333567265-23986-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195014>

On Wed, Apr 4, 2012 at 12:21 PM, Tim Henigan <tim.henigan@gmail.com> wr=
ote:
> diff --git a/git-difftool.perl b/git-difftool.perl
> index d4fe998..5bb01e1 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -1,21 +1,29 @@
> =C2=A0#!/usr/bin/env perl
> =C2=A0# Copyright (c) 2009, 2010 David Aguilar
> +# Copyright (c) 2012 Tim Henigan
> =C2=A0#
> =C2=A0# This is a wrapper around the GIT_EXTERNAL_DIFF-compatible
> =C2=A0# git-difftool--helper script.
> =C2=A0#
> =C2=A0# This script exports GIT_EXTERNAL_DIFF and GIT_PAGER for use b=
y git.
> -# GIT_DIFFTOOL_NO_PROMPT, GIT_DIFFTOOL_PROMPT, and GIT_DIFF_TOOL
> -# are exported for use by git-difftool--helper.
> +# GIT_DIFFTOOL_NO_PROMPT, GIT_DIFFTOOL_PROMPT, GIT_DIFFTOOL_DIRDIFF,
> +# and GIT_DIFF_TOOL are exported for use by git-difftool--helper.

What if we punt on enumerating each variable and reword this to:

# This script exports GIT_EXTERNAL_DIFF and GIT_PAGER for use by git.
# The GIT_DIFF* variables are exported for use by git-difftool--helper.

I also think we should change the shebang line to #!/usr/bin/perl.


> @@ -24,15 +32,121 @@ usage: git difftool [-t|--tool=3D<tool>]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 [-x|--extcmd=3D<cmd>]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 [-g|--gui] [--no-gui]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 [--prompt] [-y|--no-prompt]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
[-d|--dir-diff]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 ['git diff' options]
> =C2=A0USAGE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0exit($exitcode);
> =C2=A0}
>
> +sub setup_dir_diff
> +{
> + =C2=A0 =C2=A0 =C2=A0 # Run the diff; exit immediately if no diff fo=
und
> + =C2=A0 =C2=A0 =C2=A0 my $repo =3D Git->repository();
> + =C2=A0 =C2=A0 =C2=A0 my $diffrtn =3D $repo->command_oneline(['diff'=
, '--raw', '--no-abbrev', '-z', @ARGV]);
> + =C2=A0 =C2=A0 =C2=A0 exit(0) if (length($diffrtn) =3D=3D 0);
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
> + =C2=A0 =C2=A0 =C2=A0 my $null_mode =3D 0 x 6;
> + =C2=A0 =C2=A0 =C2=A0 my $null_sha1 =3D 0 x 40;

I know Perl allows it, but my eyes get confused.

How about writing "0" x 6 and "0" x 40?
That way we can visually see that the result is a string.


> + =C2=A0 =C2=A0 =C2=A0 my $lindex =3D "";
> + =C2=A0 =C2=A0 =C2=A0 my $rindex =3D "";
> + =C2=A0 =C2=A0 =C2=A0 my %submodule;
> + =C2=A0 =C2=A0 =C2=A0 my @rawdiff =3D split('\0', $diffrtn);
> +
> + =C2=A0 =C2=A0 =C2=A0 for (my $i=3D0; $i<@rawdiff; $i+=3D2) {

We use $i + 1 to grab list elements, so how about $#rawdiff instead of =
@rawdiff?
It doesn't matter in practice, though...


> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 my ($lmode, $rmode=
, $lsha1, $rsha1, $status) =3D split(' ', substr($rawdiff[$i], 1));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 my $path =3D $rawd=
iff[$i + 1];
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (($lmode eq $su=
bmodule_mode) or ($rmode eq $submodule_mode)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 $submodule{$path}{left} =3D $lsha1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if ($lsha1 ne $rsha1) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $submodule{$path}{right} =3D $rsha1=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $submodule{$path}{right} =3D "$rsha=
1-dirty";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 next;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ($lmode ne $nul=
l_mode) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 $lindex .=3D "$lmode $lsha1\t$path\0";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ($rmode ne $nul=
l_mode) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if ($rsha1 ne $null_sha1) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $rindex .=3D "$rmode $rsha1\t$path\=
0";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 push(@working_tree, $path);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 # Populate the left and right directories base=
d on each index file
> + =C2=A0 =C2=A0 =C2=A0 my ($inpipe, $ctx);
> + =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_DIR} =3D $repo->repo_path();
> + =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_INDEX_FILE} =3D "$tmpdir/lindex";
> + =C2=A0 =C2=A0 =C2=A0 ($inpipe, $ctx) =3D $repo->command_input_pipe(=
qw/update-index -z --index-info/);
> + =C2=A0 =C2=A0 =C2=A0 print($inpipe $lindex);
> + =C2=A0 =C2=A0 =C2=A0 $repo->command_close_pipe($inpipe, $ctx);
> + =C2=A0 =C2=A0 =C2=A0 system(('git', 'checkout-index', '--all', "--p=
refix=3D$ldir/"));

Please drop the extra parens.  Perl ignores them.
We should also check the return value from system() here.


> +
> + =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_INDEX_FILE} =3D "$tmpdir/rindex";
> + =C2=A0 =C2=A0 =C2=A0 ($inpipe, $ctx) =3D $repo->command_input_pipe(=
qw/update-index -z --index-info/);
> + =C2=A0 =C2=A0 =C2=A0 print($inpipe $rindex);
> + =C2=A0 =C2=A0 =C2=A0 $repo->command_close_pipe($inpipe, $ctx);
> + =C2=A0 =C2=A0 =C2=A0 system(('git', 'checkout-index', '--all', "--p=
refix=3D$rdir/"));
> +
> + =C2=A0 =C2=A0 =C2=A0 # Changes in the working tree need special tre=
atment since they are
> + =C2=A0 =C2=A0 =C2=A0 # not part of the index
> + =C2=A0 =C2=A0 =C2=A0 my $workdir =3D $repo->repo_path() . "/..";
> + =C2=A0 =C2=A0 =C2=A0 for (@working_tree) {

Please use the "for my $foo (@list)" form so we can say $foo instead of=
 $_.


> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 my $dir =3D dirnam=
e($_);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unless (-d "$rdir/=
$dir") {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 mkpath("$rdir/$dir") or die $!;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 copy("$workdir/$_"=
, "$rdir/$_") or die $!;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chmod(stat("$workd=
ir/$_")->mode, "$rdir/$_") or die $!;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 # Changes to submodules require special treatm=
ent. This loop writes a
> + =C2=A0 =C2=A0 =C2=A0 # temporary file to both the left and right di=
rectories to show the
> + =C2=A0 =C2=A0 =C2=A0 # change in the recorded SHA1 for the submodul=
e.
> + =C2=A0 =C2=A0 =C2=A0 foreach my $path (keys %submodule) {

I think it's better to use "for" instead of "foreach" since we do not
modify $path.


> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (defined $submo=
dule{$path}{left}) {

In some places we write "defined(...)" but here it's "defined ...".
We should be consistent...


> @@ -65,22 +179,40 @@ if ($gui) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$ENV{GIT_DIFF_=
TOOL} =3D $guitool;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
> -if (defined($prompt)) {
> - =C2=A0 =C2=A0 =C2=A0 if ($prompt) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_DIFFTOOL_=
PROMPT} =3D 'true';
> +
> +# In directory diff mode, 'git-difftool--helper' is called once
> +# to compare the a/b directories. =C2=A0In file diff mode, 'git diff=
'
> +# will invoke a separate instance of 'git-difftool--helper' for
> +# each file that changed.
> +if (defined($dirdiff)) {
> + =C2=A0 =C2=A0 =C2=A0 my ($a, $b) =3D setup_dir_diff();
> + =C2=A0 =C2=A0 =C2=A0 if (defined($extcmd)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 system(($extcmd, $=
a, $b));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_DIFFTOOL_=
NO_PROMPT} =3D 'true';
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_DIFFTOOL_=
DIRDIFF} =3D 'true';
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 system(('git', 'di=
fftool--helper', $a, $b));
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 # If the diff including working copy files and=
 those
> + =C2=A0 =C2=A0 =C2=A0 # files were modified during the diff, then th=
e changes
> + =C2=A0 =C2=A0 =C2=A0 # should be copied back to the working tree
> + =C2=A0 =C2=A0 =C2=A0 my $repo =3D Git->repository();
> + =C2=A0 =C2=A0 =C2=A0 my $workdir =3D $repo->repo_path() . "/..";

Does this work when $GIT_WORK_TREE / core.worktree are defined?


> + =C2=A0 =C2=A0 =C2=A0 for (@working_tree) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 copy("$b/$_", "$wo=
rkdir/$_") or die $!;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chmod(stat("$b/$_"=
)->mode, "$workdir/$_") or die $!;
> + =C2=A0 =C2=A0 =C2=A0 }

"for my ..."


> +} else {
> + =C2=A0 =C2=A0 =C2=A0 if (defined($prompt)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ($prompt) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 $ENV{GIT_DIFFTOOL_PROMPT} =3D 'true';
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 $ENV{GIT_DIFFTOOL_NO_PROMPT} =3D 'true';
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> -}
>
> -$ENV{GIT_PAGER} =3D '';
> -$ENV{GIT_EXTERNAL_DIFF} =3D 'git-difftool--helper';
> -my @command =3D ('git', 'diff', @ARGV);
> -
> -# ActiveState Perl for Win32 does not implement POSIX semantics of
> -# exec* system call. It just spawns the given executable and finishe=
s
> -# the starting program, exiting with code 0.
> -# system will at least catch the errors returned by git diff,
> -# allowing the caller of git difftool better handling of failures.
> -my $rc =3D system(@command);
> -exit($rc | ($rc >> 8));
> + =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_PAGER} =3D '';
> + =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_EXTERNAL_DIFF} =3D 'git-difftool--hel=
per';
> + =C2=A0 =C2=A0 =C2=A0 my $rc =3D system(('git', 'diff', @ARGV));
> + =C2=A0 =C2=A0 =C2=A0 exit($rc | ($rc >> 8));
> +}


We went back and forth a few times on this section,
eventually landing back on using system().

Should we retain this comment to help future readers from
having to re-learn it the hard way again?

We could also link to the ML threads, if you think that's helpful.
--=20
David
