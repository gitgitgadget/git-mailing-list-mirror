From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH] [import-tars] fix importing of subversion tars
Date: Tue, 24 Apr 2007 13:51:04 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070424115104.GA14986@informatik.uni-freiburg.de>
References: <20070424073907.GA22121@diana.vm.bytemark.co.uk> <20070424084037.GA8906@informatik.uni-freiburg.de> <20070424100924.GB23811@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Michael Loeffler <zvpunry@zvpunry.de>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 13:51:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgJYE-0003L3-CS
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 13:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161727AbXDXLvM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Apr 2007 07:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161725AbXDXLvM
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 07:51:12 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:33159 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161727AbXDXLvJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2007 07:51:09 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HgJY4-0002Jw-65; Tue, 24 Apr 2007 13:51:08 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l3OBp5sc016313;
	Tue, 24 Apr 2007 13:51:05 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l3OBp449016312;
	Tue, 24 Apr 2007 13:51:04 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Michael Loeffler <zvpunry@zvpunry.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070424100924.GB23811@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45444>

add a / between the prefix and name fields of the tar archive if prefix
is non-empty.

Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
---

> No, it still breaks, but in a new and interesting way: Now I _only_
> get the files with long pathnames!

I don't know exactly how standard-conformant it is not to include a
trailing / after prefix, but the subversion tar does it.=20

I checked for a description of the tar format, the best thing I could
find is[1]:

	On USTAR format archives, the value of the prefix field, if
	non-null, is prefixed to the name field to allow names longer
	then 100 characters

But it's not specifying if an additional / is needed.


With this patch I get all the filenames right.

Now the common prefix subversion-1.4.3 is stripped, but probably that's
a feature.

BTW I shortly tested a tar that had an entry with prefix ending in / an=
d
fast-import did the right thing.  So something more complicated as:

	if ($prefix and $prefix[-1] eq "/") ...

should not be needed.

Best regards
Uwe

[1] http://www.mkssoftware.com/docs/man4/tar.4.asp

 contrib/fast-import/import-tars.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import=
/import-tars.perl
index 5585a8b..1842146 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -64,7 +64,12 @@ foreach my $tar_file (@ARGV)
 		}
 		print FI "\n";
=20
-		my $path =3D "$prefix$name";
+		my $path;
+		if ($prefix) {
+			$path =3D "$prefix/$name";
+		} else {
+			$path =3D "$name";
+		}
 		$files{$path} =3D [$next_mark++, $mode];
=20
 		$commit_time =3D $mtime if $mtime > $commit_time;
--=20
1.5.2.rc0.16.g0f57d

--=20
Uwe Kleine-K=F6nig

exit vi, lesson IV:
Z Z

NB: may write current file
