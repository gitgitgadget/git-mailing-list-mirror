From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git checkout $tree path
Date: Mon, 03 Oct 2011 09:08:31 -0700
Message-ID: <7vmxdigirk.fsf@alter.siamese.dyndns.org>
References: <7vk48rq854.fsf@alter.siamese.dyndns.org>
 <20111003102647.GD16078@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 03 18:08:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAl4K-0007Uv-Ik
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 18:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756660Ab1JCQIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 12:08:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58830 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664Ab1JCQIf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 12:08:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A84F841D3;
	Mon,  3 Oct 2011 12:08:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=sOIWK1kjwIpdGlU5yrwxw0dreN4=; b=nAjA10hPFn9Eosy3CM0b
	Lqp1ciFa+Lc1srbOfl0RmqvoHSK5Dx/aV5qlzNC6IY9XiTYSVipeqsCo/F0QFsxK
	qNZ3DYPeaBxEOTovlwimIhXGrdFeAmsiKSLgozsl7sUlgmiddv8nFcWhH5M6EwGd
	lZxnjD3j9ICK8Yz+M6xIS7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Z+4K4mqoPKnrj5xaHwJIsGMiK6729Dgk8FH8DAk5e5VXDx
	aui+IRggRpk0JHWRmwRJcQZ9TEGJSRhHELpt9qhlIHZUOzcPzjCJiG1VwRsWu1/o
	tHrqc6EFYpxtDRLLvINts/hLSQv8vV231gmLj2sxmTqZgyIGOuBtbty7R07Nk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FA8141D2;
	Mon,  3 Oct 2011 12:08:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36A7141D1; Mon,  3 Oct 2011
 12:08:34 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1D932BC-EDD9-11E0-A644-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182669>

Jeff King <peff@peff.net> writes:

> But we can't distinguish those two cases without actually having a merge
> base. And this isn't a merge; it's not about picking changes from
> master, it's about saying "make dir look like it does in master". So
> in that sense, the most straightforward thing is your second
> alternative: afterwards, we should have only the files in "dir" that
> master has.

We can think of it both ways, but the "make it look like the other one"
unfortunately is too big a departure from the traditional semantics. At
least I wanted "checkout master -- $path" to mean "I want to copy $path
out of master and _overlay_ that on top of what I have now", similar to
the way how "tar xf master.tar $path" and "cp -r ../master/$path $path"
would be used, so that the command can help the user advance what is in
progress and already underway in $path in the current working tree.

Replacing could be easily done with "git rm -r [--cached] $path" followed
by "git checkout $tree $path" under the original semantics, but overlaying
is not very easily done if "git checkout $tree $path" had your "make $path
look like it does in $tree" semantics.

The change brought in by the RFC/PATCH does change the behaviour, and I am
fairly comfortable now to say that it is a bugfix ("copy and overlay" a la
"tar xf" never clobbers/removes files not in the source, but the current
code does).
