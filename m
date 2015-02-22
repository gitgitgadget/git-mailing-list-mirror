From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] connect.c: allow ssh://user@[2001:db8::1]/repo.git
Date: Sun, 22 Feb 2015 11:37:40 -0800
Message-ID: <xmqqwq39vit7.fsf@gitster.dls.corp.google.com>
References: <54E8A9D0.30108@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, lists@hcf.yourweb.de,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Feb 22 20:39:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPcN0-0004s8-95
	for gcvg-git-2@plane.gmane.org; Sun, 22 Feb 2015 20:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbbBVThn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2015 14:37:43 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752006AbbBVThn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2015 14:37:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 130B33971E;
	Sun, 22 Feb 2015 14:37:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=edgI7/1MSaqa
	ve5cna4x0PCL/P0=; b=giIaxEcnfH/KSdW/G0ZvkzvBZPN012p9ksrfYhBjQfqq
	a5ZLy1K5eoru3FXI+222EfIIPVtwZz5fuLUg1oU8QlsGOW6BobIoSQ+jGpXENH9F
	Juhz73XqlOugO0AehWzMZJn8J9dzYEc8yr24x7oBX9WvjrArTAQXa6PNZoFPw6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hSyvMh
	do9WioUa+WyCVwqQOH7xdc6MXgyR2klg5G8lhb73eFfk5Wq7yRRK7TjqeCbAM0dj
	tQN+OLIOU+FU4YcLzD+kli/RK2ci9VNDpTESrp67mHLAWFN3NMwRyPw1G+BxjHhs
	csRRrL028ZpxgPor4UcBZQ9xEzaWU6ULAdWGU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 05E053971D;
	Sun, 22 Feb 2015 14:37:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6EE803971A;
	Sun, 22 Feb 2015 14:37:41 -0500 (EST)
In-Reply-To: <54E8A9D0.30108@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of
	"Sat, 21 Feb 2015 16:52:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 43FCAAAE-BACA-11E4-BB76-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264237>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The ssh:// syntax was added in 2386d65822c91, it accepted
> ssh://user@2001:db8::1/repo.git, which is now legacy.

Please do not quote just a raw object name, but annotate it so that
we can more easily tell what the change was about and how far back
in the history it was done without having to run "git show -s" on
it.

> Over the years the parser was improved to support [] and port numbers=
,
> but the combination of ssh://user@[2001:db8::1]:222/repo.git did
> never work.
>
> The only only way to use a user name, a literall IPV6 address and a p=
ort
> number was ssh://[user@2001:db8::1]:222/repo.git

Let me double check if I understand Brian and the above correctly:

 * The original 2386d658 (Add first cut at "git protocol" connect
   logic., 2005-07-13) did not even care that the IPv6 syntax was
   valid or not, and worse yet, it did not correctly handle literal
   addresses in brackets;

 * Later we started supporting literal addresses in brackets, but
   "user@[literal]:port" form did not work.  Instead, a bug in the
   parser allowed "[user@literal]:port" (which is not a valid way to
   spell such things) to work as if it were "user@[literal]:port",
   which is what users would expect.

 * This three-patch series is an attempt to allow that kosher
   syntax, "user@[literal]:port", to work.

 * It does not terribly matter if we broke the invalid syntax
   "user@literal:port" without brackets, and it might even be
   beneficial if we declared such addresses invalid and deprecated
   for the sake of uniformity with other protocols.  Making that
   judgement, however, is outside the scope of this series.
   "user@literal:port" will continue to behave as it did before.

Is that what is going on?

If that is the case, I think it addresses Brian's concern well.

Thanks.

(I haven't checked the patch text itself yet, though).
