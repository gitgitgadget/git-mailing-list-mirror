From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: input validation in receive-pack
Date: Wed, 2 Jan 2008 08:51:52 +0100
Message-ID: <20080102075152.GA24401@auto.tuwien.ac.at>
References: <20080101213451.GA26772@auto.tuwien.ac.at> <7vzlvp3oya.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 08:52:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9yOo-00089C-3z
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 08:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbYABHvz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2008 02:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbYABHvy
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 02:51:54 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:51168 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbYABHvy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 02:51:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id E1110680BF61;
	Wed,  2 Jan 2008 08:51:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pgBkWCfo9ZhZ; Wed,  2 Jan 2008 08:51:52 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id C06F4680BEA4; Wed,  2 Jan 2008 08:51:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vzlvp3oya.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69461>

On Tue, Jan 01, 2008 at 07:07:25PM -0800, Junio C Hamano wrote:
> mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:
> > Some lines above:
> > |        if (!prefixcmp(name, "refs/") && check_ref_format(name + 5=
)) {
> > |                error("refusing to create funny ref '%s' remotely"=
, name);
> > |                return "funny refname";
> > |        }
> >
> > Is this code really correct?
>=20
> Interesting.  Things have been this way forever, I think.  I do
> not offhand see any reason not to refuse refs outside refs/, so
> you can try=20
>=20
> 	if (prefixcmp(name, "refs/") || check_ref_format(name +	5))
>=20
> and see what happens.=20

I tried this and it passed the test suite.

>  Some people may however want to push to
> HEAD (that is ".git/HEAD" which is outside ".git/refs"), though.

If pushing to HEAD is allowed, it bypasses the fast-forward check.

As minimum,
if (check_ref_format(name))
should be safer, as it rejects totally invalid refnames (especially ../=
[...]).

Are there more refs outside "refs/", which somebody would want to push =
to?
If not, the following patch could work:

if (!strcmp(name, "HEAD") &&=20
   (prefixcmp(name, "refs/") || check_ref_format(name+5))) {
  [..error..]
}

if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
    !is_null_sha1(old_sha1) &&
    (!prefixcmp(name, "refs/heads/")||!strcmp(name, "HEAD")) {
[...]
}

mfg Martin K=F6gler
