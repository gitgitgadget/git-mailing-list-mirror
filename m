From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 18:07:31 -0400
Message-ID: <20120328220731.GC10795@sigill.intra.peff.net>
References: <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino>
 <7v1uocwpap.fsf@alter.siamese.dyndns.org>
 <20120328184014.GA8982@burratino>
 <20120328193909.GB29019@sigill.intra.peff.net>
 <20120328194516.GD8982@burratino>
 <20120328201851.GA29315@sigill.intra.peff.net>
 <20120328215704.GB10795@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 00:07:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD11n-0007RA-AR
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 00:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758740Ab2C1WHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 18:07:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36453
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753679Ab2C1WHd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 18:07:33 -0400
Received: (qmail 22781 invoked by uid 107); 28 Mar 2012 22:07:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Mar 2012 18:07:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2012 18:07:31 -0400
Content-Disposition: inline
In-Reply-To: <20120328215704.GB10795@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194208>

On Wed, Mar 28, 2012 at 05:57:04PM -0400, Jeff King wrote:

> +static int exists_in_PATH(const char *file)
> +{
> +	const char *p = getenv("PATH");
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	if (!p || !*p)
> +		return 0;

One thing to note: real execvp, when it sees a NULL $PATH, will fill in
some OS-dependent default path. My linux box has _PATH_DEFPATH, but I
don't know how portable that is (I can't find anything useful in POSIX).

> No tests yet. I'll post some output on that in a minute.

So here is a quick test script to show the output for a couple different
cases. Should this be a real test script? A lot of what is being tested
is the actual stderr output in many cases, which we tend to try not to
include in tests.

-- >8 --
#!/bin/sh

rm -rf bin .git

# bin/broken is a PATH directory that cannot be searched
# bin/ok can be searched, but has a broken entry
mkdir bin bin/broken bin/ok
chmod -x bin/broken

# The "yes" command lets us know when things are working.
cat >bin/ok/git-yes <<\EOF
#!/bin/sh
echo yes
EOF
chmod +x bin/ok/git-yes

# and the "no" command is broken, and should be reported as EACCES
 >bin/ok/git-no

git init -q
git config alias.alias-yes yes
git config alias.alias-no no

PATH=$PWD/bin/broken:$PWD/bin/ok:$PATH

set -x
git does-not-exist
git yes
git no
git alias-yes
git alias-no

-- >8 --

The output I get is:

# stock git
+ git does-not-exist
fatal: cannot exec 'git-does-not-exist': Permission denied
+ git yes
yes
+ git no
fatal: cannot exec 'git-no': Permission denied
+ git alias-yes
fatal: cannot exec 'git-alias-yes': Permission denied
+ git alias-no
fatal: cannot exec 'git-alias-no': Permission denied

# my earlier patches to do alias lookup after EACCES
+ git does-not-exist
Failed to run command 'does-not-exist': Permission denied
+ git yes
yes
+ git no
Failed to run command 'no': Permission denied
+ git alias-yes
yes
+ git alias-no
Expansion of alias 'alias-no' failed; 'no': Permission denied

# this patch
+ git does-not-exist
git: 'does-not-exist' is not a git command. See 'git --help'.
+ git yes
yes
+ git no
fatal: cannot exec 'git-no': Permission denied
+ git alias-yes
yes
+ git alias-no
fatal: cannot exec 'git-no': Permission denied

-Peff
