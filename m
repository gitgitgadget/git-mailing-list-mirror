From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git fast-import : Warning duplicated ref:
 refs/remotes/origin/master
Date: Mon, 30 May 2011 12:35:17 -0500
Message-ID: <20110530173517.GA13539@elie>
References: <BANLkTinTuEppMGO16z2sMkjV8FveCbrwEQ@mail.gmail.com>
 <20110529232405.GA8369@elie>
 <BANLkTinhH7ksP8EZV+Sd4ryCT1_bhVhgaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Mike Hommey <mh@glandium.org>
To: =?utf-8?B?SsOpcsOpbWll?= NIKAES <jeremie.nikaes@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 19:35:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR6NH-0003TU-8K
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 19:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448Ab1E3Rf0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 13:35:26 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42028 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757475Ab1E3RfZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 13:35:25 -0400
Received: by iyb14 with SMTP id 14so3098528iyb.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 10:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Cr3dcihs21g/LtQtqQoo/WMiaVxLj9lAR6+i72yX7LA=;
        b=cHYHCdIlyOa1Pn9IoEieIKhv81AzFG3GnX4ljHE5n2JVHZUh/FPD7Yx9QLvrVnvJ0C
         IKmPGfRt6Zecs01JzSoRCcwzoI7ghdsbMhTXvpj4g9JZar3Iide55WJ0xi/fVeiRdKXW
         lrLnALYQEM7f03BzSsV8lE0N7pprGBV9NuK3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=HQAg1AjxTi58GIcGLs3/Xow6khLct392riVBQTULWkaJqJhQJC9uZtBWkMGfDEumYY
         92NBkys4Meknb3Rb9JuAfrTaz53jBSueRiAlIfLkvz4zuxzoXe2zpmVpUrIwBVd4CkfD
         RskR3wV9OI2F7/lytPGXwn4ye9BJnip2s+2oc=
Received: by 10.42.165.10 with SMTP id i10mr969057icy.206.1306776924740;
        Mon, 30 May 2011 10:35:24 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.ameritech.net [69.209.65.98])
        by mx.google.com with ESMTPS id ly7sm1421676icb.12.2011.05.30.10.35.23
        (version=SSLv3 cipher=OTHER);
        Mon, 30 May 2011 10:35:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinhH7ksP8EZV+Sd4ryCT1_bhVhgaw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174763>

J=C3=A9r=C3=A9mie NIKAES wrote:

> No, I actually still have the problem. The version commited on github
> is pulling revisions straight to refs/heads/master which is gross
> After discussing this matter with our teacher Matthieu Moy, I wanted
> to change this to refs/remotes/origin/master but then this warning
> gets thrown.

The following fixes it for me.

-- >8 --
Subject: use refs/mediawiki/<remote> namespace for private refs

Unless the "refspec" capability is used, the remote helper machinery
expects remote helpers to write remote refs/heads/master ref to
refs/heads/master.  That's not very good since it scribbles on top of
whatever local changes the user might have.

So specify a refspec that puts the refs elsewhere.  For now this
only works when fetching from a named remote, like so:

	git remote add origin mediawiki::testwiki
	git fetch origin

Attempting to fetch directly from a URL with a command like
"git fetch mediawiki::testwiki" produces an "Invalid refspec"
error.
---
 git-remote-mediawiki |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/git-remote-mediawiki b/git-remote-mediawiki
index af66b58..7a3fdd3 100755
--- a/git-remote-mediawiki
+++ b/git-remote-mediawiki
@@ -7,6 +7,7 @@ use Storable qw(freeze thaw);
 use DateTime::Format::ISO8601;
 use Encode qw(encode_utf8);
=20
+my $remotename =3D $ARGV[0];
 my $url =3D $ARGV[1];
=20
 print STDERR "$url\n";
@@ -62,6 +63,7 @@ while ($loop) {
=20
 sub mw_capabilities {
 #	print STDOUT "fetch\n";
+	print STDOUT "refspec refs/heads/*:refs/mediawiki/$remotename/*\n";
 	print STDOUT "import\n";
 	print STDOUT "list\n";
 	print STDOUT "option\n";
@@ -91,7 +93,7 @@ sub mw_import {
 =09
 	sub get_last_revision {
 		# Get last commit sha1
-		my $commit_sha1 =3D `git rev-parse refs/remotes/origin/master 2>/dev=
/null`;
+		my $commit_sha1 =3D `git rev-parse refs/mediawiki/$remotename/master=
 2>/dev/null`;
=20
 		# Get note regarding that commit
 		chomp($commit_sha1);
@@ -202,15 +204,15 @@ sub mw_import {
 	=09
 		# If it's a clone and the first revision, initalize this ref
 		if ($fetch_from =3D=3D 1 && $n =3D=3D 1) {
-			#print "reset refs/remotes/origin/master\n";
+			#print "reset refs/mediawiki/$remotename/master\n";
 		}
-		print "commit refs/remotes/origin/master\n";
+		print "commit refs/mediawiki/$remotename/master\n";
 		print "mark :$n\n";
 		print "committer $user <$user\@$wiki_name> ", $dt->epoch, " +0000\n"=
;
 		print "data ", bytes::length(encode_utf8($comment)), "\n", encode_ut=
f8($comment);
 		# If it's not a clone, needs to know where to start from
 		if ($fetch_from !=3D 1 && $n =3D=3D 1) {
-			print "from refs/remotes/origin/master^0\n";
+			print "from refs/mediawiki/$remotename/master^0\n";
 		}
 		print "M 644 inline $title.wiki\n";
 		print "data ", bytes::length(encode_utf8($content)), "\n", encode_ut=
f8($content);
--=20
1.7.5.3
