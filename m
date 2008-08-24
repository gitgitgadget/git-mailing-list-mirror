From: Simon Hausmann <simon@lst.de>
Subject: Re: [RFC] Using git-p4 on project with branches
Date: Sun, 24 Aug 2008 12:36:32 +0200
Message-ID: <200808241236.38387.simon@lst.de>
References: <1a6be5fa0808180226h79eebf46yad9174b1518d4eed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1822402.u6dpi6YMtB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Tor Arvid Lund" <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 12:38:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXCyw-0004Cd-Ma
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 12:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbYHXKg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 06:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbYHXKg4
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 06:36:56 -0400
Received: from hoat.troll.no ([62.70.27.150]:51066 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752698AbYHXKgz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 06:36:55 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id BEA4C20A4D;
	Sun, 24 Aug 2008 12:36:49 +0200 (CEST)
Received: from rani.localnet (unknown [172.20.1.59])
	by hoat.troll.no (Postfix) with ESMTP id 25EEF209F1;
	Sun, 24 Aug 2008 12:36:47 +0200 (CEST)
User-Agent: KMail/1.10.0 (Linux/2.6.26-5-generic; KDE/4.1.0; i686; ; )
In-Reply-To: <1a6be5fa0808180226h79eebf46yad9174b1518d4eed@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93526>

--nextPart1822402.u6dpi6YMtB
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 18 August 2008 11:26:27 Tor Arvid Lund wrote:
> Hi!
>
> I really appreciate the work that is done with allowing us poor souls
> stuck with perforce at work to use git via git-p4. But I'm wondering
> how to make it work when there are several branches on the perforce
> server.
>
> Say, for instance, that I have this setup:
>
> //depot/old/path/to/projectX
> //depot/new/path/to/projectX_Devel_Branch
> //depot/new/path/to/projectX_Release_1.2_Branch
> //depot/new/path/to/projectOther
>
> It would be really nice, if I were able to make a projectX.git
> repository with the 'old', 'devel' and '1.2' branches. It seems that
> the --detect-branches argument to P4Sync wants me to enter
> //depot/new/path/to as the root path, and detect p4 branchspecs from
> there. That works poorly for me, since it would also include
> projectOther, which I don't want. It would also not include the 'old'
> branch.
>
> I have looked briefly at the git-p4 code, but don't know it very well
> yet. Anyway, I suspect this functionality is not implemented... I
> might try to do this myself, and if anybody has ideas on how to get
> started, it would be much appreciated.

I can try to explain the way we import multiple branches into one git=20
repository where I work. Our setup is based on a few assumptions on the lay=
out=20
of the perforce depot.

The components in our depot paths begin with the project, followed by the n=
ame=20
of the branch:

//depot/project/main
//depot/project/4.4
//depot/project/4.4.1
//depot/project/4.5
//depot/project/research/foobar

4.4 is branched off of main, 4.4.1 is branched off of 4.4, 4.5 and=20
research/foobar are branched off of main again.

Based on this structure we also have branch mappings stored on the perforce=
=20
server. They were originally introduced for convenience being able to run p=
4=20
integrate with few arguments. Now they are also used for the git import:

4.4branch:

//depot/project/main/...    //depot/project/4.4/...

(same for 4.5, 4.4.1, etc.)

Based on this git-p4 imports changes:

1) git-p4 is aware of //depot/project as general prefix for all branches.

2) Based on the p4 branch mappings retrieved from the server it is easy to=
=20
determine that the 'research/foobar' component in the=20
//depot/project/research/foobar/somedir/somefile.c path of a file change=20
represents the name of the branch.

3) Based on the branch mapping git-p4 knows that for example 4.4 is based o=
n=20
main. When the first change in the 4.4 branch is imported git-p4 assumes th=
at=20
last change number in //depot/qt/main that is less than $currentChangeNumber
represents the "parent" of the branch.

This approach has served us quite well, and I like that that doesn't requir=
e=20
any separate configuration files or extra state information. However I=20
understand that it requires discipline on the use of Perforce and the way=20
projects are branched.

=46rom your description I understand that you are using a very different=20
structure. I think what may work well for you would be an approach where yo=
u=20
specify a mapping from depot path to git branch manually in a configuration=
=20
file, and changes git-p4 to read such a file.

> To support submitting changelists back to perforce, it would probably
> need some configuration (to determine which path to submit to in
> perforce)... Like:
>
> [git-p4 "branches"]
>         old =3D //depot/old/path/to/projectX
>         devel =3D //depot/new/path/to/projectX_Devel_Branch
>         1.2 =3D //depot/new/path/to/projectX_Release_1.2_Branch
>
> Well, I guess I'm just wondering if this is something anybody but me
> would like to have? Or if there is another/better way to go about
> doing it...

Submitting changes back to Perforce with git-p4 submit is actually a very=20
simple thing, and thanks to Perforce's knowledge of everything on the clien=
t=20
side there is no need to set up any configuration.

1) Based on the [git-p4: depot-paths...] field in the commit log it is easy=
 to=20
determine the depot path.
2) Using the p4 where command git-p4 can find out where in your p4 client v=
iew=20
the branch resides.
3) Changes are applied in that checkout (along with p4 edit commands) and t=
he=20
change can be submitted to perforce.
4) Afterwards an import from Perforce is started and the changes just=20
submitted appear in the import with the same patch-ids as the local commits=
,=20
so git rebase will replace your local commits with the imported changes.


I hope this helps a bit with the git-p4 understanding :)


Simon

--nextPart1822402.u6dpi6YMtB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIsTm2WXvMThJCpvIRAoNHAKCkX1XTWvJY94pvmfiJU+5JY1tEZQCgwBSV
BECs3u97Pa8BjbIdHvVj56o=
=rQP/
-----END PGP SIGNATURE-----

--nextPart1822402.u6dpi6YMtB--
