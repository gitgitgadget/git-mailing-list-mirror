From: Ivo Anjo <knuckles@gmail.com>
Subject: Bug in git-filter-branch example
Date: Mon, 1 Feb 2010 11:48:27 +0000
Message-ID: <557ea2711002010348m57aa31fesd1047cbe3f01cb0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 01 12:48:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbulf-0000B6-M6
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 12:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112Ab0BALs3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Feb 2010 06:48:29 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:48540 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab0BALs2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Feb 2010 06:48:28 -0500
Received: by bwz23 with SMTP id 23so4763bwz.21
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 03:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=wmYuOr2D6hZLuGLezqhEaEyzpqHVoLg+ZvqgW3aYrgo=;
        b=GpjOUMOxtn1G+0rCEanMrB2H0Z3AztynKsk9eJAkEoZAAfW+DV6jyHF6yAcxdaXtcp
         M7A0B46UB9vtCUXeAMSMjpLRegOq5+tMp5tAXMkLKnL53NXGz2YVs2v6wNsypwMAVjGs
         F7eg45FzFxJH/Au4Zeyh8OuT/kMzcIgsNv+EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=VeYFI1zzv0ibNmqRo8up5Hgl4ucbNWGemzDQdSqTyqK6gKBPuFYcdYs697cHH8VmL1
         LR8haQFn101CZBQ4KVzDWVrjzwh1HF4l3WEXg3rQpiN7K7vKv+S4Qfbw1NLFWPq+tcaf
         e6PTqM5058k7eGCwpmptX6KPP1+6u4M1M7bS0=
Received: by 10.204.139.217 with SMTP id f25mr402863bku.73.1265024907092; Mon, 
	01 Feb 2010 03:48:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138602>

I've been working on importing my svn repo into git, and while moving
some things around using git-filter-branch I ran into a bug in the
example provided on the manpage:

=C2=A0=C2=A0=C2=A0 To move the whole tree into a subdirectory, or remov=
e it from there:

=C2=A0=C2=A0=C2=A0 git filter-branch --index-filter \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'git=
 ls-files -s | sed "s-\t-&newsubdir/-" |
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GIT_INDEX_FILE=3D$GIT_INDEX_=
=46ILE.new \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 git update-index --index-info &&
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD


The problem is with filenames that use complex utf8 (non-ascii?) chars:

> ls -lah Papers/*Lea*
-rw-r--r-- 1 knuckles users 109K 2010-01-31 18:57 Papers/A Java Fork =E2=
=81=84
Join Framework -- Lea.pdf

as you can see, I'm using '=E2=81=84' as a replacement for '/' on that
filename, since I obviously can't use '/' on a filename. The problem
is, git ls-files -s lists that file wrapped in quotes and with the
char value escaped

100644 c09309342037fa7d91f37651e2f16e981e4d739a 0=C2=A0=C2=A0=C2=A0 "Pa=
pers/A Java
=46ork \342\201\204 Join Framework -- Lea.pdf"

while other files aren't, so the simple sed line provided won't work,
as it will output the new filename as newsubdir/"Papers...

I ended up using git filter-branch to remove the offending file ("if
all you have is a hammer..."), and re-adding it after the move.

I'm also left wondering how many uses of git ls-files out there on the
"internets" survive working on a filename such as this one. Maybe git
ls-files should have an option to output the real utf8 file name
instead of escaping the bytes...?

Ivo Anjo
