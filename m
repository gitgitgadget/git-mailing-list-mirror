From: Jeff King <peff@peff.net>
Subject: Re: t5800-*.sh: Intermittent test failures
Date: Thu, 8 Sep 2011 14:20:55 -0400
Message-ID: <20110908182055.GA16500@sigill.intra.peff.net>
References: <4E417CB4.50007@ramsay1.demon.co.uk>
 <CAGdFq_jv_T-x7VGqm_j-fDfeW6TsBG95=1TWn91Yk9B3TGZdsQ@mail.gmail.com>
 <7vpqjgyvn1.fsf@alter.siamese.dyndns.org>
 <4E68FE73.4000005@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Sep 09 01:47:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1oJv-0000Jf-74
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 01:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246Ab1IHXrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 19:47:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56675
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837Ab1IHXrl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 19:47:41 -0400
Received: (qmail 16008 invoked by uid 107); 8 Sep 2011 18:21:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Sep 2011 14:21:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2011 14:20:55 -0400
Content-Disposition: inline
In-Reply-To: <4E68FE73.4000005@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181007>

On Thu, Sep 08, 2011 at 06:42:11PM +0100, Ramsay Jones wrote:

> When I run the tests with "make test >test-out", I see a failure rate of about
> 1 in 10. If I then set the debug environment variables (GIT_TRANSPORT_HELPER_DEBUG,
> GIT_TRANSLOOP_DEBUG and GIT_DEBUG_TESTGIT) and run the test script directly (-v),
> then the failure rate goes up to about 1 in 3.

Hmm. I can't reproduce a failure here, but I do get some weirdness. My
recipe is:

-- >8 --
cat >foo.sh <<\EOF
#!/bin/sh

exec >$1.out 2>&1

n=0
while test $n -lt 100; do
	n=$(($n+1))
	GIT_TRANSPORT_HELPER_DEBUG=1 \
	GIT_TRANSLOOP_DEBUG=1 \
	GIT_DEBUG_TESTGIT=1 \
	./t5800-remote-helpers.sh --root=/run/shm/git-tests-$1 -v || {
		echo FAIL $n
		exit 1
	}
	echo OK $n
done
EOF

# try to keep an 8-core machine busy
for i in `seq 1 16`; do
  sh foo.sh $i &
done
-- 8< --

I never see a test failure, but a few of the 16 end up hanging. The
process tree for the hanged tests look like:

  t5800-remote-helper
    git push
      git-remote-testgit
        git fast-import
          git-fast-import

All of them are blocked on wait(), except for the final fast-import,
which is blocked trying to read() from stdin.

-Peff
