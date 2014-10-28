From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/15] refs.c: update rename_ref to use a transaction
Date: Tue, 28 Oct 2014 14:12:49 -0700
Message-ID: <xmqqh9ynkiem.fsf@gitster.dls.corp.google.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
	<1413923820-14457-6-git-send-email-sahlberg@google.com>
	<xmqqppdcj9m9.fsf@gitster.dls.corp.google.com>
	<xmqqlho0j7dq.fsf@gitster.dls.corp.google.com>
	<CAL=YDWm05PyO07HbiOTiweh+3AEvXnbptbzoreLw-b9YUrm-Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 22:40:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjEVZ-00033G-4o
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 22:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbaJ1Vks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 17:40:48 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932227AbaJ1Vkr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 17:40:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 540CA1AB6F;
	Tue, 28 Oct 2014 17:40:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TNkdauoofKPxgQkj8b+xYuMh3WA=; b=tSV2IK
	UEvZw45lYB5VExDjZfaXDvgHUEFZfGeadea0NV1mp7elndYhFf/Y8hz2OTmwJTim
	NwuFO/TVggD6BciIZn/ItaRE1SNStwg+mtJHNoB2P5YTJQ/mKBffIRZv1icouSxZ
	VZMz92FL5NUl6wN+0r11QljgKNNpQBH+kOuHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cc2TiAPXIzqS/Q8uC+vH6+0VroqruxV5
	rVpQROoAloVNV9rymQH5zZZ5yM3/+B5YCJXwRsmWKYVQjySNNbwJj7S5JaUGG63K
	GF66SdIslajkD4Xvc7s7XiDBS/ps474um4AbuKJSEFnVLvkQiIS6ut6GvSi5Ed4H
	j/hjd2JRw/I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4AEB51AB6D;
	Tue, 28 Oct 2014 17:40:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CBB4F1A55E;
	Tue, 28 Oct 2014 17:12:50 -0400 (EDT)
In-Reply-To: <CAL=YDWm05PyO07HbiOTiweh+3AEvXnbptbzoreLw-b9YUrm-Hg@mail.gmail.com>
	(Ronnie Sahlberg's message of "Tue, 28 Oct 2014 13:56:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2CB4CCA8-5EE7-11E4-870D-527C6E758C04-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ronnie Sahlberg <sahlberg@google.com> writes:

> I timed a git branch -m for a branch with ~2400 log entries and it
> takes neglible time :
>   real 0m0.008s
>   user 0m0.000s
>   sys 0m0.007s

I really hate this line of reasoning.  Small things tend to add up.

More importantly, when you know that the end result you want to see
is that the old and new log files are bit-for-bit identical, and if
not there is some bug in either parsing or formatting, why parse the
old and reformat into the new?  What would happen when there were
malformed entries in the old that makes your parsing fail?
