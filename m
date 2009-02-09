From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: "repack" when a needed commit object missing "kills" the repo
Date: Mon, 9 Feb 2009 03:26:42 +0100
Message-ID: <20090209022642.GA19413@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 09 03:28:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWLsu-0000u0-ED
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 03:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbZBIC1G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2009 21:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753099AbZBIC1E
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 21:27:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:57308 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753692AbZBIC1B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 21:27:01 -0500
Received: (qmail invoked by alias); 09 Feb 2009 02:26:59 -0000
Received: from i577BBA15.versanet.de (EHLO atjola.local) [87.123.186.21]
  by mail.gmx.net (mp006) with SMTP; 09 Feb 2009 03:26:59 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+zTvdULpGzFjWct6k9XkRLx9usSY55FMxAI17CPs
	6u4A/Za+LtWlAF
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109039>

Hi,

I have a git-svn repo with a large grafts file to recreate merges done
in svn and in one case to simply change a commit's parent. I don't
recall the reason for the latter, it's been there for almost a year now=
,
probably some crap from the svn repo that I didn't want to have in my
git history. So the original history was like:

A---B---C

And the graft turns that into:

A---C

Earlier repacks seem to have already pruned the B commit object, so
removing the grafts correctly causes git to complain about that missing
object.

Now I decided to finally run filter-branch on that repo to get rid of
the huge grafts file. So I ran "git filter-branch -- --all", removed th=
e
grafts file, dropped all the refs/original/ stuff and went on to "git
repack -adf". And when that finished, a _lot_ of objects were suddenly
missing, including some of the rewritten commits --> repo busted.
=46ortunately I had made a backup. :-)

The pack-objects process complained about the B commit object that was
already missing earlier, and after some time I realised that I didn't
expire the reflogs, so the "broken" commit was still reachable through
them. So I retried with the reflogs empty, and yup, that worked well. S=
o
missing objects seem to confuse pack-objects enough to stop it from
packing all of objects reachable through non-broken chains.

A backtrace from the point at which pack-objects complains about the
missing object shows this:

#0  error (err=3D0x4bff35 "Could not read %s") at usage.c:64
#1  0x0000000000459e3c in parse_commit (item=3D0x15f8c50) at commit.c:3=
04
#2  0x000000000048d2ea in add_parents_to_list (revs=3D0x7fff5f8bd7c0,=20
    commit=3D0x15f8a10, list=3D0x7fff5f8bd7c0, cache_ptr=3D0x0) at revi=
sion.c:514
#3  0x000000000048d75d in get_revision_1 (revs=3D0x7fff5f8bd7c0)
    at revision.c:1740
#4  0x000000000048d7cb in get_revision_internal (revs=3D0x7fff5f8bd7c0)
    at revision.c:1843
#5  0x000000000048da31 in get_revision (revs=3D0x7fff5f8bd7c0) at revis=
ion.c:1924
#6  0x0000000000471f0c in traverse_commit_list (revs=3D0x7fff5f8bd7c0,=20
    show_commit=3D0x437ec0 <show_commit>, show_object=3D0x437e80 <show_=
object>)
    at list-objects.c:147
#7  0x0000000000437fc8 in get_object_list (ac=3D<value optimized out>,=20
    av=3D<value optimized out>) at builtin-pack-objects.c:2059
#8  0x000000000043aa4e in cmd_pack_objects (argc=3D6, argv=3D0x7fff5f8b=
de38,=20
    prefix=3D<value optimized out>) at builtin-pack-objects.c:2288
#9  0x0000000000404983 in handle_internal_command (argc=3D6, argv=3D0x7=
fff5f8bde38)
    at git.c:244
#10 0x0000000000404eb6 in main (argc=3D6, argv=3D0x7fff5f8bde38) at git=
=2Ec:473

Maybe get_revision_internal() switching into boundary mode is bad there=
?
The failing parse_commit() call causes get_revision_1() to return NULL,
so get_revision_internal() assumes it ran out of commits, but in this
case, it "just" hit a bad commit.

Up to now, I don't have a small reproduction case yet and unfortunately
I can't make the repo with which I've seen the failure available.

Thanks,
Bj=F6rn
