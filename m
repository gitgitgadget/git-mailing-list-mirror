From: Jeff King <peff@peff.net>
Subject: Re: obscure platform autobuilders
Date: Wed, 1 Oct 2008 11:37:03 -0400
Message-ID: <20081001153703.GC4962@coredump.intra.peff.net>
References: <20080924154632.GR3669@spearce.org> <e2b179460809260624n4b329345q3610069af5af75c2@mail.gmail.com> <20080926225423.GA25502@coredump.intra.peff.net> <e2b179460809290051q8ca76a4k7cf0af2748a5f0fc@mail.gmail.com> <20081001071653.GA21174@sigill.intra.peff.net> <e2b179460810010346j23617764i8134c1f24b2746f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 17:38:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl3mh-0005tU-5X
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 17:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbYJAPhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 11:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbYJAPhH
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 11:37:07 -0400
Received: from peff.net ([208.65.91.99]:2512 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbYJAPhF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 11:37:05 -0400
Received: (qmail 19487 invoked by uid 111); 1 Oct 2008 15:37:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 01 Oct 2008 11:37:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Oct 2008 11:37:03 -0400
Content-Disposition: inline
In-Reply-To: <e2b179460810010346j23617764i8134c1f24b2746f0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97239>

On Wed, Oct 01, 2008 at 11:46:43AM +0100, Mike Ralphson wrote:

> My googling led me to think that INTERNAL_QSORT would be a good idea
> on at least some versions of Solaris... it may depend on the fs
> though.

I thought it was purely a performance enhancement. Should it affect the
test results?

> How about this - let me know if ok, and I'll push it.

It mostly looks good, though I would have split it into several distinct
commits for readability. A few comments below.

> -  - 'branches', a list of branches, one per line, to build and test
> +  - 'branches', a list of branches, one per line, to build and test.
> +    Lines starting with # are treated as comments

Makes sense.

>    - 'config.mak'; if this file exists, it will be used as the config.mak
> -    file for building git
> +    file for building git. If it is not present, but there is a
> +    config.mak file in your project directory, it is copied here to
> +    prevent it being removed by 'git clean'

I'm not sure I agree with this. My goal was to treat the project
directory as nothing more than a cache, with the gitbuild repo as the
master source driving the tests. So this works backwards to that.

One of the things I was (and am) considering is rather than doing
checkout/clean, to simply export each branch to a new directory and
build from there. Then the "project" repo could actually be bare.

How is this feature intended to be used? It looks like it would
basically be invoked one time, when running this script on an existing
gitbuild setup. So it saves one manual step of copying your config.mak
to the platform directory. But you still have to manually inspect, add,
and commit that config.mak file.

> +  - 'catch', a shell script sourced by the build script if an error
> +    occurs. It is passed the failing command-line in its arguments
> +
> +  - 'finally', a shell script sourced by the build script at the end
> +    of the process. It is passed the exit code of build.sh as its
> +    argument

These look like sensible hooks.

> +  - project; the path to the directory to build in. If not set, defaults
> +             to ./project relative to the starting directory
> +

I am accomplishing the same thing with a symlink, but I think this is
probably cleaner.

> +if ! test -d $project; then
> +  try mkdir $project
> +  try cd $project

Quotes around $project? I'm not sure how robust the rest of the script
is to paths with spaces (which I personally consider insane).

> -  for i in `cat "$root/branches"`; do
> +  for i in `cat "$root/branches" | grep -v '^#'`; do

Useless use of cat. :)

  grep -v ^# < "$root/branches"

-Peff
