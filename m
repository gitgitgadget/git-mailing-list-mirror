From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On refreshing the index
Date: Sat, 13 Mar 2010 14:32:32 -0800
Message-ID: <7vmxyb3la7.fsf@alter.siamese.dyndns.org>
References: <loom.20100311T191149-453@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 23:32:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqZsy-0000sR-BO
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 23:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759367Ab0CMWcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 17:32:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759356Ab0CMWci (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 17:32:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CEB9A15EC;
	Sat, 13 Mar 2010 17:32:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Nq+p5fxveqIrEhf4jCUb3jTo4is=; b=pg+cd/c1zF7lzEtxVXKsx0Z
	vsIOl8f6eSxiIJcvFiNg9Eh1iC+ONWGKNukUR5qh30qDemKJT7kjqMyYVDWVQHPK
	QwYBMNgArVI+OfceyrOfz6o+FpppRVFD2LNNXrR+hhgkKnEE5bx7EIpoWt1yvplp
	ulGFGez5Vboc7tesq6x0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=sTDjG7bnQ/APeFG9zzdFr31eHMBUuIgn2j2dL851JnAgfP4hB
	i7d/AE2QitNjNpwGKb7EOOcyJ1ub2lJSiZEyXIhEQ+U2eYXuhAzFEhfx8ISBpT5Y
	sxb48OGRE1/0d/MMNSQD3S6X+K5vOFhTXdsB81MprA81szSeZD+jutOe0s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BA49A15EA;
	Sat, 13 Mar 2010 17:32:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95376A15E7; Sat, 13 Mar
 2010 17:32:33 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 52E487E6-2EF0-11DF-97BB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142117>

Sergio Callegari <sergio.callegari@gmail.com> writes:

> If I run git status, git runs filters on a couple of opendocument files for
> which a filter is defined
>
> GIT_TRACE=1 git status
> trace: built-in: git 'status'
> trace: run_command: 'rezip -p ODF_UNCOMPRESS2'
> trace: exec: 'sh' '-c' 'rezip -p ODF_UNCOMPRESS2' 'rezip -p ODF_UNCOMPRESS2'
> trace: run_command: 'rezip -p ODF_UNCOMPRESS2'
> trace: exec: 'sh' '-c' 'rezip -p ODF_UNCOMPRESS2' 'rezip -p ODF_UNCOMPRESS2'
> # On branch M05
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #       WIP/
> #       program.txt
> #       program.txt~
> nothing added to commit but untracked files present (use "git add" to track)

What does "git diff-files" and/or "git diff-index HEAD" say at this point?
If they do not say there are no difference, that means that the file on
the filesystem and the blob registered in the index are different, even
though after transmogrified with rezip (whatever it does) these two
different blobs may look the same.

"update-index --refresh" marks index entries for paths whose files on the
filesystem are identical to the blobs registered for them in the index as
up-to-date, so that later comparison do not have to inspect contents
(instead, it can notice something has changed by looking at stat data such
as file timestamps).

I think the difference between "may look the same" and "identical" is what
you are seeing.  Try "git add" on those paths and see what happens.
