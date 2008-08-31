From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 - RFH/WIP] xdiff-merge: optionally show conflicts in
 "diff3 -m" style
Date: Sun, 31 Aug 2008 00:10:45 -0700
Message-ID: <7v1w05d5hm.fsf@gitster.siamese.dyndns.org>
References: <7vzlmwbs1u.fsf@gitster.siamese.dyndns.org>
 <7vsksobrn9.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0808281727490.3300@nehalem.linux-foundation.org>
 <7vmyiwbpe2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 31 09:12:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZh6g-0002QB-Gz
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 09:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbYHaHK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 03:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752773AbYHaHK7
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 03:10:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37625 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbYHaHK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 03:10:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3BDCD587DE;
	Sun, 31 Aug 2008 03:10:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D4FEC587DD; Sun, 31 Aug 2008 03:10:52 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F536E238-772B-11DD-87E2-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94459>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Thu, 28 Aug 2008, Junio C Hamano wrote:
>>> 
>>> Some poeple find it easier to be able to understand what is going on when
>>> they can view the common ancestor's version, which is used by "diff3 -m",
>>> which shows:
>>> 
>>>  <<<<<<<
>>>  postimage from one side;
>>>  |||||||
>>>  shared preimage;
>>>  =======
>>>  postimage of the other side; and
>>>  >>>>>>>
>>> 
>>> This is an initial step to bring that as an optional feature to git.
>>> Only "git merge-file" has been converted, with "--diff3" option.
>>
>> If you have the common ancestor, why would you ever want this format, and 
>> not a nice conflict entry in the index?
>
> We already have that, don't we?  You can think of it as how to present
> that information without resorting to "diff :1:path :2:path".

I've been using this for my own work, and here is a typical example.  This
happened while rebuilding 'pu', merging jc/merge-whitespace topic on top
of what contains jc/better-conflict-resolution topic.

    In case if anybody is interested in reproducing this to follow the
    discussion of improving the support of conflicted merge resolution,
    here is how to reproduce this:

        $ git checkout 7ead6a7^
        $ git merge ^2

In builtin-merge-file.c, there appears:

	ret = xdl_merge(mmfs + 1, mmfs + 0, names[0], mmfs + 2, names[2],
<<<<<<< HEAD:builtin-merge-file.c
			&xpp, merge_level | merge_style, &result);
|||||||
			&xpp, XDL_MERGE_ZEALOUS_ALNUM, &result);
=======
			&xpp, XDL_MERGE_ZEALOUS_ALNUM, ws_rule, &result);
>>>>>>> jc/merge-whitespace:builtin-merge-file.c

	for (i = 0; i < 3; i++)

In this case, both branches are my code, so I do not need the additional
hint to see that one branch added ws_rule parameter while the other one
generalized the "merge simplify level" parameter and is now passing a
bitwise OR of two variables.  But if somebody else is doing the merge, it
may not be so obvious how the resolution should be.

On the other hand, this appears in ll-merge.c:

	xpparam_t xpp;
<<<<<<< HEAD:ll-merge.c
	int style = 0;
|||||||
=======
	unsigned ws_rule = 0;
>>>>>>> jc/merge-whitespace:ll-merge.c

This is obviously useless; perhaps we can drop the "original" hunk when it
is empty to save space?

Another thing that helped me figure out what was going on was when merging
mv/merge-recursive topic on top of next.

    In case if anybody is interested in reproducing this to follow the
    discussion of improving the support of conflicted merge resolution,
    here is how to reproduce this:

        $ git checkout ebe0e3b^
        $ git merge ebe0e3b^2

This merge involves removal of quite a lot of lines to a new file
merge-recursive.c from existing builtin-merge-recursive.c; the default
conflict simplification (XDL_MERGE_ZEALOUS) works _extremely_ well for
this merge, in that it shows this (I'll refer to this result as *1* in a
later paragraph):

    <<<<<<<
    static struct commit *get_ref(const char *ref)
    {
    ...
    }

    static int merge_config(const char *var, const char *value, void *cb)
    {
    ...
    }

    =======
    >>>>>>>

It just shows we have _some_ changes to these two functions since the
other side removed them from this file, but it does not say what the
change is.  However, with the "common ancestor" version, here is what I
get (you need to use 'next' and "merge.conflictstyle" configuration set to
"diff3" to reproduce this):

    <<<<<<<
    static struct commit *get_ref(const char *ref)
    {
    ...
    }

    static int merge_config(const char *var, const char *value, void *cb)
    {
    ...
            return git_xmerge_config(var, value, cb);
    }

    |||||||
    static struct commit *get_ref(const char *ref)
    {
    ...
    }

    static int merge_config(const char *var, const char *value, void *cb)
    {
    ...
            return git_default_config(var, value, cb);
    }

    =======
    >>>>>>> theirs

By comparing the first and second part, we can tell that the call to
git_default_config() was replaced to a call to git_xmerge_config().  And
this is a crucial clue to me to make an corresponding update to the
function that now lives in merge-file.c.

On average, I am finding that "diff3 -m" format more irritating than
useful.  However, on occasions like this, I am finding it quite useful.

My observation so far suggests that it would be best for me to leave the
configuration "merge.conflictstyle" to the default "merge", and instead
give an option to allow me to tell "git checkout -m -- $path" (which is
also a new feature; it overwrites the $path by the result of a fresh merge
to reproduce the conflicted state in the working tree, using the three
stages recorded in the index) to use "diff3 -m" style, when I want to.

That means the command sequence would look like:

    $ git merge mv/merge-recursive ;# git merge ebe0e3b^2
    .. oops, heavily conflicted merge and I see *1*, which is not
    .. very useful.  Let's see what is going on.
    .. Note that this --merge=diff3 option does not exist yet.
    $ git checkout --merge=diff3 -- builtin-merge-recursive.c
    $ emacs builtin-merge-recursive.c
    .. split the buffer into two, move the cursor to the line after <<<
    .. in one window while moving the cursor to the line after ||| line
    .. in the other one, and say "M-x compare-windows".  Aha, there is
    .. a change there.

Having said all that, I now realize that the way I described in my
response to you is just as easy to view this particular case:

    $ git merge mv/merge-recursive ;# git merge ebe0e3b^2
    .. oops, heavily conflicted merge and I see *1*, which is not
    .. very useful.  Let's see what is going on.
    .. Note that this --merge=diff3 option does not exist yet.
    $ git diff :{1,2}:builtin-merge-recursive.c ;# shell expands {1,2} ;-)

which exactly shows what one side changed -- instead of calling
git_default_config(), the code calls git_xmerge_config().

$ git diff :{1,2}:builtin-merge-recursive.c
diff --git a/:1:builtin-merge-recursive.c b/:2:builtin-merge-recursive.c
index dfb363e..f3b6ede 100644
--- a/:1:builtin-merge-recursive.c
+++ b/:2:builtin-merge-recursive.c
@@ -1348,7 +1348,7 @@ static int merge_config(const char *var, const char *value, void *cb)
                merge_rename_limit = git_config_int(var, value);
                return 0;
        }
-       return git_default_config(var, value, cb);
+       return git_xmerge_config(var, value, cb);
 }

 int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
