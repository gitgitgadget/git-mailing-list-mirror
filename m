From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 10/10] ce_compare_data() did not respect conversion
Date: Fri, 06 May 2016 10:11:57 -0700
Message-ID: <xmqq4mab5cwy.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1461942126-16296-1-git-send-email-tboegi@web.de>
	<xmqqvb30w29z.fsf@gitster.mtv.corp.google.com>
	<a571e222-68db-3dc1-1a94-d6b47feaf84d@web.de>
	<xmqqtwigtjfg.fsf@gitster.mtv.corp.google.com>
	<xmqqpot4s1ap.fsf@gitster.mtv.corp.google.com>
	<55d60bb1-8626-4c97-630c-1a9f114c46b4@web.de>
	<xmqqbn4nngci.fsf@gitster.mtv.corp.google.com>
	<57297579.6060805@web.de>
	<xmqqfutyjnhh.fsf@gitster.mtv.corp.google.com>
	<e33e0b87-caa1-84a3-7c5c-8938e0c78a77@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri May 06 19:12:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayjIM-0003hd-5p
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 19:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758171AbcEFRMB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2016 13:12:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758091AbcEFRMA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 13:12:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7189E18F78;
	Fri,  6 May 2016 13:11:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HDFBhQzpvSIL
	r8CoriCvVc4HXBM=; b=sploDkGRhXxpAGUTB2Ez7D/q9/0P5cashdeS1trJ8sK3
	7T5JDuZT92W81QEsMw43qufosiOeC/cjxKlxNR3K70DatKv+BuFea1TslESStJEr
	xLmc/xNQpb0r7kyBLuo3pCcq7crNcRjY0W/h4dhPUo2peu+zI08sxxZGDNs+S7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=c7fypT
	f8WAcHFGbiJ3CTYbTY3i3HT1Q1TgrdAo3i+IaEeQQmzzyIxyt35YbZWOGv9kxtNP
	6B2LrUjxHWxAlXjCk2f1tGNm0vx1EYf1EgjbFQDghWghy4MUfq8QXlZitILyJTtO
	J0gWOxt72Yjr5CYNLl8s3qoomFQmz1jAYT8oY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 67FC418F76;
	Fri,  6 May 2016 13:11:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E422618F75;
	Fri,  6 May 2016 13:11:58 -0400 (EDT)
In-Reply-To: <e33e0b87-caa1-84a3-7c5c-8938e0c78a77@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Fri, 6 May 2016 10:54:55
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A4612342-13AD-11E6-8772-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293834>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> We only need to pay extra attention when there is an external
> clean/smudge filter defined - otherwise we should be able to skip
> it - after 10/10.

The last two words worries me.  The goal of the suggested fix was to
make sure that

	$ git reset --hard && git diff

reports that there _are_ differences in the working tree files, if
the to-git and to-working-tree conversion do not round-trip.  It is
a total opposite of 10/10, which hides the fact that working tree
contents, if added to the index, would change the index.
