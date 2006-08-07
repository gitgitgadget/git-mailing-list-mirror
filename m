From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Mon, 07 Aug 2006 16:49:19 -0700
Message-ID: <7vejvsyum8.fsf@assigned-by-dhcp.cox.net>
References: <200608071626.52655.jnareb@gmail.com>
	<7v3bc82v7l.fsf@assigned-by-dhcp.cox.net> <eb8cdh$s6n$1@sea.gmane.org>
	<7v4pwo1a0r.fsf@assigned-by-dhcp.cox.net> <eb8e12$2aa$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 08 01:49:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAEqb-0002HD-9I
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 01:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWHGXtW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 19:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWHGXtW
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 19:49:22 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:22718 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932368AbWHGXtV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 19:49:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060807234920.WLJL6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Aug 2006 19:49:20 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25055>

Jakub Narebski <jnareb@gmail.com> writes:

> Matthias Lederhofer has noticed that parsing all the tags in "summary" and
> "tags" views, while we use only epoch/timestamp information to sort them
> and discard most of parsed input, is bottleneck due to the fact that
> usually number of tags is linear with history (version tags) and the fact
> that for each tag is one invocation of git (one fork, two execs).

Maybe we would want to expose for_each_ref somehow to the
command level then.  Looking at how "git branch" without any
argument lists the branches, and how "git tag -l" lists the
tags, it appears that we could benefit from such a command [*1*].

Of course doing it in Git.xs to make a single C level call is
easy, but that would benefit only Perl scripts, so it is not a
very good general solution.

> So the new guidelines would be:
> * git_get_ prefix for subroutines related to git repository
>   and returning single scalar (single value).
> * git_read_ prefix for subroutines related to git repository, reading some
>   files or multiline output, and returning hash reference, or list
>   reference, or list.

I would suggest to use git_get for both, unless there is a good
reason to differenciate them, since I do not understand why you
would want to differenciate one value vs multivalue.

-- >8 -- [*1*] -- >8 --
[PATCH] git-show-refs

Implementation is left as an exercise ;-)

---
diff --git a/Documentation/git-show-refs.txt b/Documentation/git-show-refs.txt
new file mode 100644
index 0000000..e2869e0
--- /dev/null
+++ b/Documentation/git-show-refs.txt
@@ -0,0 +1,96 @@
+git-show-refs(1)
+================
+
+NAME
+----
+git-show-refs - Lists refs in various formats
+
+SYNOPSIS
+--------
+'git-show-refs' [--count=<max>] [--sort=<sortkeys>] [--format=<format>] [<pattern>]
+
+DESCRIPTION
+-----------
+
+Iterate over refs under `$GIT_DIR/refs` that match `<pattern>`
+and show them according to the given `<format>`, after sorting
+them according to the given `<sortkeys>`.  If `<max>` is given,
+stop after showing that many refs.
+
+OPTIONS
+-------
+<max>::
+	By default the command shows all refs that match
+	`<pattern>`.  This option makes it stop after showing
+	that many refs.
+
+<sortkeys>::
+	Comma separated field names to sort on.  Prefix `-` to
+	sort in descending order of the value.  When
+	unspecified, `name` is used.
+
+<format>::
+	A string that interpolates `%(field name)` from the
+	object pointed at by a ref being shown.  When
+	unspecified, `%(name)` is used.
+
+<pattern>::
+	If given, the name of the ref is matched against this
+	using fnmatch(3).  Refs that do not match the pattern
+	are not shown.
+
+
+FIELD NAMES
+-----------
+
+Various values from structured fields in referenced objects can
+be used to interpolate into the resulting output, or as sort
+keys.
+
+For all objects, the following names can be used:
+
+name::
+	The name of the ref (the part after $GIT_DIR/refs/),
+	except that when `<pattern>` is used, the leading fixed
+	string part of `<pattern>` is stripped out.
+
+objecttype::
+	The type of the object (`blob`, `tree`, `commit`, `tag`)
+
+objectsize::
+	The size of the object (the same as `git-cat-file -s` reports).
+
+objectname::
+	The object name (aka SHA-1).
+
+In addition, for commit and tag objects, the header field names
+(`tree`, `parent`, `object`, `type`, and `tag`) can be used to
+specify the value in the header field.  Fields that have
+name-email-date tuple as its value (`author`, `committer`, and
+`tagger`) can be suffixed with `name`, `email`, and `date` to
+extract the named component.  The first line of a commit and tag
+object can be referred to with `subject`, the remaining lines
+with `body`, and both (including the typical blank line after
+`subject`) with `contents`.
+
+Also a pseudo field name `ishead` can be used to check if the
+ref is pointed by `$GIT_DIR/HEAD` pointer.  The field
+interpolates as "* " if true, otherwise an empty string.
+
+For sorting purposes, fields with numeric values sort in numeric
+order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
+All other fields are used to sort in their byte-value order.
+
+
+EXAMPLES
+--------
+
+Show most recent 16 tags for consumption by gitweb::
+	git-show-refs --count=16 --sort=-taggerdate,name \
+		--format='%(taggerdate) %(name)\t%(tag)\t%(subject)' 'tags/*'
+
+`git-branch` without argument::
+	git-show-refs --format='%(ishead)%(name)' 'heads/*'
+
+`git-tag -l`::
+	git-show-refs tags/*
