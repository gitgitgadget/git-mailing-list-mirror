From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Minimum libCurl version for git
Date: Fri, 20 Mar 2009 17:59:08 +0000
Message-ID: <e2b179460903201059j20e37c1cr7ccfa4b42e45c9d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Daniel Stenberg <daniel@haxx.se>,
	Nick Hengeveld <nickh@reactrix.com>,
	Mike Hommey <mh@glandium.org>,
	Mike Gaffney
X-From: git-owner@vger.kernel.org Fri Mar 20 19:00:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkj1R-0000Ib-OH
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 19:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbZCTR7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 13:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757697AbZCTR7M
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 13:59:12 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:45654 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbZCTR7L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 13:59:11 -0400
Received: by qyk16 with SMTP id 16so1421597qyk.33
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=SkMglo44+bk/0Nm1DGov0P5gOQRtZtEXPTX3H18jvCQ=;
        b=OJparSrN1f/PU+CqgMyt59TauJCE98bHQRSCMshCpO0bQ0oH7hzAFp0wMPUNew958u
         DtnpulVGctTMECZrBEwk8dkTWmK3FrBdxHpwzkdXXFvx22VuEEkQ3EUhEL+41A5yM6IZ
         V/sT/yOrwDYNeFVyjzg0t5Bv1ESdXK44et7Kc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=S2ksESdpEZ6dGV7JLS9NqX0+unqcFaT+JeYBRgq+N0NJg8PG1WZtBXW6p67uDhjVRt
         yvManRndLRaYkM+amFb2FgzBO7SAZu+7y3CnpWIDu+HaQTRn4EzMZXSDR/ZF0HPedHCN
         NejWConVl3JxLDtdwdfr1UrGFiZMHYwnC52Dk=
Received: by 10.224.28.207 with SMTP id n15mr5588103qac.95.1237571948426; Fri, 
	20 Mar 2009 10:59:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113985>

See $gmane/112765 for background.

Git uses 31 CURL_, CURLINFO and CURLOPT symbols, two of these
(CURLINFO_HTTP_CODE and CURLOPT_INFILE) are officially deprecated, but
only because they have been renamed in 'recent' versions.

We protect the usage of symbols introduced in version 7.9.2 and later
with #ifdefs. These date back to some time in 2005 when those versions
of libCurl were 3 or so years old.

We use CURLOPT_FTP_USE_EPSV unprotected, which was introduced in
version 7.9.2. This is something of a pity as it is an optional
configuration item which is probably not widely used (I don't think I
knew there was any support for git over ftp). Still, 7.9.2 was a long
time ago (Dec 2001), and no-one is complaining. Disregarding this, we
would be able to use libCurl versions as far back as 7.8.1 (Aug 2001),
bugs, security fixes and performance notwithstanding.

According to Daniel's list [1], CURLOPT_SSLKEY was introduced in
7.9.3, but we enable it in http.c if we see version >=3D 7.9.2. This
could be a typo in the haxx.se list, or the option could have been
available in (some) 7.9.2 releases, or it could be a git bug. Again,
not one which appears to be biting anyone.

Going forward there are various options:

1. Do nothing - go with the status quo.

2. Correct the #ifdefs for CURLOPT_SSLKEY

3. Drop the #ifdefs for CURLOPT_SSLKEY entirely and make 7.9.3 our
minimum supported version. I feel slightly embarrassed about that, as
that's exactly the version I have here on AIX (unless I wrest it back
from being sysadmin-installed to being user-supported). Add a check to
the Makefile and error if libCurl is too old.

4. Drop all current #ifdefs and one of the deprecated symbol names.
Our minimum supported libCurl version would be 7.9.8 from Jun 2002.

5. Drop all current #ifdefs and both of the deprecated symbol names.
Our minimum supported libCurl version would be 7.10.8 from Nov 2003.

6. Warn (not error) if libCurl is older than say the 3 years suggested
by Daniel. This would seem to require periodic updates to the Makefile
check.

I'm happy to whip up a patch if required, but I thought a series of
mutually-exclusive alternative patches would be confusing without
prior agreement on the approach.

Mike

[1]=C2=A0 http://cool.haxx.se/cvs.cgi/curl/docs/libcurl/symbols-in-vers=
ions?rev=3DHEAD&content-type=3Dtext/vnd.viewcvs-markup
