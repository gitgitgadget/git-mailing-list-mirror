From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Problem with CRLF line endings and colored diff
Date: Tue, 14 Oct 2008 23:13:59 +0200
Message-ID: <48F50B97.9090106@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 14 23:15:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KprEy-0002aX-6D
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 23:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314AbYJNVOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 17:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754747AbYJNVOE
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 17:14:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:48992 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754304AbYJNVOC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 17:14:02 -0400
Received: (qmail invoked by alias); 14 Oct 2008 21:14:00 -0000
Received: from 174-52.79-83.cust.bluewin.ch (EHLO [192.168.123.204]) [83.79.52.174]
  by mail.gmx.net (mp048) with SMTP; 14 Oct 2008 23:14:00 +0200
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX18AHu4WV/oA2nkSklM7Dz5S0ZIenleiWnQlKcgNa5
	PPtVkcLRAc3X92
User-Agent: Thunderbird 2.0.0.17 (X11/20080928)
X-Enigmail-Version: 0.95.7
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98212>

Hello list!

I'm using CRLF line endings on the files of a project and I'm
running into odd output from 'git diff'.  Here are the steps to
reproduce:

    git init
    echo -e 'line1\r' > file
    git add file
    echo -e 'line2\r' > file
    PAGER='less -R' git diff --color

The output looks like this:

    diff --git a/file b/file
    index 495181c..a1413a4 100644
    --- a/file
    +++ b/file
    @@ -1 +1 @@
    -line1
    +line2^M

Note the trailing ^M on the '+' line.  After examining that line
it seems it's a bug in git, as that line really looks like this
(<...> denoting ANSI sequences or CR/LF):

    <GREEN FOREGROUND>+<RESET><GREEN FOREGROUND>
    line2<RESET><RED BACKGROUND><CR><RESET><LF>

The CR and the LF are not after each other, there's an ANSI
sequence in between (because the CR is being highlighted as white
space).  That confuses 'less'.  The '-' line above does not do
that and thus doesn't have this problem.  It also doesn't reset
the color between the '-' and the line:

    <RED FOREGROUND>-line1<RESET><CR><LF>

I tried poking around the code, but the diff machinery is more
complex than could be quickly grasped, so I'll let someone that
knows it already have a look.

Using git 1.6.0.2, but have the same problem with HEAD.

jlh
