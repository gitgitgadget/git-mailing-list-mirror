From: Junio C Hamano <gitster@pobox.com>
Subject: Re* git --literal-pathspecs add -u says "fatal: pathspec ':/' did not match any files"
Date: Sat, 24 Oct 2015 10:57:16 -0700
Message-ID: <xmqq37x0m9oj.fsf@gitster.mtv.corp.google.com>
References: <CAM-tV--Q=DjTwLk8sZVm7-xMQsGwKmyjy4XiT08QpQ5-dffL0w@mail.gmail.com>
	<562B2FB2.4080604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Noam Postavsky <npostavs@users.sourceforge.net>,
	git@vger.kernel.org, vleschuk@accesssoftek.com
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 19:57:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zq34F-0001CK-UD
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 19:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbbJXR5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 13:57:20 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63349 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751884AbbJXR5T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2015 13:57:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E01CF22A27;
	Sat, 24 Oct 2015 13:57:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=bjKG2dVoVqSCFcRyt31NvH1+o54=; b=aPysG3IQg+t3aRVoGbVA
	9GyDcCTsLueUCB7QVsd8y9zVp+N1zKUwnezC2GrAVKvz6KfwvX7b+rfoD55nyn/d
	1MRAud7nHOxtI7zrSmcwxVKGPvvPKe/h81IsnFi5QhdD7IVhL/IHVfJV6A7KNDCs
	3LsB1ZtCBOp+i1XOv94vRbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=RKzgtp5CqbAZZpE3KlpFX/zA8O7ncGwJiTf8FyL7DDQeBw
	kwflzXTiCc9Yk+d+2gZmPs4fu4kHqO/f8Xbpc/lMmYsQXldrv2Qj8bB1cUFM4hck
	3Njf6nfVA01SGG2oy4xMr3fSKeMMeFINX1EjgtC/MF8yhPsn9Q+u7ER6GB654=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D799722A26;
	Sat, 24 Oct 2015 13:57:17 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5CCC322A25;
	Sat, 24 Oct 2015 13:57:17 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AA2F628A-7A78-11E5-87D2-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280130>

Victor Leschuk <vleschuk@gmail.com> writes:

> Maybe it'll make sense to modify file_exists() to treat ":/"
> specially.

The real problem is that the code assumes that it can internally use
":/" to mean "everything from the top", and with global 'literal
pathspec' magic, that is not the case.  "did not match" is a red
herring.  Even if you disable that typo-catcher, the resulting
pathspec will match only paths inside a directory whose name is ':',
so you would break 'add -u' in a more grave way.

Disabling the typo-catcher has another problem.  When an end user
says "git --literal-pathspecs add -u :/", the user means "I happen
to have this funnily named directory ':' and want to update
everything under it, but because :/ is normally taken as special, I
am passing --literal-pathspecs".  And if that ':' does not exist,
the user must get the "well you may have misspelt it" error.

But a code you are changing cannot tell if ":/" came from the end
user, or if it the one added by our code upon seeing "-u" or "-A"
without any pathspecs, to make that distinction so that you disable
it only for our internal ":/".

I think the right approach is something along the line of this patch
instead.

-- >8 --
Subject: add: simplify -u/-A without pathspec

Since Git 2.0, "add -u" and "add -A" run from a subdirectory without
any pathspec mean "everything in the working tree" (before 2.0, they
were limited to the current directory).  The limiting to the current
directory was implemented by inserting "." to the command line when
the end user did not give us any pathspec.  At 2.0, we updated the
code to insert ":/" (instead of '.') to consider everything from the
top-level, by using a pathspec magic "top".

The call to parse_pathspec() using the command line arguments is,
however, made with PATHSPEC_PREFER_FULL option since 5a76aff1 (add:
convert to use parse_pathspec, 2013-07-14), which predates Git 2.0.
In retrospect, there was no need to turn "adding . to limit to the
directory" into "adding :/ to unlimit to everywhere" in Git 2.0;
instead we could just have done "if there is no pathspec on the
command line, just let it be".  The parse_pathspec() then would give
us a pathspec that matches everything and all is well.

Incidentally such a simplifcation also fixes a corner case bug that
stems from the fact that ":/" does not necessarily mean any magic.
A user would say "git --literal-pathspecs add -u :/" from the
command line when she has a directory ':' and wants to add
everything in it (and she knows that her :/ will be taken as
'everything under the sun' magic pathspec unless she disables the
magic with --literal-pathspecs).  The internal use of ':/' would
behave the same way as such an explicitly given ":/" when run with
"--literal-pathspecs", and will not add everything under the sun as
the code originally intended.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin/add.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index b2a5c57..145f06e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -336,14 +336,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
 
-	if ((0 < addremove_explicit || take_worktree_changes) && !argc) {
-		static const char *whole[2] = { ":/", NULL };
-		argc = 1;
-		argv = whole;
-	}
-
 	add_new_files = !take_worktree_changes && !refresh_only;
-	require_pathspec = !take_worktree_changes;
+	require_pathspec = !(take_worktree_changes || (0 < addremove_explicit));
 
 	hold_locked_index(&lock_file, 1);
 
