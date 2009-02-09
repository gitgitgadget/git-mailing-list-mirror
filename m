From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: repack might cause having when commit objects are missing
Date: Mon, 9 Feb 2009 10:13:03 +0100
Message-ID: <20090209091303.GA1320@atjola.homenet>
References: <20090209022642.GA19413@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 09 10:14:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWSE8-0005Nz-On
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 10:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbZBIJN0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Feb 2009 04:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752199AbZBIJNY
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 04:13:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:49417 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751801AbZBIJNX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 04:13:23 -0500
Received: (qmail invoked by alias); 09 Feb 2009 09:13:21 -0000
Received: from i577B8B51.versanet.de (EHLO atjola.local) [87.123.139.81]
  by mail.gmx.net (mp004) with SMTP; 09 Feb 2009 10:13:21 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18uBgInBHAu3kbQMPamhbHmrPzYkLoQKis/BztROP
	JlwNygK5BCh5Oo
Content-Disposition: inline
In-Reply-To: <20090209022642.GA19413@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109058>

[topic fixed to resemble something sane...]

On 2009.02.09 03:26:42 +0100, Bj=F6rn Steinbrink wrote:
> Up to now, I don't have a small reproduction case yet and unfortunate=
ly
> I can't make the repo with which I've seen the failure available.

Not a self-contained reproduction test, but at least it shows the
problem with a public repo. Assuming you have no refs referencing
a0325eb^

In a clone of git.git add to .git/info/grafts:
a0325eb2e982e25376e4cb89ebcac5d8d703548d 604dd0a0782b3e33bcc397c27e811e=
bc019c9f5a

Then:
git reflog expire --expire=3D0 --all
git repack -ad
rm .git/info/grafts
git repack -ad

The second repack wrecks the repo:

doener@atjola:git2 (master) $ cp /home/doener/grafts .git/info/
doener@atjola:git2 (master) $ git reflog expire --expire=3D0 --all
doener@atjola:git2 (master) $ git repack -ad
Counting objects: 92161, done.
Delta compression using 4 threads.
Compressing objects: 100% (23481/23481), done.
Writing objects: 100% (92161/92161), done.
Total 92161 (delta 67185), reused 92061 (delta 67092)
doener@atjola:git2 (master) $ rm .git/info/grafts
doener@atjola:git2 (master) $ git repack -ad
error: Could not read c0e2e12fa0babcc4ab28b95bc5ad4f86e139d6b4
Counting objects: 3195, done.
Delta compression using 4 threads.
Compressing objects: 100% (2245/2245), done.
Writing objects: 100% (3195/3195), done.
Total 3195 (delta 1263), reused 2418 (delta 886)
error: refs/heads/rebase does not point to a valid object!
[dozens of more broken refs]

Note how in the second repack, the walking machniery finds only 3195
objects, as opposed to more than 92k before.

I've also tried with threaded delta search disabled (pack.threads=3D1),
no difference.

Bj=F6rn
