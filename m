From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Do not autosquash in case of an implied interactive
 rebase
Date: Fri, 25 May 2012 10:50:26 -0700
Message-ID: <7vehq8tajh.fsf@alter.siamese.dyndns.org>
References: <1337867575-7212-1-git-send-email-vfr@lyx.org>
 <1337867846-5336-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Fri May 25 19:50:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXyep-0007JQ-Cz
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 19:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104Ab2EYRub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 13:50:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65124 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757588Ab2EYRu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 13:50:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4109F8F5A;
	Fri, 25 May 2012 13:50:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x/80mIXFnk/wzCdzdgOZZZ1oziY=; b=vM+eHe
	cFqXRvJ0xF815nyK8pfRv4Vo7HI024QiqQ5GKUH0rTyiW7vl16IuSk5NJvDNaDFd
	v8BZndG3Gjb8BJrNtDTeNsVTr49EYAc1RAy2IyXWgpFvqcBvAtGo8y0wjyOJEZjS
	FZoUqWf10m7ENM8YRVxYOLrAHhdFsz57DjlSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oExTIMfcK+D3Unrk/27T/ISWeTHd+XCC
	O+oWnN4Q4hR4vc0Qxy3GHKTl6frjK5v9fxp5uZjiHjYozCpaZOpFbW9FqUrgw0e9
	3qUZO3hpg3r69gBlhvnHeTnbdtKXLnwnPowDJLk0mrx4UirgXvPCU8wb3fU6UMnf
	pXwm+FiohJU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3725B8F59;
	Fri, 25 May 2012 13:50:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B8FE8F50; Fri, 25 May 2012
 13:50:27 -0400 (EDT)
In-Reply-To: <1337867846-5336-1-git-send-email-vfr@lyx.org> (Vincent van
 Ravesteijn's message of "Thu, 24 May 2012 13:57:26 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1CCD587E-A692-11E1-B842-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198494>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> The option to autosquash is only used in case of an interactive rebase.
> When merges are preserved, rebase uses an interactive rebase internally,
> but in this case autosquash should still be disabled.
>
> Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>

Hrm, what if the end user said "git rebase --autosquash -p" explicitly
from the command line?

I _think_ you are addressing the case where rebase.autosquash is set to
true in the configuration.  The handling of that variable that was added
in dd1e5b3 (add configuration variable for --autosquash option of
interactive rebase, 2010-07-14) is not correct.  The configuration should
kick in only when the end user did not explicitly give either --autosquash
or --no-autosquash, so the variable $autosquash is logically a tristate
(unknown, set to yes, set to no), initialized to "unknown", set to either
value when --[no-]autosquash option is seen, and fall back to the
configured value _only_ after the option parsing loop exits and the
variable is still set to "unknown".  In other words, the current:

	autosquash=$(ask rebase.autosquash or default to no)
        for each option:
        	if option == --autosquash: autosquash=yes
                if option == --no-autosquash: autosquash=no

is wrong and I think this patch is trying to sweep that real problem under
the rug.  Shouldn't the fix be more like the following, learning from what
was done to the "implied interactive rebase" case, to fix the option
parsing loop?

	autosquash=unknown
        interactive_rebase=unknown
        for each option:
        	if option == --autosquash: autosquash=yes
                if option == --no-autosquash: autosquash=no
                if option == --preserve-merges:
                	preserve_merges=yes
                        if interactive_rebase is unknown:
				interactive_rebase=implied
			if autosquash is unknown:
                        	autosquash=no
		... other options ...
	if autosquash is unknown:
        	autosquash=$(ask rebase.autosquash or default to no)
