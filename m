From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/4] format-patch: add '--base' option to record base tree info
Date: Fri, 22 Apr 2016 14:59:42 -0700
Message-ID: <xmqqfuudnw35.fsf@gitster.mtv.corp.google.com>
References: <1461303756-25975-1-git-send-email-xiaolong.ye@intel.com>
	<1461303756-25975-3-git-send-email-xiaolong.ye@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Xiaolong Ye <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 23:59:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atj78-0006aP-5O
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 23:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbcDVV7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 17:59:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751609AbcDVV7p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 17:59:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6810D137F2;
	Fri, 22 Apr 2016 17:59:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zBPLj5DS+jz5XBe6/QNJw0eiKik=; b=HAumNh
	S+UQGqGYgM0LXME1+3yUYp1YjKPbMvb3FBxL+mW/qCX8WxF8zFqezig1xdtH4kBl
	hL/uuG5SWEZf3I4OHT17wOOC9BZOyBNtFnOoPgE7qdEiCvn+A7n4jmN8UZpeySUo
	0sb7vzW0U2hnUMNKd3u5++9b32KuHwUFdAbrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LAgCNPm15qFSN6sRhJNXUN4UJ92L/wRN
	56aJmBIxLp1cbQVVLzpGFUS1EExQx2uZp90z0Ck9YCtb5jOmItFm8cqWh9wO6sBk
	r+fr3VnaNWSnO8Gx/wVPYMsdvoET7AVxLu0mvPE9AXrMLNcBQVwor9w0aS4Wx9BX
	XVK6M0qDOK4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E59B137F1;
	Fri, 22 Apr 2016 17:59:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CC938137EB;
	Fri, 22 Apr 2016 17:59:43 -0400 (EDT)
In-Reply-To: <1461303756-25975-3-git-send-email-xiaolong.ye@intel.com>
	(Xiaolong Ye's message of "Fri, 22 Apr 2016 13:42:34 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8547B526-08D5-11E6-898A-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292275>

Xiaolong Ye <xiaolong.ye@intel.com> writes:

> +test_expect_success 'format-patch --base' '
> +	git checkout side &&
> +	git format-patch --stdout --base=HEAD~~~ -1 >patch &&
> +	grep -e "^base-commit:" -A3 patch >actual &&

The -A3 is GNUism.  To do this portably, perhaps you can do

	sed -n -e "/^base-commit:/,+3p"

or something like that.

But more importantly, grabbing 3 lines (and always 3 lines) will not
catch a future bug that somebody else may introduce to this code
that shows extra "prerequisite-patch-id:" after them.

> +	echo "base-commit: $(git rev-parse HEAD~~~)" >expected &&
> +	echo "prerequisite-patch-id: $(git show --patch HEAD~~ | git patch-id --stable | awk "{print \$1}")" >>expected &&
> +	echo "prerequisite-patch-id: $(git show --patch HEAD~ | git patch-id --stable | awk "{print \$1}")" >>expected &&
> +	test_cmp expected actual
> +'
