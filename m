From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH 1/4] Prepare checkout_entry() for recursive checkout
 of submodules
Date: Fri, 09 Apr 2010 14:59:51 -0700
Message-ID: <7vd3y81e3s.fsf@alter.siamese.dyndns.org>
References: <4BBF9D6F.2000006@web.de> <4BBF9DC9.8030905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 10 00:00:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0MFG-00023T-Ef
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 00:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757297Ab0DIWAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 18:00:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab0DIWAB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 18:00:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 588C0A9A1C;
	Fri,  9 Apr 2010 17:59:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HDkGb5k1b6TxB+JQQaJAtfhhEkA=; b=bpBcCD
	UAmBIpwjBtKk8uwiRjBIaSKt6WUABKdrSgTwUi4LCXVqUHNCwTNHaWiTyr0UMT99
	Q6b9aDMZ6A/syd47JARKla1PEpkvORJSRJII+cSUXOTP5yfidmkgjGvCjlG7dv6d
	3W2LZVTnQocU9aypphZpyKHnSTbiTNofMpH70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DH9b1szzFxXZ6+0OXHC6nXlxJf3Zu9Pb
	IASsKWigofayANBHaGg/g+DQa7+LGunHw2Hh4uE5CFbUAR52mTHVlqLTXOCRK8qu
	EKaW+6hMvIX5oDOrXxq8yRZDouEhKoszuIQ4kbf5vM2W4b8L65zyjeanNDlwj5mz
	o6gn/UCha+Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 30661A9A17;
	Fri,  9 Apr 2010 17:59:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 995B6A9A16; Fri,  9 Apr
 2010 17:59:52 -0400 (EDT)
In-Reply-To: <4BBF9DC9.8030905@web.de> (Jens Lehmann's message of "Fri\, 09
 Apr 2010 23\:36\:09 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3B2BE53E-4423-11DF-B266-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144479>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> +int checkout_submodule(const char *path, const unsigned char sha1[20], int force)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	struct child_process cp;
> +	const char *hex_sha1 = sha1_to_hex(sha1);
> +	const char *argv[] = {
> +		"checkout",
> +                force ? "-qf" : "-q",
> +		hex_sha1,
> +		NULL,
> +	};

Why force -q?

> +	strbuf_addf(&buf, "%s/.git/", path);
> +	if (!is_directory(buf.buf)) {
> +		strbuf_release(&buf);
> +		/* The submodule is not populated, so we can't check it out */
> +		return 0;
> +	}

This would give you an incorrect result if .git is a file that records
"gitdir: overthere" (see read_gitfile_gently() in setup.c); I would expect
it would become a fairly important ingredient if we ever enhance the
submodule support to add submodule that disappears/reappears in the
history.
