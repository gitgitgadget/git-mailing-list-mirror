From: =?ISO-8859-1?Q?Conrad=A0Irwin?= <conrad.irwin@gmail.com>
Subject: Re: git 1.8.0.rc0.18.gf84667d trouble with "git commit -p file"
Date: Sat, 6 Oct 2012 11:32:51 -0700
Message-ID: <CAOTq_pu=xWF7q3QobxSerkkbV56n5o+CPQSyHg8onwv73v25+A@mail.gmail.com>
References: <201210051420.q95EKjj3008300@netbook1.inf.utfsm.cl>
 <op.wlp1lws70aolir@keputer> <7vsj9ssgcp.fsf@alter.siamese.dyndns.org>
 <20121005225758.GA1202@sigill.intra.peff.net> <7v8vbkru8o.fsf@alter.siamese.dyndns.org>
 <20121006131200.GB11712@sigill.intra.peff.net> <7vvcenqx39.fsf@alter.siamese.dyndns.org>
 <20121006183026.GA3644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Frans Klaver <fransklaver@gmail.com>, git@vger.kernel.org,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 06 20:33:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKZBk-0001iM-C8
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 20:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302Ab2JFSdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 14:33:13 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:60542 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab2JFSdN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 14:33:13 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so3017853vbb.19
        for <git@vger.kernel.org>; Sat, 06 Oct 2012 11:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Xber23QHQzW7hwtXZdqAy5wtlZ/9TyoGhWH3LbFR80E=;
        b=QEqjzgmiRw0EjO2r0W2S/O8fSTAAIblO7PDqDD53OUBqSr83mBWKKr5WWOQHUl8Lui
         KBXf95VCEgq8vPtq9+Jojjs6b4TFLjvsvVLYJN6KRYabiyEJiflAslhI6P/4104kVwRH
         4v60Zi7LFP5Bpp6ffmrWxeL9N5Mj5bDqLyQsnEjMlrQYu9xV8G+2i12JhiAjqjoWFvC9
         xP8DoxAEsmuqlg2tL5utqCGW9KcaOGb1c0K71bPbymiLbL8WbhyD6jTRgHBppiUu5Csy
         COoIWBpWowjrXleB702UyBw2PIxJThcuQ1Rx2k5wH5zwb5uswCzpLyohrWRUOeg49LfB
         jxog==
Received: by 10.52.29.138 with SMTP id k10mr6052104vdh.53.1349548392041; Sat,
 06 Oct 2012 11:33:12 -0700 (PDT)
Received: by 10.220.220.196 with HTTP; Sat, 6 Oct 2012 11:32:51 -0700 (PDT)
In-Reply-To: <20121006183026.GA3644@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207163>

I think I messed up sending somehow:

On Fri, Oct 5, 2012 at 11:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Suppose you have two paths E and F, both of which have differences
> between HEAD and the index, and the index and the working tree file
> (i.e. you earlier edited E and F, did "git add E F" and further
> edited them).
>
> You say "git commit -p F".
[...]
>
> What state should the "add -p" interaction start from for path F?
> Should you be picking from a patch between the state you previously
> "git add"ed to the index and the working tree, or should the entire
> difference between HEAD and the working tree eligible to be picked
> or deferred during the "add -p" session?  Starting from a temporary
> index that matches HEAD essentially means that you lose the earlier
> "git add F" [*1*].

Two questions are easier answered:

What should git commit --only --patch F do?
=> It should start you from the state of HEAD.

What should git commit --include --patch F do?
=> It should start you from the state of the index.

The question that's harder to ponder, is "what should the default be".
Historically it's been '--include', but that was for the sake of easy
implementation (6cbf07efc5702351897dee4742525c9b9f7828ac). Using '--only' seems
good for consistency with other forms of git commit and the current
documentation; inventing a third way (i.e. depending on which paths are
specified) seems worst of all.

The big UI problem with --only is not figuring out what should go in the commit,
but rather ensuring that the index is in the expected state after the commit
(it's the problems solved by 2888605c649ccd423232161186d72c0e6c458a48 but for
hunks instead of files). If file F has hunks (H, J, K) then I stage hunk J with
git add --interactive; then I commit hunks H & K with git commit --interactive,
the resulting index should contain H, J, K. Unfortunately, git add --interactive
allows me to edit hunks, and so if I instead commit H & J2 (where J2 is an
edited version of J) then the index would contain (H, J) and the commit (H, J2);
the working tree would contain H, J, K still.

This gets a bit mind-bending to resolve; the first solution I came up with
"don't touch the index if the index differs from HEAD" will give unexpected
results in the case that extra non-conflicting chunks are added to the commit.
The next idea is to do a three-way merge between the new commit and the index
with the old HEAD as the base, and resolve conflicts in favour of the index. I
think that works, but it sounds pretty horrific to implement and still leaves
you in a pretty confusing state (though no more confusing than using edit in git
add --interactive normally is).

The other cases to consider are files that aren't in HEAD. At the moment git add
 --patch and git commit --patch cannot include new files, though that's fixable
by treating new files as 1 hunk instead of 0.

All in all, I think supporting --only --interactive is well beyond what I'm
capable of doing, and probably pushing the limits of what's sane. (it would be
nice for warm fuzzy completeness reasons though).

On Fri, Oct 5, 2012 at 3:57 PM, Jeff King <peff@peff.net> wrote:
> We should probably also support explicit "-i -p" and "-o -p" options, as
> well (the former would give people who really want the existing behavior
> a way to get it). And the same for "--interactive". I can't say I'm
> excited about making all that work, though. Like you, I think it is more
> sane to use existing tools to inspect and tweak the index to your
> liking, and then commit.

You made the same thinko as me :). --include isn't defined to mean "include the
index as well", but rather "include these files when committing the index".
Flipping that around makes a lot of sense and then --include can be used
semantically with --patch, --interactive or even --all. (patch attached).

>
> Unless somebody who cares about "commit -p" does so to come up with
> reasonable semantics, and updates the code to match that desired
> behaviour, the responsible thing to do is to error out "-p" when
> your index is different from HEAD, I think.

That would be a shame; instead we should just document that "--interactive" and
"--patch" add to the existing index like they always have. If we still worry
about users shooting themselves in the foot, then we can require "--include" to
use --interactive or --patch on a dirty index. (not done)

Conrad

--------8<------

Flip the meaning of 'git commit --include' from 'include these files' to
'include the index' to reduce the number of concepts in the manpage.

Clarify that --interactive/--patch add to the existing index to avoid
confusion like [1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/207108

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---
 Documentation/git-commit.txt | 20 +++++++++++---------
 builtin/commit.c             | 10 ++++++----
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 9594ac8..a2d4a6d 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -41,9 +41,9 @@ The content to be added can be specified in several ways:
    actual commit;

 5. by using the --interactive or --patch switches with the 'commit' command
-   to decide one by one which files or hunks should be part of the commit,
-   before finalizing the operation. See the ``Interactive Mode'' section of
-   linkgit:git-add[1] to learn how to operate these modes.
+   to add files or hunks to the current index before committing. See the
+   ``Interactive Mode'' section of linkgit:git-add[1] to learn how to
+   operate these modes.

 The `--dry-run` option can be used to obtain a
 summary of what is included by any of the above for the next
@@ -63,10 +63,14 @@ OPTIONS

 -p::
 --patch::
-       Use the interactive patch selection interface to chose
-       which changes to commit. See linkgit:git-add[1] for
+       Use the interactive patch selection interface to add hunks
+       to the index before committing. See linkgit:git-add[1] for
        details.

+--interactive::
+       Use the ``Interactive mode'' of linkgit:git-add[1] to edit
+       the index before committing.
+
 -C <commit>::
 --reuse-message=<commit>::
        Take an existing commit object, and reuse the log message
@@ -215,10 +219,8 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)

 -i::
 --include::
-       Before making a commit out of staged contents so far,
-       stage the contents of paths given on the command line
-       as well.  This is usually not what you want unless you
-       are concluding a conflicted merge.
+       In addition to the paths specified on the command line,
+       include the current contents of the index in the commit.

 -o::
 --only::
diff --git a/builtin/commit.c b/builtin/commit.c
index a17a5df..14afa58 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1034,10 +1034,12 @@ static int parse_and_validate_options(int
argc, const char *argv[],
        if (patch_interactive)
                interactive = 1;

-       if (!!also + !!only + !!all + !!interactive > 1)
-               die(_("Only one of
--include/--only/--all/--interactive/--patch can be used."));
-       if (argc == 0 && (also || (only && !amend)))
-               die(_("No paths with --include/--only does not make sense."));
+       if (only && all)
+               die(_("--only with --all does not make sense."));
+       if (only && interactive)
+               die(_("--only with --interactive/--patch is not supported."));
+       if (argc == 0 && (only && !amend))
+               die(_("No paths with --only does not make sense."));
        if (argc == 0 && only && amend)
                only_include_assumed = _("Clever... amending the last
one with dirty index.");
        if (argc > 0 && !also && !only)
