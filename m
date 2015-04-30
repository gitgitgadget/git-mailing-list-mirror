From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Wed, 29 Apr 2015 18:31:22 -0700
Message-ID: <xmqq7fsu4d1x.fsf@gitster.dls.corp.google.com>
References: <1430341032.14907.9.camel@ubuntu>
	<xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
	<1430343059.14907.18.camel@ubuntu> <20150429214817.GA2725@peff.net>
	<1430346576.14907.40.camel@ubuntu> <20150429231150.GB3887@peff.net>
	<20150430003750.GA4258@peff.net> <1430355983.14907.55.camel@ubuntu>
	<20150430011612.GA7530@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 03:31:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YndK9-0005yH-9j
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 03:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbbD3Bb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 21:31:26 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750891AbbD3BbY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 21:31:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CAE4C4D9E0;
	Wed, 29 Apr 2015 21:31:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8ZZpb+mPDDYvRaojZ5F4qONKJ2U=; b=LCjMY2
	Rv9LwciFwx4S79Q/kXh0QzAPiZ/T66xaDyt4/9oDfpqlxVmUS84beLcI4V75WJpS
	LVCr6avdIYaKDL90VLp73VFrHe8KPE33AEvkvIJ6dIMBgY/XQJhrbcfrd5b/v7qd
	eoDEnn51nePxZG5Z23EmvWk/AH7E8otUc813I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iov159Nb12zxby/z9zdnLz0zrfRl2gU4
	tomZ+5pJ3r/rli5tE9Nclct84SBP3mgN5ZQ3t/lH3DMBm4DP7WVCt9Q8YtRQo45o
	mbpIoI/DAcQIBB9DitlppJwQuYyUCyU0SFTw9SzmNEU0o/qelJV8XOLBz8D9a6ag
	/oJSwhe5mc0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C33F64D9DF;
	Wed, 29 Apr 2015 21:31:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4AFF74D9DA;
	Wed, 29 Apr 2015 21:31:23 -0400 (EDT)
In-Reply-To: <20150430011612.GA7530@peff.net> (Jeff King's message of "Wed, 29
	Apr 2015 21:16:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9C74B8D8-EED8-11E4-8C82-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268044>

Jeff King <peff@peff.net> writes:

> I had imagined we would stop resolution and you would just get the last
> object peeled object. Combined with teaching cat-file to show more
> object context, doing:
>
>   echo content >dest ;# actual blob
>   ln -s dest link    ;# link to blob
>   ln -s broken foo   ;# broken link
>   ln -s out ../foo   ;# out-of-tree link
>   git add . && git commit -m foo
>   for i in link broken out; do
> 	echo HEAD^{resolve}:$i
>   done |
>   git cat-file --batch="%(intreemode) %(size)"
>
> would yield:
>
>  (1)   100644 8
>        content
>  (2)   040000 3
>        foo
>  (3)   040000 6
>        ../foo
>
> where the left-margin numbers are for reference:
>
>   1. We dereference a real symlink, and pretend like we actually asked
>      for its referent.
>
>   2. For a broken link, we can't dereference, so we return the link
>      itself. You can tell by the mode, and the content tells you what
>      would have been dereferenced.
>
>   3. Ditto for out-of-tree. Note that this would be the _raw_ symlink
>      contents, not any kind of simplification (so if you asked for
>      "foo/bar/baz" and it was "../../../../out", you would the full path
>      with all those dots, not a simplified "../out", which I think is
>      what you were trying to show in earlier examples).

s/040000/160000/ I would think (if you really meant to expose a
tree, write it as 40000 instead, so that people will not get a wrong
impression and reimplement a broken tree object encoding some popular
Git hosting site broke their customer projects with ;-).

I am not sure $treeish^{resolve} is a great syntax, but I like the
concept and agree that it is a lot more sensible to handle this at
the level of sha1_name.c layer than an ad-hoc solution in the
cat-file layer.
