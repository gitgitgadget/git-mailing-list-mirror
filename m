From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: help needed: Splitting a git repository after subversion
	migration
Date: Mon, 8 Dec 2008 15:24:47 +0100
Message-ID: <20081208142447.GA20186@atjola.homenet>
References: <493C0AAD.1040208@intra2net.com> <493D2174.80500@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Jarosch <thomas.jarosch@intra2net.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Dec 08 15:26:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9h3r-0000Jk-Sm
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 15:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbYLHOYw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2008 09:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbYLHOYw
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 09:24:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:44983 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752021AbYLHOYv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 09:24:51 -0500
Received: (qmail invoked by alias); 08 Dec 2008 14:24:49 -0000
Received: from i577B9E20.versanet.de (EHLO atjola.local) [87.123.158.32]
  by mail.gmx.net (mp007) with SMTP; 08 Dec 2008 15:24:49 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18e/1JghMwea5kc9dAWIktK9dekPXHbGlq9tVmEyF
	2fJvPPQVZBEFdB
Content-Disposition: inline
In-Reply-To: <493D2174.80500@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102547>

On 2008.12.08 14:30:28 +0100, Michael J Gruber wrote:
> Thomas Jarosch venit, vidit, dixit 07.12.2008 18:41:
> > Hello together,
> >=20
> > I've successfully imported a large subversion repository into git.
> > The tree contains source code and binary data ("releases"),
> > the resulting .git directory is about 11GB.
> >=20
> > After the import I recreated the tags/branches by converting the re=
fs
> > to the subversion tags using a small shell script from the web:
> >=20
> > for branch in `git branch -r`; do
> >      ...
> >      version=3D`basename $branch`
> >      git tag -s -f -m "$subject" "$version" "$branch^"
> >      git branch -d -r $branch
> > done
> >=20
> > Ok, so far everything went really smooth. I wanted to split this re=
pository
> > into two repositories, one for the source code and one for the bina=
ry data.
> > The current tree layout is like this:
> >=20
> > sources/c++_xyz
> > releases/large_binary_data
> > ...
> >=20
> > The original tree was imported from CVS to subversion and the layou=
t
> > of the trunk was once reorganized/moved later. Here's the command
> > I used to split out the "source" tree:
> >=20
> > git filter-branch --index-filter 'git rm --cached --ignore-unmatch =
-r -f
> > CVSROOT Attic source/Attic develpkg/Attic
> > source/packages/Attic releases update_pkg' -- --all
> >=20
> > After that I ran these commands to reclaim the space:
> > - git clone --no-hardlinks filtered_tree final_output
> > - cd final_output
> > - git gc
> > - git prune
> > - git repack -a -d --depth=3D250 --window=3D250
> >=20
> > Unfortunately the .git directory of the "source" tree is still 7.5G=
B big.
> >=20
> > When I just imported the "trunk" from subversion without any tags
> > and then ran "git filter-branch --subdirectory-filter source" + git=
 gc,
> > the .git directory was about 1.5GB afterwards.
> >=20
> > How can I find out where those other 6GB go to?
> > I already looked at the tags with gitk,
> > there's no sign of the releases/* stuff left.
>=20
> I strongly suspect the reorganization/move to be the cause. Most
> probably some releases were put in places where you don't expect them=
,
> and therefore they are not filtered out by removing the releases subd=
ir.
> If they have distinguished file names (say you know a name from befor=
e
> the move) you can find them using "git log". Or use gitk --all, switc=
h
> to "tree display" and look for unexpected files in the earliest revis=
ions.

If it's about huge objects, and not just lots of small objects, you can
use this:

# Find large objects
git rev-list --objects --all | cut -f1 -d' ' | \
	git cat-file --batch-check | grep blob | sort -n -k 3

This outputs lines in the format:
<object_hash> blob <object_size>

sorted by object size, large objects come last. To make use of that
information, you'll likely need to also find the filename(s) that are
used for these blobs:

# Find filenames for objects
git rev-list --all --objects | grep <object_hash>

And then you can use the filenames to do some more filtering.

Bj=F6rn
