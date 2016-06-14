From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] gpg-interface: check gpg signature creation status
Date: Tue, 14 Jun 2016 11:13:54 -0700
Message-ID: <xmqq60tbaba5.fsf@gitster.mtv.corp.google.com>
References: <26353a3d-e495-075f-4f84-b34a2420a6cf@drmicha.warpmail.net>
	<8e08b63b58302b6e7fe91f0dfb5b476781bfd37d.1465915311.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	ZhenTian <loooseleaves@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 20:14:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCsqp-0001Mh-OT
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 20:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbcFNSN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 14:13:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58950 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932302AbcFNSN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 14:13:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C57423060;
	Tue, 14 Jun 2016 14:13:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EYkTY8FSaiWWsrlupbVsFsHgOCY=; b=fUC2Ki
	oj3SXplye9p2r01bR45WMhueijExj5pjTs0gDNGr3Gopj/BlSeb6+JsXGrSKUY8/
	vw7Z8JOOwe6DB/zf7ZfRUy5kHCeXyvmJQe2BEpYF7RzgF0LrJUOx0zk7Tu8Fh4Ir
	lupuspukB/IHFOX/4iTDrJWMWWn8iYpMnCA7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YhMOXbTi9TqG6q44hMj/CPkkA7EGHru3
	m1QLlyBFgMUbzUvZOkA1kgOp3s71bOODE2WJkr+6ePoH94ngfgJxiaoqikMdcVew
	iouoC3+LtR/eA3LF721zhW7OT71Py41XZuUIjAL8riCMz0NYJ/l3Jf+n8tTFk9GQ
	w77ecH6bEY4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5536D2305F;
	Tue, 14 Jun 2016 14:13:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D5CB32305E;
	Tue, 14 Jun 2016 14:13:55 -0400 (EDT)
In-Reply-To: <8e08b63b58302b6e7fe91f0dfb5b476781bfd37d.1465915311.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Tue, 14 Jun 2016 16:44:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C1F567E8-325B-11E6-B769-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297316>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>  	bottom = signature->len;
> -	len = strbuf_read(signature, gpg.out, 1024);
> +	strbuf_read(signature, gpg.out, 1024);
> +	strbuf_read(&err, gpg.err, 0);

Hmmmm, isn't this asking for a deadlock?  When GPG spews more than
what would fit in a pipe buffer to its standard error (hence gets
blocked), its standard output may not complete, and the we would get
stuck by attempting to read from gpg.out, failing to reach the other
strbuf_read() that would unblock GPG by reading from gpg.err?
