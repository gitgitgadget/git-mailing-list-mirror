From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] introduce pack metadata cache files
Date: Tue, 29 Jan 2013 09:35:12 -0800
Message-ID: <7v622friy7.fsf@alter.siamese.dyndns.org>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091555.GC9999@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 18:35:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0F5v-0004aS-Ec
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 18:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999Ab3A2RfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 12:35:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47992 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082Ab3A2RfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 12:35:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D59DC051;
	Tue, 29 Jan 2013 12:35:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=u/W85Qyf1GUF6zlqDFnPdKxe+mA=; b=d7t8PDOKc0slZ/xXntop
	dPggctc3SO3UClMtyrf9bgfZpabZTP12zhJ5bm7/x2RHmlGlYnT1aoniinSccaM4
	St0g7xsie/XcIlFH9Dkqwqd9XnaUjAR8kx/wOaYaf/wEUfEh9OSmHLa9wZAMIW2D
	EP+mwWHYR8dVzfKijQVdz6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=QIjsR+CU5/DtdSutIWD2chGs84iVslj+t/V8NVTtlvLgNm
	e5And9W94Ov8thK3Kix9xNeEhkIV1bTnKfYntXlL64KATUwfx71PJAQ2nDwVyA6a
	H9qmzSPrsSWeR3wEVijJbQJakLXpXzpvvDyDb+4MCSxdKMSdLxY0GSDPwWqoc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E5B8C04F;
	Tue, 29 Jan 2013 12:35:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73870C049; Tue, 29 Jan 2013
 12:35:14 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3D5EE29E-6A3A-11E2-A99F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214949>

Jeff King <peff@peff.net> writes:

> +static void write_meta_header(struct metapack_writer *mw, const char *id,
> +			      uint32_t version)
> +{
> +	version = htonl(version);
> +
> +	sha1write(mw->out, "META", 4);
> +	sha1write(mw->out, "\0\0\0\1", 4);
> +	sha1write(mw->out, mw->pack->sha1, 20);
> +	sha1write(mw->out, id, 4);
> +	sha1write(mw->out, &version, 4);
> +}

It seems that you are very close to actually having a plumbing that
could also do the pack .idx files.  Until/unless that can be done, I
am not sure how much benefit we would be getting from a file format
that records a subtype "id" and a generic "META" type, instead of
just a single "id" as the type ehader.  But it is OK to use 8 extra
bytes if we can potentially gain something later.

Shouldn't id be validated with at least something like

	if (strlen(id) < 3)
		die("Bad id: %s", id);

to catch a call

	write_meta_header(&mw, "me", 47);

that will stuff 'm', 'e', NUL and the garbage the compiler/linker
combo has placed after that constant string in the 4-byte id field?

> +void metapack_writer_init(struct metapack_writer *mw,
> +			  const char *pack_idx,
> +			  const char *name,
> +			  int version)
> +{
> +	struct strbuf path = STRBUF_INIT;
> +
> +	memset(mw, 0, sizeof(*mw));
> +
> +	mw->pack = add_packed_git(pack_idx, strlen(pack_idx), 1);
> +	if (!mw->pack || open_pack_index(mw->pack))
> +		die("unable to open packfile '%s'", pack_idx);
> +
> +	strbuf_addstr(&path, pack_idx);
> +	strbuf_chompstr(&path, ".idx");
> +	strbuf_addch(&path, '.');
> +	strbuf_addstr(&path, name);

Your chompstr() does not even validate if the given name ends with
".idx", so this sounds like a glorified way to say

	strbuf_splice(&path, path->len - strlen("idx"), strlen("idx"),
			 name, strlen(name));

to me.

> +	mw->path = strbuf_detach(&path, NULL);
> +
> +	mw->out = create_meta_tmp();
> +	write_meta_header(mw, name, version);
> +}
> +
> +void metapack_writer_finish(struct metapack_writer *mw)
> +{
> +	const char *tmp = mw->out->name;
> +
> +	sha1close(mw->out, NULL, CSUM_FSYNC);
> +	if (rename(tmp, mw->path))
> +		die_errno("unable to rename temporary metapack file");

Who is responsible for running adjust_shared_perm()?  The caller, or
this function?
