From: Ivan Todoroski <grnch_lists@gmx.net>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Sun, 18 Mar 2012 11:37:22 +0000 (UTC)
Message-ID: <loom.20120318T121808-344@post.gmane.org>
References: <loom.20120318T083216-96@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 12:38:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9ER3-00060g-FE
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 12:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920Ab2CRLhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 07:37:39 -0400
Received: from plane.gmane.org ([80.91.229.3]:58798 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754506Ab2CRLhi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 07:37:38 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S9EQY-0005et-KX
	for git@vger.kernel.org; Sun, 18 Mar 2012 12:37:34 +0100
Received: from 77.28.161.254 ([77.28.161.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Mar 2012 12:37:34 +0100
Received: from grnch_lists by 77.28.161.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Mar 2012 12:37:34 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 77.28.161.254 (Opera/9.80 (Windows NT 5.1; U; en) Presto/2.10.229 Version/11.62)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193379>

Ivan Todoroski <grnch_lists <at> gmx.net> writes:
> Now share this repo using the Smart HTTP transport (git-http-backend) and 
then 
> try cloning it in a different directory. This is what you would get:
> 
> $ git clone http://localhost/.../too-many-refs/.git
> Cloning into 'too-many-refs'...
> fatal: cannot exec 'fetch-pack': Argument list too long
> 
> [...]
> 
> The solution is conceptually simple: if the list of refs results in a too 
long 
> command line, split the refs in batches and call fetch-pack multiple times 
such 
> that each call is under the cmdline limit:
> 
> git fetch-pack --stateless-rpc --lock-pack ...<first batch of refs>...
> git fetch-pack --stateless-rpc --lock-pack ...<second batch of refs>...
> ...
> git fetch-pack --stateless-rpc --lock-pack ...<last batch of refs>...


BTW, I didn't want to sound like I am expecting or demanding a fix. If the 
experienced Git devs lack the time or inclination to work on this bug 
(understandable), I am certainly willing to try it myself. My C skills are a 
bit rusty and I'm not very familiar with the Git codebase, but I will do my 
best to follow Documentation/SubmittingPatches as well as the existing code 
structure.

I will need a few pointers to get me started in the right direction though...


1) Is splitting the cmdline in batches and executing fetch-pack multiple times 
the right approach? If you have another solution please suggest.


2) Should I add the test case for this bug to existing scripts like t/t5551-
http-fetch.sh and t/t5561-http-backend.sh, or should I create a new test script 
under t/ following their example? There will probably be only one test case for 
this bug, basically the script I pasted in the original email to reproduce it.


3) What would be the most portable way to get the cmdline length limit between 
POSIX and Windows? Would something like this be acceptable:

#ifder _WIN32
	int cmdline_limit = 32767;
#else
	int cmdline_limit = sysconf(_SC_ARG_MAX);
#endif

I couldn't actually find a Windows API to get the cmdline limit, but this blog 
post by one of the Windows people tells the value:

http://blogs.msdn.com/b/oldnewthing/archive/2003/12/10/56028.aspx


4) Should this problem be fixed only in remote-curl.c:fetch_git() or should it 
be solved more generally in run-command.c:start_command(), which is used by 
fetch_git() for the actual invocation?

If this is fixed only in remote-curl:fetch_git(), then the same logic would 
need to be open coded in any other such place that might be found. Are you 
aware of any other internal sub-commands that put all refs on the command line 
and could be susceptible to the same issue?


If it's fixed at a lower level in run-command.c:start_command(), the logic 
would become available to any other sub-command that needs it.

However, this would mean that struct child_process as well as struct rpc_state 
would need an additional field that would tell whether the command is safe to 
execute in multiple batches and how many of the arguments at the beginning of 
child_process.argv must be preserved on every invocation (the switches and 
such).

Something like child_process.split_after, which if non-zero would mean that 
start_command() is free to invoke the command multiple times when argv exceeds 
the cmdline limit, by grouping any arguments after argv[split_after] in smaller 
batches for each invocation.
