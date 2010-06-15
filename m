From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] common_prefix: be more careful about pathspec bounds
Date: Tue, 15 Jun 2010 09:06:45 -0700
Message-ID: <7v4oh48elm.fsf@alter.siamese.dyndns.org>
References: <825550ec93610c2d3c7dae7550729d96fc6cebbc.1276194169.git.trast@student.ethz.ch> <7v8w6g8hfx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 15 18:07:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOYfK-0002RC-7X
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 18:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463Ab0FOQG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 12:06:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63579 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307Ab0FOQG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 12:06:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 11EB6BA193;
	Tue, 15 Jun 2010 12:06:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bA0QV9LPG+xoEwrYbGjYDXwLnkw=; b=bgYbSj
	asqRT1df4ph6bv9B+7RXHl8xFOnYI041mqT/sBEmVIX5/qoidpvYPnkQFs/PMZDb
	68U05Vbzj5dTTeipAQw2hh4XIy9484arvwmJk1LVy0x9k3OzERsK/o1q9kPPUher
	U+nzf+os5h4w2mBhwYl9AYb08YRBx1+ZimVFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lTEglVsOdXyAAWvws8fLyZxqyiC8G6y8
	h8f8xGe5WuZcqNHYyl0hnoSJ1Ow0mAjOPuL1LHSLZyuWsu5mQt1Vp6+DLf8ZUWGp
	zxSkVNO7pZqnAwRLYofqWBXj/qx2L84RlhEblWL8iAk3fwbial7zYBTtc5uPNBJI
	PVEuuo9o5jg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CF5DFBA18F;
	Tue, 15 Jun 2010 12:06:50 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01264BA18A; Tue, 15 Jun
 2010 12:06:46 -0400 (EDT)
In-Reply-To: <7v8w6g8hfx.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 15 Jun 2010 08\:05\:22 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 01FE04A0-7898-11DF-AC61-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149194>

Junio C Hamano <gitster@pobox.com> writes:

> Isn't it more intuitive to structure the loop by saying 'Ok, if "path" up
> to the currently proposed "prefix" is too long to match, let's shorten it
> by one path component and try again'?

Another way of saying this, which probably needs less number of scans,
would be to shorten prefix to what is known to match --- use of memcmp()
discards this information.

static int common_prefix(const char **pathspec)
{
	const char *path, *slash, *next;
	int prefix;

	if (!pathspec)
		return 0;

	path = *pathspec;
	slash = strrchr(path, '/');
	if (!slash)
		return 0;
	prefix = slash - path + 1;

	while ((next = *++pathspec) != NULL) {
		int len, last_matching_slash = -1;
		for (len = 0;
		     len < prefix && next[len] == path[len];
		     len++)
			if (next[len] == '/')
				last_matching_slash = len;
		if (len == prefix)
			continue;
		if (last_matching_slash < 0)
			return 0;
		prefix = last_matching_slash + 1;
	}
	return prefix;
}
