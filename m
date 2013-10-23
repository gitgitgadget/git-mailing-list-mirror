From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clear fd after closing to avoid double-close error
Date: Wed, 23 Oct 2013 09:06:53 -0700
Message-ID: <xmqqvc0oq8de.fsf@gitster.dls.corp.google.com>
References: <1382443823-31317-1-git-send-email-jl@opera.com>
	<CACsJy8DtvaojrrQr4=uYCRse7N+SXb+WdjY+C_0FRSjYsNC6zg@mail.gmail.com>
	<xmqq8uxltaeh.fsf@gitster.dls.corp.google.com>
	<CAEef6Wyui5EkNoEGKfb+NHZyb3BTkHME234M1zMyjuux5yMUeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens =?utf-8?Q?Lindstr=C3=B6m?= <jl@opera.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 18:07:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0xZ-0003xX-B0
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 18:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808Ab3JWQG5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Oct 2013 12:06:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56447 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977Ab3JWQG4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 12:06:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18ED24D2F6;
	Wed, 23 Oct 2013 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kKrMMaTJEx1A
	L2RX9TLyqVLlmZQ=; b=lVJSvdpR7rhHSQurbQkY9h7VVUMq6+q2bvFwZiJoN7Je
	QCFYjr4GkLEv63EEA1LrdHVKc9k9GcHpyxi10n4QLvDyt+XCtkJu/aNP4lx8/KbX
	94LWE+3GOhcTD2pJkBWj3Rk79woaRMoDTXyxJuBn5CVsKWfofsSo8qLScwJk3FQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HsOzaD
	l7cx64HI9XAXT1YOH9/avEBF1cqHFc+NzR0Wtd1u8NntGuUdqHytV5Pphsyz8EBF
	4qKiWXihxT79BxuNDsMejNpHdi04xoTkJpkfBg1nfHve5nUkFQzQhHHSffHCKw+K
	u1XTU6l8V+4HN3AZjVipLQFujw0E6C+Xyw/+k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DCFB4D2F5;
	Wed, 23 Oct 2013 16:06:56 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 672284D2F2;
	Wed, 23 Oct 2013 16:06:55 +0000 (UTC)
In-Reply-To: <CAEef6Wyui5EkNoEGKfb+NHZyb3BTkHME234M1zMyjuux5yMUeg@mail.gmail.com>
	("Jens =?utf-8?Q?Lindstr=C3=B6m=22's?= message of "Wed, 23 Oct 2013
 09:52:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 232F0A4E-3BFD-11E3-9FCA-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236533>

Jens Lindstr=C3=B6m <jl@opera.com> writes:

> On Tue, Oct 22, 2013 at 8:42 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>
>>> Life would have been simpler if fd[1] was _always_ closed by
>>> send_pack(), like in c20181e (start_command(), if .in/.out > 0, clo=
ses
>>> file descriptors, not the callers - 2008-02-21).
>>
>> Yeah, that was also my first reaction when I saw the above three
>> lines after reading the discussion that led to the diagnosis.
>
> If send_pack() always closes fd[1], then I believe "git send-pack
> --stateless-rpc --helper-status" would die in print_helper_status(),
> called after send_pack(), since fd[1] would be 1, to which
> print_helper_status() will try to write.

Ah, I obviously did not look far enough.  Of course we could dup(2)
the fd=3D1 to code it around, but it is not clear to me if it is worth
it---your solution (v2) is clearer, so let's queue it with Acks we
saw from Peff and Duy.

Thanks.
