From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-svn: Fails to drop leading path from empty dir name
Date: Mon, 23 Nov 2009 00:52:48 +0100
Message-ID: <20091122235248.GA17418@atjola.homenet>
References: <20091122134638.GA12233@atjola.homenet>
 <20091122232504.GA28127@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Nov 23 00:53:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCMFO-0003sf-0I
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 00:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855AbZKVXws convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 18:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755839AbZKVXws
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 18:52:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:36279 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755790AbZKVXwr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 18:52:47 -0500
Received: (qmail invoked by alias); 22 Nov 2009 23:52:52 -0000
Received: from i59F5B6DD.versanet.de (EHLO atjola.homenet) [89.245.182.221]
  by mail.gmx.net (mp011) with SMTP; 23 Nov 2009 00:52:52 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19b1p1CwxNb5tTqxOpUjngy3jwShNrqYXsy+2VyXR
	Wj4i3zEMsaugES
Content-Disposition: inline
In-Reply-To: <20091122232504.GA28127@dcvr.yhbt.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133466>

Hi Eric,

On 2009.11.22 15:25:04 -0800, Eric Wong wrote:
> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> wrote:

> I'm having a bit of trouble figuring out exactly what you mean
> here, can you double check your tests?  Annotations below, thanks
>=20
> > +test_expect_success 'clone trunk' 'git svn clone -s "$svnrepo" tru=
nk'
>                                                     ^^            ^^^=
^^
>                                                            Huh?
>=20
> > +test_expect_success 'empty directories in trunk exist' '
> > +	(
> > +		cd cloned &&
>                    ^^^^^^ - ?
>=20
> > +		for i in trunk/a trunk/"weird file name"

Argh, yeah, I messed that patch up, the test only failed because I also
messed up this line, adding the trunk prefix there, too. Fixed patch
below.

SVN Repo layout:

/
|
|---trunk
|   |
=2E.. |---foo/ # Empty
    |
    |---bar/
        |
        somefile

with "git svn clone -s svn://host/path/to/repo you get:

=2Egit
bar/
bar/somefile
trunk/foo # This should be just foo/

i.e. the empty directories have their path relative to the repo root,
instead of relative to the directory the git branch is associated with.

Sorry for the messed up first patch.

Bj=F6rn

diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs=
=2Esh
index 5948544..70c52c1 100755
--- a/t/t9146-git-svn-empty-dirs.sh
+++ b/t/t9146-git-svn-empty-dirs.sh
@@ -82,4 +82,27 @@ test_expect_success 'git svn mkdirs -r works' '
 	)
 '
=20
+test_expect_success 'initialize trunk' '
+	for i in trunk trunk/a trunk/"weird file name"
+	do
+		svn_cmd mkdir -m "mkdir $i" "$svnrepo"/"$i"
+	done
+'
+
+test_expect_success 'clone trunk' 'git svn clone -s "$svnrepo" trunk'
+
+test_expect_success 'empty directories in trunk exist' '
+	(
+		cd trunk &&
+		for i in a "weird file name"
+		do
+			if ! test -d "$i"
+			then
+				echo >&2 "$i does not exist"
+				exit 1
+			fi
+		done
+	)
+'
+
 test_done
