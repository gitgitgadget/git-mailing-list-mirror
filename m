From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git_checkattr() is inefficient when repeated [Re: [PATCH 00/11]
 Micro-optimizing lookup_object()]
Date: Mon, 15 Aug 2011 16:19:00 -0700
Message-ID: <7vliuujmaj.fsf@alter.siamese.dyndns.org>
References: <1313085196-13249-1-git-send-email-gitster@pobox.com>
 <201108121759.24884.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 16 01:19:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qt6R4-0001n4-68
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 01:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075Ab1HOXTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 19:19:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38451 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492Ab1HOXTD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 19:19:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EA7446B4;
	Mon, 15 Aug 2011 19:19:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZHDE0/SQjKzy9beiVePlnLfLFqw=; b=gjSKDu
	9PPzFKa6mDLce1Hf86q1AD7GNwzvGFmtxZANuSW1PNR129a93zHkdaIlRVzVVK0I
	Z4NusnhSc4FAwPiCp/Moe19asW0ZkLfd8M7VyxiXNORomaEzd+eaIfvVXOH2CcvL
	YCm7VUaqK9pKHp8obpjimAvm+hQseCz5n9J+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dS79Fl1az9rUQxF+5+qkwJH6l0yKSufR
	aotTQydbY7itb31GQbVywFsGMYp14ascYhJuHOrYuG/bE3o+LukM6ReqmFc8BcZi
	08q4P0vaj/7gX+OX4NVw8SHwl+zLzTGI818mqV2/g6SzDFB44tudIxvoLKcVYbaQ
	IBM9Rv5aEkY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9308446B3;
	Mon, 15 Aug 2011 19:19:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A08746B2; Mon, 15 Aug 2011
 19:19:01 -0400 (EDT)
In-Reply-To: <201108121759.24884.trast@student.ethz.ch> (Thomas Rast's
 message of "Fri, 12 Aug 2011 17:59:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F62FABD6-C794-11E0-B049-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179394>

Thomas Rast <trast@student.ethz.ch> writes:

> Which would be a 4.5% speedup.  Obviously that won't quite be
> attainable since we want the attributes mechanism to work, but we
> still shouldn't have to open 4398 .gitattributes files when there are
> only 8 .gitattributes plus one .git/info/attributes.

True. At runtime, the attribute mechanism wants a stack of per-directory
attributes it can walk up to find the applicable ones maintained for the
directory it currently is looking at, and the elements near the leaf are
popped from the stack to be discarded when the caller goes on to inspect
paths in a different directory (IOW the machinery is optimized for callers
that walk the paths in order, without randomly jumping around).

But at least within a process like pack-objects that are known to be long
lived, we should be able to instead _keep_ the elements that are popped
when we leave directories at deeper levels, and bring them back to the
stack when the caller asks for a path in that directory later, without
going back to the filesystem.
