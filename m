From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] Keep last used delta base in the delta window
Date: Mon, 27 Aug 2007 22:43:20 +0200
Message-ID: <20070827204320.GA17126@auto.tuwien.ac.at>
References: <11881617934179-git-send-email-mkoegler@auto.tuwien.ac.at> <7v3ay5l5wq.fsf@gitster.siamese.dyndns.org> <86veb1thmp.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 23:11:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPlQv-0002Jv-NK
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 22:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbXH0Un0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 27 Aug 2007 16:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757389AbXH0Un0
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 16:43:26 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:36511 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758113AbXH0UnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 16:43:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 45A2478ECE19;
	Mon, 27 Aug 2007 22:43:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AoACU2vlrL8f; Mon, 27 Aug 2007 22:43:20 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id BDDB678ECE0E; Mon, 27 Aug 2007 22:43:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <86veb1thmp.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56882>

On Mon, Aug 27, 2007 at 12:07:58PM +0200, David Kastrup wrote:
> Well, given the little amount of spare time I have for personal
> projects, I should not go flaunting them too much, but anyway...
>=20
> I am just drafting implementing a delta-diff size estimator: for ever=
y
> hash value it does not store hash chains or pointers to memory images=
,
> but just a bit map of at most 32 (possibly 64 where ulong delivers it=
,
> possibly even just 16 bits when one restricts oneself to 16 element
> windows in order to save memory) delta window files, telling which of
> the files show such a hash value anywhere.=20

How do you want to select these few hash values?=20

I eg. dump database tables as SQL statements in per table files and
commit all changes. All lines in each file share a common prefix
(INSERT INTO tablename (COL1, COL2, ...) VALUES). Statistics showed, th=
at up
to 50% of the hash elements of the delta index were dropped, because
they had eqal has values.

With you apropach:

If rare used values are selected as the 32 hash values, you will
probably regard files, which contain different tables (and therefore a
different prefix), as "similar", although the files have not very much
similarity otherwise.

If you select the hash values of the prefixes, you will create for each
table one cluster (if the table count is < 32/64). This already happens
by using the hash value of the path name in the sorting.

I don't belive, that your idea will improve very much in this case.
I fear, that it will be even worser than the current algorithm.

> When a file is considered
> for deltaing, it is run once against this delta-diff estimator which
> does not even look at the files again.  This delivers a lower bound
> for the size a delta towards each of the delta candidates can take.
> The candidates are then sorted in increasing size of expected delta
> size and are considered in turn.  Once a delta has a lower size than
> the lowest bound for further delta candidates, no further candidates
> need to get considered.

So this means, that we have to hash the target entry too (which could
be merged with creating the delta index). We currently only hash an
entry, if it is really needed as source in a delta-diff.

On bigger blobs, this could slow the process down.

> Also the calculation of a delta can get aborted once it exceeds the
> size of a previous delta.=20

This already happens.

> Somewhat more complex and error-prone would
> be to abort based on continually correcting the estimated lower bound
> from the estimator while one is creating a delta and dropping out as
> soon as it becomes impossible to beat a previous delta.
>=20
> The nice thing about this is that one can start out with a simplistic
> estimator as long as it is guaranteed never to deliver an estimate
> that is too high.  As long as that is the case, the packs will never
> get worse than they are now: a bad estimator will just mean that more
> elements of the window need to be considered before the conclusion is
> reached.
>=20
> Since the estimator data structure does not point into any
> memory-mapped files or hash chains scattered through memory, it shoul=
d
> be comparatively light (in comparison to an actual delta) on page
> thrashing which appears to me one of the main performance problems,
> while delivering a reasonably useful lower bound for all deltas in th=
e
> window at once.

Do you want to do your estimations only against a small window of objec=
ts
or all objects?

mfg Martin K=F6gler
