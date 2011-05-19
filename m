From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat: add a getpass() compatibility function
Date: Thu, 19 May 2011 10:27:39 -0700
Message-ID: <7v62p68ut0.fsf@alter.siamese.dyndns.org>
References: <563395AE-A3E5-45FF-9063-F807C2CE3AD0@gieschke.de>
 <BANLkTinPHeSfZXRb7pqt7-XWkR5fH=wAjg@mail.gmail.com>
 <EC81F772-7149-40A0-891A-973C886AB052@gieschke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rafael Gieschke <rafael@gieschke.de>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 19:27:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN70t-00033l-4V
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 19:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933669Ab1ESR1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 13:27:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53234 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933494Ab1ESR1t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 13:27:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 18F8255A6;
	Thu, 19 May 2011 13:29:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/eLFx9G/+nq8DpTxe+iPRCNcadA=; b=aOvdux
	88iGi24MPqHVOtw7lqLUNAV0ujwR0C3ihemHLl6QENnIRoOcGVeA7SNISSVrg1hB
	WzBYOHiFv3KQ/ynEXDEAkWBwzl+Ro1WUGFXBY24FLmnIvxSCXR2uke+ndiDjT4Kv
	RzxZsVH/v65N5jE6tk/uYtaMKAn1rQoEAyUhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xl6I18OwvgFy5CUuOl8aVvdQVa+AG+x8
	3suMGzkyfUzdTA/UjUYGuTmMyjBI/RKZnbVX4xcK3VC1uw5xWnZGnUawjbMTiixx
	AbiyOtnIqUzrJql29T0i9FngQ4EOHSZxANGGWYbx5Uwy6WH0rPQMVz53b4ndxxRU
	eoeVcDOYT7w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DAC8355A4;
	Thu, 19 May 2011 13:29:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CE0C7559F; Thu, 19 May 2011
 13:29:47 -0400 (EDT)
In-Reply-To: <EC81F772-7149-40A0-891A-973C886AB052@gieschke.de> (Rafael
 Gieschke's message of "Thu, 19 May 2011 19:01:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9A83BADA-823D-11E0-B0F3-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173973>

Rafael Gieschke <rafael@gieschke.de> writes:

>> Windows doesn't have /dev/tty, but the logic in this version handles
>> that by using stdin/stderr instead. The signal-stuff has a comment
>> that indicates it might not even be correct. tcgetattr/tcsetattr isn't
>> supported on Windows, but it's not needed if we use getch (as the
>> version in compat/mingw.c does). POSIX/curses getch respects the
>> echo-setting, while Windows getch never echo.

Probably a properly abstracted common version would look like a function
that calls four platform-dependent helper funcions in this order:

	0. prompt
	1. start "noecho" mode
        2. get whole line
        3. exit "noecho" mode

where Windows may use stderr for 0, have noop() implementation for 1 and
3, use _getch() that does not echo for 2, while POSIX may write to
/dev/tty for 0, use tc[gs]etattr() with perhaps some signal settings
sprinkled in for 1 and 3.

So I don't see a need for Windows to emulate tc[g]setattr nor curses in
order to get a generic getpass() abstraction between two platforms.
