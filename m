From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (1b)] merge-recursive.c: Add more generic
 merge_recursive_generic()
Date: Wed, 13 Aug 2008 12:55:47 -0700
Message-ID: <7v3al8ofjw.fsf@gitster.siamese.dyndns.org>
References: <1218559514-16890-1-git-send-email-vmiklos@frugalware.org>
 <1218572040-23362-1-git-send-email-s-beyer@gmx.net>
 <alpine.LNX.1.00.0808122309460.19665@iabervon.org>
 <20080813172938.GC12871@leksak.fem-net>
 <alpine.LNX.1.00.0808131333230.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 21:57:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTMSq-0002aY-C3
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 21:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbYHMTz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 15:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752424AbYHMTz5
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 15:55:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbYHMTz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 15:55:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AF9AC53F98;
	Wed, 13 Aug 2008 15:55:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C858253F95; Wed, 13 Aug 2008 15:55:49 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0808131333230.19665@iabervon.org> (Daniel
 Barkalow's message of "Wed, 13 Aug 2008 13:54:16 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D6CE5F96-6971-11DD-BC8D-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92257>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> Puhh, I've not dug into merging stuff that deep, but for me it does not
>> look that this can be done in a useful way, i.e. merge_working_tree()
>> does not do a recursive merge.
>
> Ah, true. It's actually doing a single merge in the way that 
> merge_recursive would do a single merge. I think it ought to be doing 
> a recursive merge, but that's probably a change for later, anyway. (This 
> is for -m, which essentially picks the uncommited changes versus the old 
> branch, applied to the new branch uncommitted)

Why would you think it should be doing a recursive merge?  It shouldn't.

Think of builtin-merge-recursive.c::merge_trees() as a fancier version of
3-tree variant of "unpack_trees()", with -m and -u option.

When you want to perform an exact three-way merge (i.e. you have two
states O and B, and you want to apply changes between O and B to your
state A, and you _precisely_ know what O is) that's the interface you
would want to use, not the recursive one.  The recursive behaviour is
desirable only when you have A and B and need to infer where O should be,
and/or there are multiple O's to deal with (i.e. running "git-merge B"
when you are at A).

In all the potential users of merge-recursive machinery, namely, "revert",
"cherry-pick", "stash apply", "am -3", and "checkout -m", you know what
single common tree to use for your three-way merge.  These operations,
when done with direct C call into merge machinery, should NOT be using the
"recursive" one.

When you switch branches from A to B with checkout, and you have local
changes A', then you would want an exact three-way merge that modifies B
by applying changes from A to A'.

When you cherry-pick commit C on top of your current HEAD, you want an exact
three-way merge that modifies your HEAD by applying changes from C^ to C,
and you do not want the merge machinery to take ancestry relation (and
criss cross merges) between HEAD and C into account at all.

The scripted version of revert/cherry-pick used git-merge-recursive
because that is the Porcelain API available, and the current C-rewrite
uses it as well, but if we are rewriting it to call merge-recursive
machinery directly, it should be making a single merge request to
merge_trees(), not "recursive" one.
