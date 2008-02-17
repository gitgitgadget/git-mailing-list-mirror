From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] parse_tag: fail, if tagged objected would be NULL
Date: Sun, 17 Feb 2008 18:48:26 +0100
Message-ID: <20080217174826.GB22515@auto.tuwien.ac.at>
References: <12031670802582-git-send-email-mkoegler@auto.tuwien.ac.at> <7vpruw90jv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 18:49:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQndg-0008OJ-O3
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 18:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbYBQRsc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Feb 2008 12:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbYBQRsc
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 12:48:32 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:41700 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbYBQRs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 12:48:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 4D09268018CD;
	Sun, 17 Feb 2008 18:48:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0hEnicrqwjyr; Sun, 17 Feb 2008 18:48:26 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 296646800676; Sun, 17 Feb 2008 18:48:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vpruw90jv.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74144>

On Sat, Feb 16, 2008 at 11:13:56AM -0800, Junio C Hamano wrote:
> Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:
>=20
> > The cause of a NULL in tag->tagged can be:
> > * a unknown object type is used
> > * the tag points to a object with an other type as stated
> >   in the tag.
> >
> > Both situations are most likley be caused by a not welformed
> > tag. Catching this error here avoids doing tag->tagged!=3DNULL
> > checks in the rest of git.
>=20
> Honestly, I am torn on this.
>=20
> The approach certainly is attractive if you care only about
> working in a perfectly well connected repository of a known
> vintage.
>=20
> On the other hand, however, this robs from callers the clue that
> the tag itself was Ok but it points at something we do not know
> about.  Maybe the caller was only interested in the tag itself
> but did not care about the pointee, and erroring out like this
> may make it impossible for the caller to act on the tag itself.
> Maybe the caller even knew about the breakage of the repository
> and wanted to salvage as much as possible, but because this
> errors out, it would now consider this tag object itself is bad
> and give up, salvaging one less object.=20

This opens up the question, why do we set tagged to NULL in the case
of an unknown object? If we want to get out as much information as
possible, we could call lookup_unknown_object and store the result.

> It looks to me that
> this, along with other "tighten parse_X_buffer()" changes you
> sent earlier, closes door to them.  That's why I think that
> parse_X_buffer() should be more lenient than fsck and keep
> saying it.

OK, so please forget the parse_tag_buffer patch.=20

If I understand you correctly, you want to reject my last
parse_commit_buffer patch (parse_commit: don't ignore NULL from
loopup_commit, http://www.spinics.net/lists/git/msg58148.html) because
of the same reasons.

This means, that Shawns idea (using rev-list for reachability checking
during upload, http://www.spinics.net/lists/git/msg57978.html) is not
implementable, as certain kinds of errors are not reported to the
caller by parse_commit(_buffer).

mfg Martin K=F6gler
