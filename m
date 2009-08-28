From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: inotify-commit, was Re: git guidance
Date: Fri, 28 Aug 2009 14:30:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908281424100.7434@intel-tinevez-2-302>
References: <20071129105220.v40i22q4gw4cgoso@intranet.digizenstudio.com> <200712070737.18519.a1426z@gawab.com> <475906F7.5010309@op5.se> <200712071353.11654.a1426z@gawab.com> <20071207220025.GD2001@atjola.homenet>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1261885024-1251462647=:7434"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 28 14:34:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh0f7-0004TA-BB
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 14:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbZH1Mat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 08:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbZH1Mas
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 08:30:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:42056 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751123AbZH1Mar (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 08:30:47 -0400
Received: (qmail invoked by alias); 28 Aug 2009 12:30:47 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp054) with SMTP; 28 Aug 2009 14:30:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181Uel2gis18ZVf/BGeqJzck8OjzGs4v7oPEAIfrA
	untpgHJMdvovm1
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20071207220025.GD2001@atjola.homenet>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127293>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1261885024-1251462647=:7434
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

[long Cc: list culled, as they probably forgot about this thread]

On Fri, 7 Dec 2007, Björn Steinbrink wrote:

> That said, out of pure curiousness I came up with the attached script 
> which just uses inotifywait to watch a directory and issue git commands 
> on certain events. It is extremely stupid, but seems to work. And at 
> least it hasn't got the drawbacks of a real gitfs regarding the need to 
> have a "separate" non-versioned storage area for the working directory, 
> because it simply uses the existing working directory wherever that 
> might be stored. It doesn't use GIT_DIR/WORK_DIR yet, but hey, should be 
> easy to add...
> 
> Feel free to mess with that thing, hey, maybe you even like it and
> extend it to match your proposed workflow even more. I for sure won't
> use or even extend it, so you're likely on your own there.
> 
> Side-note: Writing that script probably took less time than writing this
> email and probably less time than was wasted on this topic. Makes me
> want to use today's preferred "Code talks, b...s... walks" statement,
> but I'll refrain from that... Just because I lack the credibility to say
> that, and the script attached is quite crappy ;-)

I could not agree more with the statement.

As it happens, I have a very delicate setup that we tested in a test 
environment as much as possible, but now we have to deploy it and I want 
to be able to rewind very quickly to a known-good state.

So I adjusted your script a little.  It now reads like this:

-- snip --
#!/bin/sh

# Originally by Bjoern Steinbrink, simplified by Johannes Schindelin

inotifywait -m -r --exclude ^\./\.git/.* \
        -e close_write -e move -e create -e delete . 2>/dev/null |
while read FILE_PATH EVENT FILE_NAME
do
        FILE_NAME="$FILE_PATH$FILE_NAME"
        FILE_NAME=${FILE_NAME#./}

        # git doesn't care about directories
        test -d "$FILE_NAME" && continue

        case "$EVENT" in
        *MOVED_TO*|*CREATE*)
                git add "$FILE_NAME"
                git commit -m "$FILE_NAME created"
                ;;
        *CLOSE_WRITE*|*MODIFY*)
                git add "$FILE_NAME"
                git commit -m "$FILE_NAME changed"
                ;;
        *DELETE*|*MOVED_FROM*)
                git rm --cached "$FILE_NAME"
                git commit -m "$FILE_NAME removed"
                ;;
        esac
done
-- snap --

Thanks for your original script!

Ciao,
Dscho

--8323329-1261885024-1251462647=:7434--
