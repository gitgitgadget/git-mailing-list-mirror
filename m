From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 7/9] difftool: teach difftool to handle directory diffs
Date: Tue, 20 Mar 2012 13:43:52 -0400
Message-ID: <CAFouetiSyTFAR=CJBuYEcpUDq=f2jVaOMnsThgEP-zSbTH1H_g@mail.gmail.com>
References: <1331949574-15192-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 18:44:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA36F-00053h-4z
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 18:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838Ab2CTRny convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Mar 2012 13:43:54 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43537 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab2CTRnx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Mar 2012 13:43:53 -0400
Received: by iagz16 with SMTP id z16so302252iag.19
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 10:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=GovB+MmqxaRGd7BY8vd65b9VrR9J8DOO87adQMa2Oy4=;
        b=QwdKpEUyK1A3KVjeqeasfUH3tG5A/mjAiK54XZYq5HECxknBKEwiNJqF340ARRvAJk
         6dR0bfUMJgqft3LHXJZg8tpEhCnDpkVeHqNuimlOICIH/1dg1EfKpkb4ZF0FmfXD54kC
         lNjHHRwoBKY9lpGlGq5tLni/ukkBWrhcpht3uCMstwSbvQcTg+gUnp98Ei/QTOQOr67q
         Ak920uZ9pMy2SFt2NzTIEknjUMGfOw5e6/WdZg2i6rZjlWhZ76FKyaqGngqnzMv9cwiE
         Pxe8w96/DOlmy6kyms2D8f8CBjeak6+zVgnzfFCGid37TDprxUZ0r8D2KuY38OQq3uBC
         dkZw==
Received: by 10.42.203.67 with SMTP id fh3mr454859icb.44.1332265432980; Tue,
 20 Mar 2012 10:43:52 -0700 (PDT)
Received: by 10.42.138.5 with HTTP; Tue, 20 Mar 2012 10:43:52 -0700 (PDT)
In-Reply-To: <1331949574-15192-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193523>

I have run into a problem with the way that the tmp directories are
populated using 'git update-index' and 'git checkout-index'.  I would
appreciate any feedback that may help me understand what I am doing
wrong.

This is in regard to the following section of code:

On Fri, Mar 16, 2012 at 9:59 PM, Tim Henigan <tim.henigan@gmail.com> wr=
ote:
>
> +sub setup_dir_diff
> +{
> + =C2=A0 =C2=A0 =C2=A0 # Run the diff; exit immediately if no diff fo=
und
> + =C2=A0 =C2=A0 =C2=A0 my $repo =3D Git->repository();
> + =C2=A0 =C2=A0 =C2=A0 my $diffrtn =3D $repo->command_oneline(['diff'=
, '--raw', '--no-abbrev', '-z', @ARGV]);
> + =C2=A0 =C2=A0 =C2=A0 exit(0) if (length($diffrtn) =3D=3D 0);

<snip>

> + =C2=A0 =C2=A0 =C2=A0 my @rawdiff =3D split('\0', $diffrtn);
> +
> + =C2=A0 =C2=A0 =C2=A0 for (my $i=3D0; $i<@rawdiff; $i+=3D2) {
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
 =C2=A0 $submodule{$path}{right} =3D $rsha1;
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
> + =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_INDEX_FILE} =3D "$tmpdir/lindex";
> + =C2=A0 =C2=A0 =C2=A0 ($inpipe, $ctx) =3D $repo->command_input_pipe(=
qw/update-index -z --index-info/);
> + =C2=A0 =C2=A0 =C2=A0 print($inpipe $lindex);
> + =C2=A0 =C2=A0 =C2=A0 $repo->command_close_pipe($inpipe, $ctx);
> + =C2=A0 =C2=A0 =C2=A0 $repo->command_oneline(["checkout-index", "-a"=
, "--prefix=3D$ldir/"]);

When run from the root directory of a Git repository, the 'difftool
--dir-diff' command operates as expected:
  - Temporary index files for each side of the diff are created using
'git update-index'.
  - 'git checkout-index --all --prefix=3D$tmp' is used to populate the
tmp directory based on the index file.

However, when 'difftool --dir-diff' is run from a subdirectory of the
Git repository, there are problems.
  - The temporary index file generated by 'git update-index' appears
to be correct.
  - 'git checkout-index --all --prefix=3D$tmp' command does not work
(output tmp dir is empty).

I have tried some combinations of setting $ENV{GIT_DIR} and
$ENV{GIT_WORK_TREE}, but it has not fixed the problem.  Is there
anything obvious that I missed?
