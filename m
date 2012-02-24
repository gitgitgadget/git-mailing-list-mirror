From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] bulk checkin does not respect filters
Date: Thu, 23 Feb 2012 19:42:11 -0800
Message-ID: <7vr4xk28z0.fsf@alter.siamese.dyndns.org>
References: <20120224030244.GA15742@sigill.intra.peff.net>
 <7vvcmw2a3m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 24 04:42:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0m31-0005YM-Op
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 04:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983Ab2BXDmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 22:42:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53880 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753026Ab2BXDmO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 22:42:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F26B787C;
	Thu, 23 Feb 2012 22:42:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9ftZIGgZrmgB9BHXGdtw4VrlNIQ=; b=EAtmJK
	YQy2ILLLWj8MuyiQsGWK+aZ8WU353zfSPQASzUbdq+3lUBvUel6LrXyYEnBRd11d
	UdRMUW231rVQJZ1a+S886jT554UYoePQ5rPpDns40EvQpnO+O0MzUlKR9aqr6sRj
	9m5/Th3FzmttAAKu465s5yNbVts3uQrxDantE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P5lgQLoOe5KEmR6pLcMPEYc3zTjVNK55
	VGf62TouHz+SpU251gvOFoBQDSuyONRg+Wy+e3MEbrk8Q/9XyXj1FWNsF/GxNxqi
	2lUC0noWoygF7ygq1srzvHhC4stYmkcLp5UG9rYi5wis1saf8mdz4g+YFcuxxeKe
	ZgFsoBdQUIU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05F4A787B;
	Thu, 23 Feb 2012 22:42:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6841F7879; Thu, 23 Feb 2012
 22:42:13 -0500 (EST)
In-Reply-To: <7vvcmw2a3m.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 23 Feb 2012 19:17:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89E5E296-5E99-11E1-8D71-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191413>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Thoughts? Was this intentional, or just overlooked?

It is a bit curious that anything filtered even goes to the streaming
codepath, given this piece of code in write_entry() in entry.c:

	if (ce_mode_s_ifmt == S_IFREG) {
		struct stream_filter *filter = get_stream_filter(path, ce->sha1);
		if (filter &&
		    !streaming_write_entry(ce, path, filter,
					   state, to_tempfile,
					   &fstat_done, &st))
			goto finish;
	}

and get_stream_filter() in convert.c has an explicit exception for this
case at the very beginning:

struct stream_filter *get_stream_filter(const char *path, const unsigned char *sha1)
{
	struct conv_attrs ca;
	enum crlf_action crlf_action;
	struct stream_filter *filter = NULL;

	convert_attrs(&ca, path);

	if (ca.drv && (ca.drv->smudge || ca.drv->clean))
		return filter;

to make sure that it says "No streaming filtering is possible, do not even
attempt to call streaming_write_entry()".
