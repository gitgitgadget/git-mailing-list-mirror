From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: backup or mirror a repository
Date: Thu, 18 Oct 2007 09:32:26 +0400
Message-ID: <20071018053226.GA20588@dpotapov.dyndns.org>
References: <1190921742.2263.17.camel@Tenacity> <Pine.LNX.4.64.0709272255360.28395@racer.site> <1190940704.2263.32.camel@Tenacity> <Pine.LNX.4.64.0709280253150.28395@racer.site> <1190947063.2263.46.camel@Tenacity> <7vsl4zqp8l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Farina <drfarina@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 07:32:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiNzs-0004yG-5T
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 07:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbXJRFc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 01:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbXJRFc3
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 01:32:29 -0400
Received: from smtp05.mtu.ru ([62.5.255.52]:64755 "EHLO smtp05.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579AbXJRFc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 01:32:28 -0400
Received: from potapov.private (ppp85-141-239-26.pppoe.mtu-net.ru [85.141.239.26])
	by smtp05.mtu.ru (Postfix) with ESMTP id 44C2C99397D;
	Thu, 18 Oct 2007 09:32:26 +0400 (MSD)
Received: from dpotapov by potapov.private with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1IiNze-0005aY-2e; Thu, 18 Oct 2007 09:32:26 +0400
Content-Disposition: inline
In-Reply-To: <7vsl4zqp8l.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61480>

On Thu, Sep 27, 2007 at 11:27:06PM -0700, Junio C Hamano wrote:
> The "git remote add --mirror" setup is about setting up the
> local repository _AS_ the backup of the remote.  In other words,
> the contents come from the remote by fetching from it and safely
> kept away from disaster on the local side.  And for that,
> "remote prune" is a perfect thing to do.

I have tried to do that but I am getting a warning:
$ git remote prune origin
Warning: unrecognized mapping in remotes.origin.fetch: +refs/*:refs/*
and no branch is removed.

I suspect that the change that introduced --mirror option for the 'add'
command did not adjust the prune procedure to handle the new situation
properly. Or is just me doing something wrong?

Anyway, because the official released git still does not have --mirror
and it could be difficult to convince the admin to use the bleading edge
version of Git for secure backup, I wrote a simple script instead, which
provides the same functionality but using the released version of Git.
Maybe, someone else finds it useful.

$ cat git-mirror
#!/bin/sh

usage() {
	echo >&2 "Usage: $0 URL"
	exit 1
}

set -e

test $# -eq 1 || usage
URL="$1"

# Initialize Git bare directory
git --bare init

# Initialize the mirror
git remote add origin "$URL"
git fetch
rmdir refs/heads
ln -s remotes/origin refs/heads

# Adding creating a script that will be run by cron
cat <<EOF > git-mirror-sync
cd "$PWD"
git fetch
git remote prune origin
EOF
chmod +x git-mirror-sync

# Adding git-mirror-sync to cron
echo "Please, add $PWD/git-mirror-sync to cron"

#########################################################

Dmitry
