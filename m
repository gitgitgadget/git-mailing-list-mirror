From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/15] refs.c: update rename_ref to use a transaction
Date: Wed, 29 Oct 2014 11:43:09 -0700
Message-ID: <xmqqtx2myawy.fsf@gitster.dls.corp.google.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
	<1413923820-14457-6-git-send-email-sahlberg@google.com>
	<xmqqppdcj9m9.fsf@gitster.dls.corp.google.com>
	<xmqqlho0j7dq.fsf@gitster.dls.corp.google.com>
	<CAL=YDWm05PyO07HbiOTiweh+3AEvXnbptbzoreLw-b9YUrm-Hg@mail.gmail.com>
	<xmqqh9ynkiem.fsf@gitster.dls.corp.google.com>
	<CAL=YDWkOZ29+ikXJUzhZqW8-Mk91Z_E1QCiXxT1HZ1oj04pk0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 19:43:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjYDG-00070f-3p
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 19:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbaJ2SnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 14:43:14 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62205 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751226AbaJ2SnN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 14:43:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C49781985C;
	Wed, 29 Oct 2014 14:43:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gnddFX9ENJuWegg/mZnYbAaNG9o=; b=RwDX5z
	oo07Q3RBtBF1/pZaQIt6qoYSaSC1yN2yIp5V1BJ9OAFATAWOQzJGBtzkI7r0/XPy
	eBIP343IZxqEV10nzvmZEgzyoNmct6mEw7Hsfq705vbK688fW9sNNKqyYzZ2ZwQJ
	QqH0pZ+xsKJuj0f8apFZnSFR8epl2gh97ys2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W/gqvwyMH6OXhfNhzDysqKeCr55b55Wl
	vqaJWedrgWCc9sT4uMYH6sYOjxehjjY1IxZMBfZMPp+ut9D7YE2z6ZsnRzhzzcDi
	qbP27bOSWM7tTFeiYG8DEO0WO+fxFTZZ3zZO92/5uzUKAk3WmeY/yBfc7zC9g/XQ
	hI4oTz9v1dY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB01C1985B;
	Wed, 29 Oct 2014 14:43:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1AF651985A;
	Wed, 29 Oct 2014 14:43:11 -0400 (EDT)
In-Reply-To: <CAL=YDWkOZ29+ikXJUzhZqW8-Mk91Z_E1QCiXxT1HZ1oj04pk0w@mail.gmail.com>
	(Ronnie Sahlberg's message of "Wed, 29 Oct 2014 10:18:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6EC94632-5F9B-11E4-81A9-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ronnie Sahlberg <sahlberg@google.com> writes:

> On Tue, Oct 28, 2014 at 2:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> More importantly, when you know that the end result you want to see
>> is that the old and new log files are bit-for-bit identical, and if
>> not there is some bug in either parsing or formatting, why parse the
>> old and reformat into the new?  What would happen when there were
>> malformed entries in the old that makes your parsing fail?
>>
>
> Fair enough. I will change it to ONLY use a transaction for the actual
> ref update and keep using rename() for the reflog handling.
> Only real change I will do for the reflog handling is to change the
> temporary file name used to be less collission prone if there are two
> renames happening at the same time
> so that they don't destroy each others reflogs.

I think it is a good idea to make renaming the entire reflog a
logical element of transaction (as you mentioned in our private
discussion) to allow different backends implement in their best
efficient & robust way.

And for filesystem-backed backends, I actually think "keep the
original until we know we do not have to roll back", that follows
the same pattern for the other transactional updates, is a good
implementation of that "best efficient & robust way", compared to
the original "just rename it".  It frees us from having to be
worried about what happens if we cannot rename it back.

Thanks.
