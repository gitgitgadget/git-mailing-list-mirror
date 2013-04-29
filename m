From: Junio C Hamano <gitster@pobox.com>
Subject: Re: improvements to checks for core.notesRef / GIT_NOTES_REF / --ref
Date: Mon, 29 Apr 2013 10:13:32 -0700
Message-ID: <7vmwshjm4j.fsf@alter.siamese.dyndns.org>
References: <20130427132118.GA25295@pacific.linksys.moosehall>
	<20130429133205.GA4672@pacific.linksys.moosehall>
	<20130429163909.GA19014@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Mon Apr 29 19:13:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWre0-0004oi-3F
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 19:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757191Ab3D2RNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 13:13:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35379 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756852Ab3D2RNf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 13:13:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CA43196CD;
	Mon, 29 Apr 2013 17:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cUxKYPGkOKlBEgCEfMfoyteOtkY=; b=scFQwr
	stwDcJan656NOjhrykulBGLwonlGxBdOs8t3QFd18HvKBznuBPWSpfeTsqQvLK5X
	3//UAfjY14Vc6sjLOU7rQLD8xkqdykeM76kQ+HL9RNCfbpNSBnAHUTs1adGY0PMh
	Firosh2ZhHFQSEn+wB1lei3Pols6gNUW/th1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ez/r71ay85QTGHQzqqmLAzyjRrWwQPpV
	r/G1qOdKeU/w8ysxamJniZTP8r9q6OkScXca4Eo2oO/9Ngi7of8xjHjXpvGDP9qR
	WEuyIaBgxb35vxKE+FnzSJbI0mi/kwekhSOd8tDZkZQdISun8GRmD9EwiW+HQ8WI
	RoU2JLjrpsA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51241196CC;
	Mon, 29 Apr 2013 17:13:34 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C30B8196C9;
	Mon, 29 Apr 2013 17:13:33 +0000 (UTC)
In-Reply-To: <20130429163909.GA19014@pacific.linksys.moosehall> (Adam Spiers's
	message of "Mon, 29 Apr 2013 17:39:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F494D1A-B0F0-11E2-A597-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222815>

Adam Spiers <git@adamspiers.org> writes:

>     static struct notes_tree *init_notes_check(const char *subcommand)
>     ...
> Can we relax this to "refs/", to allow better isolation of namespaces
> for remote notes?  Also, the check is applied for GIT_NOTES_REF and
> core.notesRef, but not for values passed via --ref.  Therefore I would
> propose that init_notes_check() is not only relaxed but also moved
> from builtin/notes.c to notes.c, so that it can be consumed by
> default_notes_ref().  Thoughts?

Such a policy decision at the application level should be done in
builtin/notes.c, and not notes.c, I think.  It is OK to have a
sharable check routine in notes.c and help different notes
applications to implement their own sanity checking, though.  "git
notes" that operates only on local notes might restrict its
operation to refs/notes, while "git notes-merge" may allow it to
read from other hierarchies but still write only into refs/notes,
for example.

I am not sure if it is a good idea in general to have a separate
remotes-notes/ hierarchy in the first place, though.  Wouldn't the
notes be less like branches (private view) and more like tags
(common world view)?

> Also, are there any plans in the future for making "git notes merge"
> provide an index, so that a proper 3-way merge with ancestor can be
> done using git mergetool?

Are we committed that all notes leaves must be blobs (I do not
personally mind it)?

I do think we need a way to call a custom low level 3-way merge
driver once we identify which notes blobs correspond to each other
with what common ancestor notes blob while merging two notes trees.

But I do not think that "an index" that we use for the usual working
tree merge is necessarily a good representation for driving such a
ll-merge driver and recording its result.  Each side likely has a
note for the same object to be merged in a different fan-out layout,
and fan-out is merely a performance hack to spread the objects in
smaller trees.  As mergetools only work with the usual working tree
with the usual index, they may be a poor substitute for ll-merge
drivers to handle merging notes trees.
