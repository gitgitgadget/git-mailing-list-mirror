From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segmentation fault found while fuzzing .pack file under 2.7.0.rc3
Date: Wed, 24 Feb 2016 10:48:27 -0800
Message-ID: <xmqqegc2t05g.fsf@gitster.mtv.corp.google.com>
References: <568BC8D1.3080201@gmail.com>
	<20160105152436.GA1205@sigill.intra.peff.net>
	<xmqqr3ht41w8.fsf@gitster.mtv.corp.google.com>
	<xmqqtwmp2e6d.fsf@gitster.mtv.corp.google.com>
	<20160224110548.GA21620@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacek Wielemborek <d33tah@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 19:48:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYeUE-0001PA-OR
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 19:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755151AbcBXSsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 13:48:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59455 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752829AbcBXSsa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 13:48:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D8CF345FD2;
	Wed, 24 Feb 2016 13:48:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DBYzlfW+IRI5iEgdXnHl+GHWwZY=; b=w2KqxA
	fxRoBQHRFgEr9lQxNXq+tBwdofoHlmFp0Jc81HNEcbTGzmSiS7jyJVh03NaEKXmp
	Yof6JYfSLr2QEjhU+4PUo7uBQLo6NofAn465nZuLKBoq0mkmObBlSywU+9+0ViyY
	PhxWcyiLLwdtsppY61AMmzv6uuEXfi5U7pBlc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kna7Ihd3+aX5Aqhq/xqz5I/d6w3Frebl
	S3OGK0E0UgrUd82oMkqZls0m9aDbR0n7KhvNSGtEgmXmxyB+XlzPSdfJ9KACJ96T
	OZvQS9lB5Cxh1KfrHDS80/8wYOvVDdgmvBK0llZwXJo1JN2E+WAcUlsPJWoV/u4D
	g6wi4h3+aFM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CF71045FD1;
	Wed, 24 Feb 2016 13:48:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3C95345FCD;
	Wed, 24 Feb 2016 13:48:29 -0500 (EST)
In-Reply-To: <20160224110548.GA21620@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 24 Feb 2016 06:05:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 31EEE880-DB27-11E5-8A7F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287217>

Jeff King <peff@peff.net> writes:

> On Thu, Jan 07, 2016 at 02:54:50PM -0800, Junio C Hamano wrote:
>
>> We do not check if the offset of individual objects are within the
>> corresponding .pack file, either, and nth_packed_object_offset()
>> does return the data read from .idx file that is not checked for
>> sanity.  use_pack(), which is the helper used by the callers of
>> nth_packed_object_offset() that finds the offset in the packfile for
>> each object, avoids allowing a read access to mapped pack data
>> beyond the end of it, so it is OK to return bogus value that was
>> read from the .idx file from this function, but there is one
>> computation the function itself does using a possibly bogus value
>> read from the disk: to find out where in the secondary offset table
>> in the .idx file the offset in the packfile is stored.
>
> Looks like this topic got dropped. I was reminded of it when somebody
> pointed me to a similar case[1] today which segfaults in a similar way (but
> this time was caused by actual filesystem corruption).
>
> Did you ever push the patch below further along?

I do not think so, as I didn't "dig"; I recall trying to be explicit
that it was an illustration to prevent two extra and unnecessary
changes I alluded to in the earlier parts of the thread, not a real
patch.

> I confirmed that your patch detects and complains on this newer case.
> Though I think there is another similar problem in
> read_v2_anomalous_offsets (I haven't dug, but it triggers for me in
> "index-pack --verify").
>
> -Peff
>
> [1] https://github.com/libgit2/libgit2/issues/3556
