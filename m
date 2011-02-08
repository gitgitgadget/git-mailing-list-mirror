From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: [PATCH 7/8] git-p4: decode p4 wildcard characters
Date: Tue, 8 Feb 2011 10:09:42 +0100
Message-ID: <AANLkTi=Gah9yeYYnHPZ2Z6-OZQ2-CU5Kub=o5SqWAXht@mail.gmail.com>
References: <20110205224848.GA30963@arf.padd.com>
	<20110205225237.GH30963@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 10:09:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmja3-00006I-B2
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 10:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110Ab1BHJJp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Feb 2011 04:09:45 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40477 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab1BHJJn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Feb 2011 04:09:43 -0500
Received: by yxt3 with SMTP id 3so2121569yxt.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 01:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HYQhar6L/hyG8s3E3hayiy1P7HVcmeCr7uSlBITEbuc=;
        b=c5wTwmoL7hqBq1/pjC8N8B0Jf4iZWOmOi9HRTQ0ABCXmJplv0wHZycwUzUFCwkXyTB
         hATZ8+pqkwKpS41NqqqUs6/3tN7zAJek6QsEXM3x2iyeu1K+US6kHGYM+vcsFVBU6kA9
         m7S8uNlPxltyvBJFkeTPNh6MsISBN2M55s148=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gFYrLFDxDQsuYllZUqRCusnRYLwQ9Hx7KNK5FOe5t13ccOpQlbqsF2H5qXah4vFlCe
         gR3v3cVyoH4+WcEk012Sgg+gFNITsOhD5vRX6KXxzgDg2O6FR8xS09Nv8rv+C6u4ukKH
         RmUtqocOijtRdKPPbAJNqqHz65sUaDBjTgb+M=
Received: by 10.100.165.20 with SMTP id n20mr10253991ane.114.1297156182595;
 Tue, 08 Feb 2011 01:09:42 -0800 (PST)
Received: by 10.101.1.19 with HTTP; Tue, 8 Feb 2011 01:09:42 -0800 (PST)
In-Reply-To: <20110205225237.GH30963@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166341>

On Sat, Feb 5, 2011 at 11:52 PM, Pete Wyckoff <pw@padd.com> wrote:
> There are four wildcard characters in p4. =C2=A0Files with these
> characters can be added to p4 repos using the "-f" option.
> They are stored in %xx notation, and when checked out, p4
> converts them back to normal.
>
> This patch does the same thing when importing into git,
> converting the four special characters. =C2=A0Without this change,
> the files appear with literal %xx in their names.
>
> Signed-off-by: Pete Wyckoff <pw@padd.com>
> ---
> =C2=A0contrib/fast-import/git-p4 | =C2=A0 13 +++++++++++++
> =C2=A0t/t9800-git-p4.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 22=
 ++++++++++++++++++++++
> =C2=A02 files changed, 35 insertions(+), 0 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 04e6c3d..5b08cd6 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -884,6 +884,18 @@ class P4Sync(Command):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if gitConfig("git-p4.syncFromOrigin") =3D=
=3D "false":
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.syncWithOrigin =3D Fal=
se
>
> + =C2=A0 =C2=A0# The p4 wildcards are not allowed in filenames. =C2=A0=
It complains
> + =C2=A0 =C2=A0# if you try to add them, but you can override with "-=
f", in
> + =C2=A0 =C2=A0# which case it translates them into %xx encoding. =C2=
=A0Search for
> + =C2=A0 =C2=A0# and fix just these four characters. =C2=A0Do % last =
so it does
> + =C2=A0 =C2=A0# not inadvertantly create new %-escapes.
> + =C2=A0 =C2=A0def wildcard_decode(self, path):
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D path.replace("%23", "#") \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .rep=
lace("%2A", "*") \

This probably works fine on UNIX platforms, but the asterisk '*'
character is not allowed in windows filenames. I don't really know
what perforce does in that scenario. Does it make the most sense to
just keep the %2A in the filename if we are running on windows (??)

    -- Tor Arvid

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .rep=
lace("%40", "@") \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .rep=
lace("%25", "%")
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return path
> +
> =C2=A0 =C2=A0 def extractFilesFromCommit(self, commit):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.cloneExclude =3D [re.sub(r"\.\.\.$",=
 "", path)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for path in self.cloneExclude]
> @@ -962,6 +974,7 @@ class P4Sync(Command):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 relPath =3D self.stripRepoPath(file['depo=
tFile'], self.branchPrefixes)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0relPath =3D self.wildcard_decode(relPath=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if verbose:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.stderr.write("%s\n" % r=
elPath)
>
> diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
> index 41e57bb..72c38af 100755
> --- a/t/t9800-git-p4.sh
> +++ b/t/t9800-git-p4.sh
> @@ -65,6 +65,28 @@ test_expect_success 'exit when p4 fails to produce=
 marshaled output' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail grep -q Traceback errs
> =C2=A0'
>
> +test_expect_success 'add p4 files with wildcards in the names' '
> + =C2=A0 =C2=A0 =C2=A0 cd "$cli" &&
> + =C2=A0 =C2=A0 =C2=A0 echo file-wild-hash >file-wild#hash &&
> + =C2=A0 =C2=A0 =C2=A0 echo file-wild-star >file-wild\*star &&
> + =C2=A0 =C2=A0 =C2=A0 echo file-wild-at >file-wild@at &&
> + =C2=A0 =C2=A0 =C2=A0 echo file-wild-percent >file-wild%percent &&
> + =C2=A0 =C2=A0 =C2=A0 p4 add -f file-wild* &&
> + =C2=A0 =C2=A0 =C2=A0 p4 submit -d "file wildcards" &&
> + =C2=A0 =C2=A0 =C2=A0 cd "$TRASH_DIRECTORY"
> +'
> +
> +test_expect_success 'wildcard files git-p4 clone' '
> + =C2=A0 =C2=A0 =C2=A0 "$GITP4" clone --dest=3D"$git" //depot &&
> + =C2=A0 =C2=A0 =C2=A0 cd "$git" &&
> + =C2=A0 =C2=A0 =C2=A0 test -f file-wild#hash &&
> + =C2=A0 =C2=A0 =C2=A0 test -f file-wild\*star &&
> + =C2=A0 =C2=A0 =C2=A0 test -f file-wild@at &&
> + =C2=A0 =C2=A0 =C2=A0 test -f file-wild%percent &&
> + =C2=A0 =C2=A0 =C2=A0 cd "$TRASH_DIRECTORY" &&
> + =C2=A0 =C2=A0 =C2=A0 rm -rf "$git" && mkdir "$git"
> +'
> +
> =C2=A0test_expect_success 'shutdown' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pid=3D`pgrep -f p4d` &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test -n "$pid" &&
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
