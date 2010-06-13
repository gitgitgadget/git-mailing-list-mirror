From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] git-svn: strip off leading slashes on --trunk argument
Date: Sun, 13 Jun 2010 06:27:43 -0500
Message-ID: <20100613112743.GA21855@burratino>
References: <20090915113634.GC22524@ra.ncl.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Dowland <jmtd@debian.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 13 13:28:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONlMF-00060y-N6
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 13:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989Ab0FML17 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jun 2010 07:27:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39902 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982Ab0FML15 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 07:27:57 -0400
Received: by iwn9 with SMTP id 9so2189466iwn.19
        for <git@vger.kernel.org>; Sun, 13 Jun 2010 04:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=L3HU8svUiz1QSZ7XTxJyCvQuHzjmJE7PO1CMVrv7IWs=;
        b=daS5DX4zMpmRH8yKlEez4fBCY8c5DhFb31A/phVGkNMH3vFSRDfm8JpWXAIPfjjYts
         2YzsiVITIZ8jOWt2Dxso/Vo2bnwSsma+q+QCQXlNtDY57DG1B+Zhy6L3383lyHse/zpI
         dTgKAqhfFan+LOXPLvl0DQ0wuH86NtXM/8+LE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=jUWLLb2qFh/03a/AkfxIxVSEwyTxwOYldyBkQqa+xXF5ZYE4pyj9+iRnSS068q8ehv
         mvMUBDS1IJEV1AwRtpkd64WRUdWCCv9r4YOhFH6qyTAXxxCY85E9X4kg9TUnGI1gHN+w
         fvo7hIpMmraAnK2I1CuWILT9je31bd1+QUaMc=
Received: by 10.231.169.6 with SMTP id w6mr4717495iby.5.1276428475548;
        Sun, 13 Jun 2010 04:27:55 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm15128969ibf.1.2010.06.13.04.27.54
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 13 Jun 2010 04:27:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090915113634.GC22524@ra.ncl.ac.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149045>

The following command

 git svn clone \
	-r9500:10006 \
	svn://svn.debian.org/svn/pkg-games/packages \
	--trunk=3D/trunk/freedoom \
	--branches=3D/branches/freedoom \
	--tags=3D/tags/freedoom \
	freedoom.git.2009091

produces strange results:

With v1.6.3.3 (and perhaps earlier versions), this would fetch up to
and including r9978 (the last revision of the no_iwad_alternatives
branch before it was deleted), check it out, and prematurely declare
success, leaving out some commits to the trunk (r9984, r9985, r10006)
from after the branch was merged.

With v1.6.5-rc0~74 (svn: allow branches outside of refs/remotes,
2009-08-11) and later, this fetches up to and including r9978 and then
attempts a post-fetch checkout and fails.

 r9978 =3D 25f0920175c395f0f22f54ae7a2318147f745274
 (refs/remotes/no_iwad_alternatives)
 fatal: refs/remotes/trunk: not a valid SHA1
 update-ref refs/heads/master refs/remotes/trunk: command returned erro=
r: 128

Checking .git/config reveals

 fetch =3D packages//trunk/freedoom:refs/remotes/trunk

And with both 1.6.3.3 and 1.7.1, using --trunk=3Dtrunk/freedom without
the leading slash (/) works fine.

Moral: git-svn needs to scrub an initial / from $_trunk and related
arguments it receives.  Make it so.

Reported-by: Jon Dowland <jmtd@debian.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi Eric,

It=E2=80=99s not clear to me what=E2=80=99s going on here, but this see=
ms to fix it.  Insights?

Jonathan

=46rom

  http://bugs.debian.org/546733
  http://bugs.debian.org/572847

 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 265852f..a352000 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -959,6 +959,7 @@ sub cmd_multi_init {
 	}
 	do_git_init_db();
 	if (defined $_trunk) {
+		$_trunk =3D~ s#^/+##;
 		my $trunk_ref =3D 'refs/remotes/' . $_prefix . 'trunk';
 		# try both old-style and new-style lookups:
 		my $gs_trunk =3D eval { Git::SVN->new($trunk_ref) };
--=20
1.7.0.dirty
