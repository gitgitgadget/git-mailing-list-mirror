From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Avoid a useless prefix lookup in strbuf_expand()
Date: Wed, 02 Jan 2008 19:11:00 +0100
Message-ID: <477BD3B4.2070708@lsrfire.ath.cx>
References: <e5bfff550712300546o167c460bl4628d87f8a4e14db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 19:12:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA84T-0007Ym-2c
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 19:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbYABSLU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2008 13:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbYABSLU
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 13:11:20 -0500
Received: from india601.server4you.de ([85.25.151.105]:51532 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbYABSLT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 13:11:19 -0500
Received: from [10.0.1.201] (p57B7C4DA.dip.t-dialin.net [87.183.196.218])
	by india601.server4you.de (Postfix) with ESMTP id 7A3FB2F8037;
	Wed,  2 Jan 2008 19:11:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <e5bfff550712300546o167c460bl4628d87f8a4e14db@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69482>

Marco Costalba schrieb:
> Currently the --prett=3Dformat prefix is looked up in a
> tight loop in strbuf_expand(), if found is passed as parameter
> to format_commit_item() that does another search using a
> switch statement to select the proper operation according to
> the kind of prefix.
>=20
> Because the switch statement is already able to discard unknown
> matches we don't need the prefix lookup before to call format_commit_=
item()
>=20
> This patch removes an useless loop in a very fasth path,
> used by, as example, by 'git log' with --pretty=3Dformat option
>=20
> Signed-off-by: Marco Costalba <mcostalba@gmail.com>
> ---
>=20
> This patch is somewhat experimental and is not intended to be merged =
as is.
>=20
> That's what is missing:
>=20
> - Matching of multi char prefixes is not 100% reliable, as example to=
 match
>   prefix "Cgreen" only the first 'C' and the third char 'e' is
> checked, this could
>   lead to aliases in case of malformed prefixes, as example something=
 like
>   "Cxxexxxx" will match the same.

Well, you need to undo this optimization if you remove the loop that
makes sure that only valid placeholders are passed to the callback
function -- the result would be that you only move the prefixcmp() from
strbuf_expand() into the callbacks.

A better way to speed up strbuf_expand() may be to require the list of
placeholders to be sorted, their count to be passed on and then to
replace the sequential lookup with a binary search.  --pretty=3Dformat
currently recognizes 29 placeholders, which might be a high enough
number for a more complicated search method to pay off.

> marco@localhost linux-2.6]$ time git log --topo-order --no-color
> --parents -z --log-size --boundary
> --pretty=3Dformat:"%m%HX%PX%n%an<%ae>%n%at%n%s%n%b" HEAD > /dev/null

In your special case it would be even faster to simply reorder the list
with decreasing number of occurrence.  Of course it's hard to guess how
often a particular placeholder is used in the wild, but moving %n from
next to last to first place should be a safe bet.

Ren=C3=A9
