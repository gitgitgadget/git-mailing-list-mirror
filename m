From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] push: Add support for pre-push hooks
Date: Mon, 14 Jan 2013 19:12:11 -0800
Message-ID: <7vtxqj5ed0.fsf@alter.siamese.dyndns.org>
References: <1358054224-7710-1-git-send-email-aaron@schrab.com>
 <1358054224-7710-3-git-send-email-aaron@schrab.com>
 <7vip6z7056.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 04:12:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuwx0-0006j5-Uv
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 04:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869Ab3AODMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 22:12:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54580 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873Ab3AODMO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 22:12:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3389B603;
	Mon, 14 Jan 2013 22:12:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mSCZrgieBqAD/F5cF/7dHGt9oBE=; b=n7mgpV
	LxWSoq+8ZN8Ad0YfLMPS8GmzoAZ7/vcNRZzwCHIgaJzB0E9+es+mlbZeKEwxhFP6
	Nb8/PbEY67CRWcz2zB7DdKrvfgXPf73UqwuV7UjOz6iLj1Z+6e1x2x7vErQqfJGq
	zb9Tm8KMBusOPte2vrGMZosacckoZFuM4ESno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B+TV0G+odaptBOdAY2XGthyxBk6yOADZ
	Tvmx0NwIkHphdEIpRqWVubagdlFzA787U1GtMfjat14xmgeGL2DvyR7nZOgrRm+1
	SVzfVBO+7p2e64cIZykxZN8zKfw/G8AaJxv85kvfVuVRGEakVSPKB0lRYgvhGuSw
	s6yceeRF60Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4905B602;
	Mon, 14 Jan 2013 22:12:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DE43B5FE; Mon, 14 Jan 2013
 22:12:13 -0500 (EST)
In-Reply-To: <7vip6z7056.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 14 Jan 2013 16:36:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B9D4EFA-5EC1-11E2-8F27-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213572>

Junio C Hamano <gitster@pobox.com> writes:

> At least the attached patch is necessary.

Sorry, but the last hunk (see below) is not.  It breaks the hook.

> In the longer term, we may want to discuss what should happen when
> the hook exited without even reading what we fed.  My gut feeling is
> that we can still trust its exit status (a hook that was badly coded
> so it wanted to read from us and use that information to decide but
> somehow died before fully reading from us is not likely to exit with
> zero status, so we wouldn't diagnosing breakage as a success), but
> there may be downsides for being that lax.
>
> If we decide we want to be lax, then the call site of this hook and
> the pre-receive hook (is there any other "take info from the
> standard input" hook?) need to be modified so that they ignore
> sigpipe, I think.
>
> There was a related discussion around this issue about a year ago.
>
> http://thread.gmane.org/gmane.comp.version-control.git/180346/focus=186291
> ...
>

> @@ -38,6 +40,7 @@ COMMIT2="$(git rev-parse HEAD)"
>  export COMMIT2
>  
>  write_script "$HOOK" <<'EOF'
> +cat >/dev/null
>  echo "$1" >actual
>  echo "$2" >>actual
>  cat >>actual

As this one wants to keep the incoming data to "actual", we do not
want the extra "cat" to slurp everything in.  Sorry for not being
careful.
