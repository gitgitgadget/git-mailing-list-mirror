From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] avoid SIGPIPE warnings for aliases
Date: Wed, 09 Jan 2013 13:49:41 -0800
Message-ID: <7vehhu3u2y.fsf@alter.siamese.dyndns.org>
References: <20130104124756.GA402@sigill.intra.peff.net>
 <7vr4lu3wx7.fsf@alter.siamese.dyndns.org>
 <20130109205116.GA24605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bart Trojanowski <bart@jukie.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 09 22:50:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt3XB-00006p-E1
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 22:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933088Ab3AIVtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 16:49:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49555 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932894Ab3AIVto (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 16:49:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC01AAA12;
	Wed,  9 Jan 2013 16:49:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gPxn1KefHCcam3/hTW0uLoCxqHM=; b=Crl5NW
	DupGerxQFuGIku1v5A41P27rg7lmcINWCmDKyaVr10196n50W6PP+7GHRU6Kab2V
	bGdDhGO6bqaenjKrYdkpxwILNno4eeBIkIE9qODruOP44+ASIQQQJqwO+8zuUDvA
	cDuagrUS3KXQ1Cy1JgX/HVH2enBBylGp6is4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wKFw8lVHXex1ApGNUXg1tDbgixrkd9sM
	i1L6GfvOrtnsmj5i3M/Pt10UGCMMGB2CGFpOzpOlT5udircEnHrmwkarXRi+1Ijv
	W+FYYLbX1NfUuwQaycHSDXw4TzDIVCr6SnEJXwcCzo55a2/+auUkF9d7zWqjodcS
	WHmuCU2T80k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E1C4AA11;
	Wed,  9 Jan 2013 16:49:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B45CAA10; Wed,  9 Jan 2013
 16:49:43 -0500 (EST)
In-Reply-To: <20130109205116.GA24605@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 9 Jan 2013 15:51:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79ED82AE-5AA6-11E2-A3C0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213108>

Jeff King <peff@peff.net> writes:

> But we still say "error: ... died of signal 13", because that comes from
> inside wait_or_whine. So it is a separate issue whether or not
> wait_or_whine should be silent on SIGPIPE (we already are on SIGINT and
> SIGQUIT, as of some recent patches).
>
> The upside is that it is noise in this case that we would no longer see.
> The downside is that we may be losing a clue when debugging server
> problems, which do not expect to die from SIGPIPE.  Should it be an
> optional run-command flag?

Do we know if we are upstream of a pager that reads from us through
a pipe (I think we should, especially in a case where we are the one
who processed the "git -p $alias" option)?  Is there any other case
where we would want to ignore child's death by SIGPIPE?  If the
answers are yes and no, then perhaps we can ask pager_in_use() to
decide this?
