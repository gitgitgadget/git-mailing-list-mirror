From: Johan Herland <johan@herland.net>
Subject: Re: BUG? in --dirstat when rearranging lines in a file
Date: Fri, 8 Apr 2011 16:46:35 +0200
Message-ID: <201104081646.35750.johan@herland.net>
References: <201104071549.37187.johan@herland.net> <BANLkTinEipewx2+Cx7Us0BSoSbjjU9uE6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	johan@herland.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 16:48:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8Cyo-00058i-LV
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 16:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756685Ab1DHOsE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2011 10:48:04 -0400
Received: from smtp.opera.com ([213.236.208.81]:44133 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752580Ab1DHOsD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 10:48:03 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p38EkZwW007695
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 8 Apr 2011 14:46:36 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <BANLkTinEipewx2+Cx7Us0BSoSbjjU9uE6A@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171124>

On Thursday 07 April 2011, Linus Torvalds wrote:
> On Thu, Apr 7, 2011 at 6:49 AM, Johan Herland wrote:
> > Consider the following sequence of commands:
> > [...]
> > $ git diff --stat
> > =A0dir/file | =A0 =A02 +-
> > =A01 files changed, 1 insertions(+), 1 deletions(-)
> > $ git diff --dirstat
> > $ # WTF!?
>
> So the "--dirstat" thing really is different - it has never done a
> full patch, it really only does a line hash count and then estimates
> the amount of deleted/new code from that.
>
> [...]

Ok, so here are 3 patches to somewhat improve the situation without=20
making --dirstat too ugly or expensive.

#1: Simply document the current behavior.

#2: Improve --dirstat-by-file. It doesn't really care about the per-fil=
e=20
analysis done by --dirstat, but only whether or not a file has changed=20
at all. Since the diff queue does not contain unchanged files (<- this=20
is an assumption that I hope someone with more diffcore knowledge can=20
verify), we can unconditionally assign damage =3D=3D 1 to each entry in=
 the=20
diff queue, and bypass the entire --dirstat per-file analysis.

#3. This is a quick/ugly hack that depends on the same assumption as #2=
:=20
If an entry is in the diff queue, we now that it is not unchanged. So=20
if the per-file analysis yields damage =3D=3D 0, we know that it must h=
ave=20
overlooked something (rearranged lines), so we set damage =3D 1 instead=
=2E=20
The logic is that underrepresenting a change in --dirstat is better=20
than ignoring it...


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
