From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Bizarro race conditions in the Git Makefile
Date: Fri, 6 Aug 2010 19:44:57 +0000
Message-ID: <AANLkTim2NMi3Vf-EGbFwy370q-YseQoGj=QLGMAq6N=B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 06 21:45:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhSqp-0007tK-D4
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 21:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761950Ab0HFTo7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 15:44:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44460 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab0HFTo5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 15:44:57 -0400
Received: by iwn33 with SMTP id 33so1539684iwn.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 12:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=8rHCwH7g982DHb/V6RJ7nLudtZOSZDUhSMUyzeDf9mQ=;
        b=HSgWrQ7zMsF+cvuLPTCAbDfIjwhMoZYEjcdbFuFIS3z9FMT5emBELdh+TokAovYIBD
         udxz/Uze9yZZ9spZP6GbNCLdETPjslaI7PpT9tEM/1wl9qJf331xtLEEkNX7no9Ea01U
         Wx0708SyGLTfP2NegRZlUEBXcJVQcyM5J/UsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=rj8UWqvPkeu0Y2OJwFJScNV+zhSBSSPqRmPdSwQaavX5RNqgcsvsdYCzo7JkEF/C4N
         +DOZ5OsuBIwB32tQTSL+FbXS7uzcA51aJqtTd/A+XC8MIdylPcDUUgYt7ugPqgnTvwZQ
         QODclcRoXOCIS5TPF/9+Dv6FVdV4mbL5z0tOA=
Received: by 10.231.167.196 with SMTP id r4mr14498053iby.29.1281123897045; 
	Fri, 06 Aug 2010 12:44:57 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 6 Aug 2010 12:44:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152807>

   "Doctor, when I poke my eye like this it hurts"
   -"So don't do that then"

If you run the Git Makefile (with GNU Make 3.81) in parallel for long
enough you'll get some interesting breakages. Those interested in
poking their eyes can try:

    while nice -n 30 make -j 15 clean all CFLAGS=3D-O0 CC=3Dgcc; do 1; =
done

These suggest that we have some bugs in our Makefile dependencies, but
since I haven't found what they are I'm just going to post the
symptoms.

The first example is the generation of the perl.mak from the
top-level. It seems that if you run make with -j $n the perl.mak will
get generated $n times:

        LINK git-fast-import
    Writing perl.mak for Git
    Writing perl.mak for Git
    Writing perl.mak for Git
    Writing perl.mak for Git
        LINK git-imap-send
    Writing perl.mak for Git
        LINK git-shell
        LINK git-show-index
        LINK git-upload-pack
    Writing perl.mak for Git
    [...]

This can lead to an error where they trip over each other:

    Writing perl.mak for Git
    Writing perl.mak for Git
        AR libgit.a
        AR xdiff/lib.a
        LINK git-fast-import
        LINK git-imap-send
    Writing perl.mak for Git
    Writing perl.mak for Git
    rename MakeMaker.tmp =3D> perl.mak: No such file or directory at
/usr/share/perl/5.10/ExtUtils/MakeMaker.pm line 1004.
    make[2]: perl.mak: No such file or directory
    make[2]: *** No rule to make target `perl.mak'.  Stop.
    make[1]: *** [instlibdir] Error 2
    make: *** [git-svn] Error 2
    make: *** Waiting for unfinished jobs....
    make[2]: perl.mak: No such file or directory
    make[2]: *** No rule to make target `perl.mak'.  Stop.
    make[1]: *** [instlibdir] Error 2
    make: *** [git-relink] Error 2
    Writing perl.mak for Git
    Writing perl.mak for Git
    Writing perl.mak for Git
    Writing perl.mak for Git
    Writing perl.mak for Git

Here one make job seemingly had its MakeMaker.tmp file usurped by
another job.

Here's another one, it seems that the builtin/help.o dependency on
common-cmds.h is broken:

        CC builtin/help.o
        [...]
        CC builtin/ls-remote.o
    builtin/help.c:9:25: error: common-cmds.h: No such file or director=
y
    builtin/help.c: In function =E2=80=98list_common_cmds_help=E2=80=99=
:
    builtin/help.c:278: error: =E2=80=98common_cmds=E2=80=99 undeclared=
 (first use in
this function)
    builtin/help.c:278: error: (Each undeclared identifier is reported =
only once
    builtin/help.c:278: error: for each function it appears in.)

Which is odd, because this seems OK:

    builtin/help.o: common-cmds.h
    builtin/help.s builtin/help.o: EXTRA_CPPFLAGS =3D \
        '-DGIT_HTML_PATH=3D"$(htmldir_SQ)"' \
        '-DGIT_MAN_PATH=3D"$(mandir_SQ)"' \
        '-DGIT_INFO_PATH=3D"$(infodir_SQ)"'

A vaguely recall having run into some other make error, but I can't
reproduce it now. I'll keep poking my eye and reporting results to the
list.
