From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH/RFC 2/2] git-p4: Add complex test case for branch import
Date: Tue, 23 Aug 2011 19:10:34 -0400
Message-ID: <20110823231034.GA11918@arf.padd.com>
References: <1313712590-26876-1-git-send-email-vitor.hda@gmail.com>
 <1313712590-26876-3-git-send-email-vitor.hda@gmail.com>
 <20110820191203.GC7135@arf.padd.com>
 <20110822011319.0a013117@fenix.utopia.dhis.org>
 <20110823022713.GA6005@arf.padd.com>
 <CAOpHH-V92CcWm1tCwvb=pJux5PKbYQoG=E8M_Pc2JGu00wnR8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 01:10:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qw07J-0006Uh-At
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 01:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301Ab1HWXKl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Aug 2011 19:10:41 -0400
Received: from honk.padd.com ([74.3.171.149]:48915 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754432Ab1HWXKk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 19:10:40 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 491D85B51;
	Tue, 23 Aug 2011 16:10:39 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3E29E31448; Tue, 23 Aug 2011 19:10:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAOpHH-V92CcWm1tCwvb=pJux5PKbYQoG=E8M_Pc2JGu00wnR8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179979>

vitor.hda@gmail.com wrote on Tue, 23 Aug 2011 23:02 +0100:
> On Tue, Aug 23, 2011 at 3:27 AM, Pete Wyckoff <pw@padd.com> wrote:
> > I think I understand the problem now, and have a small test case
> > to see what's going wrong. =A0Your solution is definitely
> > sub-optimal. =A0:) =A0Is there anything that can be done with
> > --import-marks and --export-marks?
>=20
> Don't know if you agree, but I think it would be better to keep git-p=
4
> from storing extra files in the filesystem. And, as far as I understo=
od,
> these two options require extra files.
> But I don't think marks would help us that much. We already have
> something similar: the changelist number in the commit log. The big
> problem is that P4 does not store a pointer to the previous changelis=
t.

Agreed.

> > Could you guess at the branch point using p4? =A0I.e. for each file
> > in the new branch, grab the change that caused its most recent
> > revision (the #xx part). =A0Pick the max of those changes. =A0In gi=
t,
> > find the commit whith "change =3D ..." that you just discovered.
> > That's the parent.
>=20
> Yes, I think this would work. Nevertheless, I would prefer not to do =
so
> much pooling on the P4 server because when we're in a remote location=
 in
> regards to the P4 proxy server this kind of command becomes rather sl=
ow.
> And if the branch has many files this may become cumbersome.
>=20
> > Even this won't be perfect, and I'm not even sure if it's less
> > icky than diff-tree.
>=20
> From what I can see, the two possible solutions would be:
>=20
> a) Running a "filelog" on all files. This may become slower when the
>    branch has lots of files. There's also the problem in needing to
>    contact the P4 proxy server every time.
>=20
> b) Using diff-tree. This will be slower if the original changelist is
>    very far from the latest one, but has the advantage of being run
>    locally. It has the disadvantage of not having an apparent
>    compatibility with fast-import.
>=20
> In my personal point of view, diff-tree solution still looks better, =
if
> it weren't for the fast-import issue. Now if we could just figure out
> how to overcome this issue...

Nice analysis.  P4 can indeed be the bottleneck, even on near
servers if there are lots of files.  Diff-tree seems like the
better choice to find the branch point.  I don't understand fully
why the way we are using fast-import causes these problems.  Will
look at that next.

		-- Pete
