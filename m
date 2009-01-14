From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] implement pattern matching in ce_path_match
Date: Wed, 14 Jan 2009 10:39:29 -0800
Message-ID: <7vljtd20m6.fsf@gitster.siamese.dyndns.org>
References: <1231944876-29930-1-git-send-email-drizzd@aon.at>
 <1231944876-29930-2-git-send-email-drizzd@aon.at>
 <1231944876-29930-3-git-send-email-drizzd@aon.at>
 <1231944876-29930-4-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes@familieschneider.info
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Jan 14 19:41:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNAg0-0005zA-Gu
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 19:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbZANSji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 13:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752994AbZANSji
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 13:39:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbZANSjh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 13:39:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4E24090742;
	Wed, 14 Jan 2009 13:39:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 41FB290740; Wed,
 14 Jan 2009 13:39:31 -0500 (EST)
In-Reply-To: <1231944876-29930-4-git-send-email-drizzd@aon.at> (Clemens
 Buchacher's message of "Wed, 14 Jan 2009 15:54:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0E34996-E26A-11DD-BABF-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105679>

Clemens Buchacher <drizzd@aon.at> writes:

> With this patch ce_path_match uses match_pathspec in order to perform
> pattern matching.

We have two conflicting definitions of pattern matching in our system.
I'd make it more explicit which kind of pattern matching you are talking
about here.

The family of operations based on the diff-tree machinery (e.g. path
limited revision walking "git log A..B -- dir1/dir2") define the pattern
matching as "leading path match (exact match is just a special case of
this)".  Other operations that work on paths in the work tree and the
index (e.g. grep, ls-files) uses "leading path match, but fall back to
globbing".

In the longer term we really should unify them by teaching the former to
fall back to globbing without getting undue performance hit, and this
patch may be a step in the right direction.  There are optimizations that
assume the "leading path" semantics to trim the input early and avoid
opening and descending into a tree object if pathspec patterns cannot
possibly match (see tree-diff.c::tree_entry_interesting() for an example),
and we need to teach them to notice a glob wildcard in an earlier part of
a pathspec and to descend into some trees that they would have skipped
with the old definition of pathspec.

> @@ -49,7 +60,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
>  		rev->always_show_header = 0;
>  	if (DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES)) {
>  		rev->always_show_header = 0;
> -		if (rev->diffopt.nr_paths != 1)
> +		if (rev->diffopt.nr_paths != 1 || has_special(rev->diffopt.paths[0]))
>  			usage("git logs can only follow renames on one pathname at a time");
>  	}

The reason match_pathspec() first tries exact match and then falls back to
globbing is so that the user can say "I have a file whose name ends with a
question mark, please match it literally."  This patch defeats it, but it
probably is a minor point.

1/3 and 2/3 in the series looked good.

Thanks.
