From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse: clarify documentation for the --verify option
Date: Sun, 31 Mar 2013 15:52:12 -0700
Message-ID: <7vwqsnnpwj.fsf@alter.siamese.dyndns.org>
References: <1364625865-8459-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 01 00:52:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMR7E-0000Ya-9r
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 00:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755988Ab3CaWwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 18:52:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57538 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755894Ab3CaWwP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 18:52:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A295B11D65;
	Sun, 31 Mar 2013 22:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9OeCuqUxuoIZgQXFDfQU6M8KSaQ=; b=pcNbX7
	RKEGi4XHxmMS/CF54WOgi40+gAVYcUyn5UBBuSqxLbT9hISuYPslutJRTgeKKQBq
	9QOg3N3h89bOPJULYHLA3vXuvDljfI5YGtih5hH++F8DX2Z8frCyBgSePhkfy9wC
	99Qbq52t8lUbX9hJkkcFrcyvAmw++TGcxAyWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jeBFGRiO2MeFhKjxQGRYKd221ChAjNIV
	KKGnGIS2R8sKnnT/Uuu1x+Qa8jGOpNeQkydnIzbjrJ74C7lQi7wFZl2tf8mJ+Q8R
	X8CdjYxWFPYFmij+0VShRpxMJ3W1CLwwPbXhojNlImmzENAOYAnypzxAD223l1BG
	dhcI+/1HyOI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 964A911D64;
	Sun, 31 Mar 2013 22:52:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB9D311D60; Sun, 31 Mar
 2013 22:52:13 +0000 (UTC)
In-Reply-To: <1364625865-8459-1-git-send-email-mhagger@alum.mit.edu> (Michael
 Haggerty's message of "Sat, 30 Mar 2013 07:44:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A112436C-9A55-11E2-A77E-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219647>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> ...  Though honestly, I don't see the point of using
> --default as opposed to
>
>     $ git rev-parse --verify ${REV:-master}^{commit}

I would agree ${VAR:-default} is sufficient in that particular case.

The --default is more about the use of the pluming command not with
--verify but as its original use of an "argument sifter" when
composing "git rev-list" piped into "git diff-tree --stdin", i.e.

	git rev-list $(git rev-parse --default HEAD --revs-only "$@") |
        git diff-tree --stdin $(git rev-parse --no-revs "$@")

which was the original way to write commands in the "git log" family
using the plumbing command as a scripted Porcelain.

>  --verify::
> +	If the parameter can be used as a single object name, output
> +	that name; otherwise, emit an error message and exit with a
> +	non-zero status.  Please note that the existence and validity
> +	of the named object itself are not checked.

Perhaps s/used as a single object name/turned into a raw 20-byte SHA-1/;

Because the primary use case of this option is to implement end-user
input validation, I think it would be helpful to clarify use of the
peeler here.  Perhaps

    --verify::
            Make sure the single given parameter can be turned into a
            raw 20-byte SHA-1, something that can be used to access the
            object database, and emit the SHA-1 in 40-hex format (unless
            --symbolic and other formatting option is given); otherwise,
            error out.
    +
    If you want to make sure that the output from this actually
    names an object in your object database and/or can be used
    as a specific type of object you require, it is a good idea
    to add "^{type}" peeling operator to the parmeter.  For
    example, `git rev-parse "$VAR^{commit}"` will make sure $VAR
    names an existing object that is a commit-ish (i.e. a
    commit, or an annotated tag that points at a commit).  To
    make sure that $VAR names an existing object of any type,
    you can say `git rev-parse "$VAR^{object}"`.

or something.
