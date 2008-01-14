From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] parse_commit_buffer: don't parse invalid commits
Date: Sun, 13 Jan 2008 23:23:40 -0800
Message-ID: <7vk5mclvk3.fsf@gitster.siamese.dyndns.org>
References: <12002478702664-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Jan 14 08:24:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEJg6-0001XI-Uy
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 08:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbYANHXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 02:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbYANHXq
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 02:23:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38575 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbYANHXq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 02:23:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DEDC1C5B;
	Mon, 14 Jan 2008 02:23:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E98C11C5A;
	Mon, 14 Jan 2008 02:23:41 -0500 (EST)
In-Reply-To: <12002478702664-git-send-email-mkoegler@auto.tuwien.ac.at>
	(Martin Koegler's message of "Sun, 13 Jan 2008 19:11:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70446>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> +	if (!parse_commit_date(bufptr, tail, &item->date))
> +		return error("bogus commit date in object %s", sha1_to_hex(item->object.sha1));
>  
>  	if (track_object_refs) {
>  		unsigned i = 0;

I suspect this might be an undesirable regression.

If somebody managed to create a commit with a bogus "author"
line and wanted to clean up the history, your previous one at
least gave something usable back, even though it had to come up
with a bogus date.  It gave the rest of the data back without
barfing.  And it was easy to see which "resurrected" commit had
a missing author date (bogus ones always gave 0 timestamp).

This round you made it to error out, and callers that check the
return value of parse_commit() would stop traversing the
history, even if the commit in question has perfectly valid
"parent " lines, thinking "ah, this commit object is faulty".
It actively interferes with attempts to resurrect data from
history that contains a faulty commit.

Your previous version was much better with respect to this
issue.  It was about being more careful not to read outside the
commit object buffer, while still allowing the data from a
history that has an unfortunate commit with broken author line
to be resurrected more easily.

I do not think the checks done by fsck and parse_commit should
share the same strictness.  They serve different purposes.
