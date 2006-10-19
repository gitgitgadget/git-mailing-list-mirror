From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: "stage files" vs "cached files"
Date: Thu, 19 Oct 2006 16:58:52 +0100
Message-ID: <4537A0BC.5040301@shadowen.org>
References: <eh7vl2$unr$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 18:01:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaaJQ-00018c-Sy
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 18:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946120AbWJSP7b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Oct 2006 11:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946139AbWJSP7b
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 11:59:31 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:62479 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1946120AbWJSP7a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 11:59:30 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GaaIJ-0000BD-II; Thu, 19 Oct 2006 16:58:55 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: t2a2e9z8ncbs9qg@brefemail.com
In-Reply-To: <eh7vl2$unr$1@sea.gmane.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29362>

Jerome Lovy wrote:
> Hi,
>=20
> after having read tutorial1+2, I thought the following were more or l=
ess
> synonyms: index ~ directory cache ~ staging area
>=20
> But then I discover that --cache and --staged are two different thing=
s,
> notably when using ls-files.
>=20
> The documentation states indeed:
>  "--cached   Show cached files in the output"
>  "--stage    Show stage files in the output"
>=20
> I'm a bit confused. Is maybe a "stage file" entry missing in the glos=
sary?
>=20
> TIA for clarification/pointer.
> J=E9r=F4me

This is not stage as in staging area, its stage as in 'at a cirtain
stage'.  It refers to files which are in the index but are in conflict.

The cache doesn't just contain an entry for each file.  It contains an
entry for each file version in a merge situation.  These are referred t=
o
as 'stages'.  There is a description in the documentation about how the=
y
get pushed 'down' to stage 0 and then are deemed merged (see
Documentation/core-tutorial.txt).

Below is the git ls-files --cached, and --stage output from a repo whic=
h
has one file 'bar' which is fine and another 'bar' which has a conflict=
=2E

  apw@pinky$ git ls-files --cached
  bar
  this
  this
  this
  apw@pinky$ git ls-files --stage
  100644 8dc5f23c673e9c1ac8dd3499f9acab11b093527f 0       bar
  100644 01e79c32a8c99c557f0757da7cb6d65b3414466d 1       this
  100644 fbbafbfdaadbff9c7f8db580f91a8ab5a0653704 2       this
  100644 10c8337d3d240283bdf35af68d17d1319ca069a4 3       this

Note that there is in fact three 'this's in the index.  The first entry
is bar which is in stage 0 and is merged fine.  'this' however appears
three times.  1 represents the common parent of the merge (I believe)
and 2 and 3 represent the conflicting options for that.  The 'this' on
disk has the mangled version with both sets of changes in, but this
information can be used to show the actual files in the various forms.

  apw@pinky$ git cat-file blob :1:this
  1
  2
  3
  apw@pinky$ git cat-file blob :2:this
  1
  2b
  3
  apw@pinky$ git cat-file blob :3:this
  1
  2a
  3
  apw@pinky$ cat this
  1
  <<<<<<< HEAD/this
  2b
  =3D=3D=3D=3D=3D=3D=3D
  2a
  >>>>>>> c2acfdd8e6a50e571a007744e023c65c7b188dbf/this
  3

-apw
