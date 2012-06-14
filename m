From: Brendan Brewster <brendan.brewster@gmail.com>
Subject: Checksum incorrectly uses signed values
Date: Wed, 13 Jun 2012 21:16:21 -0400
Message-ID: <CA+-ctj5M4XraOQJfWRVVFmRrNsUZUJyt63_Oi__OJCcYMC=ciw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 03:16:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Seyg4-0003mQ-01
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 03:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005Ab2FNBQn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 21:16:43 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43818 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab2FNBQm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 21:16:42 -0400
Received: by pbbrp8 with SMTP id rp8so3052500pbb.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 18:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=Qwa7ozyq5ipQXVpOV6c31tkuyS+xk1fDDT/w8OofIEQ=;
        b=euB9IyYpKXRKKN6jKnzOKlLbsGe69ALIXtsvI6/BWBKjEbJRVg59OBct30UV2QZYHX
         r8aoiTdKvpyZW7aQkwcTpV1o+nM31W75wu5Vsnt1DwKSrr7H4l7FQdNWy496WZxLEafe
         1Ms+VAdmtBWG2vBYTqwXj4mbdgIlh+uXe3I7LnQUEn5awGHxwrSB4+wSPeWK4gPZQSJU
         Cq9mc2P2QxlNrU2OmGr5ppEJqVTkfKt9JchgMH0OLunhYiMfE+pShrVvrwKLOr0lBkBK
         UfiJJQFVsbfQ3FPIdhZCCBb2b/p4LxXnjl0yZNLZ3Xb3z+l+2ckpQLkl4jTfdnZKuhoq
         QcrA==
Received: by 10.68.217.229 with SMTP id pb5mr1937811pbc.20.1339636602261; Wed,
 13 Jun 2012 18:16:42 -0700 (PDT)
Received: by 10.143.161.18 with HTTP; Wed, 13 Jun 2012 18:16:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199963>

Hi,

I initially reported this issue to another developer thinking the
issue resided there but after some testing and discussion, have found
that the issue is not there but possibly here :)

The issue, in summary, is that 7-zip was unable to untar a tar created
via a "git archive" whereas gnu tar can. It seem that it may be the
case that git is incorrectly using signed values when creating the
checksum.

As Igor commented in the other aforementioned thread, "[t]hey use
'char' (that is 'signed char' by default in most compilers).=A0BUT
correct TAR must use sum of unsigned values."

Please see the following:

1) The thread previously opened with Igor/7-Zip:
http://sourceforge.net/projects/sevenzip/forums/forum/45798/topic/53226=
04
2)=A0http://www.gnu.org/software/tar/manual/html_node/Checksumming.html
3) TAR source code:
=A0 =A0 =A0tar_checksum
=A0 =A0 =A0=A0and
=A0 =A0 =A0simple_finish_header
=A0 =A0 =A0=A0functions.
4) GIT source code that calculates checksum: ustar_header_chksum
function in=A0archive-tar.c.=A0For reference, here is the snippet of th=
e
git source code in question:

git-git-f623ca1\archive-tar.c
static unsigned int ustar_header_chksum(const struct ustar_header=A0*he=
ader)
{
=A0 =A0 =A0 =A0const char *p =3D (const char *)header;
=A0 =A0 =A0 =A0unsigned int chksum =3D 0;
=A0 =A0 =A0 =A0while (p < header->chksum)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chksum +=3D *p++;
=A0 =A0 =A0 =A0chksum +=3D sizeof(header->chksum) * ' ';
=A0 =A0 =A0 =A0p +=3D sizeof(header->chksum);
=A0 =A0 =A0 =A0while (p < (const char *)header + sizeof(struct ustar_he=
ader))
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chksum +=3D *p++;
=A0 =A0 =A0 =A0return chksum;
}

Can someone please look into this and possibly redirect if needed?

Thanks,
Brendan
