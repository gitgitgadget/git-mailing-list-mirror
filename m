From: Simon Hausmann <simon@lst.de>
Subject: Re: Yet another git perforce integration
Date: Tue, 8 May 2007 12:49:35 +0200
Message-ID: <200705081249.36214.simon@lst.de>
References: <200705081023.38810.simon@lst.de> <81b0412b0705080247l2385529t61ad4ecd083261c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1889974.5y3BXdWctb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 12:49:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlNGR-0006Q9-E1
	for gcvg-git@gmane.org; Tue, 08 May 2007 12:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966429AbXEHKtr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 06:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966481AbXEHKtr
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 06:49:47 -0400
Received: from verein.lst.de ([213.95.11.210]:37971 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966429AbXEHKtq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 06:49:46 -0400
Received: from rhea.troll.no (nat0.troll.no [62.70.27.100])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l48AngpX026007
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Tue, 8 May 2007 12:49:43 +0200
User-Agent: KMail/1.9.6
In-Reply-To: <81b0412b0705080247l2385529t61ad4ecd083261c7@mail.gmail.com>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46564>

--nextPart1889974.5y3BXdWctb
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 08 May 2007 11:47:31 Alex Riesen wrote:
> On 5/8/07, Simon Hausmann <simon@lst.de> wrote:
> > git-p4 submit
> >
> > is used to submit changes back into Perforce (use at your own risk! :)
>
> right, because you have to know where (and when) your perforce repo is,
> and then where and when your copy (in Git) is, copy the p4 changes,
> rebase your changes on top of the just copied changes (p4 history
> is linear), try to submit, watch out for fails, because someone else could
> have submitted something, possibly resync and repeat. Cursing and
> swearing notwithstanding.

Yeah, it's a bit tricky. I'm using "p4 where" to locate the p4 checkout and=
=20
submitting back to perforce is an interactive process for me. The user is=20
presented with the entire diff for each change as well as the log message i=
n=20
an editor and can also abort/continue in-between. In real-life usage I've=20
found it to be fairly smooth though (no or only few conflits), but then I=20
guess it depends also on the number of people working on the depot as a who=
le=20
at the same time :)

> > It also doesn't require any additional meta-data. Instead every import
> > commit has a line added to the log message that contains the Perforce
> > path the changeset comes from as well as the change number. git-p4
> > sync/rebase "parses" this on the last commit in the "p4" git branch to
> > find out where to continue importing for incremental imports.
>
> How do you handle that patchwork of mappings synced to diverse revisions
> that P4 clients tend to become? Don't you have to save change number or
> revision for _each_ file?

I'm not sure I understand the question. I don't really use the p4 client vi=
ew=20
at all. I know the last imported p4 change number from the top commit in th=
e=20
git "p4" branch. Then I use "p4 changes //depot/path/@lastchangenum,#head" =
to=20
get the list of changes that need to be imported. For each change I look at=
=20
the list of affected files using "p4 describe" and feed each file using "p4=
=20
print" into git-fast-import. None of these import operations require anythi=
ng=20
from the client view/mapping.

Only when submitting changes back to Perforce the corresponding depot path=
=20
must be checked out /somewhere/ (!=3D git repository), so that "p4=20
where //depot/path" reports it. But then I just offer the user to run "p4=20
sync" before applying the changes from git.

I guess the feasibility may very well depend a bit on the development model=
=20
used with p4. I don't know if there are many models, but for example we hav=
e=20
a fairly linear model where it's normal to be at the #head revision, don't=
=20
use a whole lot of branches in Perforce. So p4 users are used to running "p=
4=20
resolve" and I personally got used to git conflict resolving through "git=20
rebase" :)

> > What's still missing is a bit of cleanup. For example I'd like to put t=
he
> > import branch into refs/remotes instead of refs/heads, but I've had some
> > problems with fast-import when trying that. Also the support for Perfor=
ce
> > branches isn't quite working yet.
>
> AFACS, it is impossible: Perforce does not have branches (in Git's meaning
> of the word). It only has directories. Integration (it is something like
> "in-repo-copy") metadata are just duct-taped on it (that stupid
> branchspec).

True, it probably depends a bit on the depot organization. For example we h=
ave
//depot/qt/main and then branches like //depot/qt/4.3 or research branches=
=20
like //depot/qt/research/somecoolfeature . That's the kind of structure I'd=
=20
like to map to git, and merges /could/ be detected from integrations if aft=
er=20
a commit that has integrations between these "known" branches all revisions=
=20
of all files are integrated. But that's obviously a very slow operation and=
 I=20
currently don't think it's worth it. But of course detecting the initial=20
branch point is easy and fast and that is worth it (to record the branch=20
creation, there's no merge of course).

> > Also I've never tried it on Windows and I expect problems as the script
> > uses pipes, calls "patch", etc.
>
> ...and case-sensitivity. BTW, how does your script handle filenames with
> special characters and spaces in them?

I don't really treat them special. I get the file name from the output of "=
p4=20
describe" (using the Guido option :) and pass it on to git-fast-import.

Simon

--nextPart1889974.5y3BXdWctb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQBGQFXAWXvMThJCpvIRAuiwAJda0csKjJbeuAtibwiczWtnG7CyAJ0WqM3H
vovsSh3YF5hBxCVc6b/PQg==
=7ZL4
-----END PGP SIGNATURE-----

--nextPart1889974.5y3BXdWctb--
