From: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
Subject: Re: [RFC] Faster git grep.
Date: Thu, 25 Jul 2013 23:31:00 +0200
Message-ID: <20130725213100.GA28551@domone.kolej.mff.cuni.cz>
References: <20130725182905.GA7664@domone.kolej.mff.cuni.cz>
 <7vli4u4bkm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 25 23:31:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2T89-00065s-JW
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 23:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909Ab3GYVbI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jul 2013 17:31:08 -0400
Received: from popelka.ms.mff.cuni.cz ([195.113.20.131]:34214 "EHLO
	popelka.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810Ab3GYVbG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 17:31:06 -0400
Received: from domone.kolej.mff.cuni.cz (popelka.ms.mff.cuni.cz [195.113.20.131])
	by popelka.ms.mff.cuni.cz (Postfix) with ESMTPS id 6CF6B61D58;
	Thu, 25 Jul 2013 23:31:01 +0200 (CEST)
Received: by domone.kolej.mff.cuni.cz (Postfix, from userid 1000)
	id A0F4F5FB95; Thu, 25 Jul 2013 23:31:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vli4u4bkm.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.97.6 at popelka.ms.mff.cuni.cz
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	UNPARSEABLE_RELAY autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	popelka.ms.mff.cuni.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231153>

On Thu, Jul 25, 2013 at 01:41:13PM -0700, Junio C Hamano wrote:
> Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz> writes:
>=20
> > One solution would be to use same trick as was done in google code.=
=20
> > Build and keep database of trigraphs and which files contain how ma=
ny of
> > them. When querry is made then check
> > only these files that have appropriate combination of trigraphs.
>=20
> This depends on how you go about trying to reducing the database
> overhead, I think.  For example, a very naive approach would be to
> create such trigraph hit index for each and every commit for all
> paths.  When "git grep $commit $pattern" is run, you would consult
> such table with $commit and potential trigraphs derived from the
> $pattern to grab the potential paths your hits _might_ be in.
>
Do you think that git grep $commit $pattern is run in more than 1%=20
of cases than git grep $pattern ?

If grepping random commit in history is important use case then keeping
db information in history makes sense. Otherwise just having database
for current version and updating it on the fly as version changes is
enough.
> But the contents of a path usually do not change in each and every
> commit.  So you may want to instead index with the blob object names
> (i.e. which trigraphs appear in what blobs).  But once you go that
> route, your "git grep $commit $pattern" needs to read and enumerate
> all the blobs that appear in $commit's tree, and see which blobs may
> potentially have hits.  Then you would need to build an index every
> time you make a new commit for blobs whose trigraphs have not been
> counted.
>=20
> Nice thing is that once a blob (or a commit for that matter) is
> created and its object name is known, its contents will not change,
> so you can index once and reuse it many times.  But I am not yet
> convinced if pre-indexing is an overall win, compared to the cost of
> maintaining such a database.
