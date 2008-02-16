From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse_tag: fail, if tagged objected would be NULL
Date: Sat, 16 Feb 2008 11:13:56 -0800
Message-ID: <7vpruw90jv.fsf@gitster.siamese.dyndns.org>
References: <12031670802582-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sat Feb 16 20:14:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQSUn-0007JS-OS
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 20:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755746AbYBPTOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 14:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755625AbYBPTOJ
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 14:14:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470AbYBPTOI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 14:14:08 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B54A5649;
	Sat, 16 Feb 2008 14:14:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 BB0C65647; Sat, 16 Feb 2008 14:14:03 -0500 (EST)
In-Reply-To: <12031670802582-git-send-email-mkoegler@auto.tuwien.ac.at>
 (Martin Koegler's message of "Sat, 16 Feb 2008 14:04:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74060>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> The cause of a NULL in tag->tagged can be:
> * a unknown object type is used
> * the tag points to a object with an other type as stated
>   in the tag.
>
> Both situations are most likley be caused by a not welformed
> tag. Catching this error here avoids doing tag->tagged!=NULL
> checks in the rest of git.

Honestly, I am torn on this.

The approach certainly is attractive if you care only about
working in a perfectly well connected repository of a known
vintage.

On the other hand, however, this robs from callers the clue that
the tag itself was Ok but it points at something we do not know
about.  Maybe the caller was only interested in the tag itself
but did not care about the pointee, and erroring out like this
may make it impossible for the caller to act on the tag itself.
Maybe the caller even knew about the breakage of the repository
and wanted to salvage as much as possible, but because this
errors out, it would now consider this tag object itself is bad
and give up, salvaging one less object.  It looks to me that
this, along with other "tighten parse_X_buffer()" changes you
sent earlier, closes door to them.  That's why I think that
parse_X_buffer() should be more lenient than fsck and keep
saying it.
