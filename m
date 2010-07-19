From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 05/13] parse the -L options
Date: Mon, 19 Jul 2010 11:44:15 -0700
Message-ID: <7vwrsrnwg0.fsf@alter.siamese.dyndns.org>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
 <1278829141-11900-5-git-send-email-struggleyb.nku@gmail.com>
 <7vbpab2de5.fsf@alter.siamese.dyndns.org>
 <AANLkTimNAyKZNdIIc6R5ylHuOVJho7UF0fnYC8jiaF9i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 20:46:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OavLq-00023y-Hx
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 20:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966479Ab0GSSoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 14:44:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936492Ab0GSSoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 14:44:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DE54C54C8;
	Mon, 19 Jul 2010 14:44:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gETHivnSpLz7o1SXUhc17/VweuU=; b=MGaTY6
	iXFBFCFRQvC/IFWKOkclemTF4JvucKuD+lwElZecG1ZaOJS8OkiNuo2ldmkQz4s8
	B6dzuo3Zg4G6Z0KjdUh0q5PR9iOCeoZMQQSj/wG2/L8rklct8JAalUozFp4NQWpj
	ZQ8qelRRfqCzpGwMKPp3ZXKqnWqGR7am6Q+hI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CTASTa6ShwhirgVYRfpyWdVlnRopWKv1
	U7e468ovdh794QhFT+PjLWbNYbL3D5AUkhU+dQ+kVOU5xKeNiTXd3nRyrj2GLRxb
	7PxrAVvSWq8oyYQS4jwqUBiRKKecsrvubPNKNDZWNK+tDo/2BNNCXhHbW/9gP+Hj
	uX2Hrcg7/pc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EF46EC54C7;
	Mon, 19 Jul 2010 14:44:19 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D988C54C6; Mon, 19 Jul
 2010 14:44:17 -0400 (EDT)
In-Reply-To: <AANLkTimNAyKZNdIIc6R5ylHuOVJho7UF0fnYC8jiaF9i@mail.gmail.com>
 (Bo Yang's message of "Sun\, 18 Jul 2010 22\:49\:41 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A428C6C4-9365-11DF-AC52-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151268>

Bo Yang <struggleyb.nku@gmail.com> writes:

> The point is that, the syntax we support is:
>
> -L n1,m1 -L n2,m2 pathspec1  -L n3,m3 pathspec2

That itself smells like a bad design, unless done very carefully and
documented clearly.

For example, what does this mean?

    $ git log -L n1,m1 master

As -L wants to see at least one path before running out of the command
line argument, we take "master" as the filename.  Hence, the command line
does not have any revision specified and defaults to HEAD.  I.e. "traverse
from the current HEAD and show only commits that touch the line region
n1,m1 that appears in the version of path 'master' in HEAD".

What about this?

    $ git log -L n1,m1 master..next one two

Clearly the user wants to traverse revision range between master and next.
The -L option wants to see one path so slurps "one".  The traversal
however is further limited by a pathspec "two".  Should the use of "one"
as an argument to -L automatically add it also to the pathspec?  I.e.
"traverse from 'next' down to 'master', checking commits that touch either
path 'one' or 'two', and show only commits that touch the line region
n1,m1 that appears in the version of path 'one' in 'next'"?

Or perhaps master..next is the name of the file the user is interested in?
I.e. "Starting from branches 'one' and 'two', show only commits that touch
the line region n1,m1 that appears in file 'master..next'"?  But that is a
broken interpretation, as "-L range path" cannto possibly make sense if
you have more than one starting point, and this interpretation gives you
two (i.e. 'one' and 'two').

How would you disambiguate -Lpaths, revisions and pathspecs?  How does -Lpath
interact with pathspecs?

What if the name of the file the user wants to annotate begins with a "-"?
For pathspec limiter, the users have already learned that "--" can be used
to say "everything that comes after this token is pathspec", but that
knowledge cannot be reused with this syntax.

It almost feels as if you want to have something more like

    -L <begin>,<end>[,<path>]

where <path> is mandatory for the first use of -L (i.e. missing ,<path>
means the same path from the previous -L that has one) to make it clear
that this is completely different from the normal pathspec.
