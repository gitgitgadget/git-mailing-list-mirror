From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/3] apply: handle traditional patches with spaces in
 filename
Date: Fri, 23 Jul 2010 20:06:18 -0500
Message-ID: <20100724010618.GA13670@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
	Giuseppe Iuculano <iuculano@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 03:08:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcTDf-0008RQ-H1
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 03:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756695Ab0GXBH6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 21:07:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47489 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656Ab0GXBH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 21:07:57 -0400
Received: by iwn7 with SMTP id 7so742556iwn.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 18:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=HQjaIbKpMCRykxIylKCt0AhVng6l84ZX0f6XznswAV4=;
        b=PHzDq4lX/lwc7myDkmKHC96A1ioCG16T4m9/s+G6o9xKJV9JZvU3ZSllTbGn20L3O1
         G7574T6T2D8QI7oHjq/HA3AUNSB4DCrOIz3anCOtrmWQsGPFo/zJfFPXZzH6XSuYpWAZ
         ApcpbsajNLn6MWHECVuOzczBuV9F/acvHyso8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=Nwa8bhSjpP0NKA7Fezz+KWlNujA05mUYuion4lm5TM8468/6AzgbVQxGqx5mfF6TTM
         b4rJH406XMCX9TC36fBvvpefVn/HLTFO/B5n+S4gLnQxDULdE+0VflMBJC45pg6lA/r0
         3satIkOifefaU1M1g5CiM3pAGRqqCHzsuonu0=
Received: by 10.231.39.134 with SMTP id g6mr4601224ibe.8.1279933676396;
        Fri, 23 Jul 2010 18:07:56 -0700 (PDT)
Received: from burratino ([64.134.164.56])
        by mx.google.com with ESMTPS id h8sm758352ibk.15.2010.07.23.18.07.29
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 18:07:55 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151590>

The goal: let =E2=80=98git apply=E2=80=99 handle such filenames as
=E2=80=9Cb/debian/licenses/LICENSE.Apache (v2.0)=E2=80=9D in patches pr=
oduced by
non-git tools without erroring out.

When we last left our heroes[1] in April:

> | The name and last modification time of each file shall be output in
> | the following format:
> |
> | "---[space]%s  %s%s%s", file1, <file1 timestamp>, <file1 frac>, <fi=
le1 zone>
> | "+++[space]%s  %s%s%s", file2, <file2 timestamp>, <file2 frac>, <fi=
le2 zone>
[...]
> If this is really describing the format of patches in the wild, that
> means we should only look for a tab character to terminate the filena=
me.
[...]
> A big downside: this does not cope with copy-and-pasted patches with
> tabs transformed to spaces.  The example [2] consists mostly of
> file-creation patches, so we can=E2=80=99t look to the repository for=
 hints.
> Maybe the space-plus-date-plus-newline sequence should be used as a
> delimiter.

It turns out that is not so hard.  Maybe it could be rewritten using
regcomp() and regexec(); if someone wants to do that, I won=E2=80=99t s=
top
them. ;-)

Patch 1 factors out a function to handle "GNU-format" C-style quoted
filenames in patches.  The only tool I know of that produces this
format is git; the discussion in [2] about what characters to escape
seems to have come to no conclusion.

Patch 2 adds some tests for all those weird characters that might
appear in a filename.  They abuse =E2=80=9Cdiff=E2=80=9D and =E2=80=9Cp=
r=E2=80=9D; testing on weird
platforms would be helpful.

Patch 3 adds the logic to search for a date at the end of a filename
line, for traditional (non --git) patches only.  If no date is found
at the end, we return to the previous heuristic, except that the only
accepted filename terminator is a tab.  Whitespace damage is only
accepted if there is a timestamp at the end of the line.

Thoughts, suggestions, improvements welcome.

Jonathan Nieder (3):
  apply: Split quoted filename handling into new function
  tests: Test how well =E2=80=9Cgit apply=E2=80=9D copes with weird fil=
enames
  apply: Handle traditional patches with space in filename

 builtin/apply.c                  |  251 ++++++++++++++++++++++++++++++=
++------
 t/t4120-apply-popt.sh            |   35 +++++-
 t/t4135-apply-weird-filenames.sh |  119 ++++++++++++++++++
 3 files changed, 363 insertions(+), 42 deletions(-)
 create mode 100755 t/t4135-apply-weird-filenames.sh

[1] http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/69796=
9/focus=3D145543
[2] http://thread.gmane.org/gmane.comp.version-control.git/9813/focus=3D=
10046
