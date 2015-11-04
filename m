From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 02/11] run-command: report failure for degraded output just once
Date: Wed, 04 Nov 2015 12:42:15 -0800
Message-ID: <xmqq8u6da448.fsf@gitster.mtv.corp.google.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
	<1446597434-1740-3-git-send-email-sbeller@google.com>
	<xmqqd1vpbpik.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaiRKHd2RS9eNeZt_VZqqBF0HS0D=x1HbOTPXYOphu8pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 21:42:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu4sy-0007dO-FF
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 21:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965692AbbKDUmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 15:42:20 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64288 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965412AbbKDUmT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 15:42:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8774428F65;
	Wed,  4 Nov 2015 15:42:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XPNm6LAiHnbYduELOvw821V/CGg=; b=V9m6xx
	lc0rQfAQ/zk1vqSgXbalzBUGWfZP6kcOHUSGSBXO3ZmgQRb4Ul7FoSUG/GvnQg/O
	/B01G2L5r7zz6uYXaruiQu6fUJpN8o//OxIqRPMRu6DcFIYn9r9+I6OvteyfaK5X
	ssUxEn6bQH4WM4UcW+ubTO2nNhUJa08v58fP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F7vFjaagl8/SecjnyzHMugKagI6fEVAa
	4gba+xwT9fcmP1L3vhkzhNPT2WiF++fscaMgD4pUGj16yEOSBmlRSW/pJ1ArExLn
	xMiHpXmRM1IW5O0syUpdqV3wc0OKng3lW9grOpf+Zf7dRNVauGxkbQtYt04Ai/GL
	CBksweve9Ik=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7C66B28F64;
	Wed,  4 Nov 2015 15:42:18 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0359528F63;
	Wed,  4 Nov 2015 15:42:18 -0500 (EST)
In-Reply-To: <CAGZ79kaiRKHd2RS9eNeZt_VZqqBF0HS0D=x1HbOTPXYOphu8pg@mail.gmail.com>
	(Stefan Beller's message of "Wed, 4 Nov 2015 12:14:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 89F84080-8334-11E5-A661-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280882>

Stefan Beller <sbeller@google.com> writes:

> Another approach would be to test if we can set to non blocking and if
> that is not possible, do not buffer it, but redirect the subcommand
> directly to stderr of the calling process.
>
>     if (set_nonblocking(pp->children[i].process.err) < 0) {
>         pp->children[i].process.err = 2;
>         degraded_parallelism = 1;
>     }
>
> and once we observe the degraded_parallelism flag, we can only
> schedule a maximum of one job at a time, having direct output?

I would even say that on a platform that is _capable_ of setting fd
non-blocking, we should signal a grave error and die if an attempt
to do so fails, period.

On the other hand, on a platform that is known to be incapable
(e.g. lacks SETFL or NONBLOCK), we have two options.

1. If we can arrange to omit the intermediary buffer processing
   without butchering the flow of the main logic with many
   #ifdef..#endif, then that would make a lot of sense to do so, and
   running the processes in parallel with mixed output might be OK.
   It may not be very nice, but should be an acceptable compromise.

2. If we need to sprinkle conditional compilation all over the place
   to do so, then I do not think it is worth it.  Instead, we should
   keep a single code structure, and forbid setting numtasks to more
   than one, which would also remove the need for nonblock IO.

Either way, bringing "parallelism with sequential output" to
platforms without nonblock IO can be left for a later day, when we
find either (1) a good approach that does not require nonblock IO to
do this, or (2) a good approach to do a nonblock IO on these
platforms (we know about Windows, but there may be others; I dunno).
