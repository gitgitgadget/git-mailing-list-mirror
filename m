From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/32] Split index mode for very large indexes
Date: Mon, 28 Apr 2014 15:23:53 -0700
Message-ID: <xmqq7g69nldy.fsf@gitster.dls.corp.google.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 00:24:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wetxx-0001UF-E0
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754349AbaD1WX5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 18:23:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53054 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754195AbaD1WX5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 18:23:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8A3681A88;
	Mon, 28 Apr 2014 18:23:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=atcMDuGQBuA0
	Dzh/sYpX4nOqk/Y=; b=Tvxs0wVEcPoIruskHXMkK/De6TJHtXu4W6QW4T+xWHq1
	Z2JHGqJbUXxMJTHeM67KzKDRldl24QxU5zfgw1LEHBdusQPyeNQdq5YedfAy6Kde
	mTEAMMYhQyPwGgDFGcajFJWUrxQ9pnTv2VM0dvZWYz+EwSWRfR6OYalTHgRLka4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hmIrIB
	n/dNXBFxVVhKYWVn6cLtY6x3SD/x6Yf4rV20sNwrGyHWZ/iChlRriSqPlk9FWla5
	Yb1fw0qlnzAHR4ISxsRitzZzXXETQwmvf+cEFmS0VCfKyq0ktl9OkJV2refE9OM9
	iIVbBxvso4eoYqYzYeTSrbqcusaRWrYhLgMn0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90DCA81A87;
	Mon, 28 Apr 2014 18:23:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3C6F81A80;
	Mon, 28 Apr 2014 18:23:54 -0400 (EDT)
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 28
 Apr 2014 17:55:21 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C88FAACA-CF23-11E3-B548-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247460>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The read penalty is not addressed here, so I still pay 14MB hashing
> cost.

Hmm, yeah, the cost for verify_hdr() would still matter, and
presumably you would be hashing the additional 200kB to validate the
smaller "changes since the base" file to give users the same level
of protection against corruption.

> Doing this in other implementations should be easy (at least the
> reading part) and with small code change. The whole index format is
> retained. All you need is to read a new extension that contains two
> ewah-bitmaps and apply the changes to create the final index.

Why bitmaps, though?  Na=C3=AFvely I would have expected you to read fr=
om
two sorted streams and have the transaction log override the base.

Intrigued to find it out...
