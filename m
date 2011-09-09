From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Improved infrastructure for refname normalization
Date: Fri, 09 Sep 2011 10:57:34 -0700
Message-ID: <7vzkidtx81.fsf@alter.siamese.dyndns.org>
References: <1315568778-3592-1-git-send-email-mhagger@alum.mit.edu>
 <4E6A1D7D.6050602@gmail.com> <4E6A31D1.5020404@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, git@vger.kernel.org, cmn@elego.de
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 09 19:57:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R25Kg-0008BG-VC
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 19:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758757Ab1IIR5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 13:57:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50019 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205Ab1IIR5h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 13:57:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 070DE5D7A;
	Fri,  9 Sep 2011 13:57:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BjJUgm7qB3enrNHArltVKeWCoMg=; b=lpXyDU
	6TCr6XcxtHrThlzzhpF6gRTokiSfABd8CFt5CQHxtERYfJgsEWH4nuUgi4HHUMl7
	jcVpE3bSzTA/B7pKIJuSWhC5369LWsyoPIG20P5BsXsA8zSw9cswE38VCs+c+dlG
	6GSc/SASn5h6L99DuCqNvuptARH+58brHJmz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tkTQNBGukspFJ7EnP6wihJCiNipP6YC3
	PMhYcQpd+tj8HOuD2jRKVuEaz4We/zCWT+bGLJPLnre6Ezh38B5NfFOCEwOfA989
	AADrQLxRURhnATSi8BIGuc7aq95xcg0ETpIL2HZF+qYEv2cWrNMMk7YZDEFpK/AY
	yoU7BS8wyfk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F10275D79;
	Fri,  9 Sep 2011 13:57:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 847C75D77; Fri,  9 Sep 2011
 13:57:35 -0400 (EDT)
In-Reply-To: <4E6A31D1.5020404@alum.mit.edu> (Michael Haggerty's message of
 "Fri, 09 Sep 2011 17:33:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32DD5A16-DB0D-11E0-9323-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181100>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The library could do the normalization, but
>
> 1. It would probably cost a lot of redundant checks as reference names
> pass in and out of the library and back in again
>
> 2. Normalization requires copying or overwriting the incoming string, so
> each time a refname crosses the library perimeter there might have to be
> an extra memory allocation with the associated headaches of dealing with
> the ownership of the memory.
>
> 3. The library doesn't encapsulate all uses of reference names; for
> example, for_each_ref() invokes a callback function with the refname as
> an argument.  The callback function is free to do a strcmp() of the
> refname (normalized by the library) with some arbitrary string that it
> got from the command line.  Either the caller has to do the
> normalization itself (i.e., outside of the library) or the library has
> to learn how to do every possible filtering operation with refnames.

4. The caller needs to be corrected to pay attention to the normalization
the library did for it. Your code may use a string as a ref and then
create something based on the refname; illustrating with a fictitious
example:

	ref = make_branch_ref("refs/heads/%s", branch_name);
        update_ref(ref, sha1);
        write_log("created branch '%s'", branch_name);

Even though make_branch_ref() may have removed duplicated slashes from the
name in "branch_name" when it computed "ref", the log still will record
unnormalized name.

I think the callers need to be aware of the normalization in practice
anyway for this reason, and a good way forward is to give the callers a
library interface to do so. It might even make sense to make the other
parts of the API _reject_ unnormalized input to catch offending callers.

By the way, does this series introduce new infrastructure features that
can be reused in different areas, such as Hui's "alt_odb path
normalization" patch?
