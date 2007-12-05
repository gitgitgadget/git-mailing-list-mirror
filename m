From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsserver runs hooks/post-update
Date: Wed, 05 Dec 2007 03:18:26 -0800
Message-ID: <7vtzmxs83h.fsf@gitster.siamese.dyndns.org>
References: <7v63zdtnjz.fsf@gitster.siamese.dyndns.org>
	<7245A47D-143F-4DC7-8414-D8C99C0ED9C3@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Dec 05 12:18:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzsHF-0006cm-P9
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 12:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbXLELSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 06:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751963AbXLELSd
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 06:18:33 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:41312 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbXLELSc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 06:18:32 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 644102EF;
	Wed,  5 Dec 2007 06:18:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E77B09C38D;
	Wed,  5 Dec 2007 06:18:50 -0500 (EST)
In-Reply-To: <7245A47D-143F-4DC7-8414-D8C99C0ED9C3@mit.edu> (Michael Witten's
	message of "Wed, 5 Dec 2007 06:07:29 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67145>

Michael Witten <mfwitten@MIT.EDU> writes:

> 	### Emulate git-receive-pack by running hooks/post-receive
> 	my $hook = $ENV{GIT_DIR}.'hooks/post-receive';
> 	if( -x $hook ) {
> 		open(my $pipe, "| $hook") || die "can't fork $!";
>
> 		local $SIG{PIPE} = sub { die 'pipe broke' };
>
> 		print $pipe "$parenthash $commithash refs/heads/$state->{module}\n";
>
> 		close $pipe || die "bad pipe: $! $?";
> 	}
>
>> Unfortunately, it turns out that open() with a pipe essentially
>> invokes system(); the solution is to fork a child process and
>> then to turn the child into the process with which communication
>> is desired via a call to exec().
>>
>> Because the rest of git-cvsserver.perl uses explicit system()
>> calls, I have been wondering if I am being overly cautious.
>
> Am I being overly cautious?

I do not think you are.  open($fh, "| $hook") can be confused with any
IFS in $hook (there is no problem with 'hooks/post-receive', but
$ENV{GIT_DIR} part can have pretty much anything other than NUL), so if
anything, you are not being careful enough.  Other parts of cvsserver
seem to be more careful by doing open($fh, '-|', @cmd), which does not
have this problem.

The execution environment of post-receive is probably wrong; I think
receive-pack runs the hooks with their $CWD = $GIT_DIR.
