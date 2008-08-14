From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH 2/3] git-daemon: make the signal handler almost a no-op
Date: Thu, 14 Aug 2008 02:18:58 +0200
Message-ID: <20080814001858.GB14939@cuci.nl>
References: <20080813084330.30845.89753.stgit@aristoteles.cuci.nl> <20080813084331.30845.74788.stgit@aristoteles.cuci.nl> <7v1w0sjw47.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 02:20:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTQZP-0003wH-Lc
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 02:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266AbYHNAS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 20:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753544AbYHNAS7
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 20:18:59 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:38682 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbYHNAS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 20:18:59 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 23F4C5465; Thu, 14 Aug 2008 02:18:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1w0sjw47.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92297>

Junio C Hamano wrote:
>"Stephen R. van den Berg" <srb@cuci.nl> writes:
>> by exploiting the fact that systemcalls get interrupted by signals;
>> and even they aren't, all zombies will be collected before the next
>> accept().

>Dscho may want to say something about "even they aren't..." part, after he
>comes back to the keyboard.

That should have read "even if they aren't".  Nonetheless, I don't know
systems where it doesn't work this way, but even if a system resisted,
the problem is mitigated by the fact that we reap the children before
every accept.

>> Fix another error() -> logerror() call.

>which should have been in 1/3, I suppose.

Sort of, yes, it was a bit messy to get it out in one piece.

>> @@ -1036,10 +1034,7 @@ int main(int argc, char **argv)
>>  	gid_t gid = 0;
>>  	int i;

>> -	/* Without this we cannot rely on waitpid() to tell
>> -	 * what happened to our children.
>> -	 */
>> -	signal(SIGCHLD, SIG_DFL);
>> +	child_handler(0);

>Why?

child_handler() now does barely more than setup the signal handler,
which is exactly what we want to do here.

>With your change, the first part happens to be almost no-op, but I do not
>think it justifies this hunk.

>After all, we might even want to do something like:

>	static void child_handler(int signo)
>        {
>        	if (USE_SYSV_SIGNAL_SEMANTICS)
>                	signal(SIGCHLD, child_handler);

>and have the compiler optimize out the signal rearming with

>	cc CFLAGS=-DUSE_SYSV_SIGNAL_SEMANTICS=0

In return I ask: why?
There is no particular performance reason to optimise this.
So in order to keep the code simpler, it might make an extra unneeded
systemcall on some systems when the signal is processed.  I don't think
it's worth our while to optimise this further.
-- 
Sincerely,
           Stephen R. van den Berg.

"And now for something *completely* different!"
