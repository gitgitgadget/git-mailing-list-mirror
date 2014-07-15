From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] sha1_file: do not add own object directory as alternate
Date: Tue, 15 Jul 2014 12:48:41 -0700
Message-ID: <xmqq8unuv1wm.fsf@gitster.dls.corp.google.com>
References: <53BFB055.206@gmail.com>
	<xmqqy4vz51gb.fsf@gitster.dls.corp.google.com>
	<53C26309.5040401@gmail.com> <53C39CB0.6040909@gmail.com>
	<CACsJy8B-QFu4SU6HHZukAmmjLrgb+L8KsHPn3GgQhcX6-LGXLg@mail.gmail.com>
	<53C3D2AD.9050204@gmail.com> <53C4BFC7.2000507@kdbg.org>
	<53C510A9.4010208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ephrim Khong <dr.khong@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 21:48:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X78if-0007p7-Th
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 21:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933761AbaGOTsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 15:48:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62319 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933276AbaGOTst (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 15:48:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A6F6628A99;
	Tue, 15 Jul 2014 15:48:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rypmibtd7yJ2xkyn8PALXBkxSoo=; b=qYJpDi
	dL2YFzhSa0F3xks+mFz0OVbstBijdEYBd+2mG4jb7QZadnqq6xizqLH9r6zbT4kW
	jPOwXNVML+Wr1lu1LWXqc9Lfh3aAHi1TFd3mu94AS8grq5YH1xwg4+Ti58FYaCq/
	TLXIcYVVe8hG3wMPFF7ffLyrolSIGXB6U+Ins=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ls8NcqX99BAjbBDW09ZPtxc/FgB8mBdK
	MXvD8SKWuz4bQGexK0GMXQxMJxYsj1WYjxAMoFAQS380CeEyyqFUORizRUs0vqXE
	r2eX2SvunOFldfSZSpilSPDWjpjumyx9LHzyPtDloJ1cxmb+6M4GFcX4kkQXF9qs
	8iJupCq6jgY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C0FF28A98;
	Tue, 15 Jul 2014 15:48:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0464C28A8D;
	Tue, 15 Jul 2014 15:48:25 -0400 (EDT)
In-Reply-To: <53C510A9.4010208@gmail.com> (Ephrim Khong's message of "Tue, 15
	Jul 2014 13:29:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FC777558-0C58-11E4-AB6D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253596>

Ephrim Khong <dr.khong@gmail.com> writes:

> diff --git a/t/t7702-repack-cyclic-alternate.sh b/t/t7702-repack-cyclic-alternate.sh
> new file mode 100755
> index 0000000..8341d46
> --- /dev/null
> +++ b/t/t7702-repack-cyclic-alternate.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2014 Ephrim Khong
> +#
> +
> +test_description='repack involving cyclic alternate'
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	GIT_OBJECT_DIRECTORY=.git//../.git/objects &&
> +	export GIT_OBJECT_DIRECTORY &&

Do you need this artificially strange environment settings for the
problem to manifest itself, or is it sufficient to have a
non-canonical pathname in the info/alternates file?

Exporting an environment early in the test and having later tests in
the file depend on it makes it harder to debug when things go wrong,
than leaving an info/alternates file in the repository, primarily
because the latter can be inspected more easily in the trash
directory after "t7702-*.sh -i" dies, hence the above question.

> +	touch a &&

Don't use 'touch' if you are not interested in timestams.  Write this as

	>a &&

because what you care about here in this test is that an empty file
'a' exists, so that you can run "git add" on it.

> +	git add a &&
> +	git commit -m 1 &&
> +	git repack -adl &&
> +	echo "$(pwd)"/.git/objects/../objects >.git/objects/info/alternates
> +'
> +
> +test_expect_success 're-packing repository with itsself as alternate' '
> +	git repack -adl &&
> +	git fsck
> +'
> +
> +test_done
