From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] verify_path: consider dos drive prefix
Date: Mon, 06 Jun 2011 20:46:39 -0700
Message-ID: <7v39jm8fs0.fsf@alter.siamese.dyndns.org>
References: <1306512040-1468-1-git-send-email-kusmabite@gmail.com>
 <1306512040-1468-4-git-send-email-kusmabite@gmail.com>
 <4DDFF473.7030104@kdbg.org>
 <BANLkTikdeq7cuhi0uo7Q6wqDJK3nxjmP-g@mail.gmail.com>
 <C8718F35FD1A4C3C84A4D353D27621E0@martinic.local>
 <BANLkTi=o6p=E4bM+CG77yKrFFvQ8sBS07g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theo Niessink <theo@taletn.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, johannes.schindelin@gmx.de
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 07 05:47:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTnFt-0005zd-MM
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 05:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209Ab1FGDqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 23:46:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42735 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658Ab1FGDqy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 23:46:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D259A5DDA;
	Mon,  6 Jun 2011 23:49:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kiNY8KTAQrfw49F5b6m+L8ESER8=; b=hedIXL
	uxdEie8f7s5f0GozYLdYvRnCUkOl9oGMocOux/Vg0vivX02xV/+eVScqTgM5c2yQ
	ykPXcLp/p1poKInpXKvuyXbeiU2TCw30Ji3QwMWjIjFvJfu6yQkqqNWOzT1msXxB
	u7Lt+UFyxJk15MunhWF1KYxYmDBQu0G7y3msI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j33myzk4cM8ywQ5hnZ6ekjDWmmbZsqlZ
	wMLfiphch64aQD7+Xkgzekr8s69fkL+9cydMYGAkGCm581ceNL5fx34+J+7J+QrA
	YjOU4wMU6VVIc2CKQrnBhcdxSkUcon6pJ/O2F+qkFHv5mkWfXWiZfprP42lV96y4
	5IrYgZK81WU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B2145DD6;
	Mon,  6 Jun 2011 23:48:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A9B0B5DD1; Mon,  6 Jun 2011
 23:48:50 -0400 (EDT)
In-Reply-To: <BANLkTi=o6p=E4bM+CG77yKrFFvQ8sBS07g@mail.gmail.com> (Erik
 Faye-Lund's message of "Mon, 30 May 2011 13:17:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 126965F2-90B9-11E0-AEF9-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175182>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>> Nitpick: If you already know that c != '\0' and !is_dir_sep(c), then why do
>> continue? It will check for '\0' and is_dir_sep(c) again, but you already
>> know that both ifs will be false. So you could just as easy jump straight to
>> c = *path++, which IMHO also makes the code easier to follow:
>
> Very good point, thanks for noticing. I just rewrote the logic from
> switch/case to if/else, but with the rewrite these redundant compares
> became more obvious. I think your version is better, indeed.

Let's not add an unnecessary goto while at it.  How about this on top
instead?

 read-cache.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 31cf0b5..3593291 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -784,16 +784,9 @@ int verify_path(const char *path)
 		if (is_dir_sep(c)) {
 inside:
 			c = *path++;
-			switch (c) {
-			default:
-				continue;
-			case '/': case '\0':
-				break;
-			case '.':
-				if (verify_dotfile(path))
-					continue;
-			}
-			return 0;
+			if ((c == '.' && !verify_dotfile(path)) ||
+			    is_dir_sep(c) || c == '\0')
+				return 0;
 		}
 		c = *path++;
 	}
