From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can't git stash after using git add -N
Date: Tue, 15 Mar 2016 21:51:35 -0700
Message-ID: <xmqqvb4n58ko.fsf@gitster.mtv.corp.google.com>
References: <20160315230754.GA12058@cloud>
	<xmqq8u1j7193.fsf@gitster.mtv.corp.google.com>
	<20160316020000.GB12130@cloud>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 05:51:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag3Qs-0004s1-Lk
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 05:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934412AbcCPEvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 00:51:39 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54390 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750962AbcCPEvi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 00:51:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E8BB24537F;
	Wed, 16 Mar 2016 00:51:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WrP19+lI9gqW2UCG1AotqiD/PmY=; b=cmOtG8
	kBpOYDQ9KdDbDlvcpUSvr2wsp5sxGoNvuuqsp1ZhdM+saJd/QA2lbnTrTmFbTGiE
	pCKVll+Tf10nbSUitaVnDdOIfixRA6zEfrUVmtov+y/tDNf+Ebs3GZ3xVEXE/DeU
	iZRkJKXdUAttEBlcNFaUkbxD8KsHOn6V42Ioo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BfVHxHtSsm9qrcCrjQgrWHshyQIeg+gm
	Kja2i3nHcl/Akh+UvENoVsBUGiYw/xaAzONXji8WVPcX7Ie+eqOMbki2E54jo9Gy
	Q/HUBc5LEMEbskBYo+GlD/p29l59JaabfpEwkvsm8pZc/8DiNEYa3u8rjXYwoQzz
	0zGqfq35tGU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DD4274537E;
	Wed, 16 Mar 2016 00:51:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 61D264537C;
	Wed, 16 Mar 2016 00:51:36 -0400 (EDT)
In-Reply-To: <20160316020000.GB12130@cloud> (Josh Triplett's message of "Tue,
	15 Mar 2016 19:00:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C36B7182-EB32-11E5-B176-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288945>

Josh Triplett <josh@joshtriplett.org> writes:

> As far as I can tell, if I run "git add -N" on a file, and then commit
> without adding the file contents, it gets committed as an empty file.

Is that true?  Git once worked like that in earlier days, but I
think write-tree (hence commit) would simply ignore intent-to-add
entries from its resulting tree.

> Could stash save it exactly as if I'd done "git add" of an empty file at
> that path and then filled in the contents without adding them?

As I said, there is no space for a tree object to say "this one
records an empty blob but it actually was an intent-to-add entry"
and "this other one records an empty blob and it indeed is an empty
blob".  So "stash pop" (or "stash apply") would fundamentally be
unable to resurrect the exact state after "add -N".

>> "git rm --cached" the path and then running "stash save" would be a
>> workaround, but then you'd probably need to use "--untracked" hack
>> when you run "stash save" if you are stashing because you are going
>> to do something to the same path in the cleaned-up working tree.
>
> Right; I do specifically want to save the working-tree files.

Then "git add" that path before "stash save" would probably be a
better workaround.
