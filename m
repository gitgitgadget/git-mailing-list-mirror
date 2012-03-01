From: Junio C Hamano <gitster@pobox.com>
Subject: Re: subtree merges lose prefix after rebase
Date: Thu, 01 Mar 2012 10:30:34 -0800
Message-ID: <7vboognph1.fsf@alter.siamese.dyndns.org>
References: <CALtv3HphaC7d0QyR1DUowHn0Wrmrsw4YGyU4rE8YzhZX3ea6dA@mail.gmail.com>
 <CALtv3HqtdUrRaGWvrwo89r3y1RQ4wy1Bzt5=RhQHaJTXS3gk9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zakaria ElQotbi <zakaria@elqotbi.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 19:30:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Am3-0000Hz-RZ
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 19:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755917Ab2CASai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 13:30:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40557 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755028Ab2CASah (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 13:30:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC5B27887;
	Thu,  1 Mar 2012 13:30:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mFATT+BRKfY0ge+PRPcaA4JA5SI=; b=DHrTBA
	ov5CbPVMXHwhgNiwDvQFnNKbG29AyqEnsCEZfITV3yVR7yIzM3oUXWdIbVQDZROQ
	hxIeRkYLhHMtd45YOnq9iwhhIUdrpf4kVDGCSuAP05Ou5jF7AJMcbGUIv9HB3aQl
	3QRwpxiTFt78arPs9dFXh8fxdT6W2RN6jYHmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MItfhwAF3ngUgLrjrf87FI/tGqyPYV5w
	bo6fBpYm4H0FSV4PEJqiRn9160iDIGPbljaJdcxNrhAW8EbpP+V6ZxKOcWGLz5z+
	1q3LpRNdpQAjufyuBNXVp+YejNKywO3e5OiHAlV0dRCfA5Ra6Q17lUM+lPdeyiaB
	5rpKICFen2M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3BA07886;
	Thu,  1 Mar 2012 13:30:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FD147883; Thu,  1 Mar 2012
 13:30:36 -0500 (EST)
In-Reply-To: <CALtv3HqtdUrRaGWvrwo89r3y1RQ4wy1Bzt5=RhQHaJTXS3gk9A@mail.gmail.com> (Zakaria
 ElQotbi's message of "Thu, 1 Mar 2012 16:18:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3626720-63CC-11E1-BF8D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191954>

Zakaria ElQotbi <zakaria@elqotbi.com> writes:

> why subtree merges lose prefix after an interactive rebase, is it a known
> issue ? or I'am missing somethings:
> ...
> $ git rebase -i -p a6d4e8e # this the hash of "merge b" commit
> $ git commit --amend -m "merge b edit"
> $ git rebase --continue
> $ tree
> .
> |-- C
> |-- projects
> |   |-- a
> |   |   `-- A
> |   `-- b
> |       `-- B
> `-- README

Rebase essentially is a stepwise cherry-pick, and cherry-pick does not see
anything but the trees recorded in the commit being rebased and in its
parent.

Your original history is to merge in projects a, b and c in order,
renaming them using subtree merge to their own subdirectory.  You rebase
the commits after the one that merges b, i.e. the merge of project c, in
that history.  As far as that rebased commit is concerned, the change it
makes relative to its parent commit is to add file C at the root level.
So you are starting from the state you merged a and b into the whole
project, and replaing that commit that adds C at the root level.  That
matches the above picture.

In short, this is expected, because rebase does not know anything about
evil merges made by 'subtree' (or 'ours' for that matter).  And I do not
think there is any plan to make rebase aware of subtree merges.  After
all, subtree merge was invented merely as a short-term hack to serve as a
stop gap measure until submodule support becomes mature.
