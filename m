From: Daniel Hahler <genml+git-2014@thequod.de>
Subject: git: regression with mergetool and answering "n" (backport fix /
 add tests)
Date: Tue, 23 Dec 2014 20:08:34 +0100
Message-ID: <5499BDB2.4070301@thequod.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="0grieQqR7KPw239cFAofrtdBjXmS3VeqO"
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 20:08:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Up3-0005aB-Jp
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 20:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbaLWTIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 14:08:41 -0500
Received: from hahler.de ([188.40.33.212]:46835 "EHLO elfe.thequod.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbaLWTIk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 14:08:40 -0500
Received: from localhost (amavis [10.122.1.24])
	by elfe.thequod.de (Postfix) with ESMTP id 86144620D1;
	Tue, 23 Dec 2014 20:08:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thequod.de; h=
	content-type:content-type:subject:subject:mime-version
	:user-agent:from:from:date:date:message-id:received:received; s=
	postfix2; t=1419361717; bh=vjkF+vxnDj+C5DanSckkV46v6b3GXsX57LS0V
	0Et1hQ=; b=uG1o1kHTlO0+0F4ztV8hFECcIMc7H5bBQXjPDGGGcwqinTxVukaY1
	U0inAsIaV2R6vkF/BV2Eh4vm9YEwDXPE6oE5+foMzkvhOQdmTRFRSGED7zV6majb
	f/4lqBVSc04ffemayx6GDo67BEOZAaTnB6FzJbd0hNbQeaaLuryFR4=
Received: from elfe.thequod.de ([10.122.1.25])
	by localhost (amavis.thequod.de [10.122.1.24]) (amavisd-new, port 10026)
	with ESMTP id jg4Jsid1QPQI; Tue, 23 Dec 2014 20:08:37 +0100 (CET)
Received: from lenny.thequod.de (p5DE6FC4C.dip0.t-ipconnect.de [93.230.252.76])
	(Authenticated sender: daniel@hahler.de)
	by elfe.thequod.de (Postfix) with ESMTPSA;
	Tue, 23 Dec 2014 20:08:37 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261766>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0grieQqR7KPw239cFAofrtdBjXmS3VeqO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

this is in reply to the commits from David:

    commit 0ddedd4d6b9b3e8eb3557d8ed28e1a0b354a25f8
    Refs: v2.2.0-60-g0ddedd4
    Merge: e886efd 1e86d5b
    Author:     Junio C Hamano <gitster@pobox.com>
    AuthorDate: Fri Dec 12 14:31:39 2014 -0800
    Commit:     Junio C Hamano <gitster@pobox.com>
    CommitDate: Fri Dec 12 14:31:39 2014 -0800

        Merge branch 'da/difftool-mergetool-simplify-reporting-status'

        Code simplification.

        * da/difftool-mergetool-simplify-reporting-status:
          mergetools: stop setting $status in merge_cmd()
          mergetool: simplify conditionals
          difftool--helper: add explicit exit statement
          mergetool--lib: remove use of $status global
          mergetool--lib: remove no-op assignment to $status from setup_u=
ser_tool

I've ran into a problem, where "git mergetool" (using vimdiff) would add
the changes to the index, although you'd answered "n" after not changing/=
saving
the merged file.

This regression has been introduced in:

    commit 99474b6340dbcbe58f6c256fdee231cbadb060f4
    Author: David Aguilar <davvid@gmail.com>
    Date:   Fri Nov 14 13:33:55 2014 -0800

        difftool: honor --trust-exit-code for builtin tools
       =20
        run_merge_tool() was not setting $status, which prevented the
        exit code for builtin tools from being forwarded to the caller.
       =20
        Capture the exit status and add a test to guarantee the behavior.=

       =20
        Reported-by: Adria Farres <14farresa@gmail.com>
        Signed-off-by: David Aguilar <davvid@gmail.com>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>

    diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
    index c45a020..cce4f8c 100644
    --- a/git-mergetool--lib.sh
    +++ b/git-mergetool--lib.sh
    @@ -221,6 +221,7 @@ run_merge_tool () {
            else
                    run_diff_cmd "$1"
            fi
    +       status=3D$?
            return $status
     }


My fix has been the following, but I agree that the changes from David
are much better in general.

    diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
    index cce4f8c..fa9acb1 100644
    --- a/git-mergetool--lib.sh
    +++ b/git-mergetool--lib.sh
    @@ -105,6 +105,7 @@ check_unchanged () {
                            esac
                    done
            fi
    +       return $status
     }
    =20
     valid_tool () {

I haven't verified if it really fixes the regression, but if it does it
should get backported into the branches where the regression is present.


Also, there should be some tests for this. I've came up with the
following, which is not finished and left in a state of debugging why it
did not trigger the bug.

In t/t7610-mergetool.sh:

  test_expect_success 'return code with untrusted mergetool' '
      # git config merge.tool untrusted &&
      # git config mergetool.untrusted.cmd "true" &&
      # git config mergetool.untrusted.trustExitCode false &&
          test_config mergetool.vimdiff.cmd "cat \"\$REMOTE\"" &&
      git config merge.tool vimdiff &&
      git config --get-regexp mergetool.
      git config --get-regexp merge\.tool.

      git checkout -b test_untrusted branch1 &&
      test_must_fail git merge master >/dev/null 2>&1 &&
      git status -s &&
      test "$(git status --short both)" =3D "AA both" &&
      ( echo "n" | test_must_fail git mergetool both ) &&
      git status -s &&

      test "$(git status --short both)" =3D "AA both" &&
      ( echo "y" | git mergetool both ) &&
      git status -s &&
      test "$(git status --short both)" =3D "M  both" &&
      git reset --hard &&
      git config merge.tool mytool


Cheers,
Daniel.

--=20
http://daniel.hahler.de/



--0grieQqR7KPw239cFAofrtdBjXmS3VeqO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iD8DBQFUmb2yfAK/hT/mPgARAky3AKChxX2pQi2E/Fc2Etij+UDpJedfIACgk39y
EN+kVD4t0B/9wmPWkUibELc=
=y4n6
-----END PGP SIGNATURE-----

--0grieQqR7KPw239cFAofrtdBjXmS3VeqO--
