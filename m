From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] git-svn: fix ls-tree usage with dash-prefixed paths
Date: Mon, 30 Mar 2009 07:28:17 +0200
Message-ID: <20090330052817.GB2681@atjola.homenet>
References: <22719363.post@talk.nabble.com> <20090326130213.GC3114@atjola.homenet> <83dfc36c0903260735q3231ce96h5949d1123858995f@mail.gmail.com> <83dfc36c0903270418q59a81290xcb8043b8c037be18@mail.gmail.com> <20090329060858.GB15773@dcvr.yhbt.net> <20090329061045.GA29721@dcvr.yhbt.net> <7v8wmoqdc1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Anton Gyllenberg <anton@iki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 08:08:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoAfq-0006fF-To
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 08:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbZC3GD1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 02:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbZC3GD1
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 02:03:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:35290 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750799AbZC3GD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 02:03:26 -0400
Received: (qmail invoked by alias); 30 Mar 2009 06:03:22 -0000
Received: from i59F55306.versanet.de (EHLO atjola.local) [89.245.83.6]
  by mail.gmx.net (mp013) with SMTP; 30 Mar 2009 08:03:22 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19XOZAKEVhXEbiEX79dRxe3cf0jWHLLWM4XVzup3P
	pL4rAatBLfGR0/
Content-Disposition: inline
In-Reply-To: <7v8wmoqdc1.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115082>

On 2009.03.29 13:33:02 -0700, Junio C Hamano wrote:
> Eric Wong <normalperson@yhbt.net> writes:
>=20
> > To find the blob object name given a tree and pathname, we were
> > incorrectly calling "git ls-tree" with a "--" argument followed
> > by the pathname of the file we wanted to get.
> >
> >   git ls-tree <TREE> -- --dashed/path/name.c
> >
> > Unlike many command-line interfaces, the "--" alone does not
> > symbolize the end of non-option arguments on the command-line.
> >
> > ls-tree interprets the "--" as a prefix to match against, thus
> > the entire contents of the --dashed/* hierarchy would be
> > returned because the "--" matches "--dashed" and every path
> > under it.
>=20
> The above makes only half a sense to me.  In an empty directory:
>=20
>     $ git init
>     Initialized empty Git repository in /tmp/empty/.git
>     $ mkdir -p ./--dashed/path
>     $ >./--dashed/path/name
>     $ git add .
>     $ git ls-files
>     --dashed/path/name
>     $ git commit -a -m initial
>     [master (root-commit) cd44284] initial
>      0 files changed, 0 insertions(+), 0 deletions(-)
>      create mode 100644 --dashed/path/name
>     $ git ls-tree HEAD^{tree} --
>     $ git ls-tree HEAD^{tree} -- --dashed/path/name
>     100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	--dashed/pat=
h/name
>     $ mkdir ./--
>     $ >./--/eman
>     $ git add .
>     $ git commit -m second
>     [master 80f8ef9] second
>      0 files changed, 0 insertions(+), 0 deletions(-)
>      create mode 100644 --/eman
>     $ git ls-tree HEAD^{tree} -- --dashed/path
>     100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	--/eman
>     040000 tree 23e59e0c91294c39ac7c5a2e39efb01d878de9a0	--dashed/pat=
h
>     $ exit
>=20
> Perhaps the problem repository had a pathname that is exactly -- (in
> addition to --dashed/), and ls-tree emitted everything under --/
> hierarchy?  In other words, your fix to git-svn may be correct and I =
am
> reading your problem description above incorrectly?

Your test case is flawed, because you only have a single path in
--dashed/

Initialized empty Git repository in /home/doener/test/.git/
$ mkdir ./--dashed
$ touch ./--dashed/{1,2}
$ git add .
$ git ls-files
--dashed/1
--dashed/2
$ git commit -m init
[master (root-commit) ae7cd83] init
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 --dashed/1
 create mode 100644 --dashed/2
$ git ls-tree HEAD^{tree}
040000 tree f353b342b53872c6a510229524f819c4fe0d5c1b	--dashed
$ git ls-tree HEAD^{tree} --
$ git ls-tree HEAD^{tree} -- --dashed
040000 tree f353b342b53872c6a510229524f819c4fe0d5c1b	--dashed
$ git ls-tree HEAD^{tree} -- --dashed/
100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	--dashed/1
100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	--dashed/2
$ git ls-tree HEAD^{tree} -- --dashed/1
100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	--dashed/1
100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	--dashed/2

Or even more weird (at least to me):

Initialized empty Git repository in /home/doener/test/.git/
$ mkdir foo fab
$ touch {foo,fab}/{1,2}
$ git add .
$ git commit -m init
[master (root-commit) fdb7bb3] init
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 fab/1
 create mode 100644 fab/2
 create mode 100644 foo/1
 create mode 100644 foo/2
$ git ls-files foo/1 fab/1
fab/1
foo/1
$ git ls-files foo/1 fab/1 f
fab/1
foo/1
$ git ls-tree HEAD^{tree} foo/1 fab/1
100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	fab/1
100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	foo/1
$ git ls-tree HEAD^{tree} foo/1 fab/1 f
100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	fab/1
100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	fab/2
100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	foo/1
100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	foo/2

So if you go into some tree, any additional pattern that is a prefix of
the tree name will match the tree and its contents.

Bj=F6rn
