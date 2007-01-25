From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH] make --upload-pack option to git-fetch configurable
Date: Thu, 25 Jan 2007 05:45:39 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070125044539.GA11397@cepheus>
References: <20070116150259.GA2439@cepheus> <Pine.LNX.4.63.0701161614070.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070116162645.GA18894@informatik.uni-freiburg.de> <20070116200847.GB29100@spearce.org> <Pine.LNX.4.63.0701162129430.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070117164410.GA5950@cepheus> <7vps9dsgn0.fsf@assigned-by-dhcp.cox.net> <20070118071723.GB3245@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 25 05:46:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9wUv-0002iV-RS
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 05:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933210AbXAYEp6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 24 Jan 2007 23:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbXAYEp6
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 23:45:58 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:43161 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752076AbXAYEp5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jan 2007 23:45:57 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1H9wUm-0001n0-F1; Thu, 25 Jan 2007 05:45:56 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l0P4jr1p001277;
	Thu, 25 Jan 2007 05:45:53 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l0P4jcJA001276;
	Thu, 25 Jan 2007 05:45:38 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <20070118071723.GB3245@informatik.uni-freiburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37705>

This introduces the config item remote.<name>.uploadpack to override th=
e
default value (which is "git-upload-pack").

Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
---

> > diff --git a/git-fetch.sh b/git-fetch.sh
> > index 87b940b..7372c5f 100755
> > --- a/git-fetch.sh
> > +++ b/git-fetch.sh
> > @@ -82,6 +82,13 @@ case "$#" in
> >  	set x $origin ; shift ;;
> >  esac
> > =20
> > +if test -z "$exec" && exec=3D$(git-repo-config "remote.$1.uploadpa=
ck")
> > +then
> > +	# No command line override and we have configuration for the remo=
te.
> > +	upload_pack=3D"-u $exec"
> > +	exec=3D"--exec=3D$exec"
> > +fi
> > +
> >  remote_nick=3D"$1"
> >  remote=3D$(get_remote_url "$@")
> >  refs=3D
>=20
> I thought that it would be cleaner to add this code to
> git-parse-remote.sh and only do it if $(get_data_source) =3D=3D 'conf=
ig'.
This is, what this patch does.  Actually it was easier than I feared.

 git-fetch.sh        |    6 ++++++
 git-parse-remote.sh |   13 +++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 07a1d05..61c8cf4 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -85,6 +85,12 @@ case "$#" in
 	set x $origin ; shift ;;
 esac
=20
+if test -z "$exec"
+then
+	# No command line override and we have configuration for the remote.
+	exec=3D"--upload-pack=3D$(get_uploadpack $1)"
+fi
+
 remote_nick=3D"$1"
 remote=3D$(get_remote_url "$@")
 refs=3D
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 4fc6020..1122c83 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -279,3 +279,16 @@ resolve_alternates () {
 		esac
 	done
 }
+
+get_uploadpack () {
+	data_source=3D$(get_data_source "$1")
+	case "$data_source" in
+	config)
+		uplp=3D$(git-repo-config --get "remote.$1.uploadpack")
+		echo ${uplp:-git-upload-pack}
+		;;
+	*)
+		echo "git-upload-pack"
+		;;
+	esac
+}
--=20
1.5.0.rc2.g3ea949



Uwe Kleine-K=F6nig wrote:
>=20
> Best regards
> Uwe
>=20
> --=20
> Uwe Kleine-K=F6nig
>=20
> If a lawyer and an IRS agent were both drowning, and you could only s=
ave
> one of them, would you go to lunch or read the paper?
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D12+divided+by+3
