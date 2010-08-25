From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git fetch --prune --tags origin deletes all remote
 branches origin/*
Date: Wed, 25 Aug 2010 16:52:10 -0700
Message-ID: <7vsk22ntcl.fsf@alter.siamese.dyndns.org>
References: <84CF7907-4493-4110-A852-B949BAE0214C@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Aug 26 01:52:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoPlZ-0003ha-Ib
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 01:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab0HYXwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 19:52:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33887 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631Ab0HYXwU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 19:52:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E33ED014B;
	Wed, 25 Aug 2010 19:52:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l94+f6JSJ7oUg9W6vJ4M85Pkwws=; b=NQ2I4L
	3CwjlTtdqd/XkQ4Td+Z/5zxyFkCgACpwPBjxm1ebh7gjmmh2CL9PpnUDBKeVMZCF
	zubaKPW+EW4sb6e3sn+KdCZMWAxPDAcj0xG8uwbBA7vaL2kgoPAYPDotqNwYk84C
	W/2xw03wwgGL1GVACYNeADLv3LXQBZVvMUxuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TfHAf4SCiIUPhu2Zwb7NTXWTwBgn1dZg
	P6D8Z11tuEKQMg3GNowxKBBQIGo3VJ3sZshusRI3GZ/pCPnY4LHfHA7bopzCPz24
	cRUmMj3MsIsmEz6UI4bZFkYxjoA8upvcIf5OSHx6Sm5bwT6eOJcBwIo+Jdufm0v6
	TvkKdqXDR0A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 180F1D0147;
	Wed, 25 Aug 2010 19:52:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B65AD0143; Wed, 25 Aug
 2010 19:52:12 -0400 (EDT)
In-Reply-To: <84CF7907-4493-4110-A852-B949BAE0214C@sb.org> (Kevin Ballard's
 message of "Wed\, 25 Aug 2010 15\:30\:01 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CA10FC70-B0A3-11DF-B3BC-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154496>

Kevin Ballard <kevin@sb.org> writes:

> Running the simple command `git fetch --prune --tags origin` will delete
> every single remote branch refs/remotes/origin/*, with the sole
> exception of refs/remotes/origin/HEAD. This is wildly unexpected
> behavior. This was reproduced on the tip of the next branch, with
> version git version 1.7.2.2.440.g49ea7.

I suspect "--prune --tags" behaved like that from the very beginning of
the appearance of "--prune", and also it is not limited to --tags.  With
this:

    [remote "origin"]
        url = $over_there
        fetch = refs/heads/master:refs/heads/origin
        fetch = refs/heads/next:refs/heads/next

"git fetch --prune origin master" would probably remove your local next.

get_stale_heads() seems to assume that it has the list of all existing
refs from the remote side available to make its decision.  Unless the
fetch is done using a list of refs configured with remote.<name>.fetch, I
do not think that assumption holds.

  f2ef607 (remote: refactor some logic into get_stale_heads(), 2009-11-10)
  f360d84 (builtin-fetch: add --prune option, 2009-11-10)
