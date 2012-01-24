From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Fail to add a module in a subdirectory if module is
 already cloned
Date: Tue, 24 Jan 2012 13:24:15 -0800
Message-ID: <7vhazk3ibk.fsf@alter.siamese.dyndns.org>
References: <jfmvpp$4v7$1@dough.gmane.org> <4F1F1E5F.2030509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jehan Bing <jehan@orb.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 24 22:24:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpnqp-0000Nr-CW
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 22:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757544Ab2AXVYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 16:24:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757531Ab2AXVYS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 16:24:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 690B766C7;
	Tue, 24 Jan 2012 16:24:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LEhMPggiJTnHnJSmlIDWZUkIZpM=; b=MH/Smv
	JmiairA+PJIDPDrTued9qUFhiM+XsGz4Vgmvf4aOyUdJw3R92/w8CMR9grcERfyN
	NcjdmyFvsIj/Gfj6XClDzSBvlZH5k3JYY8Sv6gV8P6M1z0iHrXJ9OcsNWdEn13D1
	WOXJbvMoz1rHYwlF0SlYcCbgfV6zCaitU52YU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ayd3sxudUxW3e/SzVIHRtIzL+tuNmsgB
	chgj7EB9vIco2Lp7X/C/x1v+GaLfwcBOWoa96GF/iTfbtDMzlkDsnDwpFl4w6Xz4
	1qvM/qgefKjAPkCT+6O4lsi7xR5e0/qz7YOmuFW6W8dtc5L4MyZ91AQAFrY8r7/A
	iqunMEWSLhg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6030566C6;
	Tue, 24 Jan 2012 16:24:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4EF466C4; Tue, 24 Jan 2012
 16:24:16 -0500 (EST)
In-Reply-To: <4F1F1E5F.2030509@web.de> (Jens Lehmann's message of "Tue, 24
 Jan 2012 22:10:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C52FBB0E-46D1-11E1-96B1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189071>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> The reason for this bug seems to be that in module_clonse() the name is
> not properly initialized for added submodules (it gets set to the path
> later), so the correct amount of leading "../"s for the git directory
> is not computed properly. The attached diff fixes that for me, I will
> send a patch as soon as I have extended a test case for this breakage.
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 3adab93..9bb2e13 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -131,6 +131,7 @@ module_clone()
>         gitdir=
>         gitdir_base=
>         name=$(module_name "$path" 2>/dev/null)
> +       test -n "$name" || name="$path"

This somehow smells like sweeping a problem under the rug. Why doesn't
module_name find the already registered path in the first place?

I see "module_name" calls "git config -f .gitmodules" and I do not see any
cd_to_toplevel in git-submodule.sh that would ensure this call to access
the gitmodules file at the top-level of the superproject. Is that the real
reason why it is not finding what it should be finding?
