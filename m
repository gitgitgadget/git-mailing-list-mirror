From: Jeff King <peff@peff.net>
Subject: Re: 1.7.2 cycle will open soon
Date: Thu, 6 May 2010 02:54:19 -0400
Message-ID: <20100506065419.GA21009@coredump.intra.peff.net>
References: <7vaaselxe8.fsf@alter.siamese.dyndns.org>
 <20100506055236.GA16151@coredump.intra.peff.net>
 <20100506064428.GA29360@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 06 08:54:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9uyo-0007eC-72
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 08:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936Ab0EFGya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 02:54:30 -0400
Received: from peff.net ([208.65.91.99]:60120 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059Ab0EFGy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 02:54:29 -0400
Received: (qmail 3144 invoked by uid 107); 6 May 2010 06:54:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 06 May 2010 02:54:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 May 2010 02:54:19 -0400
Content-Disposition: inline
In-Reply-To: <20100506064428.GA29360@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146448>

On Thu, May 06, 2010 at 01:44:28AM -0500, Jonathan Nieder wrote:

> > Am I missing something?
> 
> If cleanup fails, I want to catch it.  Would something like this do?

Ah, I see.

>  test_run_ () {
> 	test_cleanup=:
> 	eval >&3 2>&4 "$1"
> 	eval_ret=$?
> 	eval >&3 2>&4 "$test_cleanup" && (exit "$eval_ret")
> 	eval_ret=$?
> 	return 0
>  }
> 
>  test_when_finished () {
> 	test_cleanup="$* && $test_cleanup"
>  }

Doesn't that violate your rule that the cleanup will _always_ be run?
Here, if the first cleanup fails, we don't run subsequent ones.

Perhaps the simplest would be to just keep a cleanup_ret in the second
eval (where you have eval_ret in the original patch), and then act
appropriately after the eval finishes. That would be easier on the eyes,
too, I think.

> To permit a line break at the end of a cleanup command, one can do
> 
>  test_when_finished () {
> 	test_cleanup="{ $*
> 		} && $test_cleanup"
>  }
> 
> but that might not be worth the ugliness.

I doubt anyone will put a linebreak in, but it is probably better to be
defensive, and the ugliness is at least contained only in that function.

-Peff
