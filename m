From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] remote-testsvn.c: Avoid the getline() GNU extension
 function
Date: Sun, 26 Aug 2012 10:31:04 -0700
Message-ID: <7v3939wofb.fsf@alter.siamese.dyndns.org>
References: <503907B3.9040101@ramsay1.demon.co.uk>
 <CABPQNSZfUO-vjVmBU2+CMbxTXMj_HT=cTFfVbnehUjqOL-vkxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	florian.achleitner.2.6.31@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sun Aug 26 19:31:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5ggj-0007O1-8E
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 19:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375Ab2HZRbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Aug 2012 13:31:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63458 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948Ab2HZRbG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2012 13:31:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C11583B9;
	Sun, 26 Aug 2012 13:31:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ztSNz+ib+JOQ37FRcBeMvdqZMF4=; b=H5Qx9k
	yG5F03xJtNA1enNh3vjIBtU6hNXahAOMIZbjrgzNzNW86DWT7PhcGwSpcs10NLK8
	tD4H53tUX91LyHN8FdItGnrazGDszGuvLzr6HBJnKwIuJjOtR2aC5rZNSkSbxI1n
	qr6v0ja1SZ1MvfQinuueiHb+BUFV/DOdeNyNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l5IxLgNusYReku9wTp/G2RBeuJSCkCRn
	nDqq5e7zQyJdG0nbIu2u3AFpzvGx1HOL8Lw70PzQnyOQmxAt7xCp7M0sc6d9X9zO
	f0jCT6GA2Xin4hFc4xsjOSDR723qC1lsMXECtOu5uxZMnklwhB5Us4jthhEBkI6J
	/v8F1UnBwwU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28B6A83B8;
	Sun, 26 Aug 2012 13:31:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B3C883B6; Sun, 26 Aug 2012
 13:31:05 -0400 (EDT)
In-Reply-To: <CABPQNSZfUO-vjVmBU2+CMbxTXMj_HT=cTFfVbnehUjqOL-vkxw@mail.gmail.com> (Erik
 Faye-Lund's message of "Sat, 25 Aug 2012 21:20:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0926066-EFA3-11E1-9EEA-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204300>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Sat, Aug 25, 2012 at 7:13 PM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>>
>> The getline() function is a GNU extension (you need to define
>> _GNU_SOURCE before including stdio.h) and is, therefore, not
>> portable. In particular, getline() is not available on MinGW.
>
> Actually, getline is a POSIX-2008 feature, so it's not (simply) a GNU extension:
>
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/getline.html

True, thanks for pointing it out.  Justify the change with something
like this instead, perhaps?

	The getline() function, even though is in POSIX.1-2008, is
	not available on some platforms.  Use strbuf_getline() for
	portability.

By the way, the remainder of the proposed log message talks about
the difference between getline() that keeps the terminating LF vs
strbuf_getline() that drops it.  Would strbuf_getwholeline() be a
better alternative?
