From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Return or exit after done serving request
Date: Sun, 13 Jun 2010 22:33:50 -0700
Message-ID: <7v1vcach4x.fsf@alter.siamese.dyndns.org>
References: <20100613100800.28221.77529.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 07:34:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO2JK-0007fg-7n
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 07:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab0FNFd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 01:33:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49033 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab0FNFd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 01:33:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BCB5BC6CA;
	Mon, 14 Jun 2010 01:33:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=XCixnioFg6mtyO7XtsbnLl3tFnU=; b=ThurfHSpVbPprJVXOecVuXw
	oauf7FbExcuCURWTkKE4jJaTUQK4g2FzIQBRiQhOcPwuxQlcnb8DBWj4iq4YjZ0O
	YqQbItrXvAB4MgFrt2Nt01EcKI7Mt9ryV8qK0fvHuNFal6kyeFLdgwJdCKO7doH/
	32rXimiPu+LwwtEPtMj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=U6aB6DIcoXAPbdd/9TKCEmpleAJ/g+9/AvIxmzKqRq0k3mVFY
	AnKyLpH5DYqOy/mSf6ciBcP9m0OlVm5bnRKyOLx8uj8eFFAnXvinElVxbqSBnFkk
	Bcxtn335efo5qSX5ULzAG4yXB+dBXan/ONhUEFKumuOJ7KCgsxAUUZ+yBo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A393BC6C3;
	Mon, 14 Jun 2010 01:33:55 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D709BC6C1; Mon, 14 Jun
 2010 01:33:52 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6C473732-7776-11DF-9B0B-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149074>

Jakub Narebski <jnareb@gmail.com> writes:

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e108bbc..02f366d 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -987,7 +987,16 @@ if ($action !~ m/^(?:opml|project_list|project_index)$/ &&
>  	die_error(400, "Project needed");
>  }
>  $actions{$action}->();
> +
>  DONE_GITWEB:
> +if (defined caller) {
> +	# wrapped in a subroutine processing requests,
> +	# e.g. mod_perl with ModPerl::Registry, or PSGI with Plack::App::WrapCGI
> +	return;
> +} else {
> +	# pure CGI script, serving single request
> +	exit;
> +}
>  1;

Is the last "1;" still needed if we did this?

I am guessing that this new codeblock will go inside "sub run" when
merging with your c2394fe (gitweb: Put all per-connection code in run()
subroutine, 2010-05-07) and Sam's a0446e7 (gitweb: Add support for
FastCGI, using CGI::Fast, 2010-05-07).  If I am mistaken, please advise.

Thanks.
