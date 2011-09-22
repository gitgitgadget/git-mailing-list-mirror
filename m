From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diff_index: honor in-index, not working-tree,
 .gitattributes
Date: Thu, 22 Sep 2011 15:39:20 -0700
Message-ID: <7v8vpgxkvb.fsf@alter.siamese.dyndns.org>
References: <1316727861-90460-1-git-send-email-jaysoffian@gmail.com>
 <1316727861-90460-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 00:39:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6rvV-0004k0-DX
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 00:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173Ab1IVWjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 18:39:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42182 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754099Ab1IVWjY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 18:39:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A023B557C;
	Thu, 22 Sep 2011 18:39:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B/yeoL88gM1VVFQylZdw5MZ6XsQ=; b=cPf8Cd
	AdYo1JSr/jyIzABzy2ZzNEdpgaiMH8/U/mL4uSzLwTeOH0kyuoallh57ihn0Kmmv
	8P1A+vDIXFYR91lkXrZ+ppTV9WVrSDepPIgB4snIIUCLcpiMvMpVD+bBPZI/V+L7
	R2TOHeZSjUbfus1wIMYeuYn1148om6y0kT0g0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kqw10pT0PQeUkjpGxyVwYCQRPVRv7+TO
	xnrI+7NwudBjQN/iGoxMQv7LF2hPC83QaY6GTsWZM5UYLtdv9vHjb6TNsmcPdQFH
	4+dHaa0nG9o7G7CAu424OuGS6Xy48TMOAMQ1mBD9axf4zpPCA2ZLPg58ph7vlDsg
	h5eiTTnCcQo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97C62557B;
	Thu, 22 Sep 2011 18:39:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21A20557A; Thu, 22 Sep 2011
 18:39:22 -0400 (EDT)
In-Reply-To: <1316727861-90460-2-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Thu, 22 Sep 2011 17:44:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B759C3B6-E56B-11E0-B5FD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181931>

Jay Soffian <jaysoffian@gmail.com> writes:

> When diff'ing the index against a tree (using either diff-index
> or diff --cached), git previously looked at .gitattributes in the
> working tree before considering .gitattributes in the index, even
> though the diff itself otherwise ignores the working tree.

We can take attributes only from one place (so far from the working tree
and perhaps from the index), people had to live within the limitation that
comes from the "single source only" semantics. It also happens to be
easier to understand (recall the complexity of the examples Jeff gave
about "textconv" during "diff" which ideally should apply from its own
side and "funcname", which does not even have a right answer).

In practice, because development progresses by making everything
(including the .gitattributes file) better, I think "use the newer one"
would be a good compromise when we have two possible sources to grab
attributes from but we can only use one source.

In that sense, I am somewhat skeptical about what this patch tries to
do. The working tree is where people make the progress to update the
index.

A related tangent.

I think the logical conclusion of assuming that we will keep the "single
source only" semantics (which I think we will, by the way, unless I hear a
concrete proposal to how we apply attributes from more than one sources in
what way to which side of the diff) is that a patch might be an
improvement over the current behaviour if it teaches "diff-tree" to read
from the tree and populate the in-core index (never writing it out to
$GIT_DIR/index) from the postimage tree (i.e. "diff preimage postimage" or
"diff -R postimage preimage") when it is run in a bare repository. It
would be a regression if the attributes mechanism is used for auditing
purposes (as we start reading from a tree that is being audited using the
very attributes it brings in), though.
