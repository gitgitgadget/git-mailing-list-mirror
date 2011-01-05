From: Jeff King <peff@peff.net>
Subject: Re: False positives in git diff-index
Date: Wed, 5 Jan 2011 00:48:26 -0500
Message-ID: <20110105054825.GC5884@sigill.intra.peff.net>
References: <AANLkTimLW+J_rmRsqUQJO-9Gzn7aK0ZHkd1-s=Wg4Vbi@mail.gmail.com>
 <AANLkTinDSCPz-oukxzn24hj94d9WpzZ8_64TBHeNTmoG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 06:48:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaMEh-0004Tm-KY
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 06:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251Ab1AEFse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 00:48:34 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44768 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948Ab1AEFse (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 00:48:34 -0500
Received: (qmail 29319 invoked by uid 111); 5 Jan 2011 05:48:31 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 05 Jan 2011 05:48:31 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jan 2011 00:48:26 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinDSCPz-oukxzn24hj94d9WpzZ8_64TBHeNTmoG@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164547>

On Tue, Jan 04, 2011 at 12:45:33PM +0300, Alexander Gladysh wrote:

> > Anyway, I'm ready to debug this issue if someone will guide me.
> >
> > Workflow:
> >
> > <...change files in /path/dir1/...>
> > (cd /path && git add </path/dir1/>)
> > (cd /path && git commit -m <message1>)
> >
> > ... repeat change-add-commit several times for various directories
> > (can be the same directory or not) ...
> >
> > <...generate file /path/dirN/foo...>
> > # Accidentally the file is generated the same as it was
> >
> > (cd /path && git add </path/dirN/>)
> > (cd /path && git status) # Refresh index
> > (cd /path && git diff-index --exit-code --quiet HEAD -- /path/dirN) #
> > Incorrectly reports that there are some changes
> > (cd /path && git commit -m <messageN>) # fails, saying that there is
> > nothing to commit
> >
> > If I insert sleep 10 between git status and git diff-index, the
> > problem goes away.

If adding a sleep makes it work, that sounds like a race condition in
git. But from the description of your workflow, it should be easy to
make a minimal example:

-- >8 --
#!/bin/sh

random() {
  perl -e 'print int(rand(5))+1, "\n"'
}

rm -rf repo
mkdir repo && cd repo && git init

for i in 1 2 3 4 5; do
  mkdir dir$i
  echo initial >dir$i/file
done
git add .
git commit -m initial

while true; do
  for i in 1 2 3 4 5; do
    random >dir$i/file
    git add dir$i
    git update-index --refresh
    if ! git diff-index --exit-code --quiet HEAD -- dir$i; then
      if ! git commit -m foo; then
        echo breakage
        exit 1
      fi
    else
      echo not bothering to commit
    fi
  done
done
-- 8< --

Basically, we generate random data which has a 20% chance of
being the same as what's there. When it is, we should get "not bothering
to commit", but in your error case, we would try to commit (and get "no
changes").

But using that script, I can't replicate your problem. Can you try
running it on the same box you're having trouble with? That might at
least tell us if it's your environment or something more complex going
on.

-Peff
