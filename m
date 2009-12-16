From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] filter-branch: remove an unnecessary use of 'git
 read-tree'
Date: Tue, 15 Dec 2009 16:19:55 -0800
Message-ID: <7v1vivydlg.fsf@alter.siamese.dyndns.org>
References: <4B274BDE.8000504@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Dec 16 01:20:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKhcm-0005HW-89
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 01:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934164AbZLPAUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 19:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760729AbZLPAUI
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 19:20:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760666AbZLPAUG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 19:20:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D18358886D;
	Tue, 15 Dec 2009 19:20:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9hPYUCZNycdV4N2+v+N6qkbP9qA=; b=EuOfwa
	EbFL8UIlcZaOaacyKphN0rPXyETFb+vgAXFNxoE13/prBBPuns9sWvFKy8NASp2G
	t3VKpGZDSl+yUZPjgvHgpqvK39pOcUrU/3YKUl9T05qWfWd3u1oxpgnr2iFWH8Ci
	K2RXCXYbDoDOzKU1RVVMEO9kFYZ5dbz/4jOqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PUzQNoj5Dq8UULwCWbxU7kPtlS7FQjB5
	vMKMvmP55d0O9EyrSh1R4UXPBosy/e5DdbtkTxKL5uSTQKMS+tyJ43borP9T7OF7
	6E8w+0wRTzVxhILgEGIOP96slqRyrLfBzKa9ktwvOdeie5mPL3gcpGq6pAwstrcq
	mqQCQ7KRvlY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 418B38886C;
	Tue, 15 Dec 2009 19:20:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 670BD88865; Tue, 15 Dec
 2009 19:19:57 -0500 (EST)
In-Reply-To: <4B274BDE.8000504@viscovery.net> (Johannes Sixt's message of
 "Tue\, 15 Dec 2009 09\:42\:06 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C01332E8-E9D8-11DE-903B-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135309>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <j6t@kdbg.org>
>
> The intent of this particular call to 'git read-tree' was to fill an
> index. But in fact, it only allocated an empty index. Later in the
> program, the index is filled anyway by calling read-tree with specific
> commits, and considering that elsewhere the index is even removed (i.e.,
> it is not relied upon that the index file exists), this first call of
> read-tree is completely redundant.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

Very true.  The only thing it would have done is to error out early when
the user mistakenly tried to run the command in a directory in which s/he
does not have write access to, before running potentially expensive
commit listing with rev-list, but then the user would have failed to
create the tempdir before that to begin with.

Will queue, but it doesn't seem urgent to put it in 1.6.6 or 1.6.5.X
maint (i.e. nothing is broken without this patch).

>  Calling read-tree without arguments is not allowed according to the
>  documentation.

I think saying "is not allowed" is going a bit too far.  The documentation
simply does not list it as a _useful_ thing to do, that's all.

By the way, I notice that the command still insists on being run in a
clean work tree with a clean index at the beginning, but isn't everything
done inside the tempdir (i.e. ".git-rewrite" by default) these days,
including the temporary work tree tree-filter creates with "checkout-index
-fqua"?  It is obviously not a topic of this patch, but we may want to
stop doing that if we are not rewriting the current commit (which we will
know by the time we list the commits to be rewritten with rev-list before
actually starting to rewrite).
