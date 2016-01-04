From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-p4.py: add support for filetype change
Date: Mon, 04 Jan 2016 13:55:16 -0800
Message-ID: <xmqqtwmtm2m3.fsf@gitster.mtv.corp.google.com>
References: <1451904764-338-1-git-send-email-romain.picard@oakbits.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org, larsxschneider@gmail.com,
	sunshine@sunshineco.com, git-owner@vger.kernel.org
To: Romain Picard <romain.picard@oakbits.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 22:55:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGD68-0002bB-3j
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 22:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbcADVzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 16:55:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63753 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752302AbcADVzU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 16:55:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9CCAB3726F;
	Mon,  4 Jan 2016 16:55:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5dHQoQOAukO2Nhqu1GgP1yihPxc=; b=iXM5zs
	bmNXvDl0PLrjBrt9BPatKNvN9vUzOVT0L8iXRbyKtyoMMfuSJeUQ7nVhemS+3dna
	Z0VSw7ZQDISXJcxHye5vXgp+/E5J3O35L5s8z5gZsXIP6OgqleAo/1QsIfVYIgV7
	/PA9MB74ilMxE4xqBD0hPXSmEEv36BF7wmPjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kjLwuUleJyKhmlaZUOIsy1bwq5ODM+pK
	UX8IIHrKdy7dbD7O583b3FwZc3hvYzpunciRiahyP995Tih+kUMORItleuguKDui
	WXvL6o8K89WwGYX6C3IzGxeEjOSPu7mnUfGcwHnjkIZnjWy1201u5Srr1ojgHf3B
	EyOqa2ckEG4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 93ACE3726C;
	Mon,  4 Jan 2016 16:55:19 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 186153726B;
	Mon,  4 Jan 2016 16:55:19 -0500 (EST)
In-Reply-To: <1451904764-338-1-git-send-email-romain.picard@oakbits.com>
	(Romain Picard's message of "Mon, 4 Jan 2016 11:52:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D8756584-B32D-11E5-A9EF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283326>

Romain Picard <romain.picard@oakbits.com> writes:

> diff --git a/t/t9827-git-p4-change-filetype.sh b/t/t9827-git-p4-change-filetype.sh
> new file mode 100755
> index 0000000..b0a9f62
> --- /dev/null
> +++ b/t/t9827-git-p4-change-filetype.sh
> @@ -0,0 +1,69 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2016 Romain Picard
> +#
> +
> +test_description='git p4 support for file type change'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'create files' '
> +	(
> +		cd "$cli" &&
> +		p4 client -o | sed "/LineEnd/s/:.*/:unix/" | p4 client -i &&
> +		cat >file1 <<-EOF &&
> +		This is a first file.
> +		EOF
> +		cat >file2 <<-EOF &&
> +		This is a second file whose type will change.
> +		EOF

Micronit.  It would be nicer to the readers to make it clear that
there is no funny substitution to be worried about by quoting the
end marker of these here document, i.e.

		cat >dest <<-\EOF &&
                text without any funny substitution business
                EOF

> +		p4 add file1 file2 &&
> +		p4 submit -d "add files"
> +	)
> +'
> +
> +test_expect_success 'change file to symbolic link' '

This needs a SYMLINKS prerequisite so that it is skipped on systems
that lack support for symbolic links, i.e.

	test_expect_success SYMLINKS 'change file to symbolic link' '

The same for the next one.

Thanks.
