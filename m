From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 7 Dec 2010 10:14:19 -0800
Message-ID: <AANLkTimnp3xCHp_3E7ry-5OQL3PFnYh=H8PhfzMN307C@mail.gmail.com>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org> <AANLkTikbsyFUzZeu8R6yAND6spV6OnvYL08gYZ+ZgJCh@mail.gmail.com>
 <7vmxoiqeoq.fsf@alter.siamese.dyndns.org> <20101207170623.GB21749@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 07 19:14:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ23q-0000Sx-5U
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 19:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052Ab0LGSOl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 13:14:41 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39610 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab0LGSOk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 13:14:40 -0500
Received: by iwn9 with SMTP id 9so168600iwn.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 10:14:40 -0800 (PST)
Received: by 10.231.200.134 with SMTP id ew6mr5174948ibb.13.1291745680207;
 Tue, 07 Dec 2010 10:14:40 -0800 (PST)
Received: by 10.231.154.5 with HTTP; Tue, 7 Dec 2010 10:14:19 -0800 (PST)
In-Reply-To: <20101207170623.GB21749@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163100>

On Tue, Dec 7, 2010 at 9:06 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Dec 06, 2010 at 10:28:53PM -0800, Junio C Hamano wrote:
>
>> > Should this special log be mentioned in git-update-ref.txt or
>> > gitrepository-layout.txt?
>>
>> Perhaps, but I wasn't sure if this patch itself is a good idea to be=
gin
>> with. =A0Not the problem it tries to solve, but its approach.
>>
>> For example, this cannot be shown with "reflog show" or "log -g" due=
 to
>> the way these frontends locate the reflog file to read (the logic wa=
nts to
>> have an underlying ref).
>
> Yeah, I think this is not _quite_ what people want in this area. A ba=
se
> requirement from past discussions, I think, is that the whole reflog =
of
> the deleted branch be saved rather than just the tip. And then "reflo=
g
> show" would make a lot more sense on such saved reflogs.

Yup, that's what I recall too, folks (including myself) want to
save the reflog of the deleted branch, so it can be recovered if
the branch itself were to be recovered with an --undelete option.

> I'm not sure in practice how important that distinction is, as we are
> not saving deleted branch reflogs _at all_ right now, so the
> requirements are mostly speculation at this point.
>
> The most recent discussion I recall is this one:
>
> =A0http://thread.gmane.org/gmane.comp.version-control.git/144250/focu=
s=3D145353
>
> where the general idea was to just keep deleted reflogs around, appen=
d
> to them if the branch was recreated, and use a consistent renaming
> scheme to avoid D/F naming conflicts (e.g., "foo" is a deleted ref, a=
nd
> you create "foo/bar").

Per check-ref-format, ref names cannot contain two dots.  We could
archive ref logs by renaming them, $GIT_DIR/logs/refs/heads/foo
becomes $GIT_DIR/logs/refs/heads/foo..deleted-1.  If foo is created
and deleted again, it becomes foo..deleted-2.

This still causes problems for git reflog show / git log -g because
they want a current ref to enumerate the log of.


A different approach might be to have $GIT_DIR/logs/refs/REF_ATTIC,
and special case that in git reflog show / git log -g.  When a
ref is deleted, append its entire log onto REF_ATTIC, between two
specially formatted marker lines.  When recovering a branch, copy
out the region from the REF_ATTIC log.

--=20
Shawn.
