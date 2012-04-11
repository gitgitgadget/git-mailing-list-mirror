From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] fast-import doc: deadlock avoidance in bidirectional
 mode
Date: Wed, 11 Apr 2012 10:32:32 -0700
Message-ID: <7vlim2kwcv.fsf@alter.siamese.dyndns.org>
References: <20120411143249.GA4140@burratino>
 <7v1ununtb2.fsf@alter.siamese.dyndns.org> <20120411171707.GD4248@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Ivankov <divanorama@gmail.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 19:32:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI1PP-0005tD-HY
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 19:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759493Ab2DKRch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 13:32:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44643 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756591Ab2DKRcg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 13:32:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFB0B6FA9;
	Wed, 11 Apr 2012 13:32:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0cf24cGfaYTZmVTqJR3yBs/U9f0=; b=JvTVpY
	hEb1i738hV8AEgp9ezD8sCuk9mYaItwokfQ6+3GFwe5lQeNcrzjxH2ozmKjfR1Yp
	hekctzT9GJbjS86/VMF1d9vLGGE4N0OCmZu4OP0ehwta1JVHb2E/B98J37V1bX0D
	pav/1pIQV7QywLBgFFR/8dZ9tmL75b9uogoy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TtsAptGIDZSvO+uYR56Bs1x9Imnyu9DK
	Jn2FSA/UaLvwWbs5ZJONA62pfsqxck77/fGq4OOqaL4J/1RuBaFwpfqqWefUZHnK
	SvlhqogDC6ogXFL7rwB16hTrN3NVTMOtk2PRIHLiA3qg+7NASkaTkvYXN7PPe5cE
	i01obxovg+w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6A096FA8;
	Wed, 11 Apr 2012 13:32:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 487AE6FA4; Wed, 11 Apr 2012
 13:32:35 -0400 (EDT)
In-Reply-To: <20120411171707.GD4248@burratino> (Jonathan Nieder's message of
 "Wed, 11 Apr 2012 12:17:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 53779A5A-83FC-11E1-B1DD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195222>

Jonathan Nieder <jrnieder@gmail.com> writes:

> How about this?

I find all the explanation above this line (elided) understandable and
sensible.

The expected use of --cat-blob-fd is to loop it back to the frontend, and
that is obvious to _us_, but there is nothing in the existing text (or the
text added by this patch) that suggests that fact to the first time
reader.  "Frontends must consume" may not "click" without that knowledge.

>  Documentation/git-fast-import.txt |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index ec6ef311..0ea649f4 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -942,6 +942,12 @@ This command can be used anywhere in the stream that comments are
>  accepted.  In particular, the `cat-blob` command can be used in the
>  middle of a commit but not in the middle of a `data` command.
>  
> +While in some cases the 'cat-blob' result will fit in the pipe buffer,
> +allowing fast-import to continue processing additional commands, this
> +is not guaranteed.  Frontends must consume the cat-blob response
> +completely before performing any writes to fast-import that might
> +block.
> +
>  `ls`
>  ~~~~
>  Prints information about the object at a path to a file descriptor
> @@ -975,7 +981,12 @@ Reading from a named tree::
>  
>  See `filemodify` above for a detailed description of `<path>`.
>  
> -Output uses the same format as `git ls-tree <tree> {litdd} <path>`:
> +While in some cases the 'ls' response will fit in the pipe buffer,
> +allowing fast-import to continue processing additional commands, this
> +is not guaranteed.  Frontends must consume the ls response completely
> +before performing any writes to fast-import that might block.
> +
> +The 'ls' response uses the same format as `git ls-tree <tree> {litdd} <path>`:
>  
>  ====
>  	<mode> SP ('blob' | 'tree' | 'commit') SP <dataref> HT <path> LF
