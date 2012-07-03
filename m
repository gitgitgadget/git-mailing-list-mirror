From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] serious inflate inconsistency on master
Date: Tue, 03 Jul 2012 15:40:07 -0700
Message-ID: <7vipe4tqns.fsf@alter.siamese.dyndns.org>
References: <20120703221900.GA28897@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 04 00:40:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmBlZ-0003rR-Gy
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 00:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580Ab2GCWkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 18:40:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61515 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756267Ab2GCWkK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 18:40:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 841EA94C5;
	Tue,  3 Jul 2012 18:40:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=grj++Ch6YHBxVGgh1m/EJhdNyxs=; b=OMus5x
	NMh247dvToxdcWzV5v4GgUrHGv3GYLK8yAeNI6gmKi1SlrUiLLzbwm3aNhqj7pU2
	zrQlB2rKUZEdKXFofLrdB3t1x6NKe2au13UkKbpTpeHhcuMrbMWZXJyikr7nsHWi
	+utYCfZyKztph6SWAdgpPfctaw3Muszn6L/4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wFP2uPK2Tb4Kv+eXde1zc3+oKYChRynD
	tp8huOd3W17HDMqRL5Jo9enNBTP6N1JFGA7fm9Z627EbnY5f4qnTTZrPp8mK9xN9
	fQp22aYwxnztRKw/npx76THd3YcpebJCHajRyQLsHOSlcJDQGgowSsJxA7/eL0R4
	7UpqhxZrRYc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74AFA94C4;
	Tue,  3 Jul 2012 18:40:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0411794C2; Tue,  3 Jul 2012
 18:40:08 -0400 (EDT)
In-Reply-To: <20120703221900.GA28897@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 3 Jul 2012 18:19:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B05B9DC-C560-11E1-9A8A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200974>

Jeff King <peff@peff.net> writes:

> The problem seems to be in index-pack.c:unpack_data, which does this:
>
>>	git_inflate_init(&stream);
>>	stream.next_out = data;
>>	stream.avail_out = consume ? 64*1024 : obj->size;
>>
>>	do {
>>		unsigned char *last_out = stream.next_out;
>>		ssize_t n = (len < 64*1024) ? len : 64*1024;
>>		n = pread(pack_fd, inbuf, n, from);
>>		if (n < 0)
>>			die_errno(_("cannot pread pack file"));
>>		if (!n)
>>			die(Q_("premature end of pack file, %lu byte missing",
>>			       "premature end of pack file, %lu bytes missing",
>>			       len),
>>			    len);
>>		from += n;
>>		len -= n;
>>		stream.next_in = inbuf;
>>		stream.avail_in = n;
>>		status = git_inflate(&stream, 0);
>>		if (consume) {
>>			if (consume(last_out, stream.next_out - last_out, cb_data)) {
>>				free(inbuf);
>>				free(data);
>>				return NULL;
>>			}
>>			stream.next_out = data;
>>			stream.avail_out = 64*1024;
>>		}
>>	} while (len && status == Z_OK && !stream.avail_in);
>>
>>	/* This has been inflated OK when first encountered, so... */
>>	if (status != Z_STREAM_END || stream.total_out != obj->size)
>>		die(_("serious inflate inconsistency"));

Yeah, that "if (consume)" part is clearly bogus.  It should feed
what it read in "inbuf" fully to git_inflate() in a (missing) inner
loop and keep feeding consume() with the inflated data, but instead
happily goes on to read more from the packfile once the initial part
of the inflated data is fed to consume, ignoring the remainder.

> So I don't really understand what this !stream.avail_in is doing there
> in the do-while loop.  Don't we instead need to have an inner loop that
> keeps feeding the result of pread into git_inflate until we don't have
> any available data left?

Exactly.  I do not think the avain_in check should be done at the
end of the outer loop at all.  When we are buffering the entire
inflated data in core without using consume, we allocate enough
memory to "data" to hold the whole thing, so in that case, it may be
OK to expect that git_inflate() would never return without consuming
the input bytes (i.e. stream.avail_in would always be zero at the
site of the check), but with consume(), we give small piece of
memory as a temporary output area and call git_inflate(), and it is
entirely possible and normal for it to run out of output before
inflating all the input bytes.
