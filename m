From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] tree-walk: unroll get_mode since loop boundaries are
 well-known
Date: Mon, 04 Apr 2011 09:55:20 -0700
Message-ID: <7v7hba9csn.fsf@alter.siamese.dyndns.org>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
 <1301535481-1085-4-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 18:55:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6n3y-0004xE-R7
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 18:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190Ab1DDQze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 12:55:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab1DDQzd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 12:55:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 75CFA4E27;
	Mon,  4 Apr 2011 12:57:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GF1dk3ipcIv+wzTbcwWOJ5Dexyc=; b=fMegqG
	eEEzTClAAtY76CYQ3oecsOm+d+mB8PHR0zrfB0rqnFxPASSlc1UCPEAYBKhG4aN/
	aw0Oj91TfKhudhVhWf4/85lN64ZLX9i+wglrmaCwdyh30OrCe1q9kJaspFALmHdC
	3wZ6p2YfikX2I+oF5goXjlUnCeY22yFlIm0sA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AWDN28orVMSWD08E1JhhAv0r2eKP14O0
	HX+esvGoM+Ygxs4Fi/eMv7dwpNzNgPEjJFp2ZK7riYIhkDU6girJl/2cLwTLozeS
	35dxJqmGJlmiwFx0PuT1p6v2PfMezg5fQM/KoEkp49rPIN9r0Y1M5p6J6OUP2nGv
	8DTr1p2ooOc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 52BA54E23;
	Mon,  4 Apr 2011 12:57:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 475E14E1F; Mon,  4 Apr 2011
 12:57:14 -0400 (EDT)
In-Reply-To: <1301535481-1085-4-git-send-email-dpmcgee@gmail.com> (Dan
 McGee's message of "Wed, 30 Mar 2011 20:38:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98ECD848-5EDC-11E0-A0D0-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170825>

Dan McGee <dpmcgee@gmail.com> writes:

> We know our mode entry in our tree objects should be 5 or 6 characters
> long. This change both enforces this fact...

I find the implementation later shown in the thread is cleaner, but I'd
comment on the word "enforces" here.

It is more like "versions of git we know how to read from writes mode bits
with 5 or 6 characters---if we see something else, either the tree object
is corrupt, or we are too old to read the new type of entry in the tree
object".

So returning NULL is fine and it tells the caller that we do not
understand the tree object.  The caller says "corrupt tree file" when we
do so here, but this change needs to rephrase it.  If we stopped because
we saw something other than ' ' after the run of octal digits, then we
know the tree is corrupt.  If we saw a three octal digits 644 in the mode
field, terminated with ' ', maybe we are seeing a new kind of tree entry
generated from later versions of git.

Ideally, I'd rather see error checking done even higher layer than
decode_tree_entry() for the "we are too old" case, though.  We should
return mode 0644 in such a case, and let the caller suggest that the
version of git we are running might be too old, or the tree may have been
written by a broken system that tried to mimic git in its error message.
