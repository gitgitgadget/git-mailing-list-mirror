From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: unquote C-style paths when exporting
Date: Tue, 22 Oct 2013 12:13:27 -0700
Message-ID: <xmqq4n89t8yw.fsf@gitster.dls.corp.google.com>
References: <1382115821-12586-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 21:13:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYhOa-0004OZ-3j
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 21:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754975Ab3JVTNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 15:13:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47728 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754969Ab3JVTNa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 15:13:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA25A4C87C;
	Tue, 22 Oct 2013 19:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Aa3sYyPbrGFnCFquUkwOFhqkpMw=; b=WogiOT
	0VqojRPb3jkToA1CQ8iLXuSAHZ1jPS9NzuLrSYbjVKkYeFVzlANykzf/9FIEt7j9
	6LtYxRmncoqrcpF2u410VLDV/BClDaG+A170rNbQgNVFgnA0zTjd/IUrLCRhff0W
	BcnF2AovuW8O9+kl4152M/6DbIAuQIxJkpUP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gGl65coinLZhq67qAMT/jYhyCDdGT2+k
	H76WPe1jc57V3AZDvXCnXT761YJvZKKLd625+Onsz4XdrpdQD1mrTcO4uUiKAYS8
	GvB+q345dXj+ruXlWNGC0qUMa5ADgYCQ5Q+L5zEPLL+CY/BpwpZiFvJ4/5KfJOj8
	x+SDv5/KN3U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF74C4C87B;
	Tue, 22 Oct 2013 19:13:29 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1ED374C877;
	Tue, 22 Oct 2013 19:13:29 +0000 (UTC)
In-Reply-To: <1382115821-12586-1-git-send-email-apelisse@gmail.com> (Antoine
	Pelisse's message of "Fri, 18 Oct 2013 19:03:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 08BD469E-3B4E-11E3-A92B-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236484>

Antoine Pelisse <apelisse@gmail.com> writes:

> git-fast-import documentation says that paths can be C-style quoted.
> Unfortunately, the current remote-hg helper doesn't unquote quoted
> path and pass them as-is to Mercurial when the commit is created.
>
> This result in the following situation:
>
> - clone a mercurial repository with git
> - Add a file with space: `mkdir dir/foo\ bar`
> - Commit that new file, and push the change to mercurial
> - The mercurial repository as now a new directory named '"dir', which
> contains a file named 'foo bar"'
>
> Use python ast.literal_eval to unquote the string if it starts with ".
> It has been tested with quotes, spaces, and utf-8 encoded file-names.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---

A path you read in fast-import input indeed needs to be unquoted
when it begins with a dq, and I _think_ by using ast.literal_eval(),
you probably can correctly unquote any valid C-quoted string.

But it bothers me somewhat that what the patch does seems to be
overly broad.  Doesn't ast.literal_eval() take a lot more than just
strings?

    ast.literal_eval(node_or_string)

        Safely evaluate an expression node or a Unicode or Latin-1
        encoded string containing a Python expression. The string or
        node provided may only consist of the following Python literal
        structures: strings, numbers, tuples, lists, dicts, booleans,
        and None.

Also doesn't Python's double-quoted string have a lot more magic
than C-quoted string, e.g.

	$ python -i
        >>> import ast
        >>> not_cq_path = '"abc" "def"'
        >>> ast.literal_eval(not_cq_path)
	'abcdef'

>  contrib/remote-helpers/git-remote-hg | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index 92d994e..0141949 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -14,6 +14,7 @@
>  
>  from mercurial import hg, ui, bookmarks, context, encoding, node, error, extensions, discovery, util
>  
> +import ast
>  import re
>  import sys
>  import os
> @@ -742,6 +743,8 @@ def parse_commit(parser):
>              f = { 'deleted' : True }
>          else:
>              die('Unknown file command: %s' % line)
> +        if path.startswith('"'):
> +            path = ast.literal_eval(path)
>          files[path] = f
>  
>      # only export the commits if we are on an internal proxy repo
