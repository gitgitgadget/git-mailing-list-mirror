From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/8] Fix GIT_CEILING_DIRECTORIES that contain symlinks
Date: Mon, 12 Nov 2012 09:47:25 -0800
Message-ID: <7v4nkuiuhe.fsf@alter.siamese.dyndns.org>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
 <7v7gqkgvxe.fsf@alter.siamese.dyndns.org>
 <CAJDDKr4ki+NjSeuZpAU6bM=YAQ_3mdHCtawstdCqe9Ewvp=arQ@mail.gmail.com>
 <508E0FAC.5050600@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	"Lars R. Damerow" <lars@pixar.com>, Jeff King <peff@peff.net>,
	Marc Jordan <marc.jordan@disneyanimation.com>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:47:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXy6p-0007FQ-0B
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 18:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994Ab2KLRr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 12:47:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43768 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753988Ab2KLRr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 12:47:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB010976A;
	Mon, 12 Nov 2012 12:47:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=EqW1YWkOt08FpMCn/z+lzpHzh9s=; b=qcfqPFHcJfmDZ8/HN+Vn
	cMObaVoPhzZQmsaRfcIDd9tA7ClfIak4s4pQX4XzdipHVoFECu8SJjFi4kBL38nX
	0lJlHCDNz/4E6cCS0b+jMptVSE1l4Knfv4LZtWoO2PXU2E5WlDlnXp/jVakkNWXf
	w3QOpkW1kqoeo19d1jLk/VU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=RtMBk6u+n4eP0JtiDDZxkNUgNKd3OkrecQrEP2OpGqXPkM
	T+CuZ0fow+sYVIzIfOfQb/MuVCQBLWaKPlgO2BVTj1IVyZL+cppWQphN06wp9IbW
	PggB0m2sEQKM6kN3/HgVEgiLyNrNVLxPWuVgNJc8yNtYgfFQE4dDRNVhbxPnI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D84649769;
	Mon, 12 Nov 2012 12:47:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 387B89766; Mon, 12 Nov 2012
 12:47:27 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05ED3224-2CF1-11E2-A9BF-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209505>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The log message of the original commit (0454dd93bf) described the
> following scenario: a /home partition under which user home directories
> are automounted, and setting GIT_CEILING_DIRECTORIES=/home to avoid
> hitting /home/.git, /home/.git/objects, and /home/objects (which would
> attempt to automount those directories).  I believe that this scenario
> would not be slowed down by my patches.
>
> How do you use GIT_CEILING_DIRECTORIES that the proposed changes cause a
> slowdown?

Yeah, I was also wondering about that.

David?

>> Is there another way to accomplish this without the performance hit?
>> Maybe something that can be solved with configuration?
>
> Without doing the symlink expansion there is no way for git to detect
> that GIT_CEILING_DIRECTORIES contains symlinks and is therefore
> ineffective.  So the user has no warning about the misconfiguration
> (except that git runs slowly).
>
> On 10/29/2012 02:42 AM, Junio C Hamano wrote:
>> Perhaps not canonicalize elements on the CEILING list ourselves? If
>> we make it a user error to put symlinked alias in the variable, and
>> document it clearly, wouldn't it suffice?
>
> There may be no other choice.  (That, and fix the test suite in another
> way to tolerate a $PWD that involves symlinks.)
