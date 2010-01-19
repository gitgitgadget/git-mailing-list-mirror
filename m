From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bug: git-bundle create foo --stdin -> segfault
Date: Wed, 20 Jan 2010 00:52:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001192307090.3164@intel-tinevez-2-302>
References: <20100119002641.GA31434@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, 554682@bugs.debian.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 00:52:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXNsZ-0006qI-Gv
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 00:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017Ab0ASXwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 18:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756008Ab0ASXwz
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 18:52:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:47909 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755378Ab0ASXwy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 18:52:54 -0500
Received: (qmail invoked by alias); 19 Jan 2010 23:52:52 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp066) with SMTP; 20 Jan 2010 00:52:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/PoqEvwzbPXs4FxeN9OnJNkx2NnGB+1mA/4OPa+c
	CU1QLrmTvFrlRn
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20100119002641.GA31434@gnu.kitenet.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.60999999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137503>

Hi,

On Mon, 18 Jan 2010, Joey Hess wrote:

> joey@gnu:~/tmp/new>echo master | git bundle create ../my.bundle --stdin
> zsh: segmentation fault  git bundle create ../my.bundle --stdin

Current 'next' fails, too.

Some previous Git versions failed with a message like this:

error: unrecognized argument: --stdin'

Other previous Git versions failed at least with a message such as this:

fatal: exec rev-list failed.
error: rev-list died

Something similar happens to me when I run the initial official revision 
of git-bundle. The reason is that "git rev-list --boundary 
--pretty=oneline --stdin" refuses to run.

The bad versions either segfault, or "refuse to create empty bundles".

And while 8b3dce5 purports to clean things up (even acknowledging that 
support code for --stdin was removed from bundle.c!), at that 
time git-bundle was obviously not tested/fixed.

Now, I invested a lot of time into the new Git wiki, and into trying to 
bisect this (it took many, many more steps than the suggested 13, and 
somewhere in between, the number of commits to be tested even increased!).

If you want to fix it, I suggest requiring --stdin to be the only 
parameter after the bundle file name, and adding a function using 
strbuf_getline() to parse the stdin into a string_list.  Once that is 
done, you can substitute the argv for the rev-list call with that list 
(for that, you need to prepopulate with "rev-list", "--boundary" and 
"--pretty=oneline").  You can reuse that list for the call to 
setup_revisions().

Alternatively, you can try to implement the rev-list --boundary by hand 
(the --pretty=oneline is only needed to get a boundary marker IIRC), 
taking care to reset the commit flags that were set in the process.  (We 
need to know the boundary commits before actually starting to write the 
pack, because the bundle file format dictates that the boundary commits 
are listed as prerequsites in the bundle header.)

If you want to go that route (which is arguably more elegant anyway), I 
suggest having a look at the merge_bases() and get_merge_bases() functions 
in commit.c, which do something similar (i.e. a revwalk without using 
revision.c's functions -- because you cannot tell what flags they will use 
in the future, and they have to be reset after the walk).

Ciao,
Dscho
