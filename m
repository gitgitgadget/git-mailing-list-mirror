From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fatal output from git-show really wants a terminal
Date: Mon, 15 Dec 2008 00:15:38 -0800
Message-ID: <7v3agpzwet.fsf@gitster.siamese.dyndns.org>
References: <ghop5d$qud$1@ger.gmane.org>
 <200812111051.20322.bss03@volumehost.net>
 <20081211215554.GA11565@sigill.intra.peff.net>
 <200812111645.10067.bss03@volumehost.net>
 <7vr64eb9ha.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
X-From: git-owner@vger.kernel.org Mon Dec 15 09:17:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC8da-0002Zk-93
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 09:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbYLOIPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 03:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbYLOIPv
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 03:15:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbYLOIPv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 03:15:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ABBC587387;
	Mon, 15 Dec 2008 03:15:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 76CDB87386; Mon,
 15 Dec 2008 03:15:44 -0500 (EST)
In-Reply-To: <7vr64eb9ha.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 11 Dec 2008 15:03:29 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9510DAF0-CA80-11DD-BD8F-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103138>

Junio C Hamano <gitster@pobox.com> writes:

> "Boyd Stephen Smith Jr." <bss03@volumehost.net> writes:
>
>>>  $ git log >foo.out
>>>
>>>and start a pager, which makes no sense.
>>
>> Good point, I'll try and consider that while I investgate the history of the 
>> issue.
>
> Isn't the issue about 61b8050 (sending errors to stdout under $PAGER,
> 2008-02-16)?  With that commit, we changed things so that when we send the
> standard output to the $PAGER, we dup stderr to the $PAGER as well,
> because otherwise any output to stderr will be wiped out by whatever the
> pager does and the user will not notice the breakage.  E.g.
>
> 	$ git log
>
> will just show reams of output, and you won't see any errors and warnings
> even if there were any encountered during the process.
>
> Unfortunately we did it unconditionally.  There is no reason to dup stderr
> to the $PAGER if the command line was:
>
> 	$ git log 2>error.log
>
> in which case you would want to view the normal output in your $PAGER and
> you are keeping the log of the error output in a separate file.

I haven't heard anything more about this, but if you were indeed
discussing the change made by 61b8050, I think the fix should just be like
this.

 pager.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git c/pager.c w/pager.c
index aa0966c..f19ddbc 100644
--- c/pager.c
+++ w/pager.c
@@ -70,7 +70,8 @@ void setup_pager(void)
 
 	/* original process continues, but writes to the pipe */
 	dup2(pager_process.in, 1);
-	dup2(pager_process.in, 2);
+	if (isatty(2))
+		dup2(pager_process.in, 2);
 	close(pager_process.in);
 
 	/* this makes sure that the parent terminates after the pager */
