From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/10] cherry-pick: add a label for ancestor
Date: Mon, 15 Mar 2010 03:05:01 -0500
Message-ID: <20100315080501.GI8824@progeny.tock>
References: <20100305215253.364.63583.reportbug@localhost>
 <20100305221950.GB5083@progeny.tock>
 <20100315074748.GA28827@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 09:06:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr5Ik-0003DM-RZ
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 09:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759789Ab0COIFF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 04:05:05 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38006 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759781Ab0COIE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 04:04:59 -0400
Received: by gyg8 with SMTP id 8so1362021gyg.19
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 01:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=f5CQpy+v0qrwPoyRxl2EBA3Weh09C5tG0aNWVOAXRoo=;
        b=YehJEekB4y0oU4yGGRBP2rEkpJ5bWSwzE7eDg0/0tJY5ISCGkJ+42vGYsUbgnbD4PU
         RextgImxVRJ04ShMsVloeB492lh5vpE5Jwpr7dgQerrA3t9yoGs9sD7bDImPSvomoeaD
         3Jv2NnGMMNpfynU7P7wOsXMhtkKh7QcfbW/PQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=h6oIsrldasemvTN1hbJXgqO4pLmms/z9OPW2lkWnXbIOf/deksR63FoQCPtuKr2D1a
         Qb1wDPfLXkmH1FCVigOjBTH2QBjHo6ik6P+Z+4CGKH5tC9wSadfeio3GUS70tt/uJZ0Y
         BL8gHBm+IuHyh0lcmol4Vvo8uOCCsYSZJC3QY=
Received: by 10.101.155.38 with SMTP id h38mr4157106ano.131.1268640299247;
        Mon, 15 Mar 2010 01:04:59 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm4047105iwn.1.2010.03.15.01.04.58
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Mar 2010 01:04:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100315074748.GA28827@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142185>

git cherry-pick and git revert will present conflict hunks in output
something like what =E2=80=98diff3 -m=E2=80=99 produces if the merge.co=
nflictstyle
configuration option is set to diff3.

Unfortunately, some tools reportedly cannot parse the conflict hunks
because of a small difference from diff3: diff3 -m includes a label
for the merge base on the ||||||| line.  Humans parsing the conflict
hunks by hand might want to know what the common ancestor represents,
too.  So mark the start of the text from the parent of the commit
being cherrypicked (resp. from the commit being reverted) with the
label "parent".

It would be nicer to use a more informative label, and that might
happen in the future.

git rerere will not have trouble parsing this output, since instead of
looking for a newline, it looks for whitespace after the |||||||
marker.  No other code in git tries to parse conflict hunks.

Reported-by: Stefan Monnier <monnier@iro.umontreal.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
In the revert case, this gives

 <<<<<<< HEAD
 foo
 ||||||| parent
 bar
 =3D=3D=3D=3D=3D=3D=3D
 baz
 >>>>>>> ab78c93 "Make some change we would like to revert"

This is a bit misleading, since actually =E2=80=9Cbaz=E2=80=9D is from =
the commit
to revert=E2=80=99s parent and =E2=80=9Cbar=E2=80=9D is from the commit=
 to revert.

Probably the labels should be switched.  I didn=E2=80=99t do this becau=
se
it is late and it would have been a larger change from the current
behavior.

It also would be nice to suppress the ancestor and do a two-way
merge when cherry-picking a root commit.  I haven=E2=80=99t yet looked =
into
how hard this would be.

 builtin/revert.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index eff5268..a61dd9a 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -372,6 +372,7 @@ static int revert_or_cherry_pick(int argc, const ch=
ar **argv)
=20
 	read_cache();
 	init_merge_options(&o);
+	o.ancestor =3D base ? "parent" : "(empty tree)";
 	o.branch1 =3D "HEAD";
 	o.branch2 =3D oneline;
=20
--=20
1.7.0
