From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file: don't convert off_t to size_t too early to avoid potential die()
Date: Mon, 22 Sep 2014 10:49:31 -0700
Message-ID: <xmqqfvfjlf4k.fsf@gitster.dls.corp.google.com>
References: <1411293806-3087-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Sep 22 19:49:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XW7k2-00015Y-6l
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 19:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbaIVRte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 13:49:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54011 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753486AbaIVRte (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 13:49:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AAA173C5A8;
	Mon, 22 Sep 2014 13:49:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YWpYGo3xKXuq5lQ0KDdiqwBsb2Q=; b=uOX+rS
	29sEmM88DfUdNa7piksvDxz+gIW7x8psA+GbTxqY4rkJVLLZLGoPS0e6FRZdZkZC
	yJveJ7gOvVH37Ht+AMq+lfFW9qK1Y0ZXjf9xeyxom3eoBGNPEFj4GAImRJmLZxI/
	Z9RQna8eFLX99KZmizBIYdo11bJe7/NKGYR1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZKslzfUJxDvUt3/Z/XULGx8qKMlBqQqw
	L0m3Vffr5IXyNfR+Q0CKf2nxHJh1CrKxIl76RKnXKSirERQK5BmN/2oX9bCIogEJ
	oUaY6VlRnEP/sERnKiTFjS2uC9fIKAH5ZDMthS0ngxIbJC9JMKTRXvb75N4S+kP+
	vyF3HtaDxRk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A1FE53C5A7;
	Mon, 22 Sep 2014 13:49:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 28DC83C5A5;
	Mon, 22 Sep 2014 13:49:33 -0400 (EDT)
In-Reply-To: <1411293806-3087-1-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Sun, 21 Sep 2014 12:03:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CF7520D8-4280-11E4-A61F-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257372>

Steffen Prohaska <prohaska@zib.de> writes:

> xsize_t() checks if an off_t argument can be safely converted to
> a size_t return value.  If the check is executed too early, it could
> fail for large files on 32-bit architectures even if the size_t code
> path is not taken.  Other paths might be able to handle the large file.
> Specifically, index_stream_convert_blob() is able to handle a large file
> if a filter is configured that returns a small result.
>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
>
> This patch should be applied on top of sp/stream-clean-filter.
>
> index_stream() might internally also be able to handle large files to
> some extent.  But it uses size_t for its third argument, and we must
> already die() when calling it.  It might be a good idea to convert its
> interface to use off_t and push the size checks further down the stack.

Yes, if we want to futz in this area, I think that would be the
right approach.
