From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH 1/2] parse_commit_buffer: don't parse invalid commits
Date: Mon, 14 Jan 2008 21:58:26 +0100
Message-ID: <20080114205826.GB5058@auto.tuwien.ac.at>
References: <12002478702664-git-send-email-mkoegler@auto.tuwien.ac.at> <7vk5mclvk3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 21:59:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEWOX-00010W-D5
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 21:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbYANU63 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jan 2008 15:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbYANU63
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 15:58:29 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:54090 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbYANU62 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 15:58:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 427CF680BF6C;
	Mon, 14 Jan 2008 21:58:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07Un7sEXmIVG; Mon, 14 Jan 2008 21:58:26 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 1D1BE680B581; Mon, 14 Jan 2008 21:58:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vk5mclvk3.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70475>

On Sun, Jan 13, 2008 at 11:23:40PM -0800, Junio C Hamano wrote:
> Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:
>=20
> > +	if (!parse_commit_date(bufptr, tail, &item->date))
> > +		return error("bogus commit date in object %s", sha1_to_hex(item-=
>object.sha1));
> > =20
> >  	if (track_object_refs) {
> >  		unsigned i =3D 0;
>
> I suspect this might be an undesirable regression.

You seem to have missed my reply to your last mail:
http://marc.info/?l=3Dgit&m=3D119969163624138&w=3D2

I asked you, what you would think about this change, but got no
answer. Anyway, now I know your opinion ;-)

> If somebody managed to create a commit with a bogus "author"
> line and wanted to clean up the history, your previous one at
> least gave something usable back, even though it had to come up
> with a bogus date.  It gave the rest of the data back without
> barfing.  And it was easy to see which "resurrected" commit had
> a missing author date (bogus ones always gave 0 timestamp).
>
> This round you made it to error out, and callers that check the
> return value of parse_commit() would stop traversing the
> history, even if the commit in question has perfectly valid
> "parent " lines, thinking "ah, this commit object is faulty".
> It actively interferes with attempts to resurrect data from
> history that contains a faulty commit.

On the other hand, it is possible, that somebody pushed such a commit
out, if he does not notice it. Then its difficult to get rid of the
broken commit. [Hasn't happend a broken commit on pu recently?]

parse_commit_date is not very strict, so its likely, that it miss such
a commit. Commit parsing is too common function to slow it down with
further checks.

> Your previous version was much better with respect to this
> issue.  It was about being more careful not to read outside the
> commit object buffer, while still allowing the data from a
> history that has an unfortunate commit with broken author line
> to be resurrected more easily.

I'll repost a version, which reverts this change.

> I do not think the checks done by fsck and parse_commit should
> share the same strictness.  They serve different purposes.

Maybe I can improve fsck.

mfg Martin K=F6gler
