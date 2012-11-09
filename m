From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: make remote_heads config setting work.
Date: Thu, 08 Nov 2012 20:40:11 -0800
Message-ID: <7vk3tvqthw.fsf@alter.siamese.dyndns.org>
References: <20121105235047.GA78156@redoubt.spodhuis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: Phil Pennock <phil@apcera.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 05:40:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWgOR-0000hM-MA
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 05:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090Ab2KIEkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 23:40:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56165 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439Ab2KIEkP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 23:40:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D479A8AEE;
	Thu,  8 Nov 2012 23:40:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5e/P0XDPvc0HCncXfhl/wGdue2E=; b=D1rUAq
	FA8d+wc2TSq4fb60CJsVy4dzHpFb7ee+EJiTMgtw6nT3AArpK0Ztm2WZvw5RHJ07
	REarsH+unLFWaL3xA9CX0AmZTNH5qDc0oRcauLS7/mGmR7JytQ5ciBCgExqYbkxy
	cmlHpVfkp8KAp/o2uXX3fulA5SLrtNkjOQ2HA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GPMYGB5vDclvXpDaeSJXeKDwAINBEpvw
	g86hdd11SzCPc4k1zej2DUQngp4LO1vxgQWuklVKIlERP5FbYlY93M+Pv+nmnFoS
	Qiqro3FjLh9BTKR4joW4B4tpN35L0+gEDM8MrMEuAsGMCC7e6f+uflc6zDsFrrO3
	XSwcBojhbcY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C28188AED;
	Thu,  8 Nov 2012 23:40:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35F238AEC; Thu,  8 Nov 2012
 23:40:13 -0500 (EST)
In-Reply-To: <20121105235047.GA78156@redoubt.spodhuis.org> (Phil Pennock's
 message of "Mon, 5 Nov 2012 18:50:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D0135AC-2A27-11E2-A1F5-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209203>

Phil Pennock <phil@apcera.com> writes:

> @@ -2702,6 +2702,7 @@ sub git_get_project_config {
>  		$key = lc($key);
>  	}
>  	$key =~ s/^gitweb\.//;
> +	$key =~ s/_//g;
>  	return if ($key =~ m/\W/);
>  
>  	# type sanity check

The idea to strip "_" from "remote_heads" to create "remoteheads" is
fine, but I am not sure if the implementation is good.

Looking at the code before this part:

	if (my ($hi, $mi, $lo) = ($key =~ /^([^.]*)\.(.*)\.([^.]*)$/)) {
		$key = join(".", lc($hi), $mi, lc($lo));
	} else {
		$key = lc($key);
	}
	$key =~ s/^gitweb\.//;
	return if ($key =~ m/\W/);

the new code is munding the $hi and $mi parts, while the mistaken
configuration this patch is trying to correct is about the $lo part,
and possibly the $hi part, but never the $mi part.

It is expected that $hi will always be gitweb, and I suspect that
there may not be any "per something" configuration variable (e.g.
"gitweb.master.blame" may be used to override the default value
given by "gitweb.blame" only for the master branch), that uses $mi
part, so it might not matter to munge the entire $key like this
patch does with the current code.

But that makes it even more important to get this part right _now_;
otherwise, it is likely that this new code will introduce a bug to
a future patch that adds "per something" configuration support.
