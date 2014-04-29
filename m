From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git subtree issue in more recent versions
Date: Tue, 29 Apr 2014 11:22:01 -0700
Message-ID: <xmqqa9b4kncm.fsf@gitster.dls.corp.google.com>
References: <55893188F2F68B4B9819D7F9452F981D09FCDF67@NTXBOIMBX01.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Kevin Cagle \(kcagle\) \[CONT - Type 2\]" <kcagle@micron.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 20:22:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfCfd-0004Gw-5j
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 20:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934042AbaD2SWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 14:22:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56682 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932491AbaD2SWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 14:22:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F66C7FB14;
	Tue, 29 Apr 2014 14:22:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b6LxSHIsc8T4dOkMwVizA2CSYCs=; b=f25nFT
	b31tYaKoYBatLd2DNgpS2BM1f0BuNlQ1TNvCc9OV3u7bAUpSWFjEJeE7VArXHbf1
	q4403I8xXC1mnj0EBpWhY0ahmQ6H5uaAmL5qXMjtM4DhmmghbsT7Q6gQ/g1zVJxk
	/mmTsRlvxfsn+Dw8N/Z/gYen1Uhe3ShqLlVGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WSF9nqUcp+dKxXeqE32omh6jNNdQmoUL
	/MNYtxnvtxXcNFKT5268u0TsvuBic99nnq/Wv4SsLOdk4M9L0uEfc+GNPFXo9eTN
	FjXgYVWJ7PutpbpzylpgsmBeCEQn7hP+JLljL9thTqmygIUwkJCxUY+CeScp6dnH
	hytwr+sh5Ok=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55DFB7FB13;
	Tue, 29 Apr 2014 14:22:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E57C97FAFF;
	Tue, 29 Apr 2014 14:22:02 -0400 (EDT)
In-Reply-To: <55893188F2F68B4B9819D7F9452F981D09FCDF67@NTXBOIMBX01.micron.com>
	(Kevin Cagle's message of "Tue, 29 Apr 2014 00:50:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2951A7B2-CFCB-11E3-9101-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247598>

"Kevin Cagle (kcagle) [CONT - Type 2]" <kcagle@micron.com> writes:

> $ git subtree add -P oldGit https://github.com/git/git.git tags/v1.9.2
>
> Will produce this error:
>
> 10ff115f5c572299de4e04ade0d7adb3c75fbf1f is not a valid 'commit' object
>
> The bug isn't found in 1.7.1 (installed subtree manually) but is found in 1.9.0 and 2.0.0.rc1. 
>
> It's related to the git fetch putting the "wrong" SHA1 in .git/FETCH_HEAD.

The change 7a2b128d is very much deliberate; we wanted not to lose
information that the user was trying to pull a tag not a commit,
because not unwrapping a tag to a commit it points at too early is
essential to allow pulling and merging a signed tag, which was
released as part of the 1.7.9 that happened in late January 2012
(whew, is it already more than two years ago?  time flies).

    commit 7a2b128d13d880635e7317a9208cfa42a660f143
    Author: Linus Torvalds <torvalds@linux-foundation.org>
    Date:   Wed Nov 2 19:19:34 2011 -0700

    fetch: do not store peeled tag object names in FETCH_HEAD
    
    We do not want to record tags as parents of a merge when the user does
    "git pull $there tag v1.0" to merge tagged commit, but that is not a good
    enough excuse to peel the tag down to commit when storing in FETCH_HEAD.
    The caller of underlying "git fetch $there tag v1.0" may have other uses
    of information contained in v1.0 tag in mind.

If the caller of "fetch" (like the codepath in subtree) must see a
commit object, it needs to unwrap the tag itself in the new (eh, not
so new, though ;-) world order.
