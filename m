From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] hash binary sha1 into patch id
Date: Fri, 13 Aug 2010 11:40:27 +0200
Message-ID: <20100813094027.GA20906@localhost>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Cc: Marat Radchenko <marat@slonopotamus.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 11:40:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojqkl-0000Ov-Po
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 11:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934148Ab0HMJki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 05:40:38 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51811 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934113Ab0HMJkh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 05:40:37 -0400
Received: by ewy23 with SMTP id 23so1112665ewy.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 02:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=iii5+wZzxHMsQRpFoXh79f9J7HS9RqNFJIZcXfajXjw=;
        b=eF602sPTANNwxATsS22JIDcrTBONXOhRKjuzFX7JLZtuwoHv7PwzDT4AiUVnk8b6li
         MLfc9suqi6wk7NwlW0ngld7DWsas+xp1GnL1cC/IO2e/Y27nBlsauhyRIap/j7dnt+c4
         M7dDqKtwVhz0bTWthc2OLDt2W8HCDm6uHLdDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-type:content-disposition:user-agent;
        b=q/gDnJYRT2qw31IIRJ/KYWfGHrDikrqsIYpWnaU8eNZhIgT4m81M+g31WKvuTALbNz
         cOWgAidmKSgzC8x1Rlc0ujblj4+n1zfjWJUgP3yA8gBpf5LzVMWc2470C+NeOoH0zPfb
         sWFXuDT3IVR2HJxNqfwCM35oWSJo24qoucdGs=
Received: by 10.213.30.4 with SMTP id s4mr394842ebc.99.1281692436162;
        Fri, 13 Aug 2010 02:40:36 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id v8sm3854355eeh.20.2010.08.13.02.40.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 02:40:34 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OjqkV-0005SJ-P0; Fri, 13 Aug 2010 11:40:27 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153468>


--Y7xTucakfITjPcLV
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Since commit 2f82f760 (Take binary diffs into account for "git rebase"), bi=
nary
files are included in patch ID computation. Binary files are diffed using t=
he
text diff algorithm, however, which has a huge impact on performance. The
following tests performance for a 50000 line file marked as binary in
=2Egitattributes.

$ git format-patch --stdout --full-index --ignore-if-in-upstream master

real	0m0.367s
user	0m0.354s
sys	0m0.010s

Instead of hashing the diff of binary files, use the post-image sha1, which=
 is
just as unique. As a result, performance is much improved.

$ git format-patch --stdout --full-index --ignore-if-in-upstream master

real	0m0.016s
user	0m0.015s
sys	0m0.001s

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

This may be related to the rebase performance issue discussed in
the following thread.
=20
 http://mid.gmane.org/loom.20100713T082913-327@post.gmane.org

I am attaching the script which I used to test performance.

 diff.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 17873f3..20fc6db 100644
--- a/diff.c
+++ b/diff.c
@@ -3758,6 +3758,12 @@ static int diff_get_patch_id(struct diff_options *op=
tions, unsigned char *sha1)
 					len2, p->two->path);
 		git_SHA1_Update(&ctx, buffer, len1);
=20
+		if (diff_filespec_is_binary(p->two)) {
+			len1 =3D sprintf(buffer, "%s", sha1_to_hex(p->two->sha1));
+			git_SHA1_Update(&ctx, buffer, len1);
+			continue;
+		}
+
 		xpp.flags =3D 0;
 		xecfg.ctxlen =3D 3;
 		xecfg.flags =3D XDL_EMIT_FUNCNAMES;
--=20
1.7.2.1.1.g202c


--ibTvN161/egqYuK8
Content-Type: application/x-sh
Content-Disposition: attachment; filename="test-patchid.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0Aset -e=0A=0ANLINES=3D50000=0ANRAND=3D32768=0A# probability=
 of change in percent=0ACHG_PROB=3D30=0Aperf=3D=0Awhile test $# -gt 0=0Ado=
=0A	case $1 in=0A	-p)=0A		perf=3Dt=0A		;;=0A	-n)=0A		shift=0A		NLINES=3D$1=
=0A		;;=0A	*)=0A		break=0A		;;=0A	esac=0A	shift=0Adone=0A=0Aif test $# -gt =
0=0Athen=0A	export PATH=3D"$1:$PATH"=0A	shift=0Afi=0A=0Aif test $# -gt 0=0A=
then=0A	echo "too many arguments" >&2=0A	exit 1=0Afi=0A=0Adir=3D$(mktemp -d=
)=0A=0Ascramble()=0A{=0A	while read x=0A	do=0A		if test $RANDOM -lt $((($CH=
G_PROB * $NRAND)/100))=0A		then=0A			echo $RANDOM=0A		else=0A			echo "$x"=
=0A		fi=0A	done < $1 > $1.new=0A	mv -f file.new file=0A}=0A=0Arun()=0A{=0A	=
echo \$ "$@"=0A	if test -n "$perf"=0A	then=0A		perf record -g -f "$@" >/dev=
/null=0A		perf report -g=0A	else=0A		time "$@" >/dev/null=0A	fi=0A}=0A=0Acd=
 "$dir"=0Agit init -q=0A=0Afor i in $(seq $NLINES)=0Ado=0A	echo $i=0Adone >=
 file=0Agit add file=0Aecho "file binary" >.gitattributes=0Agit add .gitatt=
ributes=0Agit commit -q -m initial=0Agit branch other=0A=0Ascramble file=0A=
git add file=0Agit commit -q -m 'change big file'=0A=0Agit checkout -q othe=
r=0A: >newfile=0Agit add newfile=0Agit commit -q -m 'add small file'=0A=0Ag=
fp=3D"git format-patch --stdout --full-index"=0A=0Arun $gfp master=0Arun $g=
fp --ignore-if-in-upstream master=0A=0Agit cherry-pick master >/dev/null 2>=
&1=0A=0Agit checkout -q master=0Ascramble file=0Agit add file=0Agit commit =
-q -m 'change big file again'=0A=0Agit checkout -q other^{}=0Arun git rebas=
e master=0Aif test -n "$(git rev-list master...HEAD~)"=0Athen=0A	echo "patc=
h not identified" >&2=0A	exit 1=0Afi=0A=0Agit checkout -q -b squashed maste=
r=0Agit reset -q --soft HEAD~2=0Agit commit -q -m squashed=0Agit checkout -=
q other^{}=0Aif git rebase squashed >/dev/null=0Athen=0A	echo "patch droppe=
d" >&2=0A	exit 1=0Afi=0A=0Acd - >/dev/null=0Arm -rf "$dir"=0A
--ibTvN161/egqYuK8--

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMZRMHAAoJELKdZexG8uqM16UH/jQ9vSSOzBa+3Y7aywvAcqQO
C5o0x7JFJqjUUKiJlLf/ge1AtFb57DKvhTHakFDsFT//N5lV1JvdaAgzpyhVKI+Q
iHc6CQNtcRtAXFVnOqyFMHVvfuT8fQGRJJiSWyO3Sd7DoTVcLRWvKsW9f5lV4sTl
jzG5VXC70blKgPSPbk1eioKUW5h3ZnMPkrupIDB1ooqEFj+ZfQegYZbeZWm1MMWu
3JDoiBn8ePGBEL2dszyRO2s6HHC9XK9tE3U+u31LNifh4l5WA+sVVqVfYbDY1cV/
Lzg1SKFv73teJkR8KPJGfP5e+9nbWH7yw5B1M6zNNRCfX5Uh8x111tgwgRgEF4o=
=cLgd
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
