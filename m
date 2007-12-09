From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] Restore ls-remote reference pattern matching
Date: Sun, 9 Dec 2007 16:26:32 +0300
Message-ID: <20071209162632.a16bfd6e.vsu@altlinux.ru>
References: <Pine.LNX.4.64.0712082134350.5349@iabervon.org>
	<7vodd0tuuu.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712082346310.5349@iabervon.org>
	<7v8x44tl7q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__9_Dec_2007_16_26_33_+0300_BVGjzyXFRoR16ncU"
Cc: git@vger.kernel.org, Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 14:27:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1MBj-0003WY-Av
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 14:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbXLIN05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 08:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbXLIN05
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 08:26:57 -0500
Received: from master.altlinux.org ([62.118.250.235]:3475 "EHLO
	master.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbXLIN04 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 08:26:56 -0500
Received: by master.altlinux.org (Postfix, from userid 584)
	id 62536E3465; Sun,  9 Dec 2007 16:26:55 +0300 (MSK)
In-Reply-To: <7v8x44tl7q.fsf@gitster.siamese.dyndns.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.12.0; x86_64-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67624>

--Signature=_Sun__9_Dec_2007_16_26_33_+0300_BVGjzyXFRoR16ncU
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sat, 08 Dec 2007 22:51:05 -0800 Junio C Hamano wrote:

[...]
> 	for pat
> 	do
> 		case "/$path" in
> 		*/$pat )
> 			match=yes
> 			break ;;
> 		esac
> 	done
[...]
> +/*
> + * pattern is a list of tail-part of accepted refnames.  Is there one
> + * among then that is a suffix of the path?  Directory boundary must
> + * be honored when doing this match.  IOW, patterns "master" and
> + * "sa/master" both match path "refs/hold/sa/master".  On the other
> + * hand, path "refs/hold/foosa/master" is matched by "master" but not
> + * by "sa/master".
> + */
> +
> +static int tail_match(const char **pattern, const char *path)
> +{
> +	int pathlen;
> +	const char *p;
> +
> +	if (!*pattern)
> +		return 1; /* no restriction */
> +
> +	for (pathlen = strlen(path); (p = *pattern); pattern++) {
> +		int pfxlen = pathlen - strlen(p);
> +		if (pfxlen < 0)
> +			continue; /* pattern is longer, will never match */
> +		if (strcmp(path + pfxlen, p))
> +			continue; /* no tail match */
> +		if (!pfxlen || path[pfxlen - 1] == '/')
> +			return 1; /* fully match at directory boundary */
> +	}
> +	return 0;
> +}

This still does not match the behavior of the old shell implementation
completely - because $pat was not quoted, shell pattern characters in
$pat worked, and things like "git ls-remote . 'refs/heads/something--*'"
were possible (and used in some of my scripts), so a full fnmatch()
call is still needed.

--Signature=_Sun__9_Dec_2007_16_26_33_+0300_BVGjzyXFRoR16ncU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.6 (GNU/Linux)

iD8DBQFHW+0NW82GfkQfsqIRAuAXAJ9EXlvdoGRgajfLLuieeljgdrmjLgCaA7vr
pD+T7lziIZATblnvgGw8wDI=
=dP1p
-----END PGP SIGNATURE-----

--Signature=_Sun__9_Dec_2007_16_26_33_+0300_BVGjzyXFRoR16ncU--
