From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive: let remote clients get reachable commits
Date: Fri, 22 Feb 2013 09:10:46 -0800
Message-ID: <7vehg8s295.fsf@alter.siamese.dyndns.org>
References: <1361456643-51851-1-git-send-email-gurugray@yandex.ru>
 <20130221155208.GA19943@sigill.intra.peff.net>
 <995301361532360@web22h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Sergey Sergeev <gurugray@yandex.ru>
X-From: git-owner@vger.kernel.org Fri Feb 22 18:11:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8w9X-0008Ra-B4
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 18:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758349Ab3BVRKv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2013 12:10:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61524 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757720Ab3BVRKt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2013 12:10:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 946E0AB63;
	Fri, 22 Feb 2013 12:10:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3mlfTqXzLIJy
	UbUeZFzi2qhyiG8=; b=EouOV6mspcqGaK2AcPvtGBbFKVy6nc7QQAbo6fIxszRk
	77ubTGCIKeYHBaFl77fvrw94J2lcQuJ8R1qe4T9gCoCOwD58JPCubKDyKThz4DLb
	8iMGjo8Cast5hnY5bu8gPldxgM2BFIYf1EL9rmIKozjvlWKumhHS2dCywL/FIAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HZR545
	Aji1owp5kyQRtjFKjI6423DFIFFgEYNd+1xk7c/q/eIbNm1+x/kTR6krRmLu47l0
	NZkpwbdsX5x8mIVYlIJtsb2MUIZSNqOfZEv2E0Sdc7cM6uMp0oxjw7Q7D8++dh4X
	HK9pWVM5uhiEQjJVTA5/6rQrmMwiI0H8tTdNQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 889B5AB62;
	Fri, 22 Feb 2013 12:10:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08FACAB5E; Fri, 22 Feb 2013
 12:10:47 -0500 (EST)
In-Reply-To: <995301361532360@web22h.yandex.ru> (Sergey Sergeev's message of
 "Fri, 22 Feb 2013 13:26:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD3876BA-7D12-11E2-8576-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216842>

Sergey Sergeev <gurugray@yandex.ru> writes:

[jc: please do not top-post]

> You are right,
> I'll rethink this patch and write some test for this cases.

Thanks.

Note that this is harder to implement than one would na=C3=AFvely think=
,
if one aims for a very generic solution, without walking the whole
history.

I personally think that it is OK to limit the scope to expressions
that start from the tip of ref and expressions that start with the
SHA-1 at the tip of ref, e.g.

    master~12:Documentation
    v2.6.11:arch/alpha
    5dc01c595e6c6ec9ccda	# tag v2.6.11
    26791a8bcf0e6d33f43a:arch	# tag v2.6.12
    26791a8bcf0~12:arch		# starting at 26791a8b and dig down

are OK, while forbidding the following:

    c39ae07f393806ccf406        # tree of tag v2.6.11
    9ee1c939d1cb936b1f98	# commit v2.6.12^0
    9ee1c939d1cb936b1f98:	# tree of commit v2.6.12^0
    9ee1c939d1cb936b1f98:arch	# subtree of commit v2.6.12^0

which will make it significantly easier to implement the necessary
validation in a robust way.
