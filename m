From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] rebase -p: do not redo the merge, but cherry-pick
 first-parent changes
Date: Tue, 22 May 2012 11:23:09 -0700
Message-ID: <7vobpg3wj6.fsf@alter.siamese.dyndns.org>
References: <4FBAA33D.1080703@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Stephen Haberman <stephen@exigencecorp.com>,
	Andrew Wong <andrew.kw.w@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue May 22 20:23:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWtjv-0002YK-19
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 20:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597Ab2EVSXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 14:23:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47512 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711Ab2EVSXR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 14:23:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3AEA880C;
	Tue, 22 May 2012 14:23:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C/kX9hiPk4m7nFPp04Mh7AFmn3s=; b=RcH/Up
	KUZbpyn3lAFOzaqqzHJ2Zgzv2GpzFiuATtsjNaOYfunhKMMeJG3OEWqj5kkfsex3
	1dwqVn8I5vhjCUBSHclXI7yR5g/YXhyDt14sOPNBIKC0iB9raWfqAeGAYmoMV/e2
	5858Jb9PrzBUXWlsjQi8/saYCFuTmU3i2hzxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BcKU24zbd36bCddknrSrESQry0mXsIyW
	fHmWOFTJ2yKuFWCIwSZLuP5utvS3txeBQY+UaYhBb3lxfeGrzsHWtJ+TzBnK3CdC
	yoq8nwnBrT3N+HTKC+F/VM5mbJXI2XCJNyJcrkOuw7TDguGDset73HmNP/20X7pM
	y6hZjEIZkIM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C96B8880A;
	Tue, 22 May 2012 14:23:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61C4E8809; Tue, 22 May 2012
 14:23:11 -0400 (EDT)
In-Reply-To: <4FBAA33D.1080703@kdbg.org> (Johannes Sixt's message of "Mon, 21
 May 2012 22:19:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 300EB742-A43B-11E1-985E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198221>

Johannes Sixt <j6t@kdbg.org> writes:

> When rebase -p had to replay a merge commit, it used to redo the merge.
> But this has drawbacks:
>
> - When the merge was evil, i.e., contained changes that are in neither of
>   the parents, that change was not preserved.

This is a desiable property, and not necessarily limited to "evil" merges
but also applies to everyday conflict resolutions.  Replaying the change
between the merge and its first parent is a way to achieve it, but I think
it also has downsides.  If you are replaying a merge to an updated history
that already contains a part of what is merged, some part of the
difference between the original merge and its first parent already exists
in the commit that the will become the first parent of the replayed merge.

> - The 'git merge' invocation passed the commit message of the old merge
>   commit, but it still obeyed the merge.log option. If it was set, the log
>   ended up twice in the commit message.

This should be fixed independent of this patch, no?  Is it a matter of
just passing --no-log or something, or is there anything more elaborate
necessary?
