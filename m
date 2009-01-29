From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: (beginner) git rm
Date: Thu, 29 Jan 2009 03:34:32 +0100
Message-ID: <20090129023432.GF7503@atjola.homenet>
References: <49804385.908@dbservice.com> <1233144045221-2231849.post@n2.nabble.com> <49804D41.3010801@dbservice.com> <1233166992184-2233892.post@n2.nabble.com> <20090128201727.GD7503@atjola.homenet> <1233175322729-2234796.post@n2.nabble.com> <7vab9bm85b.fsf@gitster.siamese.dyndns.org> <20090128221355.GE7503@atjola.homenet> <7v7i4fkqmo.fsf@gitster.siamese.dyndns.org> <6bef44ba0901281711m2d05e70fj4dd3ae03d7fe1052@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Zabre <427@free.fr>,
	git@vger.kernel.org
To: Jonathan Wills <runningwild@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 03:37:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSMm7-0003Xx-5x
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 03:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756581AbZA2Cfj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jan 2009 21:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756568AbZA2Cfj
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 21:35:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:39349 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756401AbZA2Cfi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 21:35:38 -0500
Received: (qmail invoked by alias); 29 Jan 2009 02:35:36 -0000
Received: from i577B96EB.versanet.de (EHLO atjola.local) [87.123.150.235]
  by mail.gmx.net (mp011) with SMTP; 29 Jan 2009 03:35:36 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+C1Y9nN9CCJYU47JgPUOS7NrAEE83HThvEbOsSlt
	1bkacX0uM5YTSF
Content-Disposition: inline
In-Reply-To: <6bef44ba0901281711m2d05e70fj4dd3ae03d7fe1052@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107618>

On 2009.01.28 17:11:07 -0800, Jonathan Wills wrote:
> This seems like an appropriate thread to ask something I came across =
today.
> Either I am unclear about the precise semantics of git checkout <bran=
ch>
> <path>, or there is a bug in said command.  I noticed this when I wan=
ted to
> get a directory to match the same directory in another branch, so I d=
id rm
> -rf dir, followed by git checkout master dir.  Afterwards I noticed t=
hat
> files in that directory that had previously been in my branch but wer=
e not
> in the master branch had returned.  Earlier in this thread it was men=
tioned
> that git checkout will not remove files, but in this case I had alrea=
dy
> removed those files and git checkout actually replaced them (and not =
from
> the master branch like I asked, but from the current branch).

This is exactly what I meant. Your "rm -rf dir" only removed the
directory from the working tree, but _not_ from the index. And what
"git checkout master -- dir" then does is that it puts all the stuff
that is in master's "dir" into the index, in _addition_ to the stuff
already in the index. And then it puts everything from the index's "dir=
"
into the working tree. This is really a two step process and in each
step the pathspec is matched separately.

So the working tree doesn't have "dir" at all.

In the index you still have:
whatever
dir/file (index version)
dir/other_file

In master you have:
whatever_2
dir/file (master version)
dir/yet_another_file

Then you do "git checkout master -- dir".

In the first step, that "dir" pathspec matches these files from master:
dir/file
dir/yet_another_file

So those are added to the index, and the index will have:
whatever
dir/file (master version)
dir/other_file
dir/yet_another_file

So "dir/file" was replaced, and "dir/yet_another_file" was added. But
"dir/other_file" is still around.

And then comes the index -> working tree step. The pathspec matches all
three files in "dir" in the index, and so they appear in the working
tree.


To get what you expected, you have several options:
a)
rm -rf dir
git add -u dir (drops it from the index)
git checkout master -- dir

b)
git rm -rf dir
git checkout master -- dir

Just saves the "git add -u" step.

c)
rm -rf dir
git reset master -- dir
git checkout -- dir

The reset makes "dir" in the index equal to master's "dir" (ok,
technically that's wrong, as the index doesn't even know about "dir" on
its own, but my brain fails to produce a correct description).

Bj=F6rn
