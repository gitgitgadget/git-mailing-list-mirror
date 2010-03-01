From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] make union merge an xdl merge favor
Date: Mon, 01 Mar 2010 09:28:16 -0800
Message-ID: <7veik4t0i7.fsf@alter.siamese.dyndns.org>
References: <972adf380be481b5e8d031481586e9c34da2cbb7.1267385538.git.bert.wesarg@googlemail.com> <17999fdb3ff374156acb7fc670426265fa27b94b.1267385538.git.bert.wesarg@googlemail.com> <7vwrxx2k29.fsf@alter.siamese.dyndns.org> <36ca99e91002282257i7f07f035o15d8d64e062ee94e@mail.gmail.com> <7vaausza8v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 18:28:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm9Py-0000eI-Od
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 18:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519Ab0CAR20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 12:28:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab0CAR2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 12:28:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 358919E676;
	Mon,  1 Mar 2010 12:28:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=VVkw9MW+Yqcsdv7VnfsrBxb0pbw=; b=L4sktxkJIBGF3teQHXxy0CS
	WHeojSJc6Bg2G/PCi5zu34EGAdwT/DkfXopZOaY+rwKP6/PdiEb/7FWTBKHiPgT4
	cWvKG2aozuYeUUSm5IT2hMW9o0HXOz+OYCiGpnE/JkUG8aGO8G5uCzEC3w58XcuZ
	53bY0EKE+5Z5q07Al5J8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=B5KxDCfXOp3CqAFJW00nQdyYHLgGfvY8abwnFC0ol7l3qenqS
	Yx6OthJ8cJEm3uvXkzdyVbQ1NCQ8pOIRk4fZU+4zfH0BQkmXTHLo3Y5MHT4Cq72Y
	X2IXEJKMvnJ9IfPDNOqbAEzis+4NGFmVZzPliwVFoYwnxF9T379YGPSRJ4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E87FF9E675;
	Mon,  1 Mar 2010 12:28:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18A289E66E; Mon,  1 Mar
 2010 12:28:17 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D586EAEC-2557-11DF-AEB4-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141337>

Junio C Hamano <gitster@pobox.com> writes:

> I am mildly against "merge-file --union" in the first place.  The part I
> actually liked in [2/3] was the removal of postprocessing.

Actually I take the first sentence back.  The --union option given to
merge-file is comparable to --ours/--theirs that let you (a Porcelain
writer using the command) access the ll-merge machinery to resolve
conflicts in favor of one side on contents stored in an arbitrary
temporary filename (or even outside a git repository).  So as a feature
I think addition of "union" is in line with what we already have.

But I at the same time I think that we could add the feature while making
existing --ours/--theirs options redundant (and deprecatable if we want to
in the longer term), if the attributes mechanism is made available to us
(e.g. add "--attribute-path=<use attributes for this path>" option, and/or
perhaps add "--attributes=<use this set of attributes>" option) directly
from the command line.

I doubt "checkout --union" is a good idea, though.  Its --ours/--theirs
options do not have anything to do with merge (it specifies _what_ to
checkout, not _how_), and the comparison I made in the previous paragraph
for merge-file does not apply.

It however is plausible that in a scenario where:

 (1) you ran "git merge" (or anything that results in conflicts) and got a
     conflict; and

 (2) you know using other ll-merge backend, perhaps a custom one you have
     that is accessible via ll-merge, would have produced a better result.

it might be useful if you can say "forget this failed auto-merge; attempt
the same merge for the path but using this different ll-merge backend".
I don't think that feature belongs to "checkout", though.
