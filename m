From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: t5800-*.sh: Intermittent test failures
Date: Sun, 11 Sep 2011 20:14:36 +0100
Message-ID: <4E6D089C.4090006@ramsay1.demon.co.uk>
References: <4E417CB4.50007@ramsay1.demon.co.uk> <CAGdFq_jv_T-x7VGqm_j-fDfeW6TsBG95=1TWn91Yk9B3TGZdsQ@mail.gmail.com> <7vpqjgyvn1.fsf@alter.siamese.dyndns.org> <4E68FE73.4000005@ramsay1.demon.co.uk> <20110908182055.GA16500@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 11 21:42:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2pvd-0004aj-Vg
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 21:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760361Ab1IKTmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 15:42:49 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:36245 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754862Ab1IKTms (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2011 15:42:48 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1R2pvB-0003QU-fY; Sun, 11 Sep 2011 19:42:47 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20110908182055.GA16500@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181182>

Jeff King wrote:
> On Thu, Sep 08, 2011 at 06:42:11PM +0100, Ramsay Jones wrote:
> 
>> When I run the tests with "make test >test-out", I see a failure rate of about
>> 1 in 10. If I then set the debug environment variables (GIT_TRANSPORT_HELPER_DEBUG,
>> GIT_TRANSLOOP_DEBUG and GIT_DEBUG_TESTGIT) and run the test script directly (-v),
>> then the failure rate goes up to about 1 in 3.
> 
> Hmm. I can't reproduce a failure here, but I do get some weirdness. My
> recipe is:

Ah, sorry, ... I didn't make myself clear then, because ...

> -- >8 --
> cat >foo.sh <<\EOF
> #!/bin/sh
> 
> exec >$1.out 2>&1
> 
> n=0
> while test $n -lt 100; do
> 	n=$(($n+1))
> 	GIT_TRANSPORT_HELPER_DEBUG=1 \
> 	GIT_TRANSLOOP_DEBUG=1 \
> 	GIT_DEBUG_TESTGIT=1 \
> 	./t5800-remote-helpers.sh --root=/run/shm/git-tests-$1 -v || {
> 		echo FAIL $n
> 		exit 1
> 	}
> 	echo OK $n
> done
> EOF
> 
> # try to keep an 8-core machine busy
> for i in `seq 1 16`; do
>   sh foo.sh $i &
> done
> -- 8< --
> 
> I never see a test failure, but a few of the 16 end up hanging. The
> process tree for the hanged tests look like:
> 
>   t5800-remote-helper
>     git push
>       git-remote-testgit
>         git fast-import
>           git-fast-import
> 
> All of them are blocked on wait(), except for the final fast-import,
> which is blocked trying to read() from stdin.

... these hangs *are* the failures of which I speak!  Yes, the script
doesn't get to declare a failure, but AFAIAC a hanging test (and it
isn't the same test # each time) is a failing test. :-D

ATB,
Ramsay Jones
