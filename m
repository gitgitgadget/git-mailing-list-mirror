From: Pavel Roskin <proski@gnu.org>
Subject: Re: [StGit PATCH] mail: Ask for the SMTP credentials before
 sending the messages
Date: Fri, 12 Feb 2010 17:56:51 -0500
Message-ID: <1266015411.25535.21.camel@mj>
References: <20100212161150.12036.62592.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Karl Wiberg <kha@treskal.com>,
	Alex Chiang <achiang@hp.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 23:57:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng4Rk-00084n-SZ
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 23:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143Ab0BLW5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 17:57:08 -0500
Received: from c60.cesmail.net ([216.154.195.49]:38892 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963Ab0BLW5D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 17:57:03 -0500
Received: from unknown (HELO smtprelay1.cesmail.net) ([192.168.1.111])
  by c60.cesmail.net with ESMTP; 12 Feb 2010 17:57:03 -0500
Received: from [192.168.0.22] (unknown [72.92.88.10])
	by smtprelay1.cesmail.net (Postfix) with ESMTPSA id 79DE334C69;
	Fri, 12 Feb 2010 17:56:56 -0500 (EST)
In-Reply-To: <20100212161150.12036.62592.stgit@pc1117.cambridge.arm.com>
X-Mailer: Evolution 2.26.3 (2.26.3-1.fc11) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139763>

On Fri, 2010-02-12 at 16:11 +0000, Catalin Marinas wrote:
> The original implementation was asking for the SMTP password on every
> patch sent. This patch only asks the password once before sending or
> even editing the cover message and patches.

I don't have time to investigate at the moment, but "make test" fails i=
n
t1900-mail.sh on the "proposed" branch, which includes this patch:

*** t1900-mail.sh ***
*   ok 1: Initialize the StGIT repository
*   ok 2: Put all the patches in an mbox
*   ok 3: Import the mbox and compare
* FAIL 4: Put all the patches in an mbox with patch attachments
        stg mail --to=3D"Inge Str=C3=83=C2=B6m <inge@example.com>" -a -=
m \
               -t ../../templates/mailattch.tmpl > mbox1
* FAIL 5: Import the mbox containing patch attachments and compare

            t1=3D$(git cat-file -p $(stg id) | grep ^tree)
            stg pop -a &&
            stg import -M mbox1 &&
            t2=3D$(git cat-file -p $(stg id) | grep ^tree) &&
            [ "$t1" =3D "$t2" ]
           =20
* FAIL 6: Check the To:, Cc: and Bcc: headers

            stg mail --to=3Da@a --cc=3D"b@b, c@c" --bcc=3Dd@d $(stg top=
) -m \
                -t ../../templates/patchmail.tmpl > mbox &&
            test "$(cat mbox | grep -e "^To:")" =3D "To: a@a" &&
            test "$(cat mbox | grep -e "^Cc:")" =3D "Cc: b@b, c@c" &&
            test "$(cat mbox | grep -e "^Bcc:")" =3D "Bcc: d@d"
           =20
* FAIL 7: Check the --auto option

            stg edit --sign &&
            stg mail --to=3Da@a --cc=3D"b@b, c@c" --bcc=3Dd@d --auto $(=
stg top) -m \
                -t ../../templates/patchmail.tmpl > mbox &&
            test "$(cat mbox | grep -e "^To:")" =3D "To: a@a" &&
            test "$(cat mbox | grep -e "^Cc:")" =3D \
                "Cc: C O Mitter <committer@example.com>, b@b, c@c" &&
            test "$(cat mbox | grep -e "^Bcc:")" =3D "Bcc: d@d"
           =20
* FAIL 8: Check the e-mail address duplicates

            stg mail --to=3D"a@a, b b <b@b>" --cc=3D"b@b, c@c" \
                --bcc=3D"c@c, d@d, committer@example.com" --auto $(stg =
top) -m \
                -t ../../templates/patchmail.tmpl > mbox &&
            test "$(cat mbox | grep -e "^To:")" =3D "To: b b <b@b>, a@a=
" &&
            test "$(cat mbox | grep -e "^Cc:")" =3D "Cc: c@c" &&
            test "$(cat mbox | grep -e "^Bcc:")" =3D "Bcc: committer@ex=
ample.com, d@d"
           =20
* failed 5 among 8 test(s)
make[1]: *** [t1900-mail.sh] Error 1
make[1]: Leaving directory `/home/proski/src/stgit/t'
make: *** [test] Error 2

--=20
Regards,
Pavel Roskin
