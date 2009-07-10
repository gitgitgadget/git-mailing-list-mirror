From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [script] find largest pack objects
Date: Fri, 10 Jul 2009 13:43:16 +0200
Message-ID: <20090710114316.GA6880@atjola.homenet>
References: <A67AA762-487D-4CFB-B555-718C88C5787D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Antony Stubbs <antony.stubbs@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 13:43:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPEVz-00083F-HQ
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 13:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208AbZGJLn3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2009 07:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754556AbZGJLn2
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 07:43:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:38441 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753208AbZGJLnT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 07:43:19 -0400
Received: (qmail invoked by alias); 10 Jul 2009 11:43:16 -0000
Received: from i59F57A2B.versanet.de (EHLO atjola.local) [89.245.122.43]
  by mail.gmx.net (mp047) with SMTP; 10 Jul 2009 13:43:16 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18Cg84KQxACZySiovsD0P4IQ6QoJqTaKAfxHJXRN0
	DzGBeWNfGHMWhB
Content-Disposition: inline
In-Reply-To: <A67AA762-487D-4CFB-B555-718C88C5787D@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123050>

On 2009.07.10 13:16:50 +1200, Antony Stubbs wrote:
> Blog post about git pruning history and finding large objects in
> your repo: http://stubbisms.wordpress.com/2009/07/10/git-script-to-sh=
ow-largest-pack-objects-and-trim-your-waist-line/
>=20
> This is a script I put together after migrating the Spring Modules
> project from CVS, using git-cvsimport (which I also had to patch, to
> get to work on OS X / MacPorts). I wrote it because I wanted to get
> rid of all the large jar files, and documentation etc, that had been
> put into source control. However, if _large files_ are deleted in
> the latest revision, then they can be hard to track down.

Here's my script, basically for the same purpose, but instead of lookin=
g
at the packfiles, it looks at the rev-list output to find those objects
that aren't prunable (ignoring the reflog). I'm also using some kind of
ugly sed invocation to run rev-list only twice, regardless of the numbe=
r
of objects to be shown, which greatly reduces the time required to run
the script.

#!/bin/sh
git rev-list --all --objects |
	sed -n $(git rev-list --objects --all |
		cut -f1 -d' ' | git cat-file --batch-check | grep blob |
		sort -n -k3 | tail -n$1 | while read hash type size;
		do
			echo -n "-e s/$hash/$size/p ";
		done) |
	sort -n -k1

It takes the number of objects to be shown as an argument, so for the
top ten run as "git find-large 10" (assuming that the script is in $PAT=
H
and called git-find-large).

It doesn't list as much information as yours does, e.g. the compressed
size is missing, but it's good enough for me, and speed was far more
important for me, especially since the "rev-list --all --objects" trick
gets you only a single filename for the blob, so if there were renames,
you may need to run it again after having deleted one version via
filter-branch.

Something similar applies to deltified stuff. As verify-pack shows the
size of the delta, your script might miss some file B if that is a
currently stored as a delta against some other large file A. Only after
the blob for A got deleted, B will be shown (as it is no longer
deltified).

OTOH, this means that the output of my script is likely to have the sam=
e
filename over and over again. If that gets out of hand, I usually do
something like:
git find-large 100 | cut -d' ' -f2 | sort -u

So I get just the filenames, hoping that the top 100 include all
interesting things ;-)

Maybe this helps someone to come up with a smart combination of our
scripts.

Bj=F6rn
