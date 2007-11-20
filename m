From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't add To: recipients to the Cc: header
Date: Tue, 20 Nov 2007 12:21:24 -0800
Message-ID: <7vr6ikk6rf.fsf@gitster.siamese.dyndns.org>
References: <1195470026-7389-1-git-send-email-ask@develooper.com>
	<7vr6ill5f1.fsf@gitster.siamese.dyndns.org>
	<7A3DDFA5-085D-4D92-BE96-A405FF1FB029@develooper.com>
	<7v8x4slovk.fsf@gitster.siamese.dyndns.org>
	<87ejekzpx3.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ask =?utf-8?Q?Bj=C3=B8rn?= Hansen <ask@develooper.com>,
	git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 21:21:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuZbS-0000M9-A7
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 21:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757458AbXKTUVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 15:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759640AbXKTUVc
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 15:21:32 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40012 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755916AbXKTUVb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 15:21:31 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 1C7632F9;
	Tue, 20 Nov 2007 15:21:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D3BA97E4B;
	Tue, 20 Nov 2007 15:21:48 -0500 (EST)
In-Reply-To: <87ejekzpx3.fsf@osv.gnss.ru> (Sergei Organov's message of "Tue,
	20 Nov 2007 22:18:32 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65576>

Sergei Organov <osv@javad.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> [...]
>> Oops, forgot to say "no need to resend".  I asked only because I
>> wanted an independent datapoint for Emacs diff mode breakage.
>
> I bet I can damage any patch using any editor ;)
>
> More interesting is what version of Emacs it was?

To be fair and honest, I do not think there is a simple fix for
this, although it probably is possible to fix it.

What is causing the "breakage" is the fact that format-patch
output ends with the signature delimiter line "^-- $" that
immediately follows the patch text.  The number of preimage
lines recorded in the hunk header of course does not initially
count it, but you are asking the diff editing mode to help you
edit the patch.

In diff editing mode, you can not only edit the contents of
postimage lines, but also add and delete the preimage and
postimage lines, and the diff editimg mode recounts the lines
and adjusts the number of lines recorded in the hunk header when
you do it.  It is very handy if it worked reliably (and often
it does).

But if you edit the last hunk of the format-patch output, unless
the editor very carefully keeps track of what you edited and
what was in the original, it is understandable that it would
mistake the signature delimiter line as the last preimage line
that is "^- $", and ends up miscounting the length of the hunk.

The signature delimiter was there from the beginning in the
patch file, but outside of the hunk in question.  We could argue
that it is a bug to mistake that as a preimage line added by the
user (after all the editor knows what was modified and what was
from the beginning), but it still is understandable.
