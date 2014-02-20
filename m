From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 24/25] prune: strategies for linked checkouts
Date: Thu, 20 Feb 2014 11:55:39 -0800
Message-ID: <xmqqd2ih5zk4.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-25-git-send-email-pclouds@gmail.com>
	<xmqq38je9739.fsf@gitster.dls.corp.google.com>
	<CACsJy8B11ZjLgLiE=S1sqZ09z2GtbwGfdJRuQ0AC_ppnQsQvcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 20:55:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGZim-0007pp-M2
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 20:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382AbaBTTzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 14:55:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49426 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412AbaBTTzn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 14:55:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1ABBA6EC84;
	Thu, 20 Feb 2014 14:55:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y25wlSIz/GsdkbqaF6kINq6r7Cc=; b=Sanf4N
	zEzHY9qjZ3FQ1KoMhzwyAY6IbRinwv65/C35Op9rC5A6zOskbgq/8A0tSwQF9bYV
	lLQXYzM50eg4qx3w2t9HChxZN+dwK6dkVv2FYqPzboy3fJw4mYxzZmXm9AwcO3ad
	//n1wDCWZcaMDI/gyUYf9WeNKWdQubezH8OwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EoysLEJ90oL1D4JdrOC+p6T59kQyRzWM
	3ojueBZEsM1DBeLaNyRS8oWsqLvQYpQY3CEacHKwA7jTB73+AwHa2ygazzESfEN/
	OvsPFa66xSDS/cio7jt6YbAUzMGmhdEmMAWemc5IK++iTa0zn3p00Txp0vfs2h/D
	WwUESNjt4ng=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06F096EC83;
	Thu, 20 Feb 2014 14:55:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2039F6EC7E;
	Thu, 20 Feb 2014 14:55:42 -0500 (EST)
In-Reply-To: <CACsJy8B11ZjLgLiE=S1sqZ09z2GtbwGfdJRuQ0AC_ppnQsQvcQ@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 20 Feb 2014 20:15:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FA830C7E-9A68-11E3-A43B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242445>

Duy Nguyen <pclouds@gmail.com> writes:

>> But why is it OK to fail in the first place?  If we couldn't link,
>> don't you want to fall back to the lock codepath?  After all, the
>> "are we on the same device?" check is to cope with the case where
>> we cannot link and that alternate codepath is supposed to be
>> prepared to handle the "ah, we cannot link" case correctly, no?
>
> Filesystems not supporting hardlinks are one reason. The idea behind
> "locked" is that the new checkout could be on a portable device and we
> don't want to prune its metadata just because the device is not
> plugged in. Checking same device help but even that can't guarantee no
> false positives, unless your only mount point is /. So no I don't
> really think we should go lock whenever link() fails, that would just
> make fewer checkouts prunable.

It just looked wrong to have a logic that goes like this:

        if (we detect one case link() can never possibly work) {
                do something for a case we do not use link;
        } else {
                prepare parameters that is used when we do link;
                do link() but ignore error;
        }

and felt that I would have understood if it were more like this:

        prepare parameters that is used when we do link;
        if (try link() and it fails) {
                do something for a case we do not use link;
        }

but I did not mean that was the only alternative to correct the
"wrongness".

I do not think I yet know the motivation behind this step well
enough to further comment---until I read the earlier parts of the
series that lead to this step, so I'll do that first.

Thanks.
