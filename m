From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [STGIT] AssertionError on stg rebase
Date: Mon, 14 Feb 2011 17:23:15 +0000
Message-ID: <AANLkTim2F1B7=Q5wTfxxWod3yyyiMuGxKnEGNyCVjcuZ@mail.gmail.com>
References: <20110213193534.GA2437@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Karl Wiberg <kha@treskal.com>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
X-From: git-owner@vger.kernel.org Mon Feb 14 18:23:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp28z-0005hy-Ke
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 18:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755820Ab1BNRXR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 12:23:17 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58776 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755808Ab1BNRXP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 12:23:15 -0500
Received: by iwn9 with SMTP id 9so5022686iwn.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 09:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YtkNGnC7Y1b1I2iW3F3VMydcr2MVbnsF9qEXLCQNXV4=;
        b=MmjESpzK0ecGznpgLi9l/Ejr7wRdm+KCwvNfzKQUH6hFanBZdkvVtNgrcJg9at/U6I
         QLjTDs5Z3H3lbeObqPxh+7vqW4GsvMI/GZtUGtHgSwTggygSuXTAAK70etOkr7tQFkhX
         QlajL/APJWDrSj/31lVq12VEnmxIgHJt8XSGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EIBVsY240zs5qJkWW9CHEC5C5Hc+6W88vFKWlQYnqp3BvgckLh8+KKVcS8yeHDR8W4
         aXXClS4uFNDC2GEqCR77E+RTzEq/U7VskdzBrYiYDDI+tSL9SP5v26nHpHJHYxBBod/e
         Jy/6uX0XCTQxRLeVpOF21BpkMsyQVxLPesNjs=
Received: by 10.42.241.131 with SMTP id le3mr5263320icb.478.1297704195157;
 Mon, 14 Feb 2011 09:23:15 -0800 (PST)
Received: by 10.42.240.8 with HTTP; Mon, 14 Feb 2011 09:23:15 -0800 (PST)
In-Reply-To: <20110213193534.GA2437@khazad-dum.debian.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166738>

Hi,

On 13 February 2011 19:35, Henrique de Moraes Holschuh <hmh@hmh.eng.br>=
 wrote:
> Here is a testcase to reproduce the problem:
>
> $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/longterm/li=
nux-2.6.27.y.git
> $ cd linux-2.6.27.y
> $ git reset --hard v2.6.27.53
> $ stg init
> $ stg new test-patch-1
> $ echo "something" > changedfile
> $ git add changedfile
> $ stg refresh
>
> $ stg rebase v2.6.27.58
>
> Checking for changes in the working directory ... done
> Popping all applied patches ... done
> Rebasing to "v2.6.27.58" ... done
> Pushing patch "test-patch-1" ... done
> Now at patch "test-patch-1"
> Traceback (most recent call last):
[...]
> =C2=A0File "/usr/lib/pymodules/python2.6/stgit/lib/git.py", line 408,=
 in parse
> =C2=A0 =C2=A0assert False
> AssertionError

StGit is parsing the commit information for some key/value pairs. It
looks like it found one which it didn't know about - "encoding:
latin1" and it failed.

=46or now it is OK to just remove the assert. The drawback is that if
you do some "stg uncommit" on some existing commits, it will lose
additional information but I don't think it matters to you since you
create your patches with StGit anyway and it doesn't generate such
information. Longer term we may want to preserve other things that may
appear in the commit data. I'll push this to the StGit repository as
well.


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 3378728..f5ea965 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -404,8 +404,6 @@ class CommitData(Immutable, Repr):
                 cd =3D cd.set_author(Person.parse(value))
             elif key =3D=3D 'committer':
                 cd =3D cd.set_committer(Person.parse(value))
-            else:
-                assert False
         assert False

 class Commit(GitObject):


Thanks.

--=20
Catalin
