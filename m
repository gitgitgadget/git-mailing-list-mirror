From: =?utf-8?Q?Micha=C3=ABl_Fortin?= <fortinmike@gmail.com>
Subject: Unexpected behavior when git-adding files in a pre-commit hook then using "git commit -o"
Date: Mon, 4 May 2015 08:33:39 -0400
Message-ID: <463FC822-916F-4160-A1F2-B4AAEFF3A5B2@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 14:33:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpFZE-0001XA-Uv
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 14:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbbEDMdn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 May 2015 08:33:43 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:36294 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbbEDMdl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 May 2015 08:33:41 -0400
Received: by qcbgy10 with SMTP id gy10so17760280qcb.3
        for <git@vger.kernel.org>; Mon, 04 May 2015 05:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=heGoQ8snODXIQCCh2d8t6w/rSehj4nm1S/QQHusoM3c=;
        b=dYMcSyW+s1Z52yxrL7DQ4dvB+nDLCPYR1wec3D1BWEu9+xfOVymQF5iTc4KpP4INBf
         xBTQEbfP+9TBKrnnLABnprkzzZytT7i/dqMjxgeD3ow2q+PQxT6vls8NcZnOnQTUb1/x
         mpInoaRhn58PnuwDnPNbqFfeBnmKAjU934BEIXCIlc+luhCWGRowcNOcN57G6xLn/SbB
         INCJXhS/YvnlnuTQuP9iUEn0iHulprW7WIWptYtfSeaozEvWTmsfAqCqZR3zNZ33PaRe
         IwBJ2Sn7RFW55kcLq1dr8i4XmF1sFqE9F8hS9BYDT0kZe7WAoDAs9hv1pyDMYNKox6Zz
         pMsQ==
X-Received: by 10.55.22.10 with SMTP id g10mr44499889qkh.26.1430742821143;
        Mon, 04 May 2015 05:33:41 -0700 (PDT)
Received: from [172.20.10.2] ([142.169.78.60])
        by mx.google.com with ESMTPSA id 106sm9757155qge.22.2015.05.04.05.33.40
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 May 2015 05:33:40 -0700 (PDT)
X-Mailer: Apple Mail (2.2098)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268315>

Hi,

I=E2=80=99ve encountered unexpected behavior performing a git add from =
a pre-commit hook, followed by performing a commit using the =E2=80=9C-=
o=E2=80=9D flag, providing a pathspec. Here is a small bash script that=
 explains the issue and serves as a repro:

###############
echo "----> Setup a new test repo"
dir_name=3D"PreCommitHookAddTest"
rm -rf $dir_name; mkdir $dir_name; cd $dir_name
git init; git commit --allow-empty -m "Initial commit"

echo "----> Add a pre-commit hook that stages a file that doesn't curre=
ntly exist in the repo"
echo "touch auto-added; git add auto-added" > .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

echo "----> Try committing a new file using the '-o' flag"
touch manually-added; git add manually-added
git commit -o -m "Commit that ran the pre-commit hook and should contai=
n file 'auto-added'" -- manually-added

echo "----> Results (expected: working copy clean; actual: auto-added i=
s reported as both DELETED and UNTRACKED. HEAD and working copy are the=
 same, staging area contains =E2=80=98incorrect' state)"
git status

echo "----> Stage the file after the fact"
git add auto-added

echo "----> Notice that the working copy is now clean"
git status
###############

I would like to avoid the above-described =E2=80=9Cinvalid=E2=80=9D sta=
te by performing operations correctly in my pre-commit hook, rather tha=
n having to add a post-commit hook only to perform a =E2=80=9Cgit add=E2=
=80=9D after the fact (which the repro script emulates); it seems like =
an ugly workaround to me.

I have had similar issues before, which Jeff King kindly resolved here:
http://thread.gmane.org/gmane.comp.version-control.git/263319/focus=3D2=
63323

The provided solution does not seem to help in this new context, or at =
least I cannot make sense of it in relation to this issue, with my limi=
ted knowledge of Git internals.

Any insight would be appreciated!

Thanks in advance,

Micha=C3=ABl Fortin
www.irradiated.net
