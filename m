From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/15] sequencer: use logmsg_reencode in get_message
Date: Tue, 10 Jun 2014 14:40:30 -0700
Message-ID: <xmqq7g4o8mup.fsf@gitster.dls.corp.google.com>
References: <20140609180236.GA24644@sigill.intra.peff.net>
	<20140609181039.GE20315@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 10 23:40:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuTmb-0005A0-9a
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbaFJVkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:40:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57956 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753720AbaFJVkh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:40:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3C8881F17F;
	Tue, 10 Jun 2014 17:40:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BAR9nXkujvMrWUvh/2DS3VLfvm0=; b=Y5ZXCo
	cnPVzlJD0Ss8MhFAzpLrvvRFihe6zpBHouVh447Q/nCs4ImCKemxtETlczOziEKI
	6stlm4B7uFquVXfdAIzQTc1ghVVI/O3EaLHaue+3zxmG7Y8ON/FULoSxlDFIJ/B9
	kHsXWDpe52pHeeUYbUlnayM+su5CnrFQu4Sf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tp4qJLFxaBThY3fCR6jpskpkdRkwDdJ5
	bC4tLw0W4JPOMyJw8ejBevhAmDls2q4oqP1Gvz/sCoRsaHyMgbbWRvOSGKhpAHi5
	y1JCRgtCiZ4Pdvkc0Vv9erLaIYFJrhtO+BoqS3ZemkuuyEBu1cBycDKKhck7KNtR
	4TcZmArrSxw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 331C71F17E;
	Tue, 10 Jun 2014 17:40:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1CFE01F177;
	Tue, 10 Jun 2014 17:40:32 -0400 (EDT)
In-Reply-To: <20140609181039.GE20315@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 9 Jun 2014 14:10:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D9140720-F0E7-11E3-A369-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251253>

Jeff King <peff@peff.net> writes:

> Note that we may be fixing a bug here. The existing code
> does:
>
>   if (same_encoding(to, from))
> 	  reencode_string(buf, to, from);
>
> That probably should have been "!same_encoding".
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I didn't actually test for the bug, so it's possible that I'm missing
> something clever...

Thanks for spotting.  There is nothing clever going on.

0e18bcd5 (reencode_string(): introduce and use same_encoding(),
2012-10-18) has this misconversion.

diff --git a/sequencer.c b/sequencer.c
index bd62680..f2f5b13 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -58,7 +58,7 @@ static int get_message(struct commit *commit, struct commit_message *out)
 
 	out->reencoded_message = NULL;
 	out->message = commit->buffer;
-	if (strcmp(encoding, git_commit_encoding))
+	if (same_encoding(encoding, git_commit_encoding))
 		out->reencoded_message = reencode_string(commit->buffer,
 					git_commit_encoding, encoding);
 	if (out->reencoded_message)
