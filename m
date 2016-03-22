From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule helper: accept '.' for repositories with no submodules
Date: Tue, 22 Mar 2016 11:53:23 -0700
Message-ID: <xmqqy49agx98.fsf@gitster.mtv.corp.google.com>
References: <1458669579-32160-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: cederp@opera.com, Jens.Lehmann@web.de, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 19:53:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiRQp-00052E-UA
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 19:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbcCVSx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 14:53:28 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52863 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750735AbcCVSx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 14:53:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ACB774FC65;
	Tue, 22 Mar 2016 14:53:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1keB0dtXWVhx8a9e977NZ/DhQcI=; b=yiyi69
	jaGICf6lBQl9ckhCvfud8NcdprPr19ihpcY9hNLG/GqxrHxOIINEPWOywJM5RgPr
	LIJdgqKgoC7XftOEbO2MjoE5VXLjInWKpyn/dk8f4Clu55VgF+C5WiYx+UewoMDN
	uJa1llQ9OMfRULQQ6uHnxxhLT6WRtmdq5fN+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FmhZ5rN9Y1iAzsM5hMhHzxoXusdH1mDH
	oYAQB+DbfyAySd3zngVFO1jmyevCr/g0PYHpYxs4V2oIK9EwasARGukHDqOht3P+
	EaraTSxKU++qicOmPptVI4sN3gdUBDfDLIXiWmM9cnHI754iztwL67rvQ2CkA7dU
	cjGReYdOO6c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A1F824FC64;
	Tue, 22 Mar 2016 14:53:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2376A4FC63;
	Tue, 22 Mar 2016 14:53:25 -0400 (EDT)
In-Reply-To: <1458669579-32160-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 22 Mar 2016 10:59:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5B747DD0-F05F-11E5-940C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289542>

Stefan Beller <sbeller@google.com> writes:

> In 74703a1e4d (2015-09-02, submodule: rewrite `module_list` shell
> function in C), "submodule deinit ." was broken.
>
> The original module_list accepted '.' as a pathspec just fine, as it
> was using
>
>   git ls-files -z --error-unmatch --stage -- "$@" || { custom filtering}
>
> and git ls-files doesn't make a difference between "." and no arguments
> there. When using the parse_pathspec function in C, this is a difference
> however, when no path matches.

Is that an accurate description of the issue?

The original (above) errors out if there is a pathspec that does not
match any path in the index.  The C rewrite however instead does
this:

		if (!S_ISGITLINK(ce->ce_mode) ||
		    !match_pathspec(pathspec, ce->name, ce_namelen(ce),
				    0, ps_matched, 1))
			continue;

to error out if there is a pathspec that does not match any
submodule path.  That is the root cause of the difference in
behaviour.

So if we were to aim for a faithful rewrite, perhaps swapping the
order of the check, i.e.

		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
				    0, ps_matched, 1) ||
		    !S_ISGITLINK(ce->ce_mode))
			continue;

Now, arguably, the behaviour of C rewrite makes more sense in that
it would diagnose a pathspec that does not match a submodule as an
error, e.g.

	$ git submodule--helper list 'COPYIN*'
	error: pathspec 'COPYIN*' did not match any file(s) known to git.
	#unmatched

The error message _is_ wrong, but the end result is more helpful to
the user---the user thought there was a submodule that would match
that pathspec, and there isn't, so we suspect there was a typo and
cautiously error out.

"submodule deinit ." may have "worked" in the sense that you would
have at least one path in your tree and avoided this "nothing
matches" most of the time.  It would have still failed with the
exactly same error if run in an empty repository, i.e.

	$ E=/var/tmp/x/empty && rm -fr "$E" && mkdir -p "$E" && cd "$E"
        $ git init
        $ rungit v2.6.6 submodule deinit .
        error: pathspec '.' did not match any file(s) known to git.
	Did you forget to 'git add'?
	$ >file && git add file
        $ rungit v2.6.6 submodule deinit .
	$ echo $?
	0

In other words, "Use '.' if you really want to" is a faulty
suggestion.  There is no guarantee that it would match anything in
the old world order, and certainly there is no guarantee that it
would match any submodule in the new world order.

When another person who is not Per Cederqvist realizes that the
logic that issues the faulty suggestion is because the command wants
some pathspec, she may try

    $ git submodule deinit '*'

and complain that it used to work but it no longer, even with the
band-aid patch under discussion that special cases '.'.

So I dunno.  This is not only "deinit", but also the post rewrite
version catches

	$ git submodule init -- 'COPYIN*'

as an error, which we probably would want to keep, so I am reluctant
to suggest swapping the order of the check to do pathspec first and
then gitlink-ness (it has performance implications but correctness
is a more important issue), but if we want to keep the backward
compatibility, that would be the best bug-to-bug compatible fix in
the shorter term.
