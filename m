From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fast-import: allow to tag newly created objects
Date: Tue, 23 Aug 2011 11:32:08 -0700
Message-ID: <7vy5ykq8rb.fsf@alter.siamese.dyndns.org>
References: <1314015019-6636-1-git-send-email-divanorama@gmail.com>
 <1314015019-6636-3-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 20:32:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvvlo-0006tV-Vn
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 20:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276Ab1HWScM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 14:32:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065Ab1HWScL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 14:32:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98E424F53;
	Tue, 23 Aug 2011 14:32:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0qCQQ5GcZkPeH+xXAxJ57XaBjJg=; b=QeD3YM
	zvivJbxj2XGdoxGQLhE4eDvk/CQmNGGdNOMIbeCsXvmfJQVz6VSJv5UHyFge/AFS
	dj4tLXu81cCPLHqzVb2heZ6IRtXLfs0rN+zRfsE7Ikr8vl3QRYmVlxvr2vle5zqY
	4V4LzP5WZqVYMDMHIrtcLNemKfvmR65Twx9Uw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GnRus9H2AKo8MCG6FOtMRhCx3KJXQGi6
	xq4KRwrfnF+7gKTvshMJDFllawl5BgqJieGk+1StQPGRTCiEUsaCyUImNLQSToPd
	qnKB/OmAQQf+tffmoSwdwhJEEX6+NDF00NFl/1huZ7KNG5IKychu0OivRB+PEV9F
	7+p0Jw5kdcY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BDC14F52;
	Tue, 23 Aug 2011 14:32:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 218484F51; Tue, 23 Aug 2011
 14:32:10 -0400 (EDT)
In-Reply-To: <1314015019-6636-3-git-send-email-divanorama@gmail.com> (Dmitry
 Ivankov's message of "Mon, 22 Aug 2011 18:10:19 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3665AE4A-CDB6-11E0-8221-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179958>

Dmitry Ivankov <divanorama@gmail.com> writes:

>  	} else if (!get_sha1(from, sha1)) {
> -		type = sha1_object_info(sha1, NULL);
> -		if (type < 0)
> -			die("Not a valid object: %s", from);
> +		struct object_entry *oe = find_object(sha1);
> +		if (!oe) {
> +			type = sha1_object_info(sha1, NULL);
> +			if (type < 0)
> +				die("Not a valid object: %s", from);
> +		} else
> +			type = oe->type;

It might be just a "taste" thing, but I would have expected the above to
be written like so:

	struct object_entry *oe = find_object(sha1);
	if (!oe)
		type = sha1_object_info(sha1, NULL);
	else
		type = oe->type;
	if (type < 0)
		die("Not a valid object: %s", from);

The point being that find_object()->type and the return value of
sha1_object_info() are supposed to be compatible and interchangeably used,
which is exactly why the same variable "type" gets assigned and later be
used in the same codeflow, so they should get the same error checking,
even if it happens to be that the current implementation of find_object()
never returns an object with invalid type in it.
