From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: ask about and declare 8bit mails
Date: Sat, 12 Jun 2010 09:28:19 -0700
Message-ID: <7vljakfc64.fsf@alter.siamese.dyndns.org>
References: <201006121211.12870.trast@student.ethz.ch>
 <cebe57bb68b5e8ea445e560bbe6305c915ce8a1c.1276354971.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jun 12 18:28:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONTZU-0003zh-5N
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 18:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888Ab0FLQ2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 12:28:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab0FLQ2a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 12:28:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D559BBF1E;
	Sat, 12 Jun 2010 12:28:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5fjaJL+O8Qv2K2WzcGc9KhqHw4k=; b=XNv07o
	A6JOEmrvd8j7BvCw7QMk0rjYh78upQfMM+pvJDB8mXO8bX674xKSObnRcXbZrK5q
	Y8QhkQDWmbwTwsx4+Nd7uL0hnpExijcTUHViOanVykrTpu1CpR6fFuO8vNtarOvU
	FKuK+LhZ/8+UZodW2Xn9qBVwkPa6qFHhmRKaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aY2+z9CJRwu2ad3pO8sCrrJS8F2WlnxD
	AlE7cWR4iqnhG6U/P5YUJBIeuCtnAdCY3EyNUdhymnoqvfWZtwn0yjI3U7yK6BxM
	erXW/H2GOndpdVHXK4LFqH9jY0EEEz5DMtD5D91euU4VstdG8LKmqoNglWxIv/NP
	Wu5oCCP1gdo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4928FBBF1B;
	Sat, 12 Jun 2010 12:28:25 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 992A4BBF19; Sat, 12 Jun
 2010 12:28:21 -0400 (EDT)
In-Reply-To: <cebe57bb68b5e8ea445e560bbe6305c915ce8a1c.1276354971.git.trast@student.ethz.ch> (Thomas Rast's message of "Sat\, 12 Jun 2010 17\:06\:20 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 864E603E-763F-11DF-89BC-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149014>

Thomas Rast <trast@student.ethz.ch> writes:

> git-send-email passes on an 8bit mail as-is even if it does not
> declare a content-type.  Because the user can edit email between
> format-patch and send-email, such invalid mails are unfortunately not
> very hard to come by.
>
> Make git-send-email stop and ask about the encoding to use if it
> encounters any such mail.  Also provide a configuration setting to
> permanently configure an encoding.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> This takes care of what I ran into earlier today.  However, there's
> another problem: format-patch doesn't even mark the patch 8bit if its
> patch contents (not log message) are non-ASCII.  I'm really not sure
> what to do there.

A project won't have uniform file encoding anyway, so even if we were to
do something clever about this, it has to be per-patch.  Perhaps

 (0) use the attributes mechanism to allow projects to mark paths with
     encoding.  E.g.

	# everything in UTF-8 unless otherwise specified...
        * encoding=UTF-8
        Documentation/zh_CN/* encoding=big5

 (1) for each patch, find the paths involved, and if their encodings are
     the same, perhaps promote that as the encoding used for the entire
     message;

 (2) otherwise, if there is an 8-bit encoding involved in the paths,
     perhaps mark the entire message as 8-bit (binary???).

I have this suspicion that (2) is very rare (you cannot transmit such a
patch as a plain text message reliably afaict, so it is not done in
practice), and we would probably need to make a separate patchfile for
groups of paths in each encoding and attach them as MIME multiparts (ugh).

Just thinkning aloud, before morning caffeine sinks in, so please take
this with a grain of salt...
