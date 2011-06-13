From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/10] config: avoid segfault when parsing command-line
 config
Date: Mon, 13 Jun 2011 10:30:22 -0700
Message-ID: <7vhb7tod01.fsf@alter.siamese.dyndns.org>
References: <20110609155001.GA14969@sigill.intra.peff.net>
 <20110609155243.GD25507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Claire Fousse <claire.fousse@ensimag.imag.fr>, git@vger.kernel.org,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 13 19:30:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWAyL-0006ax-6b
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 19:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701Ab1FMRai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 13:30:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501Ab1FMRai (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 13:30:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7F3D75D22;
	Mon, 13 Jun 2011 13:32:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=biy0NQnQsqEVcjyEmjIjNFowCeg=; b=A3exx5IwIaf2iMqFVeMl
	7JC6c9QVjyQgW/orXmwhdXEof0Edvz2xWsq0Kby+3JUJvZCxP5/iUL4db6Y0cpaN
	Hs4Z+kLH27DqbthbbzsL2ZZEMhvvETswFYRaAuInS0x2dmI0hzjViqyKq9ir70ya
	DyAnnM41k1J6BFd/tQymTuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Kb1svmiN78dkmw9Vf/aOgg5GALw7GYyYx0VT8oOK79CiV1
	uu4HH7Zvh31P9L8wFQ+VkeMCJWMJPD10o7qhtR9VguIXL8yvG7nJgrByLIYAMoYR
	rkGHBnpbHJKh/uekLapN+KURCGLYkIvzdeyIhLGJe0Jp8wlnIUOjgBGZ0l65M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 309005D1F;
	Mon, 13 Jun 2011 13:32:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DD8D35CFF; Mon, 13 Jun 2011
 13:32:33 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2458FF6E-95E3-11E0-B01F-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175724>

Jeff King <peff@peff.net> writes:

> We already check for an empty key on the left side of an
> equals, but we would segfault if there was no content at
> all.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  config.c               |    2 ++
>  t/t1300-repo-config.sh |    4 ++++
>  2 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/config.c b/config.c
> index ebd404a..2517b62 100644
> --- a/config.c
> +++ b/config.c
> @@ -46,6 +46,8 @@ static int git_config_parse_parameter(const char *text,
>  	struct strbuf **pair;
>  	strbuf_addstr(&tmp, text);
>  	pair = strbuf_split_max(&tmp, '=', 2);
> +	if (!pair[0])
> +		return error("bogus config parameter: %s", text);

This feels wrong.

Asking strbuf_split() to split a string "foo" with "=" delimiter would
give you one element array ("foo", NULL), a string "fo" would give you
("fo", NULL), and a string "f" would give you ("f", NULL).  Shouldn't we
get ("", NULL) if we ask it to split ""?
