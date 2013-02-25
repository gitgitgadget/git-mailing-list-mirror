From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Possible regression in ref advertisement
Date: Mon, 25 Feb 2013 21:35:19 +0100
Message-ID: <1361824519.31692.12.camel@centaur.cmartin.tk>
References: <1361811516.3212.14.camel@centaur.cmartin.tk>
	 <7vvc9gxn2y.fsf@alter.siamese.dyndns.org>
	 <1361819916.24515.5.camel@centaur.cmartin.tk>
	 <7vip5gxkgy.fsf@alter.siamese.dyndns.org>
	 <1361822092.30765.12.camel@centaur.cmartin.tk>
	 <7v1uc4ximl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 21:35:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA4ll-0007FJ-L3
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 21:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757452Ab3BYUfE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2013 15:35:04 -0500
Received: from hessy.cmartin.tk ([78.47.67.53]:54694 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751535Ab3BYUfD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 15:35:03 -0500
Received: from [192.168.1.2] (p57A1F6E7.dip.t-dialin.net [87.161.246.231])
	by hessy.dwim.me (Postfix) with ESMTPSA id 4A0E380616;
	Mon, 25 Feb 2013 21:35:00 +0100 (CET)
In-Reply-To: <7v1uc4ximl.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217103>

On Mon, 2013-02-25 at 12:07 -0800, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> >> A shot in the dark, as I do not seem to be able to reproduce the i=
ssue
> >> with anything that contains the commit.  Perhaps your .git/packed-=
refs
> >> is corrupt?
> >
> > My packed-refs file did not end with LF. It seems it must or the pa=
rser
> > won't consider the last tag in the file to have a peeled target and=
 mine
> > didn't. I don't how the ended up this way but it looks like there's=
 is a
> > bug in the parser (or does the format force you to have LF at the e=
nd?)
>=20
> It is unclear what kind of corruption your packed-refs file had, as
> there are multiple ways for a file not to "end with LF", but anyway.

I mean that the file ended at the end of the peeled id. It was missing
the last empty line.

>=20
> As packed-refs file is expected to be a text file, it is not
> surprising to get an undefined result if the it ends with an
> incomplete line.

I guess that depends on what you mean by incomplete. All the data is
there, just that it had

    <tag id> SP <refname> LF ^<peeled id>

as the last entry instead of

    <tag id> SP <refname> LF ^<peeled id> LF

The parser skips the last entry if there is no trailing LF (the same
happens for lightweight tags, though here it simply doesn't report
them).

>=20
> I do not offhand recall if we tolerate lines with CRLF endings; as
> far as I know we do not _write_ CRLF out, and because we do not
> expect people to muck directly with editor bypassing "pack-refs", I
> would not be surprised if we didn't do anything special for people
> who make the lines end with with CRLF the file, either.

I wouldn't expect it to work. It would probably skip over those entries=
=2E

>=20
> I'd be more worried about the possibly lost entries after that
> incomplete line (and also possibly truncated end part of the tagname
> on the last, incomplete line).  Perhaps fsck should diagnose such an
> anomaly as repository corruption?  Perhaps we should enhance the
> file format a bit (right now, the first "capability" line should say
> something like "# pack-refs with: peeled" to say it was created with
> the version of pack-refs that can record peeled tags, but we can add
> other capabilities to extend the format) to add checksums to detect
> corruption?
>=20

I just tested and the parser ignores any malformed lines. The ones afte=
r
it are fine. Nothing complains though, ls-remote just shows the next
entry. I'd expect at least fsck to complain, but it doesn't say
anything. Presumably they all use the same parser that just ignores
anything it doesn't like.

   cmn
