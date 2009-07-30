From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Demonstrate bugs when a directory is replaced with a
 symlink
Date: Wed, 29 Jul 2009 20:26:43 -0700
Message-ID: <7vbpn2n958.fsf@alter.siamese.dyndns.org>
References: <1248819198-13921-1-git-send-email-james.e.pickens@intel.com>
 <1248819198-13921-2-git-send-email-james.e.pickens@intel.com>
 <4A70062A.4040008@drmicha.warpmail.net>
 <7v4osvyjl2.fsf@alter.siamese.dyndns.org>
 <3BA20DF9B35F384F8B7395B001EC3FB342402AD9@azsmsx507.amr.corp.intel.com>
 <7v63dbuyru.fsf@alter.siamese.dyndns.org>
 <3BA20DF9B35F384F8B7395B001EC3FB342402D3C@azsmsx507.amr.corp.intel.com>
 <alpine.LFD.2.01.0907291440480.3161@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Pickens\, James E" <james.e.pickens@intel.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 30 05:27:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWMIK-0006U5-Bq
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 05:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbZG3D0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 23:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753629AbZG3D0x
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 23:26:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57205 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbZG3D0x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 23:26:53 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7242616887;
	Wed, 29 Jul 2009 23:26:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 17D7416886; Wed, 29 Jul 2009
 23:26:44 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D3A4B580-7CB8-11DE-98E6-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124438>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This patch should fix the 'checkout' issue.
>
> I made it use a new generic helper function ("check_path()"), since there 
> are other cases like this that use just 'lstat()', and I bet we want to 
> change that.
>
> The 'merge' issue is different, though: it's not due to a blind 'lstat()', 
> but due to a blind 'unlink()' done by 'remove_path()'. I think 
> 'remove_path()' should be taught to look for symlinks, and remove just the 
> symlink - but that's a bit more work, especially since the symlink cache 
> doesn't seem to expose any way to get the "what is the first symlink path" 
> information.

This is a good thing to do, but the James's "checkout" test fails for an
unrelated reason.

The tree has

        120000 blob a36b773	a/b		-> b-2
        100644 blob e69de29	a/b-2/c/d
        100644 blob e69de29	a/x

checked out, and wants to switch to 

        100644 blob e69de29	a/b-2/c/d
        100644 blob e69de29	a/b/c/d
        100644 blob e69de29	a/x

checkout_entry() is called to check out "a/b/c/d".  If "a/b" symlink
were still there, the lstat() you fixed will be fooled.

But in James's test, because the symlink "a/b" is tracked in the
switched-from commit and is being obliterated by switching to a tree that
has a directory there, we (should) have called deleted_entry() on a/b to
mark it for removal, and inside check_updates() before going into the loop
to call checkout_entry(), we would have already removed the symlink "a/b"
that is going away inside unlink_entry().

The problem is that has_symlink_or_noent_leading_path() called from there
lies, without Kjetil's fix c52dc70 (lstat_cache: guard against full match
of length of 'name' parameter, 2009-06-14) that is in 'pu'.

If the original tree in the test did not have "a/b" tracked, but has an
untracked symlink "a/b" that points at b-2, then "a/b" will stay in the
work tree when the codepath your patch touches is reached, and the problem
will be demonstrated. Your patch will fix that issue.

So both fixes are necessary, and we need a separate test to illustrate
what your patch fixes.

I'll push out some updates to do so.
