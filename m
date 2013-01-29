From: =?UTF-8?Q?Mikl=C3=B3s_Fazekas?= <mfazekas@szemafor.com>
Subject: [PATCH] git p4: chdir resolves symlinks only for relative paths
Date: Tue, 29 Jan 2013 09:37:52 +0100
Message-ID: <CAAMmcSSEzs3+vZDO=FDMV9c2rp-8HTdMuPeeQCkok6y7sRDYJw@mail.gmail.com>
References: <CAAMmcSSvrsZqEVf68Nrqy_ZG6r5ESKhtx7JdQ7vzypkZ3gOFnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gary Gibbons <ggibbons@perforce.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 09:38:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U06hw-0001s1-IC
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 09:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447Ab3A2Ih4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2013 03:37:56 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:65425 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853Ab3A2Ihz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jan 2013 03:37:55 -0500
Received: by mail-wi0-f173.google.com with SMTP id hn17so2197800wib.0
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 00:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=0S6EuI8XVaVVO5VapG1XLnWVGTwIkjL0Wso4wHvwwro=;
        b=CNqlyGqmpB1AfBrc/o6bxo2OC1gkrTS/9tsZggUZh2rC3X+mGsJoH+e3gypliqKxlX
         eia8sBv3wav/zxYH0/8Iqcx3fPXRD3h+qEqCdHOlFM7PMc9mib1vpFXJhuNLT/eZYSrp
         Ap5tiSLmrkroTwwBjLxYZ4KGaadg85fGd6BA+rQtrh/1EO5RkTq0VxaLL8smE82X9e2O
         ARfhcC5ZTfSM+70e67jlAfL0ANzT9Dtc98/GNePu/wqCBrYgL8Gp87HWDMa1GgRgmBDk
         Rtsi9KAs6qph9PhJaSRytC0CN455y5zRoRah46ctoEjN0KegTVSeCG/bgmW/j/QEtVBU
         VGQw==
X-Received: by 10.180.97.68 with SMTP id dy4mr625157wib.7.1359448672628; Tue,
 29 Jan 2013 00:37:52 -0800 (PST)
Received: by 10.194.171.6 with HTTP; Tue, 29 Jan 2013 00:37:52 -0800 (PST)
In-Reply-To: <CAAMmcSSvrsZqEVf68Nrqy_ZG6r5ESKhtx7JdQ7vzypkZ3gOFnA@mail.gmail.com>
X-Gm-Message-State: ALoCoQn9Xm/MmM70WOSfo5RiNiyV6cg9KQqD+PpcxB5cFPOVCsHKO+Tmz6TNBX5aYAkG6kmbNEV3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214915>

[resending as plain text]

If a p4 client is configured to /p/foo which is a symlink
to /vol/bar/projects/foo, then resolving symlink, which
is done by git-p4's chdir will confuse p4: "Path
/vol/bar/projects/foo/... is not under client root /p/foo"
While AltRoots in p4 client specification can be used as a
workaround on p4 side, git-p4 should not resolve symlinks
in client paths.
chdir(dir) uses os.getcwd() after os.chdir(dir) to resolve
relative paths, but as a side effect it resolves symlinks
too. Now it checks if the dir is relative before resolving.

Signed-off-by: Mikl=C3=B3s Fazekas <mfazekas@szemafor.com>
---
 git-p4.py |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 2da5649..5d74649 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -64,7 +64,10 @@ def chdir(dir):
     # not using the shell, we have to set it ourselves.  This path cou=
ld
     # be relative, so go there first, then figure out where we ended u=
p.
     os.chdir(dir)
-    os.environ['PWD'] =3D os.getcwd()
+    if os.path.isabs(dir):
+        os.environ['PWD'] =3D dir
+    else:
+        os.environ['PWD'] =3D os.getcwd()

 def die(msg):
     if verbose:
--=20
1.7.10.2 (Apple Git-33)
