From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Which is wrong? diff or apply?
Date: Fri, 23 Jul 2010 13:49:53 -0700
Message-ID: <7vzkxhexe6.fsf@alter.siamese.dyndns.org>
References: <201007232103.08870.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jul 23 22:50:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcPC7-0006XG-GV
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 22:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757114Ab0GWUuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 16:50:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51559 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab0GWUuB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 16:50:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E39EC72B8;
	Fri, 23 Jul 2010 16:50:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rdb2FyY1MHF4lBWJSRIV4KxDD0I=; b=fucEHG
	HGm7YXQUGzwg1aN4U5kY3AE2CNKYgxzvXn20GwESzkOxq0oAMc82n1NkSRhMSRBO
	F+8KK7Hk/IPTmN62YNw1vq/oD7w1vjttmPxagcik+lS18pa7X6NV4yLmIwlx3ifD
	q6NinnNN3dKzBBT114wgBEy1h4APaXyhB8r5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KYpsiNOnqc16E73FIvfdnsaY5CwR1vXf
	g+E/fCr1aSe3NATsBWvZouXJKrhXpz+o/Hgje8MsXhIT7mCH1sjbLw5DBx2PBIKI
	cjgCipqYJw1wKVVvjQdWccrgdcH/SrCjduWnA2k/B3RQuPiSHngxC4gAO87UmEWz
	gdDI+SpVzrE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DFE51C72B7;
	Fri, 23 Jul 2010 16:49:57 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 070C6C72B3; Fri, 23 Jul
 2010 16:49:54 -0400 (EDT)
In-Reply-To: <201007232103.08870.j6t@kdbg.org> (Johannes Sixt's message of
 "Fri\, 23 Jul 2010 21\:03\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DAC5DF62-969B-11DF-AE3F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151573>

Johannes Sixt <j6t@kdbg.org> writes:

> Today, I tried this in my git.git checkout:
>
>   $ mv transport-helper.c wt-status.c
>   $ git diff -B -M | git apply --cached
>   error: wt-status.c: already exists in index
>
> That is, I overwrote the tracked wt-status.c with a completly different file 
> that is also tracked. Then I try to stage the change using git apply.
>
> git diff -B -M reports this:
>
>   diff --git a/transport-helper.c b/wt-status.c
>   similarity index 100%
>   rename from transport-helper.c
>   rename to wt-status.c
>
> Notice that there is no mention that the previously existing wt-status.c was 
> removed. I wonder whether this is a bug.

Honestly speaking, I would consider this a corner case "git apply" bug
that nobody cared about so far ;-)

We can read from the above patch that:

 (1) it does not want transport-helper.c in the resulting tree; and

 (2) it does want wt-status.c in the resulting tree the same as
     transport-helper.c from the original tree.

So I do not think a separate "deletion" record is necessary in the diff
output.  So far, we have tried (and succeeded, I think) hard to avoid
creating diffs that talk about the same path twice in a redundant way.

What should "git apply" do in this case then?

The path involved are transport-helper.c (will be removed) and wt-status.c
(will be rewritten).  The usual "safety" rules should apply to both of
them when "apply --index" is run.  Namely

 - transport-helper.c, as it will be removed, should not have difference
   from the version in the index; and

 - wt-status.c, as it will be modified to match transport-helper.c, should
   not have difference from the version in the index, either.

If we check the "renamed-to" case differently from the "created-at" case
(which I do not think the code does right now), we should be fine, I
think.
