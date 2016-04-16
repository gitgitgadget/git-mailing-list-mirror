From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Fri, 15 Apr 2016 17:49:31 -0700
Message-ID: <xmqqd1pq74ys.fsf@gitster.mtv.corp.google.com>
References: <1460761306-18794-1-git-send-email-sbeller@google.com>
	<1460761306-18794-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jacob.keller@gmail.com, git@vger.kernel.org, peff@peff.net,
	Jens.Lehmann@web.de, davidel@xmailserver.org,
	Jacob Keller <jacob.e.keller@intel.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 02:49:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arEQd-000462-5E
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 02:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbcDPAtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 20:49:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751676AbcDPAte (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 20:49:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 47D2A133BF;
	Fri, 15 Apr 2016 20:49:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QqO6+F2RT5ZeianbPtXypkwKs7g=; b=P9SyVH
	mfwlGghOyc8+9mevrgBxOCt2aRkRTuYJ67WjRmX0kun2ClSMYyFRLhDLtC+QtljF
	9HUW2gmVEWeYpj9ibeIqNrSJ7W8q/ftPoV09vtsG+oPrWr4tgAIGWFWz6QYRgezz
	0tp3q1ldIIgFULqPI6NOtCHsZ3J0B4nZoxfoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ijAQtits4ohb+DbFJEoVFGPqhKBiMS04
	6k8v/ZRuO1Kv2zUW7rL2FaYF7qMq7G6tCYUOJckZbBK8flt2ZlWQ+WR0BoBOXwrl
	TugTyi4Rdl3RdMuoaCKu6pgQv+n3HAhJHdoekwUsKb9a5df/o8vWZlEZayQ+71F1
	BCJa5+1xahI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3ECBB133BE;
	Fri, 15 Apr 2016 20:49:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 95F42133BD;
	Fri, 15 Apr 2016 20:49:32 -0400 (EDT)
In-Reply-To: <1460761306-18794-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 15 Apr 2016 16:01:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 15686AD8-036D-11E6-9065-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291708>

Stefan Beller <sbeller@google.com> writes:

> +static int line_length(const char *recs)
> +{
> +	char *s = strchr(recs, '\n');
> +	return s ? s - recs : strlen(recs);
> +}

It seems that you guys are discarding this "number of bytes on a
line, no matter what these bytes are" idea, so this may be moot, but
is there a guarantee that reading through recs until you happen to
see a NUL is safe?

Shouldn't the code that accesses a "line" be using the same "from
here to there", i.e. recs[]->ptr, recs[]->size, interface to avoid
having to scan the underlying string in an unbounded way?
