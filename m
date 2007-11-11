From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] --format=pretty: avoid calculating expensive expansions twice
Date: Sun, 11 Nov 2007 02:29:12 -0800
Message-ID: <7vejexf53b.fsf@gitster.siamese.dyndns.org>
References: <4733AEA6.1040802@lsrfire.ath.cx>
	<20071109045040.GC31760@sigill.intra.peff.net>
	<4734EA4E.8070405@lsrfire.ath.cx>
	<20071110004635.GA14992@sigill.intra.peff.net>
	<47359382.1010600@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Nov 11 11:29:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrA4T-0002SY-65
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 11:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbXKKK3X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 05:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbXKKK3X
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 05:29:23 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:38922 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbXKKK3W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2007 05:29:22 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 575D72F2;
	Sun, 11 Nov 2007 05:29:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B7F4F93994;
	Sun, 11 Nov 2007 05:29:36 -0500 (EST)
In-Reply-To: <47359382.1010600@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of
	"Sat, 10 Nov 2007 12:18:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64440>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> +static int add_again(struct strbuf *sb, struct chunk *chunk)
> +{
> +	if (chunk->len) {
> +		strbuf_adddup(sb, chunk->off, chunk->len);
> +		return 1;
> +	}
> +
> +	/*
> +	 * We haven't seen this chunk before.  Our caller is surely
> +	 * going to add it the hard way now.  Remember the most likely
> +	 * start of the to-be-added chunk: the current end of the
> +	 * struct strbuf.
> +	 */
> +	chunk->off =3D sb->len;
> +	return 0;
> +}
> +
>  static void parse_commit_header(struct format_commit_context *contex=
t)
>  {
>  	const char *msg =3D context->commit->buffer;
> @@ -447,15 +469,21 @@ static void format_commit_item(struct strbuf *s=
b, const char *placeholder,
>  		strbuf_addstr(sb, sha1_to_hex(commit->object.sha1));
>  		return;
>  	case 'h':		/* abbreviated commit hash */
> +		if (add_again(sb, &c->abbrev_commit_hash))
> +			return;
>  		strbuf_addstr(sb, find_unique_abbrev(commit->object.sha1,
>  		                                     DEFAULT_ABBREV));
> +		c->abbrev_commit_hash.len =3D sb->len - c->abbrev_commit_hash.off;
>  		return;

Brilliant.  Doubly brilliant is the adddup abstraction that does
not suffer from underlying strbuf being reallocated.

Me likee..
