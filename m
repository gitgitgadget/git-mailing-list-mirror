From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH/gitolite] Tell gitweb about repo owner via git-config
Date: Wed, 3 Feb 2010 15:58:42 +0530
Message-ID: <2e24e5b91002030228h12c3fa78pe1cece1de09876de@mail.gmail.com>
References: <1265184827-11364-1-git-send-email-madduck@madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "martin f. krafft" <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 11:29:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NccTY-0007J3-Ec
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 11:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437Ab0BCK2n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 05:28:43 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:46057 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932427Ab0BCK2m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 05:28:42 -0500
Received: by pxi12 with SMTP id 12so1275399pxi.33
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 02:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uvH9T3DaRGQQjqEGsW45TBAQikaQH90Qf6V0ezkHXfM=;
        b=nSKkDQoF2I/vYUL0pevbDlj3E90Fd3p7Ysq1OZ0kPRMLzchWL1xwOuKuTnGkQ8IseS
         ns1/J1Djrv9/VHK72k19dSk1WGfgfE9TCrDZ2dl/9WapzwWwN0mK0HVwQ0ZPjjR0GjQ0
         xL1OGqNTAuRpzKMvmtFhBxfTwTOmHypbmpFd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AlWaGY4woaw6wmcERhqLfPeKbTifTXbI5C/anEbMeQP3Pw8gHicBCBfjQNkY32cz0g
         4leH8C2j83kBAPrHiXTbsPS/jaeK7IGH0cfzZubI0gRcQHL9gUPZIqKyZ1btEGy4wT32
         PtjeVU6iwvohmgV+b1PH+v+GZCLW13jvIFQNU=
Received: by 10.114.7.10 with SMTP id 10mr2131894wag.90.1265192922290; Wed, 03 
	Feb 2010 02:28:42 -0800 (PST)
In-Reply-To: <1265184827-11364-1-git-send-email-madduck@madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138826>

On Wed, Feb 3, 2010 at 1:43 PM, martin f. krafft <madduck@madduck.net> =
wrote:
> Gitolite uses projects.list to set the owners for gitweb's use.
> Unfortunately, this does not work for gitweb setups that set
> $projectroot to a directory, thus generating the list of
> repositories on the fly.
>
> This patch changes that: gitolite now writes the gitweb.owner
> configuration variable for each repository (and properly cleans up af=
ter
> itself if the owner is removed).
>
> The patch causes gitolite not to write the owner to projects.list
> anymore, as this would be redundant.
>
> The owner also needs no longer be escaped, so this patch removes the
> poor man's 's/ /+/g' escaping previously in place.
>
> Note that I am not a Perl coder. Thus there are probably better ways =
to
> implement this, but at least it works.
>
> Cc: Sitaram Chamarty <sitaramc@gmail.com>
> Signed-off-by: martin f. krafft <madduck@madduck.net>
> ---
> =C2=A0src/gl-compile-conf | =C2=A0 19 +++++++++++++++++--
> =C2=A01 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/src/gl-compile-conf b/src/gl-compile-conf
> index e88819a..7cd5d2e 100755
> --- a/src/gl-compile-conf
> +++ b/src/gl-compile-conf
> @@ -284,7 +284,6 @@ sub parse_conf_file
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die "$WARN $fragment attemp=
ting to set description for $repo\n" if
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $fragment ne =
'master' and $fragment ne $repo and ($groups{"\@$fragment"}{$repo} || '=
') ne 'master';
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $desc{"$repo.git"} =3D $des=
c;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$owner =3D~ s/ /+/g if $ow=
ner; =C2=A0 =C2=A0# gitweb/INSTALL wants more, but meh...!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $owner{"$repo.git"} =3D $ow=
ner || '';
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> @@ -414,16 +413,32 @@ for my $repo (sort keys %repos) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 $projlist{"$repo.git"} =3D 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 # add the description file; no messages t=
o user or error checking :)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 $desc{"$repo.git"} and open(DESC, ">", $d=
esc_file) and print DESC $desc{"$repo.git"} . "\n" and close DESC;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if ($owner{"$repo.git"}) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# set the repository owner
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system("git --git-dir=3D$r=
epo.git config gitweb.owner '" . $owner{"$repo.git"} . "'");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# remove the repository ow=
ner setting
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system("git --git-dir=3D$r=
epo.git config --unset-all gitweb.owner 2>/dev/null");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 } else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 # delete the description file; no message=
s to user or error checking :)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 unlink $desc_file;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0# remove the repository owner setting
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0system("git --git-dir=3D$repo.git config=
 --unset-all gitweb.owner 2>/dev/null");
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0# unless there are other gitweb.* keys set, remove the=
 section to keep the
> + =C2=A0 =C2=A0# config file clean
> + =C2=A0 =C2=A0my $keys =3D `git --git-dir=3D$repo.git config --get-r=
egexp '^gitweb\\.' 2>/dev/null`;
> + =C2=A0 =C2=A0if (length($keys) =3D=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0system("git --git-dir=3D$repo.git config=
 --remove-section gitweb 2>/dev/null");
> =C2=A0 =C2=A0 }
> =C2=A0}
>
> =C2=A0# update the project list
> =C2=A0my $projlist_fh =3D wrap_open( ">", $PROJECTS_LIST);
> =C2=A0for my $proj (sort keys %projlist) {
> - =C2=A0 =C2=A0print $projlist_fh "$proj" . ( $owner{$proj} ? " $owne=
r{$proj}" : "" ) . "\n";
> + =C2=A0 =C2=A0print $projlist_fh "$proj\n";
> =C2=A0}
> =C2=A0close $projlist_fh;
>
> --
> 1.6.6
>
>

Thanks; applied to "pu" branch with a slight modification of the git
command that sets the owner (the first one).

--=20
Sitaram
