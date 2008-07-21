From: <ncrfgs@tin.it>
Subject: making a branch with just one file and keeping its whole history
Date: Mon, 21 Jul 2008 06:18:04 +0200
Message-ID: <20080721061804.223f7801@mail.tin.it>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gFaIBxTxjKsf6.LHxJIoCPA";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: madewokherd@gmail.com, ncrfgs@tin.it
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 06:24:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKmwf-00077O-Tm
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 06:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbYGUEXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 00:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbYGUEXV
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 00:23:21 -0400
Received: from vsmtp4.tin.it ([212.216.176.224]:57921 "EHLO vsmtp4.tin.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131AbYGUEXU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 00:23:20 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jul 2008 00:23:15 EDT
Received: from mail.tin.it (87.11.137.129) by vsmtp4.tin.it (8.0.016.5)
        id 485F5E75015BBC61; Mon, 21 Jul 2008 06:18:09 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89297>

--Sig_/gFaIBxTxjKsf6.LHxJIoCPA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

I have a working local repository and I'd like to make a branch with just o=
ne
file (let's say path2/filename2) and to keep its whole history.

At first I've considered creating a fresh new repo and redirecting
`git-log -p --follow path2/filename2` output to some other git command.

When later I've discussed the topic on #git@irc.freenode.net I've been poin=
ted to
git-filter-branch.

Searching for more info about git-filter-branch on the web I've found a cou=
ple of
examples that might be close to what I'd like to accomplish:

from http://loupgaroublond.blogspot.com/2007/12/how-to-split-repository-in-=
git.html
	$ git filter-branch --tree-filter 'rm -rf $put_the_files_you_want_to_remov=
e_here' HEAD
	$ git reset --hard
	$ git gc --aggressive
	$ git prune

from http://log.emmanuelebassi.net/archives/2007/09/when-the-levee-breaks/
	$ git clone --no-hardlinks /tmp/gtk2-perl Gtk2-SourceView.git
	$ git filter-branch --subdirectory-filter Gtk2-SourceView HEAD
	$ git reset --hard
	$ git gc --aggressive
	$ git prune

I've also gone through man pages and I've found something interesting:
	$ git-filter-branch --tree-filter 'rm $filename' HEAD
or, as far as I understood, equivalent and faster:
	$ git-filter-branch --index-filter 'git-update-index --remove $filename' H=
EAD=20

Now, what I'd like to do is complementary to the above example; the differe=
nce is
that I don't want to remove just one file and its traces from history; rath=
er I'd
like to have a new repo which includes just that file and its history.

So I would need something like the following command:
	$ git-filter-branch --tree-filter 'keep(?) $filename' HEAD

I think one possible solution would be:
	$ git-filter-branch --tree-filter 'find ! -type d | grep -v "^./path2/file=
name2$" | while read FILE; do rm $FILE; done' HEAD

Problems come, I think, if the content you want to keep track of, is placed=
 in a
file that has been renamed. For example, let's say that the content you wan=
t to
keep track of was in:
	path1/filename1 from commit 1 to commit 1000
	path2/filename1 from commit 1001 to commit 2000
	path2/filename2 from commit 2001 to commit 3000

In this case I think one possible solution would be:
	$ git-filter-branch --tree-filter 'find ! -type d | grep -v "^./path1/file=
name1$" | grep -v "^./path2/filename1$" | grep -v "^./path2/filename2$" | w=
hile read FILE; do rm $FILE; done' HEAD

But what happens if in the meanwhile a new file has been created with one o=
f the
names we used for the content we want to keep track of? Let's say, followin=
g the
previous case, that path2/filename1 has been renamed to path2/filename2 with
commit 2001, and that with commit 2500 a new file has been created with name
path1/filename1.

Considering both the solutions I've found on the web and the ones I've been
suggested on #git@irc.freenode.net I've found four/five possible path to fo=
llow:
	a) git log | another git command (later I've been told that git log --foll=
ows leaves out the initial revision)
	b) git clone; git filter-branch
	c) create a new repo with your one file and make an initial commit
	   then do: (cd repo-with-one-file; git ls-tree)|(cd repo-where-you-want-t=
he-new-branch; git-mktree)
	d) git commit-tree that-tree < file-with-commit-message
	   then: git checkout -b branchname that-commit
	e) git-am or git apply processing the output of git-log or another
	   similar command

I hope you guys can help me to make some light on this issue.


Thanks in advance. :D


P.S.
Sorry for my bad english but I'm not a native english speaker, I hope that =
what
I've written made enough sense to you. :)

--Sig_/gFaIBxTxjKsf6.LHxJIoCPA
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkiEDfwACgkQ8UJozN0kXhkN4wCg4upCrhwOsqG/9wJfXkTfUkLp
lAMAoI8vaLte9c0XkJDe1CoCjDHWV2TF
=4Q1n
-----END PGP SIGNATURE-----

--Sig_/gFaIBxTxjKsf6.LHxJIoCPA--
