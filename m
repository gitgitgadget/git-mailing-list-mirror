From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] sha1_file: use strncmp for string comparison
Date: Mon, 30 Jun 2014 09:43:17 -0400
Message-ID: <20140630134317.GB14799@sigill.intra.peff.net>
References: <53AED59B.1020209@web.de>
 <CACsJy8B_DAjLRcMe4ys2LGkLOcKuW-PL_WNHyFB8Ry3Uv38LCw@mail.gmail.com>
 <53AFA775.1090900@web.de>
 <53AFAA89.6050200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 15:43:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1brl-0005Ow-CJ
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 15:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbaF3NnU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2014 09:43:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:53521 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752497AbaF3NnS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 09:43:18 -0400
Received: (qmail 29716 invoked by uid 102); 30 Jun 2014 13:43:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jun 2014 08:43:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2014 09:43:17 -0400
Content-Disposition: inline
In-Reply-To: <53AFAA89.6050200@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252668>

On Sun, Jun 29, 2014 at 07:56:25AM +0200, Ren=C3=A9 Scharfe wrote:

> Avoid overrunning the existing pack name (p->pack_name, a C string) i=
n
> the case that the new path is longer by using strncmp instead of memc=
mp
> for comparing.  While at it, replace the magic constant 4 with a
> strlen call to document its meaning.

An unwritten assumption with this code is that we have "foo.idx" and we
want to make sure that we are matching "foo.pack" from the existing pac=
k
list. Both before and after your patch, I think we would match
"foobar.pack". It's probably not a big deal, as we don't expect random
junk in the pack directory, but I wonder if it would be better to be
explicit, like:

  /*
   * like ends_with, but return the truncated size of str via
   * the "len" parameter.
   */
  int strip_suffix(const char *str, const char *suffix, size_t *len)
  {
	size_t suflen =3D strlen(suffix);
	*len =3D strlen(str);

	if (len < suflen)
		return 0;
	else if (strcmp(str + len - suflen, suffix))
		return 0;
	else {
		*len -=3D suflen;
		return 1;
	}
  }

  int idx_matches_pack(const char *idx, const char *pack)[
  {
	size_t idx_len, pack_len;
	if (!strip_suffix(idx, ".idx", &idx_len) ||
	    !strip_suffix(pack, ".pack", &pack_len))
		return 0;
	if (idx_len !=3D pack_len)
		return 0;
	return !memcmp(idx, pack, idx_len);
  }

You'd perhaps want to split idx_matches_pack across the loop below (our
idx is actually a strbuf, so you can reuse path->len to avoid a strlen,
and you do not have to verify idx_len each time through the loop).

I think strip_suffix would have other uses, too. It's a more featureful
version of ends_with, as skip_prefix is to starts_with. E.g.,
builtin/remote.c:config_read_branches could use it to avoid some magic
numbers.

> diff --git a/sha1_file.c b/sha1_file.c
> index 394fa45..8adab14 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1207,7 +1207,8 @@ static void prepare_packed_git_one(char *objdir=
, int local)
>  		if (has_extension(de->d_name, ".idx")) {
>  			/* Don't reopen a pack we already have. */

If we don't follow my suggestion above, we still have this
has_extension. This is a reimplementation of ends_with, isn't it? We ca=
n
probably drop it and just use ends_with.

-Peff
