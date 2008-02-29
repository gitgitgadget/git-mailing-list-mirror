From: <Ken.Fuchs@bench.com>
Subject: RE: FW: git via http protocol _and_ a proxy using NTLM authentication -- git 1.5.4.2 & curl 7.18.0
Date: Fri, 29 Feb 2008 14:06:49 -0600
Message-ID: <AA28F077645B324881335614E4F7C428034C15@win-ex01.bench.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 29 21:07:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVBVy-0003bm-Ua
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 21:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758277AbYB2UGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 15:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760203AbYB2UGx
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 15:06:53 -0500
Received: from tx-smtp02.bench.com ([12.163.172.138]:19179 "EHLO
	tx-smtp02.bench.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758277AbYB2UGw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Feb 2008 15:06:52 -0500
Received: from unknown (HELO smtp.corp.bench.com) ([167.67.199.66])
  by tx-smtp02.bench.com with ESMTP; 29 Feb 2008 14:05:37 -0600
Received: from win-ex01.bench.com ([167.67.1.16]) by smtp.corp.bench.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 Feb 2008 14:06:50 -0600
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: git via http protocol _and_ a proxy using NTLM authentication -- git 1.5.4.2 & curl 7.18.0
Thread-Index: Ach6bn+Z+pXwNUyeRfCo2xRn+2lgZAAi1D7g
X-OriginalArrivalTime: 29 Feb 2008 20:06:50.0496 (UTC) FILETIME=[9EDAD800:01C87B0E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75557>

> On Thu, 28 Feb 2008, Ken.Fuchs@bench.com wrote:
> 
> > Unfortunately, this will not work because "git clone" is
> > implemented by git-clone.sh and has no support for dealing
> > with proxies at all.
> 
> I fail to see why git-clone.sh, which uses git http-fetch 
> directly, should behave differently from git fetch, which
> uses git http-fetch directly.

Sorry, I wasn't very clear.  When I said "git fetch" works, I meant
only the proxy is initiated properly.  "git fetch" itself still fails:

fatal: Couldn't find remote ref HEAD 

As I understand it, this is due to "git clone" failing earlier.

> I strongly suspect that you did not even try what I suggested.

I know you were trying to help.  I sincerely regret not thanking
you in my earlier response to your suggestion.  However, I had
already tried your suggestion over a week ago (plus numerous
user-id:password variants of the http_proxy environment variable).
I also tried "git config http.proxy <proxy.domain>:<proxy-port>".
I did not try "git config remote.<name>.proxy" which had an issue
that was recently fixed via a patch submission a few days ago.

> > So it seems that git's http protocol via a proxy isn't completely 
> > supported.
> 
> If that should really be the case, well, Git is a programmers' tool,
so 
> you should be perfectly able to find out what is happening _exactly_.

Well, all git http proxy stuff is handled by curl, so GIT_CURL_VERBOSE=1
should get us pretty close to "what is happening _exactly_":

$ GIT_CURL_VERBOSE=1 git clone http://www.kernel.org/pub/scm/git/git.git
Initialized empty Git repository in /mnt/nfs/git/test-git/git/.git/
Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?
$

No verbose output from curl?  How could that happen?  Maybe
GIT_CURL_VERBOSE=1 isn't logging all curl (especially proxy) actions?

So, let's try tcpdump to see what's happening on the wire.  In another
shell (logged in as root), we start:
"tcpdump -i eth0 | grep <proxy.domain>"

We should at least see DNS lookup requests in the tcpdump for the
<proxy.domain> if curl is using the proxy.

We repeat the above "git clone" command and find that absolutely no
proxy related traffic has been sent via eth0.  (The above tcpdump
pipe to grep generated no output whatsoever.)

On the other hand, I know that "git fetch" does properly interact with
the proxy, so as a benchmark, we repeat the tcpdump experiment with
"git fetch".  Now "tcpdump -i eth0 | grep <proxy.domain>" generates
plenty of output, consisting of DNS requests/responses for
<proxy.domain> and many packets between the git client and the proxy.

Also, the command

$ GIT_CURL_VERBOSE=1 git fetch http://www.kernel.org/pub/scm/git/git.git

generates plenty of curl logging information (indicating successful
proxy actions).  Since Bogofilter thinks this type of output is SPAM,
I won't try to include it all, but just the last 2 lines:

* Connection #0 to host <proxy.domain> left intact
fatal: Couldn't find remote ref HEAD

Again, as I understand it, "git fetch" (which is proxy aware) is
failing not due to proxy issues, but due to missing git filesystem
structure that "git clone" (which is not proxy aware) needed to provide.
If the necessary git filesystem structure existed in the local git
repository, the "git fetch" command would probably succeed via http
proxy.

Before closing, I'll note that http.c was patched slightly to allow
NTLM authentication via an http proxy server.  The informal patches
can be found earlier in this thread; they are clearly a
work-in-progress.
For example, proper user interface mechanisms (via "git config") still
need to be developed/incorporated.

Sincerely,

Ken Fuchs
