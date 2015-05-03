From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/18] Improve handling of D/F conflicts
Date: Sat, 02 May 2015 19:09:45 -0700
Message-ID: <xmqqy4l6wgwm.fsf@gitster.dls.corp.google.com>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun May 03 04:09:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YojLt-0002OV-Ed
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 04:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbbECCJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 22:09:49 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56989 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751398AbbECCJs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 22:09:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E7A34E790;
	Sat,  2 May 2015 22:09:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cWBYS10kB/lHO3rdCIM1CVfODcM=; b=Qc75BH
	kvhgYOodNtyVyWRTDpFlFsm5FANy0GNomK4g9kNkoEbR48VUBy/nr2PvzLWvTQTV
	gxZMkRLMB+IhSzzffYI/51nQw/UCJU3pvBcCvfZNXr2kIOiZ8DcsLanKDkxCEMHc
	tj1EgBixGesxKrgqBzeVIbNkZ/Qof3WXtL1GI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wz5LvvpHsZCxqrSsKhXoTSoPNtdKh1p4
	9fb+uw2hwPBUkz+Mt6qcjEaBoHw3DYFdLmqBLLwIq0btTkLZAPOVKtCzCJbUl+RD
	yMLjg+rr7hZb4gL3Tt9ECT9AzgXaKtOyTdkaXaMnYmR7bnoZYstVbnVT3UiXdPZu
	awnZnxPGtgg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 67ADA4E78F;
	Sat,  2 May 2015 22:09:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D992F4E78B;
	Sat,  2 May 2015 22:09:46 -0400 (EDT)
In-Reply-To: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Fri, 1 May 2015 14:25:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 78BD3498-F139-11E4-A8E7-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268248>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> We currently don't handle D/F conflicts very well.
>
> A "D/F conflict" is what we call a conflict between references like
> "refs/foo" and "refs/foo/bar".

Could you phrase that slightly differently, so that readers can tell
between the usual D/F conflict that is between directory and file in
the tracked contents (i.e. conflict between the branches being
merged, killing of a directory necessary when checking out a file,
etc.) and this thing?  They are similar in nature, but "D/F
conflict" has been used to refer to the clashes that happen to the
user contents, not refnames.  Starting a paragraph with "... don't
handle D/F conflicts in refnames very well" and then using "D/F
conflict" as a short-hand for "D/F conflict in refnames" throughout
the rest of the message is perfectly fine, as long as the message
never talks about the D/F conflict in the traditional sense.

> * D/F conflicts between references being created in a single
>   transaction used to be detected too late, possibly after part of the
>   transaction had already been committed.
>
> * D/F errors against loose references were typically reported as

Be consistent by s/errors/conflicts/ perhaps?

> This patch series applies on top of
> mh/ref-lock-avoid-running-out-of-fds. I did it that way because I
> expected significant conflicts between the series, and the older
> series is simple/mature enough that I expect it to be merged early in
> the post-2.4 cycle. But in retrospect it turns out that there are only
> minor conflicts between the two series. So if you would like me to
> rebase this series to another starting point, please let me know.

Thanks for being considerate about back-porting necessity.

As I have written, I actually would prefer to see that the other
topic, ref-lock-avoid-running-out-of-fds, to be made applicable to
older maintenance tracks.  So...
