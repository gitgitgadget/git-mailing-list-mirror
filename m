From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug?] checkout -m doesn't work without a base version
Date: Thu, 15 Dec 2011 09:36:03 -0800
Message-ID: <7v4nx1pwjg.fsf@alter.siamese.dyndns.org>
References: <4EDBF4D5.6030908@pcharlan.com>
 <7vbormn8vk.fsf@alter.siamese.dyndns.org> <4EE8782A.9040507@elegosoft.com>
 <7vhb13qbs6.fsf@alter.siamese.dyndns.org> <m2vcpiw1z1.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Schubert <mschub@elegosoft.com>,
	Pete Harlan <pgit@pcharlan.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 18:36:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbFE5-0004H6-3k
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 18:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759272Ab1LORgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 12:36:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59835 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759268Ab1LORgG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 12:36:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ECB4710D;
	Thu, 15 Dec 2011 12:36:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1u7Yz9lMXkAX9Sd0l2h1Nw1jwas=; b=O2QDMy
	lHWua0RudZLHMLYzJxH7Lm8/xNgpTnoj+9+qd89IBUY01ms3MdjVkMUTpPmVIZYd
	/7X8WPczCAYS8HGeQ8UZ8yxhTvp9ovVMewz3sjJR8zdX4YqJsBZ6M193QX5Jfo0T
	Dj7qjkU2VwMAnj2GJv7PNHrni92tpW3NJrEpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kg/L3gve1fHXC2bZwgXB+UKHCi0by0gb
	jPc1UpSBsSTiihW9v+2KCUOj7A4ID0heVuXjATNzNLn9QwVn103uq6jbbscOZLbr
	G7TciLkn8eNUseV3F8k4mtHXKTSUw9eX/eJ1QgnP+yJT7NldGXPIwxKjSotYD26L
	GOk+Ch+tMp0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93ED5710B;
	Thu, 15 Dec 2011 12:36:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0288D710A; Thu, 15 Dec 2011
 12:36:04 -0500 (EST)
In-Reply-To: <m2vcpiw1z1.fsf@igel.home> (Andreas Schwab's message of "Thu, 15
 Dec 2011 11:42:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 43B780A0-2743-11E1-A01F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187213>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> The variable "mode" is assigned to when we see an stage #2 entry in the
>> loop, and we should have updated threeway[1] immediately before doing so.
>> If threeway[1] is not updated, we would have already returned before using
>> the variable in make_cache_entry().
>
> How can you be sure that ce_stage(ce) ever returns 2?

You cannot and and there are cases where you exit the loop without finding
a stage #2 entry. But in that case threeway[1] stays 0{40} and control is
returned to the caller without ever getting to the place where the
variable is used.

You could do the usual "unnecessary initialization" trick, though.

 builtin/checkout.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 31aa248..064e7a1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -152,7 +152,7 @@ static int checkout_merged(int pos, struct checkout *state)
 	unsigned char sha1[20];
 	mmbuffer_t result_buf;
 	unsigned char threeway[3][20];
-	unsigned mode;
+	unsigned mode = 0;
 
 	memset(threeway, 0, sizeof(threeway));
 	while (pos < active_nr) {
