From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Add global and system-wide gitattributes
Date: Wed, 11 Aug 2010 15:19:04 -0700
Message-ID: <7vzkwsvllz.fsf@alter.siamese.dyndns.org>
References: <1281488646-7108-1-git-send-email-gsvick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Henrik Grubbstrm <grubba@grubba.org>
To: Petr Onderka <gsvick@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 00:19:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjJdo-0004oq-PN
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 00:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560Ab0HKWTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 18:19:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44666 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756238Ab0HKWTP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 18:19:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 09A2BCC5CB;
	Wed, 11 Aug 2010 18:19:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9TiX/JD5rU5W7ReuWAVAqbpV1Q4=; b=C4TkuT
	3ouSLJrIDHl0Pi5KykZb6JQqzKbRZ7ROLIj9uHoUf/CrOf75UIJLIKksz2pGQoV4
	5+Dwi9mZOXl8QJM8VAZXlPfi3i4IlqqoVCssJzAmshD/ZgMC2qUu0/hDgW/yCni9
	uXULvRVe90eBBDnO7djXTb7PCrql/s0xZ/d1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x6KlMbMzYD9aXgHJGwFmFiaDPRf3BLl+
	J4Hie8AKDy5ptLWIO5KixASnuk2nULbokwn5n5KroPzBq4le54LqLLsI/WC+jpy7
	rL9iatSxT1m/bQxv4Z3RWMq/L8tXuPmyuHBx5wLZVr4ytE7JXMOSlsknKUXrhS6d
	U7Xql4cQPzM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A2890CC5C6;
	Wed, 11 Aug 2010 18:19:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A40ECC5C5; Wed, 11 Aug
 2010 18:19:06 -0400 (EDT)
In-Reply-To: <1281488646-7108-1-git-send-email-gsvick@gmail.com> (Petr
 Onderka's message of "Wed\, 11 Aug 2010 01\:04\:06 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 76FD6A86-A596-11DF-B2E3-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153305>

Petr Onderka <gsvick@gmail.com> writes:

> @@ -480,7 +501,15 @@ static void bootstrap_attr_stack(void)
>  			debug_push(elem);
>  		}
>  
> -		elem = read_attr_from_file(git_path(INFOATTRIBUTES_FILE), 1);
> +		elem = read_attr_from_file(git_path(INFOATTRIBUTES_FILE), 1, NULL);
> +		home = get_home_directory();
> +		if (git_attr_global() && home) {
> +			char *user_attr = xstrdup(mkpath("%s/%s", home, GITATTRIBUTES_FILE));
> +			elem = read_attr_from_file(user_attr, 1, elem);
> +			free(user_attr);
> +		}
> +		if (git_attr_system())
> +			elem = read_attr_from_file(git_etc_gitattributes(), 1, elem);

Have you read the comment at the top of prepare-attr-stack?  This patch
feels triply wrong:

 - The attribute stack is arranged to have higher precedence file near the
   top ($GIT_DIR/info/attributes used to be the highest).  The above
   addition means that ~/.gitattributes from user's home trumps what is in
   a particular repository.  That is backwards.  You may work on more than
   one projects and have more than one repositories.  What you share among
   them personally will go to ~/.gitattributes, while a setting specific
   to a particular repository goes to $GIT_DIR/info/attributes and the
   latter needs to be able to override the former.

 - Same thing for git_attr_system() being at the end, which means you set
   up your own $GIT_DIR/info/attributes (or ~/.gitattributes) carefully
   but that can be broken by a selfish sysadmin who puts stuff that is
   only useful to him in /etc/gitattributes, which is not what you want.

 - Whenever we enter a new directory (either recursing into, or coming
   back up), prepare_attr_stack() is called to pop the attributes records
   from now-exited directories and push the attributes records from
   directories we are about to descend into.  The current code knows that
   the topmost element on the stack is special ($GIT_DIR/info/attributes)
   and first pops it, adjust the stack for elements that came from the
   directory hierarcy, and then pushes that back.  I don't see any code in
   the patch to do the equivalent for these two new attribute sources.
