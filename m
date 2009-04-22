From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Wait for git diff to finish in git difftool
Date: Wed, 22 Apr 2009 09:27:22 +0200
Message-ID: <81b0412b0904220027t7afd1ed7xc57c479ef8cdb6b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 09:29:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwWtC-0008B8-D9
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 09:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbZDVH1Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2009 03:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752406AbZDVH1Y
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 03:27:24 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:3196 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbZDVH1X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2009 03:27:23 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1905198ywb.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 00:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=B5+fQhWZlJN7Fxy8AHQoYpP/Ae+Dcrp6X5FheJGC5NQ=;
        b=qkdfCajxabr6CdZF5bncm+VWYij/vipBkebZbWMDqEamGNNvCuOf1HSRjuEYEbH/TI
         xh7fyNZLWZ6wblcwkYRtJWcEcLs7YOyUGBPMP5DuTqjRGvm+HtEVuaQBVs/9WqwDbiw6
         E5JfONrNVWfOyMkBlaSUfQ5oNfSozK8dDCOd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Xx91oQFwe2hp6U3FZrddCbhnDwi/3pmIA0K8/gYUz5JDX6w9OzaYb76E+TiUwRqKVq
         VE81NcKUzhuCOchg5b3w6NtL7i2XJ8ciEALMLdN+YY93Z1m/t1RvwvU42j/i7qqv0YQf
         EsTOC11FgWDCHBXs0CdpkBbTooFVdFtNUZYMM=
Received: by 10.151.42.6 with SMTP id u6mr10408834ybj.60.1240385242334; Wed, 
	22 Apr 2009 00:27:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117178>

In ActivetState Perl, exec does not wait for the started program. This
breaks difftool tests and may cause unexpected behaviour: git difftool
has returned, but the rest of code (diff and possibly the interactive
program are still running in the background.

---
 git-difftool.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

2009/4/6 David Aguilar <davvid@gmail.com>:
> +# Ensures that git-difftool ignores bogus --tool values
> +test_expect_success 'difftool ignores bad --tool values' '
> + =C2=A0 =C2=A0 =C2=A0 diff=3D$(git difftool --no-prompt --tool=3Dbog=
us-tool branch)
> + =C2=A0 =C2=A0 =C2=A0 test "$?" =3D 1 &&
> + =C2=A0 =C2=A0 =C2=A0 test "$diff" =3D ""
> +'

This breaks in that piece of ActiveState Perl if git-difftool is to
continue to use exec: exec*(2) semantics are not available there
(as they are not possible in Windows at all).

In this case the script will spawn git-diff and immediately exit with 0=
=2E
git-diff will run the bogus-tool in "background" later.

I usually don't care for exit code in a pure UI tool, so the kill signa=
l
is just ORed together with the real exit code just to provide indicatio=
n
of error.

diff --git a/git-difftool.perl b/git-difftool.perl
index 948ff7f..bd828c2 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -82,4 +82,5 @@ sub generate_command
 }

 setup_environment();
-exec(generate_command());
+my $rc =3D system(generate_command());
+exit($rc | ($rc >> 8));
--=20
1.6.3.rc0.45.g63634
