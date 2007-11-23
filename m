From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-add--interactive pathspec and patch additions
Date: Fri, 23 Nov 2007 13:07:52 -0800
Message-ID: <7vk5o8smaf.fsf@gitster.siamese.dyndns.org>
References: <1195845650-85962-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 22:08:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ivfl6-0001iI-Mc
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 22:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766AbXKWVH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 16:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752225AbXKWVH7
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 16:07:59 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59689 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbXKWVH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 16:07:59 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0624A2EF;
	Fri, 23 Nov 2007 16:08:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6BA3598FB1;
	Fri, 23 Nov 2007 16:08:16 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65929>

Wincent Colaiuta <win@wincent.com> writes:

> The series implements these changes in seven steps that apply on top of
> "master"; these patches are rebased/squashed ones which *replace* the
> ones sent the other day:

That's very unfortunate, as some already usable bits from the
series are already in 'next'.

>     1. Add -q/--quiet switch to git-ls-files
>
> Needed because run_cmd_pipe() doesn't propagate the child exit status
> and system() likes to be chatty on the standard out. Of the possible
> workarounds adding this switch seems to be the cleanest and most
> portable.

I do not like this very much.  If it is a problem that
run_cmd_pipe() does not properly signal you an error, wouldn't
it be much better to fix _that_ problem?  That way we do not
have to add kludge to all commands we need to run and get the
exit status out of.

>     2. Rename patch_update_file function to patch_update_pathspec
>
> Merely cosmetic.
>
>     3. Add path-limiting to git-add--interactive
>     4. Bail if user supplies an invalid pathspec

On the first read, I did not quite like 4, but I'd agree it is
probably the cleanest implementation for 3 to reject a wrong
invocation early.

>     5. Teach builtin-add to pass path arguments to git-add--interactive

I think this is already in 'next'.

>     6. Add "--patch" option to git-add--interactive
>     7. Teach builtin-add to handle "--patch" option

These should be straightforward, but use of Getopt::Long feels
way overkill for an internal command like add--interactive which
is called by only a very limited known callers (exactly one).

If we assume "a single caller", we probably can do without 1 and
4, by making the caller in builtin-add to validate the list of
pathspecs, reusing the code for "ls-files --error-unmatch",
before calling the external helper "add--interactive".

There are functions refactored as part of the builtin-commit
series to be usable from outside "ls-files", and you can build a
imple function called from interactive_add(ac, av) using them:

static int validate_pathspec(const char *prefix, const char **pattern)
{
	int i, ret;
	char *m;

	if (!pattern || !*pattern)
        	return 0;

	for (i = 0; pattern[i]; i++)
		;
	m = xcalloc(1, i);

	for (i = 0; i < active_nr; i++) {
		struct cache_entry *ce = active_cache[i];
                (void) pathspec_match(pattern, m, ce->name, 0);
	}
        ret = report_path_error(m, pattern, prefix ? strlen(prefix) : 0);
        free(m);
        return ret;
}
