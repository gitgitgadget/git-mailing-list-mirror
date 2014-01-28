From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse: Check argc before using argv[i+1]
Date: Tue, 28 Jan 2014 11:12:42 -0800
Message-ID: <xmqqtxcnly39.fsf@gitster.dls.corp.google.com>
References: <1390866262-10188-1-git-send-email-dhsharp@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Sharp <dhsharp@google.com>
X-From: git-owner@vger.kernel.org Tue Jan 28 20:13:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8E5w-0008RW-4p
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 20:13:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbaA1TNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jan 2014 14:13:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39174 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932146AbaA1TMw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jan 2014 14:12:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AFF567F74;
	Tue, 28 Jan 2014 14:12:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NqrsBhNnRCKrZCONI5iwwf7HhLo=; b=pdD2v1
	/KDOgYQAdU+jQtU5rPQ7brhKpE4SOw/q6JM1aPPv9dP4q3r6gSyFNrSaZShu/pyn
	fiqdCuiRysSJrbJBSub3lBWjxpe7Hj3MUO+qkL0fQjToDWAMoCs6DgIZFq6+V/oP
	lAt/IbIa1PBIux03BXxO6VjLhQgin0zF8ds1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GMw0miXGbwgfygCUMAN+epxVjOdgdEDJ
	eDqk7sOmb+64thwY3/90qdolFp4kUhlpZaCCuPYfWPMn5g7J/cgt6+egNVo3faov
	nROBaHbVseC8Kn0BN4dIF2rWpj7Wx1WMP9kour9QF1V4i3YBBYWUwv8mtsHP/Z+/
	5IGHIQakNGQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2120667F73;
	Tue, 28 Jan 2014 14:12:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CC4B67F70;
	Tue, 28 Jan 2014 14:12:45 -0500 (EST)
In-Reply-To: <1390866262-10188-1-git-send-email-dhsharp@google.com> (David
	Sharp's message of "Mon, 27 Jan 2014 15:44:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2B25B712-8850-11E3-AE41-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241189>

David Sharp <dhsharp@google.com> writes:

> @@ -738,9 +740,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				continue;
>  			}
>  			if (!strcmp(arg, "--resolve-git-dir")) {
> -				const char *gitdir = resolve_gitdir(argv[i+1]);
> +				if (++i >= argc)
> +					die("--resolve-git-dir requires an argument");
> +				const char *gitdir = resolve_gitdir(argv[i]);
>  				if (!gitdir)
> -					die("not a gitdir '%s'", argv[i+1]);
> +					die("not a gitdir '%s'", argv[i]);

This adds decl-after-statement.  As referencing argv[argc] is not a
crime (you will grab a NULL), how about doing it this way to see if
the value is a NULL, instead of comparing the index and argc?

	const char *gitdir;
        if (!argv[++i])
        	die("--resolve-git-dir requires an argument");
	gitdir = resolve_gitdir(argv[i]);
        if (!gitdir)
        	die("not a gitdir '%s'", argv[i]);

Same comment may apply to other hunks.

Thanks.
