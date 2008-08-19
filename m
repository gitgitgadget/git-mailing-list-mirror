From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2008, #05; Tue, 19)
Date: Tue, 19 Aug 2008 12:19:09 -0700
Message-ID: <7vabf83j9u.fsf@gitster.siamese.dyndns.org>
References: <7vpro5cr2x.fsf@gitster.siamese.dyndns.org>
 <20080819125429.GD17582@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 21:20:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVWkh-0008Ac-KW
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 21:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235AbYHSTTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 15:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbYHSTTS
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 15:19:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbYHSTTS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 15:19:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B20B8520E4;
	Tue, 19 Aug 2008 15:19:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8C2F5520E0; Tue, 19 Aug 2008 15:19:12 -0400 (EDT)
In-Reply-To: <20080819125429.GD17582@genesis.frugalware.org> (Miklos Vajna's
 message of "Tue, 19 Aug 2008 14:54:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B72E432A-6E23-11DD-8C97-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92909>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Tue, Aug 19, 2008 at 02:05:42AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> [On Hold]
>> (...)
>> * mv/merge-recursive (Tue Aug 12 22:14:00 2008 +0200) 3 commits
>>  - Make builtin-revert.c use merge_recursive_generic()
>>  - merge-recursive.c: Add more generic merge_recursive_generic()
>>  - Split out merge_recursive() to merge-recursive.c
>> 
>> I do not think builtlin-revert should use "recursive", but these patches
>> give a good starting point to separate the bulk of the "rename-aware
>> three-way merge" into library form.
>
> I wanted to send a patch that makes builtin-merge use the new
> merge_recursive_setup(), but then I was not able to decide to use
> merge_recursive_generic() or not.

I think git-merge and git-merge-recursive should be the only two that
actually trigger the "recursive" behaviour.  Everybody else should be
using non-recursive one, and that non-recursive one can be shared by the
one that is recursive.

Here is how the callchain looks like with your variant.

 cmd_merge_recursive()
 -> merge_recursive_setup()
 -> merge_recursive_generic()
    -> merge_recursive()
       -> merge_recursive()
       -> merge_trees()

The merge_recursive() is the "recursive" one.  The workhorse that is not
recursive is merge_trees().

Since the latter is what everybody else ("checkout -m", "revert",
"cherry-pick", "am -3", "stash apply") should be using, I think it is
pretty much up to "git-merge" and "git-merge-recursive" implementations
how the caller of merge_recursive() function is structured.  I suspect
that you would not need two separate functions, _setup() and _generic(),
for these two codepaths, but I didn't look closely.

And make_virtual_commit() should become static inside merge_recursive.c;
use of these fake commits is strictly an internal implementation issue of
how merge_recursive() function works and does not concern the caller, does
it?

By the way, the calling convention of merge_recursive_generic() looks
confusing (even though by the above reasoning it does not matter very much
outside "git-merge" and "git-merge-recursive").  Why does it take textual
object names for bases but binary object names for head and next?
