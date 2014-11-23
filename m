From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT: [PATCH] exec_cmd: system_path memory leak fix
Date: Sun, 23 Nov 2014 10:28:17 -0800
Message-ID: <xmqqmw7hydoe.fsf@gitster.dls.corp.google.com>
References: <1416750981-24446-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: 0xAX <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 23 19:28:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsbtY-00074P-En
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 19:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbaKWS2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2014 13:28:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752040AbaKWS2U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 13:28:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 476EF18837;
	Sun, 23 Nov 2014 13:28:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B+nj3pw12m/5hFgSOtPKMJ9ublA=; b=TP4Q5n
	Jia4oxvFEzUHUXoarpZSHHblBo7s2Xj1ZnW5dfkc0sJ8UK2nytso+HifZXIi1tiT
	RgqmfgFMRvl3DRi6ymtBxXuS/nEB043REzK682tFG0ameOwQqAjPBZQpc3z8I39F
	QDs3MbJFXdMOMQBPa7q8L3kYdXNmIVy31gaWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ECLVj7sH2r6bSn5Wx/JDl5r2WrrB3A3Y
	hpLnY1f2ZYtWzwRQDms+9qyGuWkH0HqV4g+QR+ZRWu8pTyetwGNNWlKy6NHnnBeY
	CQ8D5zY9hJCXfGAQmR4dga1/zkHDEkCuVzGTClbf/dRYxtIarA8kqRIltEUe2R9O
	1obr6IlDnzs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E65718835;
	Sun, 23 Nov 2014 13:28:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AAC3918834;
	Sun, 23 Nov 2014 13:28:18 -0500 (EST)
In-Reply-To: <1416750981-24446-1-git-send-email-kuleshovmail@gmail.com>
	(kuleshovmail@gmail.com's message of "Sun, 23 Nov 2014 19:56:20
	+0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7F34F28A-733E-11E4-80A1-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260094>

0xAX <kuleshovmail@gmail.com> writes:

> Hello All,
> I found memory leak at exec_cmd.c in system_path function with valgrind.
> After this patch valgrind doesn't show any memory leaks, but I'm not sure
> that it is the best way to solve this problem. There are a couple of places
> that uses system_path, if this way will be good, i'll make another patches
> to fix this leak.
>
> Waiting for feedback.

It is a bit sad that the callers of the function are prepared for
the returned value to be volatile (that is why the ones that want to
do something else between the time they call it and the time they
use the value returned do make copies), while other callers that
immediately use the returned value do not have to be worried about
freeing it, but with the change you have to force everybody to
remember freeing the returned value.

If you instead limited to your change only to these two points:

 - make "struct strbuf d" static;
 - return d.buf instead of the result of strbuf_detach(&d)

the updated system_path() will keep the promise all the caller
expects from it, i.e. the value out of the function is volatile but
the callers do not have to free it, in all cases, no?

> Signed-off-by: Alex Kuleshov <kuleshovmail@gmail.com>

Please have that S-o-b: line (and the same name in GIT_AUTHOR_NAME)
on the patches that we'd use "git am" on, not on the cover letter
;-).  Nom de guerre nobody else recognizes outside your close
friends may be fun, but I feel that it is not quite appropriate to
appear in "git shortlog -s" output on a public project like ours.

Thanks.
