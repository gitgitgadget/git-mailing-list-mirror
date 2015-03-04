From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-describe considers WC dirty incorrectly when using --git-dir
Date: Wed, 04 Mar 2015 11:54:02 -0800
Message-ID: <xmqqoao88rol.fsf@gitster.dls.corp.google.com>
References: <CACWYfsCO3O-x8zBsFXoSTFZ8GiaO6CpAszUHRtjM0dCp0Q8ogg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Chris Pimlott <chris@pimlott.net>
X-From: git-owner@vger.kernel.org Wed Mar 04 20:54:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTFMy-0000XL-SV
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 20:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759342AbbCDTyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 14:54:07 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758246AbbCDTyG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 14:54:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F6E43C43A;
	Wed,  4 Mar 2015 14:54:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xYs9IXU5EKjzKM3eP57sVLq3U50=; b=WQuRUT
	+f3Kqie5iHdn9RgFwVUvk1UquYVoXzJ0/u6VcagzxkogVBFkkHBCSlVUdOGAIPiW
	yCw4BMgbFQ4AWCog5qUga7wGNRhc3gn162JBoS/gmTDPHyJZiKzcFxKbdgwMnpr4
	7ZkuPqkzKlz6XwRa7rhuXZSm6HC0mDUA7tBW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cEVimTRcAMG8U/QG0fpTyVtnAHRrYHlG
	nsFHyHZev0UAcCxED3YeITN1E+ykhPfw2S++d/v2IH7i5eCgnx8g+nR0EX6OwWMe
	pROa+mBL4qVdGDKwWkQkGi8xrX266mHceo0szlDeK03uSPtW2u2fIz0Bcj1HpiAU
	F996dfPFlUU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5739E3C439;
	Wed,  4 Mar 2015 14:54:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D17FC3C438;
	Wed,  4 Mar 2015 14:54:03 -0500 (EST)
In-Reply-To: <CACWYfsCO3O-x8zBsFXoSTFZ8GiaO6CpAszUHRtjM0dCp0Q8ogg@mail.gmail.com>
	(Chris Pimlott's message of "Wed, 4 Mar 2015 11:47:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 35AC270A-C2A8-11E4-B434-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264769>

Chris Pimlott <chris@pimlott.net> writes:

> It seems that git-describe always thinks that working copy is dirty if
> you are not in the WC root and you explicitly specify the .git
> directory location using --git-dir:
>
>   # set up test repo
>   folio:~ chris$ mkdir repo && cd repo
>   folio:repo chris$ mkdir text && echo hi > text/hi.txt
>   folio:repo chris$ git init . && git add . && git commit -m "text/hi.txt"
>   Initialized empty Git repository in /home/chris/repo/.git/
>   [master (root-commit) c0edd63] text/hi.txt
>   1 file changed, 1 insertion(+)
>   create mode 100644 text/hi.txt
>
>   # git-describe from non-root directory
>   folio:repo chris$ cd text
>   folio:text chris$ git describe --always --dirty
>   c0edd63
>   folio:text chris$ git --git-dir=../.git describe --always --dirty
>   c0edd63-dirty
>   folio:text chris$ git --git-dir=$(git rev-parse
> --show-toplevel)/.git describe --always --dirty
>   c0edd63-dirty

I have a feeling that this is not limited to describe at all.  With
the --git-dir option, you are telling Git that your GIT_DIR is over
there and (by not using --work-tree together with that option) you
are telling Git that you do not want Git to guess where the working
tree is (instead, you are telling Git that you are at the top of the
working tree), no?
