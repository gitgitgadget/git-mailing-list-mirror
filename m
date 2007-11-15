From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to change a submodue as a subdirectory?
Date: Thu, 15 Nov 2007 13:28:55 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711151322590.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <46dff0320711140637s51e1368fv3f632b6f04d093d5@mail.gmail.com> 
 <20071114202651.GC3973@steel.home>  <46dff0320711142136r2c70d698vd380c02188f95507@mail.gmail.com>
  <Pine.LNX.4.64.0711150614380.4362@racer.site>
 <46dff0320711150014x4a35975eqc53ef1fce7d40b18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 13:29:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsdqM-0001PL-Ck
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 13:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756683AbXKOM26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 07:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756416AbXKOM26
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 07:28:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:56077 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755526AbXKOM25 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 07:28:57 -0500
Received: (qmail invoked by alias); 15 Nov 2007 12:28:55 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp024) with SMTP; 15 Nov 2007 13:28:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX188NSMDUmI80UiW+ePhOyO+kmFbbcuaYGFMdNWPQm
	ZEXTBq1LdlY5xQ
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <46dff0320711150014x4a35975eqc53ef1fce7d40b18@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65113>

Hi,

On Thu, 15 Nov 2007, Ping Yin wrote:

> On Nov 15, 2007 2:16 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Provided you do not kill the repository of the submodule (you have some
> > public repo for that, right?) you will not lose anything, since the
> > history of the superproject has pointers to the submodule.
> >
> > But I guess that you want something different... You probably want to
> > rewrite history as if the submodule had not been a submodule at all,
> > right?
>
> Yeah, this actually what i want. Now i find a way:

If this works for you, I am all the more happy for you.  I thought that 
you wanted to be able to go to a certain revision and get the same working 
directory/directories.  (But that is not what you get...)

> 1. move submodule subB outside
>     mv subB /newpath/to/subB
>     git-commit subB

Strictly speaking, you do not have to move it outside.

> 2. git-filter-branch to rename all files in subA repository to subB
> directory (say subB/subB).
> 
>        cd newpath/to/subB &&
>        git filter-branch --index-filter \
>                'git ls-files -s | sed "s-\t-&subB/-" |
>                        GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
>                                git update-index --index-info &&
>                 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD

No need to play games with GIT_INDEX_FILE, as far as I can tell.

> 3. in directory of super project superA, git-fetch repository subB to
> branch subB
>    cd path/to/superA && git-fetch /newpath/to/subB master:subB

If you plan to do away with subB, you do not need to specify it... Just 
use FETCH_HEAD, directly after the fetch.

> 4. git-cherry-pick each commit  (except the root commit) of branch
> subB to the super project superA
>     git-cherry HEAD subB | awk '{print $2}' | sed -n '2,$ p' | while
> read name; do git cherry-pick $name; done

The git-cherry call is not really necessary, right?  The two repos have no 
common history (not even common patches).

Besides, I think that what you did is just a complicated way of doing a 
rebase.

But be aware that checking out older versions of the superproject will 
still have the submodule!

Ciao,
Dscho
