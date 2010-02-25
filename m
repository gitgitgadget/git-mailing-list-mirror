From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Different views on a repository
Date: Thu, 25 Feb 2010 09:28:46 -0800
Message-ID: <7vljeh9qcx.fsf@alter.siamese.dyndns.org>
References: <cover.1267029680.git.agruen@suse.de>
 <201002251025.22881.agruen@suse.de> <4B866D60.6040306@drmicha.warpmail.net>
 <201002251535.03334.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Thu Feb 25 18:29:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkhWH-0008DX-Sz
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 18:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933033Ab0BYR24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 12:28:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932906Ab0BYR2z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 12:28:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C03199D3CE;
	Thu, 25 Feb 2010 12:28:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KPKnvwu+hFcBFviBk+aLHDwojck=; b=qNdno1
	Lfc73mylf6jx8B3NWqzUN8S/g18+Q1wVl4nmNksxmKjbYuGA9b552MAsroGAlyzm
	lmu9o1czSTlCjADazODrz+66bdwBjgBWQatAqFjqhZbQPcZLBjqksFlQTDn9fVeX
	ylDGAmKN8x5XiTxcYizgbGAQgztIuK/wXEnXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V54e1WAgGB1JQ1IcKb3nNmioI+tCsPTD
	Cm8jeAWmzVYAQYd7wVGaTSyHBrUgcx24V9/K7w3fCsTy6nO/4l+BF4I6sHjFkirg
	lthT19yjnUrI1bOIBgjzIMLFspQddb/S0ZJMwIZWVSWRXKN2vegPZQWnSRdF7XZ/
	qae1Z0XvaSI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 903939D3CB;
	Thu, 25 Feb 2010 12:28:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4B069D3C9; Thu, 25 Feb
 2010 12:28:47 -0500 (EST)
In-Reply-To: <201002251535.03334.agruen@suse.de> (Andreas Gruenbacher's
 message of "Thu\, 25 Feb 2010 15\:35\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D8AC316-2233-11DF-85CB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141057>

Andreas Gruenbacher <agruen@suse.de> writes:

> No, it's a server side thing.

If it were a server side thing, then I would expect no change to
send/receive pack.  Instead your clients will access distinct URL as if
they are different repositories.

    git clone git://example.com/pub/scm/git/A
    git push example.com:/pub/scm/git/B master
    git pull http://example.com/pub/scm/git/C

They should not have to care that the server is cheating to save disk
space, and they should be able to access your server with Git v1.6.0.

Instead, the server side would:

 - have separate repositories, A, B and C, as normal repositories;

 - these repositories share their object stores by having their
   .git/objects pointing at a shared location via a symlink;

 - on the server side, gc/prune/fsck will have to be updated so that when
   the object store of a repository (say A) is shared with something else,
   they will consider refs in other repositories (B and C) also as the
   root of traversal.

So if this were a server side solution, I would expect the series would
add:

 - a way to set up a shared object store;

 - a way to maintain a list of backlinks to repositories that share an
   object store;

 - a way to create a new repository that shares the object store
   (e.g. create a symlink to the shared store instead of having its own
   .git/objects/, and add itself to the list of backlinks for the shared
   object store);

 - a way to retire an existing such repository (rm -rf and remove itself
   from the list of backlinks);

 - update gc/prune/fsck to honor such a list of backlinks.

This would help a "forks" setup commonly seen at places like repo.or.cz
and github.com among others.

One thing that is missing from the above handwaving outline that your
"different views" offers is a "consolidated view", a pseudo-repository
that allows you to see refs from individual real (from the client's and
project participant's point of view) repositories as if they are in
individual subhierarchies of the ref namespace.

I however suspect that you didn't want such a view in the first place if
there weren't issues around reachability.  In other words, I suspect that
you invented it merely as one possible solution to the reachability issue,
and it was not your goal to have such a consolidated view by itself.
