From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Handle double slashes in make_relative_path()
Date: Sat, 23 Jan 2010 12:04:00 -0800
Message-ID: <7vwrz8bnbj.fsf@alter.siamese.dyndns.org>
References: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch> <4B59637D.4090503@viscovery.net> <201001231240.28138.robin.rosenberg@dewire.com> <201001231409.30706.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 23 21:04:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYmDV-0004BT-73
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 21:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219Ab0AWUEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 15:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753088Ab0AWUEP
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 15:04:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995Ab0AWUEO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 15:04:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D470939DB;
	Sat, 23 Jan 2010 15:04:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=xuKc3HDygg3dYFDx+TpvLfR9cPU=; b=VYDTsZCz/BiNMPTEVJgUXXK
	rIe3XFAyJEq3bDokgAG71BB/AQKGiI3L488HesAsPmr7IHTiH4gj8O1EO64LagZ8
	+55BOyLHZ9+npCsOFoPob4DsQdO+SpQ41JrxhSUMmXAUJvnpOH99vMouCjmAOf4b
	1R6myeD4wZ93VsLS8vRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=GeDRX/s6UKhHN7IM2X8biXmEeUMNS3edasWKMPQq5zdhRZeX1
	ksDq4xue8bLRh5+Tjff28EzuKKdEYimcsriNAxhJCizdeeBaLaCPhaLNb6JKL2N8
	aji9dhnCmTf3rIU/oDe/vD3I+JVPjQAQfXeYqYMJah6cW7E0ZwAJ7hs0P0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F03C939D9;
	Sat, 23 Jan 2010 15:04:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E104939D4; Sat, 23 Jan
 2010 15:04:01 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 774F7E68-085A-11DF-800F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137857>

Johannes Sixt <j6t@kdbg.org> writes:

> On Samstag, 23. Januar 2010, Robin Rosenberg wrote:
>> It seems this function does something unhealthy when you pass a path of the
>> form //server/share. On windows dropping the double // at the beginning
>> makes it a different path since // is the UNC prefix.
>
> There is no problem in practice.
>
> The function returns either the input unmodified, or it strips also at least 
> one directory component, except when base is only "/" (or "//" or "///"...). 
> I said in practice, because on Windows it does not make sense to invoke git 
> with (literally)
>
>    git --git-dir=//server/share/repo.git --work-tree=/ ...
>
> i.e., without a drive prefix before the slash of --work-tree.

If you did this:

    git --git-dir=//reposerver/repo.git --work-tree=//buildserver/workarea

then we would say "one is not a prefix of the other", so it would be
fine.  At least I don't think the "recover from unintentionally doubled
slashes in user supplied path" fix is introducing any new problem in that
case.

If on the other hand, if you did this:

    git --git-dir=//server/repo.git --work-tree=//server/workarea

that also would be Ok.

I think one issue is what happens when you did this:

    cd //server
    git --git-dir=//server/repo/repo.git --work-tree=repo

Does msysgit implementation figures out that the work tree is located at
"//server/repo" when get_git_work_tree() is asked to produce an absolute
path so that it can be compared with //server/repo/repo.git with the code?
If it does (with the leading double slash), then "doubled slahses fix" is
a regression we should do something about it.  If it doesn't, then it
probably doesn't matter.
