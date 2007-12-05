From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH] git-cvsserver runs hooks/post-update
Date: Wed, 5 Dec 2007 06:07:29 -0500
Message-ID: <7245A47D-143F-4DC7-8414-D8C99C0ED9C3@mit.edu>
References: <7v63zdtnjz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 12:08:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izs73-0002jC-Rv
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 12:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbXLELIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 06:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbXLELIA
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 06:08:00 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:57402 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751095AbXLELH7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Dec 2007 06:07:59 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id lB5B7UIw019544;
	Wed, 5 Dec 2007 06:07:30 -0500 (EST)
Received: from [18.239.7.192] (MACGREGOR-SEVEN-O-THREE.MIT.EDU [18.239.7.192])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id lB5B7TrZ007353
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 5 Dec 2007 06:07:30 -0500 (EST)
In-Reply-To: <7v63zdtnjz.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67142>


On 5 Dec 2007, at 5:59:12 AM, Junio C Hamano wrote:

> +	### Then hooks/post-update
> +	$hook = $ENV{GIT_DIR}.'hooks/post-update';
> +	if (-x $hook) {
> +		system($hook, "refs/heads/$state->{module}");
> +	}
> +

Firstly, I apologize for not getting this small patch done myself;
it's very hectic this time of year.

Secondly, I'd like to recall my unanswered question:

> Also, I explicitly decided to pipe input into post-receive
> by hand rather than relying on a system() call that someone
> might exploit maliciously:

	### Emulate git-receive-pack by running hooks/post-receive
	my $hook = $ENV{GIT_DIR}.'hooks/post-receive';
	if( -x $hook ) {
		open(my $pipe, "| $hook") || die "can't fork $!";

		local $SIG{PIPE} = sub { die 'pipe broke' };

		print $pipe "$parenthash $commithash refs/heads/$state->{module}\n";

		close $pipe || die "bad pipe: $! $?";
	}

> Unfortunately, it turns out that open() with a pipe essentially
> invokes system(); the solution is to fork a child process and
> then to turn the child into the process with which communication
> is desired via a call to exec().
>
> Because the rest of git-cvsserver.perl uses explicit system()
> calls, I have been wondering if I am being overly cautious.

Am I being overly cautious?
