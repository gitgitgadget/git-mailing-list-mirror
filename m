From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git stash: Avoid data loss when saving a stash
Date: Fri, 28 Jun 2013 12:37:18 -0700
Message-ID: <7vbo6qni1d.fsf@alter.siamese.dyndns.org>
References: <20130628150532.GD12252@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Jun 28 21:37:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UseU1-00081X-LA
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 21:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab3F1ThW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 15:37:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930Ab3F1ThV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 15:37:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65C992C103;
	Fri, 28 Jun 2013 19:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7XvlT4tbHkmQWt1R6tsJVINWakc=; b=ftICbG
	zp4yzJS2HjON9lfa1pLSB/BOI/69XiagMCm2iPgrItWdlimewZrYjN3krmFJn98A
	VK0vseAN6ruBI6NyLoje+004uvnxXPczVHQm+upsYFYwJJi5bLKJGtL033nAGnC7
	FBJ/GpWdQ9e6vNU1j6H4sOOBAFj4fuxnqYg+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WG6Fxu88dSEZpdSBK045pQfUnzPuTZWz
	svAv7WhWZYp94ll0FGiv0O22P7kEeG+V4fsNv01w+IJ0SAWtiwP5qLtkBGawo1Cq
	DOUp5e4lj+w9TekM4B4CHVqYe2Nc9FghpTlSoBSCHxIWknC8jGv3OEv65X7pgmz1
	TPLWrh76bfY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C6AE2C102;
	Fri, 28 Jun 2013 19:37:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C171E2C100;
	Fri, 28 Jun 2013 19:37:19 +0000 (UTC)
In-Reply-To: <20130628150532.GD12252@machine.or.cz> (Petr Baudis's message of
	"Fri, 28 Jun 2013 17:05:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 259056B4-E02A-11E2-9DEC-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229229>

Petr Baudis <pasky@ucw.cz> writes:

> diff --git a/git-stash.sh b/git-stash.sh
> index 1e541a2..3cb9b05 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -258,6 +262,12 @@ save_stash () {
>  		say "$(gettext "No local changes to save")"
>  		exit 0
>  	fi
> +	if test -z "$untracked$force" -a -n "$(git ls-files --killed | head -n 1)"; then
> +		say "$(gettext "The following untracked files would NOT be saved but need to be removed by stash save:")"

I think "ls-files --killed" was not adjusted for the new world order
when submodules were introduced.  With this change, you see t7402
break, even though "git status" would say

# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working
#   directory)
#
#       modified:   file
#       modified:   submodule (new commits)

The path "submodule" in HEAD and the index is already submodule, so
"stash save" that reverts to the original state will _not_ have to
kill it, but the new check triggers it.

Exactly the same breakage this patch introduces triggers in t7610,
too.

I think another patch to teach "ls-files --killed" what to do with
submodules is needed as a preliminary step before this patch.
