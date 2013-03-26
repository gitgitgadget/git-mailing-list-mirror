From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] stream_blob_to_fd: detect errors reading from stream
Date: Tue, 26 Mar 2013 14:27:19 -0700
Message-ID: <7v38vhua14.fsf@alter.siamese.dyndns.org>
References: <20130325201427.GA15798@sigill.intra.peff.net>
 <20130325201650.GA16019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 22:28:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKbPR-0003yG-Kf
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 22:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052Ab3CZV10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 17:27:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35589 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822Ab3CZV1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 17:27:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5A55BC83;
	Tue, 26 Mar 2013 17:27:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3j3E6EMoQWHJIJLBnQAy3Ag2wsw=; b=c7fjaP
	smqixVB6zqBQX1EZ+BuN1qn62blevd/Ws4PBQ2A5e3SHuobhfbk7CRXMnhhFtQoY
	KCvhp/SGN7yHq39MPz7WGP6Eq2tuKj/ZCD+j6dzpGLJVOW+dsM18QReaN4g9a7gj
	UqFUJmlOgtNcuPUe/InxY92CzInr70QHDH2OA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CvptQFKqVYSkdJsj8lKxVvEPypxD2G23
	buNIblreLOTaQo6Hohc1tMSAoaA57cr4VTLupYyXADstcg53B0hktaDnK5UyxAtJ
	HmmerUOCntdGwtWpU9xyqAmnxjAAk/EfLHqXT2ve/RubRZuNy0ivrec+kZMrYFCU
	fr4VyKai9uE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9359BC81;
	Tue, 26 Mar 2013 17:27:21 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CBA6BC7D; Tue, 26 Mar 2013
 17:27:21 -0400 (EDT)
In-Reply-To: <20130325201650.GA16019@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 25 Mar 2013 16:16:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F182248C-965B-11E2-B6BB-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219210>

Jeff King <peff@peff.net> writes:

> We call read_istream, but never check its return value for
> errors. This can lead to us looping infinitely, as we just
> keep trying to write "-1" bytes (and we do not notice the
> error, as we simply check that write_in_full reports the
> same number of bytes we fed it, which of course is also -1).

Looks sane.  Thanks.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> No test yet, as my method for triggering this causes _another_ infinite
> loop. So the test comes after the fixes, to avoid infinite loops when
> bisecting the history later. :)
>
>  streaming.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/streaming.c b/streaming.c
> index 4d978e5..f4126a7 100644
> --- a/streaming.c
> +++ b/streaming.c
> @@ -514,6 +514,8 @@ int stream_blob_to_fd(int fd, unsigned const char *sha1, struct stream_filter *f
>  		ssize_t wrote, holeto;
>  		ssize_t readlen = read_istream(st, buf, sizeof(buf));
>  
> +		if (readlen < 0)
> +			goto close_and_exit;
>  		if (!readlen)
>  			break;
>  		if (can_seek && sizeof(buf) == readlen) {
