From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 04/13] add_ref(): move the call of check_refname_format()
 to callers
Date: Wed, 19 Oct 2011 14:49:53 -0700
Message-ID: <7vsjmobqim.fsf@alter.siamese.dyndns.org>
References: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
 <1319057716-28094-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 19 23:50:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGe1R-0001yF-1s
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574Ab1JSVt5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Oct 2011 17:49:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62987 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957Ab1JSVt4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2011 17:49:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 484716256;
	Wed, 19 Oct 2011 17:49:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=u0Jd6dilr3MM
	92GI81BPD0L+8Pw=; b=im/Pc3cld4TlClLB+hUM+s12cxZVxColMVFW07e0dc/p
	BhbOgwogdEo9Clck7pttyl0FCBqDcQQumnsc0HjEmrmQa2h1vq+1LAJwsEf6yx5/
	hfDvzYi+74y0xnixwI6njvOE1S2PvIczSKykV30JYGPe9xaHDJSIBudaZRz/v90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ca62UQ
	70sH83VOwdpIP7/qdy2CnDB0XfhWbV0e36IAeWefiYbxTtcbNQ/kdXj4AIDBY9ST
	trrya4k27YC+Feb4CXlaJdS8HeXBoj/s0wbsqDuprDqyrRCuIAvZKvng4cwFdmDJ
	xdRWzIBaEFV127tzZrzjrZmKuSjmindQ2tkMA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F3E96255;
	Wed, 19 Oct 2011 17:49:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B12A66254; Wed, 19 Oct 2011
 17:49:54 -0400 (EDT)
In-Reply-To: <1319057716-28094-5-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Wed, 19 Oct 2011 22:55:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 47CD9C02-FA9C-11E0-9AC3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183980>

mhagger@alum.mit.edu writes:

> I'm still not clear on how extra_refs are used.  Are they generated
> from local refs or are they generated from remote refs?  If the
> latter, then it is probably irresponsible not to do *some* sanity
> checking in add_extra_ref() to prevent any chance of refnames like
> "../../../etc/passwd".

No, add_extra_ref() already tells us what their values are, these are
never used to actually read from filesystem. Their refname field has
almost no value other than for debugging and we probably shouldn't even
insist on uniqueness among extra refs or for that matter collision with
the real refs. As I mentioned in an earlier message, their only raison
d'=C3=AAtre is to be found by for_each_ref() that feeds revision machin=
ery with
up to which commits we know we have complete histories for. A sample ca=
ll
chain looks like this:

 - cmd_clone()
  - setup_reference()
   - add_one_reference()
     - add_extra_ref()
       adds refs in other repositories we borrow from as "extra"
  - transport_fetch_refs()
   - fetch_refs_via_pack()
    - fetch_pack()
     - do_fetch_pack()
      - find_common()
       - for_each_ref(rev_list_insert_ref)

That way find_common() thinks histories leading to these extra refs are
already complete on our end (i.e. we have all the necessary objects), a=
nd
by subtracting that from what we are asking from the other end, we can
reduce the amount of history that needs to be transferred.
