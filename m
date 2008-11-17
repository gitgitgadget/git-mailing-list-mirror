From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: purging unwanted history
Date: Mon, 17 Nov 2008 03:24:12 +0100
Message-ID: <20081117022412.GB3911@atjola.homenet>
References: <93c3eada0811161626h69929cd7va3fa4007a2341bae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 03:25:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1tnu-0002L3-Rd
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 03:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802AbYKQCYQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Nov 2008 21:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754776AbYKQCYQ
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 21:24:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:54014 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754749AbYKQCYP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 21:24:15 -0500
Received: (qmail invoked by alias); 17 Nov 2008 02:24:13 -0000
Received: from i577BB07E.versanet.de (EHLO atjola.local) [87.123.176.126]
  by mail.gmx.net (mp038) with SMTP; 17 Nov 2008 03:24:13 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19WrdJa0N1WXXAy6G2+PskaKBoR84vh3T7mOP/n1g
	ODzH/7efSMYG0r
Content-Disposition: inline
In-Reply-To: <93c3eada0811161626h69929cd7va3fa4007a2341bae@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101192>

On 2008.11.17 10:56:23 +1030, Geoff Russell wrote:
> I have a repository with 5 years worth of history, I only want to kee=
p
> 1 year, so I want to purge the first 4 years. As it happens, the
> repository only has a single branch which should simplify the problem=
=2E

Use filter-branch to drop the parents on the first commit you want to
keep, and then drop the old cruft.

Let's say $drop is the hash of the latest commit you want to drop. To
keep things sane and simple, make sure the first commit you want to
keep, ie. the child of $drop, is not a merge commit. Then you can use:

git filter-branch --parent-filter "sed -e 's/-p $drop//'" \
	--tag-name-filter cat -- \
	--all ^$drop

The above rewrites the parents of all commits that come "after" $drop.

Check the results with gitk.


Then, to clean out all the old cruft.

=46irst, the backup references from filter-branch:

git for-each-ref --format=3D'%(refname)' refs/original | \
	while read ref
	do
		git update-ref -d "$ref"
	done

Then clean your reflogs:
git reflog expire --expire=3D0 --all

And finally, repack and drop all the old unreachable objects:
git repack -ad
git prune # For objects that repack -ad might have left around

At that point, everything leading up to and including $drop should be
gone.

HTH
Bj=F6rn
