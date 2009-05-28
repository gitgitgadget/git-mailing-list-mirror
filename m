From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH WIP 0/4] Special code path for large blobs
Date: Thu, 28 May 2009 15:29:06 +1000
Message-ID: <1243488550-15357-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 07:29:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9YAr-0001wd-Pv
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 07:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbZE1F24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 01:28:56 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbZE1F2z
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 01:28:55 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:32974 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbZE1F2z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 01:28:55 -0400
Received: by pxi29 with SMTP id 29so792455pxi.33
        for <git@vger.kernel.org>; Wed, 27 May 2009 22:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=6BKXjHhcoRvkfrhtJwfmsYdbvS0a4rTRRPA3U5F61d8=;
        b=TBXBoSkhF8bJcImDNju/NhC9AgW5klyHhprT6RLbuHcTPaxMVsKgVXZsnBT2DK4hgv
         P12mRiRqMDNPXUjmLt3d/oHWAwWfRMSTa4EcA/mjQiIfvsl15Vmk2TeKFJADcReRqVkm
         ETtc3nGFCQOYLsIGmyO7Yx8XLoM0WK19NLngs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DWsR9cC/AyhRsXwA63oIJgWqRFsnBl7YZ26r6Gl2z2pFm4/y1xEejApwh7RPVkaapx
         bGOWTlnM7zTDcIFE9jSPyUoi4RJoK+q21f99Z51IsRYRYFQ+Y5idZ5vFhDsNAk9w+68a
         UlAummz7qVsh+FxfYTBg+22ewJGS+L7pES14M=
Received: by 10.114.148.2 with SMTP id v2mr474429wad.169.1243488536651;
        Wed, 27 May 2009 22:28:56 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id v39sm20973388wah.27.2009.05.27.22.28.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 22:28:55 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu, 28 May 2009 15:29:11 +1000
X-Mailer: git-send-email 1.6.3.1.257.gbd13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120146>

Thread "Problem with large files on different OSes" reminds me this.
This series is in my repository for quite some time. It addresses
adding/checking out large blobs as long as:

 - no conversion will be done
 - blobs are loose (in checkout case)

Together with a patch that prevents large blobs from being packed
(something like Dana How sent long ago), and a modification of "lazy
clone/remote alternatives" patch to avoid packing large blobs again
for sending over network, I think it should make git possible for
large files.

Just something to play.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  convert.c: refactor in order to skip conversion early without looking
    into file content
  sha1_file.c: add streaming interface for reading blobs
  write_entry: use streaming interface for checkout large files
  index_fd: support indexing large files

 cache.h     |   10 +++
 convert.c   |   86 ++++++++++++++++++++---
 entry.c     |   68 +++++++++++++++++
 sha1_file.c |  233 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 388 insertions(+), 9 deletions(-)
