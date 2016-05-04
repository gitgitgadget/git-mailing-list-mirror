From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/14] connect: rewrite feature parsing to work on string_list
Date: Wed, 04 May 2016 13:13:42 -0700
Message-ID: <xmqqr3dhfuo9.fsf@gitster.mtv.corp.google.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
	<1461972887-22100-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: dturner@twopensource.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 04 22:13:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay3B8-0001b9-Pn
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 22:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbcEDUNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 16:13:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752698AbcEDUNq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 16:13:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A0201805D;
	Wed,  4 May 2016 16:13:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HJse5M7NUPG5+IIBeOz0A/wEdmo=; b=esna7F
	BwKvt/xgbpu9ytyCpSAWin6WOM7+Vd8UkpT4Thd2l4OHHWEg5wz+M3ZQlkz3mwVu
	WdtKB7DASv1ORjnNkST4muC+t0koRjlafbymvkiFIE2YOcAbmYY2dylYnEjs8tZG
	WKvMhQH1hoa2BdjhCexkFSx7gjYKNHanKbI9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rLjc4wgpblk2MWcl/gzKnbUJYCOWvM6T
	5th+kYARHM+z/Mv+roP4Y0n1yB8yFePCbhpRq35KX+PjHxKgfkRL6XlJgbUUcQGm
	9CJ0PgA4pysyTB/Wq71hd4l+K67wWkouz8MGxcDFFXNmrOX5I9ovBRZ//R2nkGbw
	G2RlBgfRVZI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 013521805C;
	Wed,  4 May 2016 16:13:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7DF7718059;
	Wed,  4 May 2016 16:13:44 -0400 (EDT)
In-Reply-To: <1461972887-22100-5-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 29 Apr 2016 16:34:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B3C95EE6-1234-11E6-A6C4-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293582>

Stefan Beller <sbeller@google.com> writes:

> Later on when we introduce the version 2 transport protocol, the
> capabilities will not be transported in one lone string but each

s/lone/long/, I think.

> capability will be carried in its own pkt line.
>
> To reuse existing infrastructure we would either need to join the
> capabilities into a single string again later or refactor the current
> capability parsing to be using a data structure which fits both
> versions of the transport protocol. We chose to implement the later.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/receive-pack.c | 15 ++++++---
>  connect.c              | 82 +++++++++++++++++++++++---------------------------
>  connect.h              |  2 +-
>  upload-pack.c          | 13 ++++++--
>  4 files changed, 58 insertions(+), 54 deletions(-)

I am not sure if the churn is make a right tradeoff here.

A loop to concatenate each segment into a strbuf before passing it
to parse_feature_request would be at most 5 lines long, no?
