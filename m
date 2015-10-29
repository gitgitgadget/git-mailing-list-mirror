From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-fetch pulls already-pulled objects?
Date: Thu, 29 Oct 2015 10:32:06 -0700
Message-ID: <xmqqd1vxshrd.fsf@gitster.mtv.corp.google.com>
References: <D256A718.1373A%strager@fb.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Matt Glazar <strager@fb.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 18:32:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zrr3e-00071q-Hz
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 18:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757066AbbJ2RcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 13:32:09 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756910AbbJ2RcI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 13:32:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A64A226498;
	Thu, 29 Oct 2015 13:32:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IBFyhNjM8um84aep1mHn3bpsxUI=; b=TYojVN
	NohbxJITuPH7JwQENV9HSYW/mH6M6U0QY2HkjP41MzHxtdioHDQSo14bSKH6CZSE
	r12aHshDfmZXXmp3FOJnEu4y815WXFSZ3ywORugoOb/3YgMEsKOaVM6QvyKaKmNw
	r4/ovqT0Z1MNUzL3UEtBxOcl7YYRdb0y1SYdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GUK5Xv0wA6Lu2HN8T4B6xPH3mdCFXPJO
	jUlYhNim49RJsfsgqRkB1K5agoW+7EoTfOkJPSJNBM5nJn+Nzm3x9lYJ7ALtWWOT
	8x4X/Y2h7nQ3lVFlonjupLIgbrrLcwDI3q4VkscXBhssAOJfyZp0PRXUcL1HDx0j
	zIITVY9YdY8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 953B426497;
	Thu, 29 Oct 2015 13:32:07 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1F65426494;
	Thu, 29 Oct 2015 13:32:07 -0400 (EDT)
In-Reply-To: <D256A718.1373A%strager@fb.com> (Matt Glazar's message of "Wed,
	28 Oct 2015 23:28:24 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FA081908-7E62-11E5-B9BC-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280449>

Matt Glazar <strager@fb.com> writes:

> On a remote, I have two Git commit objects which point to the same tree
> object (created with git commit-tree).

What you are expecting _could_ be implemented by exchanging all
tree and blob objects sending and receiving sides have and computing
the set difference, but the sender and the receiver do not exchange
such a huge list.

The object transfer is done by first finding the common ancestor of
histories of the sending and the receiving sides, which allows the
sender to enumerate commits that the sender has but the receiver
doesn't.  From there, all objects [*1*] that are referenced by these
commits that need to be sent.


[Footnote]

*1* There is an optimization to exclude the trees and blobs that can
be cheaply proven to exist on the receiving end.  If the receiving
end has a commit that the sending end does *not* have, and that
commit happens to record a tree the sending end needs to send,
however, the sending end cannot prove that the tree does not have to
be sent without first fetching that commit from the receiving end,
which fails "can be cheaply proven to exist" test.
