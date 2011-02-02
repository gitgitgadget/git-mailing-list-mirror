From: Johan Herland <johan@herland.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Wed, 2 Feb 2011 16:51:21 +0100
Message-ID: <201102021651.21669.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com> <201102020322.00171.johan@herland.net> <AANLkTimqQtLB--7pwwTALmcchnNCX0nm4Rfx8w1gp74T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>, johan@herland.net
To: Santi =?iso-8859-1?q?B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Feb 02 16:51:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pkezd-0006xP-RS
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 16:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754464Ab1BBPvf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Feb 2011 10:51:35 -0500
Received: from smtp.opera.com ([213.236.208.81]:49627 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754397Ab1BBPve (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 10:51:34 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p12FpL4o031521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 2 Feb 2011 15:51:22 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <AANLkTimqQtLB--7pwwTALmcchnNCX0nm4Rfx8w1gp74T@mail.gmail.com>
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.64 on 213.236.208.81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165916>

On Wednesday 02 February 2011, Santi B=E9jar wrote:
> On Wednesday 02 February 2011, Johan Herland wrote:
> > Proposal:
> >
> > Currently, git stores remote refs in the local repo by default as
> > follows:
> >
> > =A0Remote repo =A0 =A0-> =A0 Local repo
> > =A0---------------------------------------------------------
> > =A0HEAD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0refs/remotes/$remote/HEAD =A0=
(implicit)
> > =A0refs/heads/* =A0 =A0 =A0 =A0refs/remotes/$remote/*
> > =A0refs/tags/* =A0 =A0 =A0 =A0 refs/tags/* =A0 =A0     (implicit, a=
utofollow)
> > =A0refs/replace/* =A0 =A0 =A0(TBD)=20
> > =A0refs/notes/* =A0 =A0 =A0 =A0(TBD)
> >
> > Instead, we should change the default ref mappings into the
> > following:
> >
> > =A0Remote repo =A0 =A0-> =A0 Local repo
> > =A0--------------------------------------------------
> > =A0HEAD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0refs/remotes/$remote/HEAD
> > =A0refs/heads/* =A0 =A0 =A0 =A0refs/remotes/$remote/heads/*
> > =A0refs/tags/* =A0 =A0 =A0 =A0 refs/remotes/$remote/tags/*
> > =A0refs/replace/* =A0 =A0 =A0refs/remotes/$remote/replace/*
> > =A0refs/notes/* =A0 =A0 =A0 =A0refs/remotes/$remote/notes/*
>
> [...]
>
> > - We might want to generalize the handling of "$remote/$head" into
> > allowing shorthands like "$remote/$tag", "$remote/$replace" and
> > "$remote/$note" as well (provided, of course, that they match
> > unambiguously).
>
> [...]
>
> > [2]: When looking up a shorthand tag name (e.g. v1.7.4): If a local
> > tag (refs/tags/v1.7.4) is found, then we have an unambiguous match.
> > If no local tag is found, we look up the tag name in all configured
> > remotes (using the method described in [1]). If the tag name exists
> > in one or more remotes, and those remotes all agree on its ultimate
> > object name (after applying e.g. ^{commit} or whatever is
> > appropriate in the context of the lookup), then we also have an
> > unambiguous match. However, if the tag name exists in multiple
> > remotes, and they do NOT all agree on its ultimate object name,
> > then the shorthand tag name is ambiguous and the lookup fails. The
> > user can always resolve this ambiguity by creating a local tag
> > (refs/tags/v1.7.4) pointing to the desired object.
>
> And the other way around. What would be the output of "git name-rev"
> , "git describe", "--decorate", and such? $remote/tags/$tag?
> $remote/$tag? $tag?
>
> I would say $remote/$tag for "git name-rev" and "--decorate" but $tag
> for "git describe" as it is usually used to create files, i.e.
> git-1.7.4.261.g705f.tar.gz. And I think many people, me included, do
> not expect to have an / in the "git describe" output, at least in the
> default output (in contrast with the --all flag).

Thanks for raising an important point.

I don't buy the file name creation argument, as 'describe' is used from=
=20
many different contexts, and file name creation is nowhere documented=20
as one of its primary objectives.

Still, the objective of 'describe' is to create a human-readable string=
=20
that tries to say something meaningful about a commit in relation to=20
its preceding history, while at the same time uniquely identifying the=20
commit. The "uniquely identifying" part is taken care of by=20
the "-g<SHA1>" part of the output, while the initial "<tagname>-<n>"=20
part makes it human-friendly. Therefore, we only care that the=20
<tagname> is fairly unambiguous in the mind of the reader. From this=20
perspective, which of the alternatives makes more sense? I would=20
disqualify "$remote/$tag" and "$remote/tags/$tag", since the $remote=20
name is repo-specific, and 'describe' output is often passed around=20
between multiple developers/repos. Hence, I think that "$tag" is a good=
=20
choice for 'describe'. If "$tag" is ambiguous in the current repo, then=
=20
an "ambiguous tag" tag warning can be printed, but I would still=20
use "$tag".

When it comes to 'name-rev' and '--decorate', those are (AFAICS) much=20
more repo-specific, and seldom passed between users. Also, they don't=20
have the "-g<SHA1>" part from the 'describe' output. Hence, in this=20
case, I consider unique identification (unambiguity) much more=20
important than not displaying $remote names. Therefore, I'd propose=20
using the shortest unambiguous alternative.

> Another point to consider is if we want a default remote for tags, a
> config tags.defaultRemote (TBD), defaulting to origin, specifying the
> default remote for tags. There would be a hierarchy: local tags,
> default remote tags, remote tags. With this if one tag is on multiple
> remote the tag from the default remote always wins.
>
> In this way all the tag related input/output would no change much.
> For example all the decoration would be $tag instead of origin/tag.

Agreed, tags.defaultRemote (or tags.preferredRemote if I'm allowed to=20
bikeshed) may be a valuable addition. Another way to achieve this would=
=20
be to explicitly copy tags from the preferred remote (e.g. origin)=20
directly into refs/tags. I.e. in addition to the (new) default tag=20
refspec

	+refs/tags/*:refs/remotes/origin/tags/*

you could add an _additional_ refspec

	refs/tags/*:refs/tags/*

that would also copy all of origin's tags directly into your local tag=20
namespace.


Thanks for the feedback! :)

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
