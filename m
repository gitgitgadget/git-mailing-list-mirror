From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 01/48] builtin/apply: avoid parameter shadowing 'p_value' global
Date: Wed, 09 Mar 2016 15:27:14 -0800
Message-ID: <xmqqlh5rfd0t.fsf@gitster.mtv.corp.google.com>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
	<1457545756-20616-2-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 00:27:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adnVp-0008Eo-CE
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 00:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbcCIX1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 18:27:24 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61062 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965087AbcCIX1R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 18:27:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 625594A82D;
	Wed,  9 Mar 2016 18:27:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jBbQ0r4oHqEboecpp16pLu1DZGM=; b=nkFGuI
	MmK+VUs7bKkvZ80dp/uuHNhi6oID74Yn2NEgGYpfmwNawmUyEX354/QW3wgzUVhm
	FDae9SI3CP/LESk1eYNhZNAOr04dgCYnxG09SLMsRQvE10xftzGEGn7LWS91KMHE
	taW8XJhle90ISOFsV2Uie0HOurXtHK8pfqa70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=URs+RwXphTe8XKMzDmfx9bQ8UVqVfP5G
	Go4chJkidWGopbrrf6uPThtXi5mru4iRA7DjAqB+XVzVHHXNX7W58Q66sZNXs33A
	3c95l/ukjyOhAFbR0T1MXkLHxlxyqLzKcjXnbOo54y376gEasGKb0UJLUfmuDifK
	MkB2p2o5RUc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 58F684A82C;
	Wed,  9 Mar 2016 18:27:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C42054A82B;
	Wed,  9 Mar 2016 18:27:15 -0500 (EST)
In-Reply-To: <1457545756-20616-2-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Wed, 9 Mar 2016 18:48:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 758F6B78-E64E-11E5-B514-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288583>

Christian Couder <christian.couder@gmail.com> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/apply.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

To be honest, I have to say that I do not like this change from
readability's point of view.  Once the global p_value becomes a
field in a "apply state" structure, functions will get a pointer to
the struct as a parameter, reference to it would be spelled as
"astate->p_value", while a local variable or a parameter would be
"p_value" and there is no shadowing issue.

Also, you wouldn't be able to catch a misconversion in this patch
only from the patch text, if the conversion is done this way, would
you?  The patch may change the parameter p_value to p_v, and change
two references to p_value also to p_v, but it may leave another
reference to p_value that originally referred to the parameter
as-is, making it refer to the global, which would be a new bug
introduced by this conversion patch, but that remaining reference
would not show up in the patch.
