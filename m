From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] revert: Use assert to catch inherent program bugs
Date: Fri, 20 May 2011 10:03:02 -0700
Message-ID: <7v7h9l4855.fsf@alter.siamese.dyndns.org>
References: <20110520071609.GA6755@domU-12-31-39-06-A8-0A.compute-1.internal>
 <1305880223-7542-1-git-send-email-artagnon@gmail.com>
 <1305880223-7542-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 19:03:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNT6h-0004bS-3k
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 19:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825Ab1ETRDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 13:03:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab1ETRDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 13:03:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E727653A3;
	Fri, 20 May 2011 13:05:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bdTmpLqygLitKVhCOipgoFulpAA=; b=CgH0Kw
	tJKddLQCM+IFwB8aFzYG28RsgHwRXVGWkfL1gh2crQJT6+GDcCjCOQWA34mlDZLM
	c+TGTMqBF2vmk3bwUPsp4YVnXYYpNpZ9go+j14InMnQ0O7np3+YV/WDoa2US6cEa
	mqW7OSg8zJz4aG2Bt+IQjbbYkBYQTVLuc6qNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OF1Lvi52GWfj18C0fLcB6ow/tlOT34Eb
	U7O3E5U3hBiSO2J1QFcrv/DO7aASo4tfNsAvrZM3g3dlr/d7uCs7NUSEEeQDDYMf
	W8R46UfbeeYuovo4bd5VhRD4OV5vTAfZnyjGjSusoUL9xaOE22RxnKj0rCPRvfAd
	CkxpoS9ejH8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9473153A1;
	Fri, 20 May 2011 13:05:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E85155399; Fri, 20 May 2011
 13:05:11 -0400 (EDT)
In-Reply-To: <1305880223-7542-2-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Fri, 20 May 2011 08:30:22 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56C4A266-8303-11E0-B248-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174066>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Instead of returning and error status or calling die, use an assert
> statement to guard against callers who don't call the functions with
> sane arguments.

Please do not do this.  assert() is a mechanism to aid debugging in a
development build, and can be stripped away in the production build.

> diff --git a/builtin/revert.c b/builtin/revert.c
> index f697e66..8102d77 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -123,8 +123,7 @@ static int get_message(const char *raw_message, struct commit_message *out)
>  	int abbrev_len, subject_len;
>  	char *q;
>  
> -	if (!raw_message)
> -		return -1;
> +	assert(raw_message);
>  	encoding = get_encoding(raw_message);

This change is wrong, as you could feed a NULL to get_encoding (and you
also broke that function in the later hunk).

If the calling convention of this internal function is that passing NULL
is a programming bug, please do something like this instead:

	if (!raw_message)
		die("BUG: get_message() called with NULL");
