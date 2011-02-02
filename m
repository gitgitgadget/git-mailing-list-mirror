From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Wed, 2 Feb 2011 14:27:30 +0100
Message-ID: <AANLkTimqQtLB--7pwwTALmcchnNCX0nm4Rfx8w1gp74T@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <20110201181428.GA6579@sigill.intra.peff.net> <AANLkTimtU56BAnWU-2pY1npdkPdKEBq_CMCGwXUK+E=H@mail.gmail.com>
 <201102020322.00171.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Feb 02 14:28:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkckX-0001L7-6p
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 14:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172Ab1BBN1w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Feb 2011 08:27:52 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:65525 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038Ab1BBN1w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Feb 2011 08:27:52 -0500
Received: by qwa26 with SMTP id 26so7909407qwa.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 05:27:51 -0800 (PST)
Received: by 10.229.246.209 with SMTP id lz17mr6395557qcb.271.1296653271328;
 Wed, 02 Feb 2011 05:27:51 -0800 (PST)
Received: by 10.229.215.129 with HTTP; Wed, 2 Feb 2011 05:27:30 -0800 (PST)
In-Reply-To: <201102020322.00171.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165911>

On Wed, Feb 2, 2011 at 3:21 AM, Johan Herland <johan@herland.net> wrote=
:
> On Wednesday 02 February 2011, Sverre Rabbelier wrote:
>> On Tue, Feb 1, 2011 at 19:14, Jeff King <peff@peff.net> wrote:
>> > i.e., make refs/remotes/* an actual mirror of selected parts of th=
e
>> > remote's refs/ hierarchy. And then figure out sane rules for mergi=
ng
>> > those namespaces into the ref lookup procedure.
>>
>> Jeff, Nguy, are either of you interested in writing up a new/modifyi=
ng
>> this proposal to be about namespacing everything?
>
> Here's my go at phrasing this in a proposal format. Feel free to revi=
se and
> resend:
>

+1
>
> Proposal:
>
> Currently, git stores remote refs in the local repo by default as fol=
lows:
>
> =A0Remote repo =A0 =A0-> =A0 Local repo
> =A0---------------------------------------------------------
> =A0HEAD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0refs/remotes/$remote/HEAD =A0(=
implicit)
> =A0refs/heads/* =A0 =A0 =A0 =A0refs/remotes/$remote/*
> =A0refs/tags/* =A0 =A0 =A0 =A0 refs/tags/* =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(implicit, autofollow)
> =A0refs/replace/* =A0 =A0 =A0(TBD)
> =A0refs/notes/* =A0 =A0 =A0 =A0(TBD)
>
> Several users report that they are confused by the difference in how =
heads
> and tags are mapped, and by the implicit mappings that are not mentio=
ned in
> the configured refspecs. Also, as users want to share ever more diffe=
rent
> types of refs (replace refs and notes refs have been discussed recent=
ly),
> the existing ref mappings (aka. refspecs) do not suggest a natural/in=
tuitive
> mapping for the new ref types.
>
> Instead, we should change the default ref mappings into the following=
:
>
> =A0Remote repo =A0 =A0-> =A0 Local repo
> =A0--------------------------------------------------
> =A0HEAD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0refs/remotes/$remote/HEAD
> =A0refs/heads/* =A0 =A0 =A0 =A0refs/remotes/$remote/heads/*
> =A0refs/tags/* =A0 =A0 =A0 =A0 refs/remotes/$remote/tags/*
> =A0refs/replace/* =A0 =A0 =A0refs/remotes/$remote/replace/*
> =A0refs/notes/* =A0 =A0 =A0 =A0refs/remotes/$remote/notes/*

[...]

> - We might want to generalize the handling of "$remote/$head" into al=
lowing
> shorthands like "$remote/$tag", "$remote/$replace" and "$remote/$note=
" as
> well (provided, of course, that they match unambiguously).

[...]

> [2]: When looking up a shorthand tag name (e.g. v1.7.4): If a local t=
ag
> (refs/tags/v1.7.4) is found, then we have an unambiguous match. If no=
 local
> tag is found, we look up the tag name in all configured remotes (usin=
g the
> method described in [1]). If the tag name exists in one or more remot=
es, and
> those remotes all agree on its ultimate object name (after applying e=
=2Eg.
> ^{commit} or whatever is appropriate in the context of the lookup), t=
hen we
> also have an unambiguous match. However, if the tag name exists in mu=
ltiple
> remotes, and they do NOT all agree on its ultimate object name, then =
the
> shorthand tag name is ambiguous and the lookup fails. The user can al=
ways
> resolve this ambiguity by creating a local tag (refs/tags/v1.7.4) poi=
nting
> to the desired object.

And the other way around. What would be the output of "git name-rev" ,
"git describe", "--decorate", and such? $remote/tags/$tag?
$remote/$tag? $tag?

I would say $remote/$tag for "git name-rev" and "--decorate" but $tag
for "git describe" as it is usually used to create files, i.e.
git-1.7.4.261.g705f.tar.gz. And I think many people, me included, do
not expect to have an / in the "git describe" output, at least in the
default output (in contrast with the --all flag).

Another point to consider is if we want a default remote for tags, a
config tags.defaultRemote (TBD), defaulting to origin, specifying the
default remote for tags. There would be a hierarchy: local tags,
default remote tags, remote tags. With this if one tag is on multiple
remote the tag from the default remote always wins.

In this way all the tag related input/output would no change much. For
example all the decoration would be $tag instead of origin/tag.

HTH,
Santi
