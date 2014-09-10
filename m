From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] Improve tag checking in fsck and with transfer.fsckobjects
Date: Wed, 10 Sep 2014 14:31:00 -0700
Message-ID: <xmqqsijzf9ij.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1409101552250.990@s15462909.onlinehome-server.info>
	<xmqq7g1bgp5r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 10 23:31:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRpTq-0000vF-Oa
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 23:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbaIJVbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 17:31:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53178 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753019AbaIJVbD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 17:31:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 24C8438F82;
	Wed, 10 Sep 2014 17:31:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q+u/NxWjEHLReXcTxjC1jDTxGEE=; b=D0rmVj
	shxODEp2mC0ay2YgAsrMbecKAI5vkSO8KJ/oW96RaPMG9c6ILaFIbR7q+BZbmWGr
	MPU0Qe+B7RIsTBrZsNHSqDvSJzy86VV4Im+Zdq+mYEx32wTtfsEJ2wf1LLUClx16
	DqTlgrodX0DeqlS+uyrKx910Oy1RweIuK2ouQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sTS1yZuKkJahBlVfUNSsqpWWP9XuVVk1
	CbPUvBRxHcArjfYcM7AZpOvJDA8IG8X2crnXVVyj6xLU6DZ+tGf/m+8YMu2afYGc
	ZSh7bo+aYe04bu33GGeIiqeUNnB5WYPiY6eBhBBy8x/BGAzSAwAGOCUFzA9wxs4O
	mA1kqolWFfY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1AD5B38F81;
	Wed, 10 Sep 2014 17:31:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8CFD638F80;
	Wed, 10 Sep 2014 17:31:02 -0400 (EDT)
In-Reply-To: <xmqq7g1bgp5r.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 10 Sep 2014 14:07:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C39B2670-3931-11E4-B78C-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256769>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> This patch series introduces detailed checking of tag objects when calling
>> git fsck, and also when transfer.fsckobjects is set to true.
>>
>> To this end, the fsck machinery is reworked to accept the buffer and size
>> of the object to check, and for commit and tag objects, we verify that the
>> buffers contain an end of header (i.e. an empty line) to guarantee that our
>> checks do not run beyond the buffer.
>
> Overall they looked sensible and I am trying to queue them on 'pu'
> for today's pushout.
>
> Thanks.

I was expecting to see interesting interactions with the "oops, fsck
was not exiting with non-zero status in some cases" fix by Peff with
the patch 5/6 of this series that adds two new tests to t1450, but
because the breakage in these two cases are both only warning-events
and not error-events, I didn't prefix "git fsck" with test_must_fail
after all.

Are there some more serious kind of breakages that the new code
actually catches as errors which the new tests are not exercising?

The second test however did need the fix I mentioned in the review
to skip ident validation when we know the buffer does not point at a
potential ident to pass, though (see below, which is what I queued
on the tip of your series as a "SQUASH???" single fix-up patch).

Please do an equivalent in the individual patches that introduce
these buglets in a reroll (i.e. not like I did here, which was done
this way only because I needed to make sure that day's integration
result passes the test suite with minimum effort on my end ;-)).

Thanks.

 fsck.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fsck.c b/fsck.c
index 8341a30..6e6ea25 100644
--- a/fsck.c
+++ b/fsck.c
@@ -248,14 +248,14 @@ static int require_end_of_header(const void *data, unsigned long size,
 		switch (buffer[i]) {
 		case '\0':
 			return error_func(obj, FSCK_ERROR,
-				"invalid message: NUL at offset %d", i);
+				"invalid header: NUL at offset %d", i);
 		case '\n':
 			if (i + 1 < size && buffer[i + 1] == '\n')
 				return 0;
 		}
 	}
 
-	return error_func(obj, FSCK_ERROR, "invalid buffer: missing empty line");
+	return error_func(obj, FSCK_ERROR, "invalid buffer: missing end of header");
 }
 
 static int fsck_ident(const char **ident, struct object *obj, fsck_error error_func)
@@ -426,14 +426,16 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 		error_func(&tag->object, FSCK_WARN, "invalid 'tag' name: %s", buffer);
 	buffer = eol + 1;
 
-	if (!skip_prefix(buffer, "tagger ", &buffer)) {
+	if (!skip_prefix(buffer, "tagger ", &buffer))
 		/* early tags do not contain 'tagger' lines; warn only */
-		error_func(&tag->object, FSCK_WARN, "invalid format - expected 'tagger' line");
-	}
-	ret = fsck_ident(&buffer, &tag->object, error_func);
+		error_func(&tag->object, FSCK_WARN,
+			   "invalid format - expected 'tagger' line");
+	else
+		ret = fsck_ident(&buffer, &tag->object, error_func);
 
 done:
 	free(to_free);
+	strbuf_release(&sb);
 	return ret;
 }
 
-- 
2.1.0-451-g8daadf2
