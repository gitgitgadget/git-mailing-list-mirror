From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2008, #05; Tue, 19)
Date: Tue, 19 Aug 2008 15:00:27 -0700
Message-ID: <7v3al0zmv8.fsf@gitster.siamese.dyndns.org>
References: <7vpro5cr2x.fsf@gitster.siamese.dyndns.org>
 <20080819125429.GD17582@genesis.frugalware.org>
 <7vabf83j9u.fsf@gitster.siamese.dyndns.org>
 <20080819205917.GJ23800@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Aug 20 00:01:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVZGo-0003iU-I1
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 00:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbYHSWAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 18:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752481AbYHSWAh
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 18:00:37 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbYHSWAg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 18:00:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D6EC95FDB0;
	Tue, 19 Aug 2008 18:00:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5956D5FDAE; Tue, 19 Aug 2008 18:00:30 -0400 (EDT)
In-Reply-To: <20080819205917.GJ23800@genesis.frugalware.org> (Miklos Vajna's
 message of "Tue, 19 Aug 2008 22:59:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3FB5155A-6E3A-11DD-BB19-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92927>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Tue, Aug 19, 2008 at 12:19:09PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> Since the latter is what everybody else ("checkout -m", "revert",
>> "cherry-pick", "am -3", "stash apply") should be using, I think it is
>> pretty much up to "git-merge" and "git-merge-recursive" implementations
>> how the caller of merge_recursive() function is structured.  I suspect
>> that you would not need two separate functions, _setup() and _generic(),
>> for these two codepaths, but I didn't look closely.
>
> Sure, I can avoid _generic() and use merge_recursive() directly, that's
> why I asked.
>
>> And make_virtual_commit() should become static inside merge_recursive.c;
>> use of these fake commits is strictly an internal implementation issue of
>> how merge_recursive() function works and does not concern the caller, does
>> it?
>
> Not exactly. builtin-merge-recursive uses get_ref() - which should not
> be in merge-recursive.c IMHO - and get_ref() uses make_virtual_commit().
> merge_recursive() itself takes commits, so it can be only static if we
> copy it builtin-merge-recursive as well, causing a code duplication. Or
> have I missed something here?

I think you have.

Let's look at the call chain from cmd_merge_recursive() and think again.

    cmd_merge_recursive()
    -> merge_recursive_setup()
    -> merge_recursive_generic()
       -> merge_recursive()
          -> merge_recursive()
          -> merge_trees()

cmd_merge_recursive() takes subtree option and set of object names (two
commits and zero or more base commits), massages them and calls
merge_recursive().  merge_recursive_setup() and merge_recursive_generic()
are involved in this massaging process.

merge_recursive() computes the bases itself when given no base, and in a
multi-base situation, does its thing recursively to come up with a
consolidated base, using virtual commits.  After coming up with the three
(virtual or real) commits to use, it gives them to merge_trees(), which
operate solely on tree objects.

In addition, merge_recursive() currently *requires* the caller to wrap
bare tree objects in virtual commits, if the caller wants to do a simple
three-way merge of trees (in which case because there is no ancestry
information available you would naturally not do any recursive behaviour).
This "input must be commit" requirement is why you think you need to have
get_ref() that uses make_virtual_commit() in the caller.

But it does not have to be that way.  It is merely an artifact of the
current refactoring that kept the interface into merge_recursive() based
on commit objects.  You could further refine the refactoring so that:

 - merge_trees(), in addition to the three tree objects, takes options
   such as use of the subtree behaviour, descriptive names for heads to be
   used for conflict markers, verbosity level, and other future options
   (such as "use this lower rename detaction threshold").  Introduce
   "struct merge_options" for that and pass it around.  These show() and
   output() calls could even become callbacks, but I didn't look very
   carefully.

 - merge_recursive(), in addition to that "merge_options" structure, will
   take heads, and list of common ancestors.

 - merge_recursive_generic() can be a layer on top of merge_recursive() to
   allow the caller to feed tree objects.  Use of "const unsigned char *"
   to give raw object names (or even "const char *" to feed texual object
   names) would be easier for the callers.  Wrapping a tree into virtual
   commit can and should be done at this layer, hidden away inside
   merge-recursive.c from the callers.

   Alternatively, you can do away without such preparation step, and move
   the "wrap a tree into a virtual commit" inside merge_recursive()
   itself.  If you take that route, merge_recursive() will take heads and
   list of common ancestors all in "const unsigned char *" object names,
   in addition to the "merge_options" structure.

When you rewrite cmd_merge() to make direct call to bypass a subprocess,
your callchain would look like:

    cmd_merge()
    -> merge_recursive()
       -> merge_recursive()
       -> merge_trees()

cmd_merge() needs to do the same arrangement for "subtree" and any
possible future options, and feed the same set of object names to
merge_recursive().  You cannot give a bare tree to "git merge", so you do
not have to worry about having to wrap it in a virtual commit.

So my gut feeling is that the interface may look something like:

struct merge_options {
        const char *branch1_label;
        const char *branch2_label;
        unsigned subtree_merge : 1;
	int verbosity;
        /* other options here ... */
};

/* rename-detecting three-way merge, no recursion */
int merge_trees(struct merge_options *,
                struct tree *head,
                struct tree *merge,
                struct tree *common,
                struct tree **result);

/* merge_trees() but with recursive ancestor consolidation */
int merge_recursive(struct merge_options *,
                    struct commit *h1,
                    struct commit *h2,
                    struct commit_list *ca,
                    struct commit **result);

/*
 * "git-merge-recursive" can be fed trees; wrap them into
 * virtual commits and call merge_recursive() proper.
 */
int merge_recursive_generic(struct merge_options *,
                            const unsigned char *head,
                            const unsigned char *merge,
                            int num_ca,
                            const unsigned char **ca,
                            struct commit **result);

and the call chain would become:

    cmd_merge_recursive()
    -> merge_recursive_generic()
       -> merge_recursive()
          -> merge_recursive()
          -> merge_trees()

    cmd_merge()
    -> merge_recursive()
       -> merge_recursive()
       -> merge_trees()

    cmd_revert(), cmd_am(), cmd_checkout(), cmd_stash(), ...
    -> merge_trees()
