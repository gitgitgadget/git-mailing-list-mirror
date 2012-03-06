From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Perform cheaper connectivity check when pack is used
 as medium
Date: Tue, 06 Mar 2012 07:56:22 -0800
Message-ID: <7vfwdlvi3d.fsf@alter.siamese.dyndns.org>
References: <7vmx849ma8.fsf@alter.siamese.dyndns.org>
 <1330435109-4437-1-git-send-email-pclouds@gmail.com>
 <7vwr73h6td.fsf@alter.siamese.dyndns.org>
 <CACsJy8D7JB9bzOvammGAx1rW04DEUCVzvfp-_Q1KtE9G00rZVQ@mail.gmail.com>
 <7v1upagb8z.fsf@alter.siamese.dyndns.org>
 <CACsJy8B7u-rvnFZKi4t2CoB=J3Ra8pWxK4439NTdnHQDhm2ibQ@mail.gmail.com>
 <7vfwdq8914.fsf@alter.siamese.dyndns.org>
 <CACsJy8A+c6t_zHziPcQZ-Nw+fm0TmaG8VmDfnoPf-DzHHm8QVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 16:56:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4wkb-0004QM-1Y
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 16:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238Ab2CFP42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 10:56:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33757 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033Ab2CFP42 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 10:56:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FA475188;
	Tue,  6 Mar 2012 10:56:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=15QnLv5nFx3/Zk/ihHeZ/ns5Kms=; b=WBUI3A
	ZUWc8xFpiknCPTUFJxA3yTH5O8J9ZHkdl2x+GBcdiG+JQyTufRJ4N3ZPaN8vQwAu
	z6S9CHRrFVAtg43DqgxKSGvBFWzxnLaQ5/aKhzva395ZM2IEgfAf6+GK5JIot600
	tNN82O3Wyzpbhr8lLEvrahlvQb8bfFXYi6C8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GiMM3L5To0d3AW+xgxd/ULJxonED7gxN
	LAX8bDA1dWgfnmOfVF1v5uDZOHk/YSS2iUcIaQqcZLHHx+RgMrjVFn1B13qMS3He
	bH98zPkr0lao5Yfb+kAWR3iUCDTIaxuKgPGWnIhEXZ7i9n9924Ca90RWkiPJ+PaO
	f4F7LcQYThQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17A6A5187;
	Tue,  6 Mar 2012 10:56:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A22925182; Tue,  6 Mar 2012
 10:56:26 -0500 (EST)
In-Reply-To: <CACsJy8A+c6t_zHziPcQZ-Nw+fm0TmaG8VmDfnoPf-DzHHm8QVA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 6 Mar 2012 18:20:21 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE37BB84-67A4-11E1-95EF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192358>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sat, Mar 3, 2012 at 1:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> But now you brought it up, I think we may also need to worry about a
>> corrupt pre-existing loose blob object. In general, we tend to always
>> favor reading objects from packs over loose objects, but I do not know
>> offhand what repacking would do when there are two places it can read the
>> same object from (it should be allowed to pick whichever is easier to
>> read).
>
> Corrupt accidentally or on purpose?

Does not matter. The attack outlined does not require you to write a
corrupt one into victim's repository. You only need to _know_ one
that the victim happens to have.
