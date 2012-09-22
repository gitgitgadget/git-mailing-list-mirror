From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Quickly searching for a note
Date: Fri, 21 Sep 2012 21:51:12 -0700
Message-ID: <7v1uhu4q4f.fsf@alter.siamese.dyndns.org>
References: <505C7C80.3000700@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 06:51:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFHgd-0005KM-UQ
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 06:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329Ab2IVEvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 00:51:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35069 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752102Ab2IVEvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 00:51:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50CD39D98;
	Sat, 22 Sep 2012 00:51:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bc5aPZhFuxNIGclDiwbZL4yOA7M=; b=Blk4/G
	UPQPDdd9z6vV07mWpByw5Y1h8aQMW7xKuUSRq7gKX9SygkuzZiFwJ2klYaYp43Cp
	1yzvm8ntJ6oV2exKHQEWs4ziyGyV0A7mmcL3iru8VVkJVWhzL0MQrsm4rMxa/GPf
	HCOj3Mapim1+Xa6A6AEtXqPuh3TXTdDYaeAIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t1Xmwiw6S2Dt8syLY1n+cU18M4vudSNC
	q9sfoBHfFIy9Cd5QpDFP/7ZCabA0HAwSXiM3fNCysCqzJ8s8dibvFY23Vc2fHYt0
	kw88xEp5Otmi/tjp7Q1nsPxmnqOTyEh+hNvTe9+a8UoRxerGpydOdMH1iSRILJcx
	w9CCt/iJEcs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C0169D97;
	Sat, 22 Sep 2012 00:51:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AC479D95; Sat, 22 Sep 2012
 00:51:14 -0400 (EDT)
In-Reply-To: <505C7C80.3000700@workspacewhiz.com> (Joshua Jensen's message of
 "Fri, 21 Sep 2012 08:41:04 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2340E6DE-0471-11E2-A4A8-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206189>

Joshua Jensen <jjensen@workspacewhiz.com> writes:

> Background: To tie Perforce changelists to Git commits, I add a note
> to a commit with the form "P4@123456".  Later, I use the note to sync
> down the closest Perforce changelist matching the Git commit.

I noticed that nobody brought this up, but probably it should not be
left unsaid, so...

For annotating commits with additional pieces of data, notes is a
reasonable mechanism, but the user should be aware that it is
heavily geared towards one-way mapping. When you have a commit and
want to know something about it, it will give you the associated
information reasonably efficiently.

But it is not a good mechanism for retrieval if the primary way you
use the stored information is to go from the associated information
to find the commit that has that note attached to it.  Your usage
pattern that triggered this thread may fall into that category.

It may still be a reasonable mechanism to use notes to exchange the
information across repositories, but if your application relies
heavily on mapping the information in the opposite way, you may want
to maintain a local cache of the reverse mapping in a more efficient
fashion.  For example, every time your notes tree is updated, you
can loop over "git notes list" output and register the contents of
the blob object that annotates each commit as the key and the commit
object name as the value to a repository-local sqlite database or
something (and depending on the nature of the frequent query, have
efficient index on the key).

Having mentioned an external database as the most generic approach,
I suspect that one important way to use notes is to associate
commits with some other (presumably unique) ID to interface with the
external world.  For example, I maintain "amlog" notes to record the
original message-ID for each commit that resulted from "git am".
The primary use of this is to find the message-ID for a commit that
was made some time ago and later found to be questionable, so that I
can find the relevant discussion thread, but the information could
be used to see if a given message I see in the mail archive has been
already applied, and this needs a fast reverse mapping.

It actually is fairly trivial to maintain both forward and reverse
mapping for this kind of use case.  For example, your gateway that
syncs from Perforce may currently be doing something like this at
the end of it:

    git notes --ref p4notes add -m "P4@$p4_change_id" HEAD

to give a quick mapping the commit object name of the resulting
commit (in HEAD) to "P4@123456".

This is stored as a mapping from the object name of HEAD to the
object name of a blob whose contents is "P4@123456"  You can see it
in action with

    $ git notes --ref p4notes list HEAD

that gives the blob object name that stores the note for the HEAD.

Now, there is _no_ reason why you cannot attach notes to these blob
objects.  For example, your "Perforce to Git" gateway can end with
something like this instead:

    HEAD=$(git rev-parse --verify HEAD)
    git notes --ref p4notes add -m "P4@$p4_change_id" $HEAD
    noteblob=$(git notes --ref p4notes list $HEAD)
    git notes --ref p4notes add -m "$HEAD" $noteblob

Then when you want to map P4@123456 to Git commit, you could

    $ noteblob=$(echo P4@123456 | git hash-object --stdin)
    $ git notes --ref p4notes show $noteblob

to see the commit object name that is associated with that notes.
Of course, the same notes tree holds the forward mapping as before,
so 

    $ git notes --ref p4notes show HEAD

will give you the "P4@123456".

We may want to support such a reverse mapping natively so that
"notes rewrite" logic maintains the mapping in both direction.

I've CC'ed people who may want to be involved in further design
work.
