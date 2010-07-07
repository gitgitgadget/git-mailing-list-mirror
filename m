From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2/RFC] gitweb: Prepare for splitting gitweb
Date: Wed, 07 Jul 2010 09:25:15 -0700
Message-ID: <7viq4rxnro.fsf@alter.siamese.dyndns.org>
References: <1278496676-26575-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 18:25:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWXRQ-0004eT-JC
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 18:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757385Ab0GGQZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 12:25:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56215 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757334Ab0GGQZd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 12:25:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13BFFC2C6F;
	Wed,  7 Jul 2010 12:25:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E8yTsIbpf48Cb9SpSFvYIkE6J2w=; b=OYaGRj
	Snn2EtP7qLEWEZgusiS7fyFua+yXP7hF7YwLK/X9Kz81MaXpP2ty9LCRcfDVlDTD
	UqJLEuWPQ47XlL8AddzZriYaEMJhUvCfLnlHnkhlmRxtRHVFZsJdwwxAUTqZDtfT
	CzbGT7GSHkeXvnDYFK2QQXdZPWGksyt6qkfgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DR9sYC0o01+kaZdzA7YSRXxfzzLB+MD+
	BFD9XoFwHwDYKvP3hzEVHdI2K3IwbY7v/L//I9YtVBUdoP3tU310NcJFsq6HLgPH
	QnPRqy/2BfXXdImI+59jSQH5oKPjnuU5qteWRS9BalHj9Hd0VNbfOVOYbM34/Vny
	owcGYC6Sgww=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AED36C2C68;
	Wed,  7 Jul 2010 12:25:23 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3C9AC2C5E; Wed,  7 Jul
 2010 12:25:17 -0400 (EDT)
In-Reply-To: <1278496676-26575-1-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Wed\,  7 Jul 2010 11\:57\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3E665AB6-89E4-11DF-9226-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150479>

Jakub Narebski <jnareb@gmail.com> writes:

> diff --git a/gitweb/Makefile b/gitweb/Makefile
> index 2fb7c2d..84a1d71 100644
> --- a/gitweb/Makefile
> +++ b/gitweb/Makefile
> @@ -145,12 +146,23 @@ gitweb.cgi: gitweb.perl GITWEB-BUILD-OPTIONS
>  
>  ### Installation rules
>  
> -install: all
> +install: all install-modules
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)'
>  	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
>  	$(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
>  
> +install-modules:
> +	install_dirs=$(sort $(dir $(GITWEB_MODULES))) && \
> +	for dir in $$install_dirs; do \
> +		test -d '$(DESTDIR_SQ)$(gitwebdir_SQ)/$$dir' || \
> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)/$$dir'; \
> +	done
> +	gitweb_modules=$(GITWEB_MODULES) && \
> +	for mod in $$gitweb_modules; do \
> +		$(INSTALL) -m 644 $$mod '$(DESTDIR_SQ)$(gitwebdir_SQ)/$$(dirname $$mod)'; \
> +	done
> +

Sorry, but you lost me here.  Where is GITWEB_MODULES defined (iow, what
commit is this patch supposed to be applied)?

I also suspect that your assignment to "install_dirs" is completely bogus
when the files listed in GITWEB_MODULES span multiple directories.
