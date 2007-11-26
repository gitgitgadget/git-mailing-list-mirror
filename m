From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Mon, 26 Nov 2007 09:55:08 -0800
Message-ID: <7vsl2sgadf.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711252236350.4725@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vbq9hiz6a.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711261236280.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 26 18:55:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwiBD-0000mn-Fl
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 18:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755761AbXKZRzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 12:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755712AbXKZRzP
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 12:55:15 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:43921 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821AbXKZRzO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 12:55:14 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id F25F22FA;
	Mon, 26 Nov 2007 12:55:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 708A29908D;
	Mon, 26 Nov 2007 12:55:32 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711261236280.27959@racer.site> (Johannes
	Schindelin's message of "Mon, 26 Nov 2007 12:39:49 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66088>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 25 Nov 2007, Junio C Hamano wrote:
>
>> I am not sure if abort should be the default.
>
> I tried to be conservative.
>
>> If a straight dump-restore is made without rewriting, the result will be 
>> identical to the original, right?
>
> Yep.
> ...
> I agree that for most serious operations sed is not good enough.

My comment was more about the perception from a new user (not a "new git
user", but a "new fast-export and fast-import user").

When you see a command pair foo-export and foo-import, and it is
advertised that you can pipe them together, a new user would first try a
straight dump-restore, and would see the warning even though he did not
do any editing on the stream.

	Huh?  Why does a tag signature become invalid because of merely
	exporting and then importing?  What is this warning about?

You would explain "yeah in your trial run you did not edit but the
command pair is to allow you editing the contents in between, and if you
do that, the object names might change.".

If the default were "straight copy", then the user will not get an
invalid signature on his trial run, but will get an invalid signature
when he rewrites the object stream.  You would get a message on the list
like this:

	Hello, I tried fast-export piped to fast-import so that I can
	rewrite my repository, but I am getting invalid signature on
	signed tags.  It does not seem to happen if I do not edit but
	just use the fast-export output without modification.  What am I
	doing wrong?

And that is the time the explanation first becomes useful.  IOW, you are
warning at the wrong place.  "It may or may not corrupt the signature, I
do not know.  Because it depends on what you are going to do with my
output, I cannot know.  I am warning you anyway to cover my backside".

I am wondering if fast-import input syntax can be extended to allow
checking inconsistencies.  A command to import a tag could take an
additional object name and tell it to warn if the name of the tagged
object (the one sent with "from:%d\n" part) is different from that
object name.  At that point, you know the object was rewritten and the
signature is invalid, and the choice of warning, stripping or aborting
becomes a useful thing to have.
