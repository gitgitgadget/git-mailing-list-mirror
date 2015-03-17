From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [GSoC] Applying for conversion scripts to builtins
Date: Tue, 17 Mar 2015 12:56:15 +0100
Organization: gmx
Message-ID: <4355599932558291b22313f244eda9bd@www.dscho.org>
References: <CAHLaBNJkL1CUJEk=cH=CLcDvZtoAr+PiCo2KHjfMLUKsugtRPA@mail.gmail.com>
 <CACRoPnQDopKNW2oc=UiLhupBBSh5ZmUHR7hU5aeguD4OVd1uPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Yurii Shevtsov <ungetch@gmail.com>, Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 12:56:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXq76-0004M8-5V
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 12:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbbCQL4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 07:56:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:57929 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753586AbbCQL4S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 07:56:18 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Ls8Qd-1ZXP8p0wCV-013tOR; Tue, 17 Mar 2015 12:56:16
 +0100
In-Reply-To: <CACRoPnQDopKNW2oc=UiLhupBBSh5ZmUHR7hU5aeguD4OVd1uPQ@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:5b6665GQYK7YrkvxAPaNnOMXFQP9QZ8DaeT1NLBBtAJCFt/t/dE
 XkQrDL9ck5vjsUPY8WHueuNnEB+zcLe893E9QZO1Bb2es7yS4XvEu8lPYpSntclSR+m/Hqe
 xYOUvMsTeiBFW/4JvehYU/XN0YEZD1xElaQpLMUVAKARJvTrhMkHMOmxUXw6fitUqnHR6WC
 iChR66va9u4a7GMhoZnfQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265626>

Hi Paul,

On 2015-03-17 01:22, Paul Tan wrote:

> On Tue, Mar 17, 2015 at 12:49 AM, Yurii Shevtsov <ungetch@gmail.com> wrote:
>
> Generally, it would be easy to convert any shell script to C by just
> using the run_command* functions (and in less lines of code), but that
> would not be taking advantage of the potential benefits in porting
> shell scripts to C. To summarize the (ideal) requirements:
> 
> * zero spawning of processes so that the internal object/config/index
> cache can be taken advantage of. (and to avoid the process spawning
> overhead which is relative large in e.g. Windows)

Spawning definitely uses up many more resources on Windows.

However, spawning a full-fledged Bash requires MSys (or soon MSys2) to spin up an entire POSIX emulation layer. This costs us dearly. For example, when I run the t3404 test (which exercises scripting heavily, what with `git rebase -i` being implemented as a shell script) on MacOSX, it takes roughly a minute to complete. On a comparable Windows machine, it takes roughly 12 minutes to complete.

Therefore, I would wager a bet that just the mere conversion of a shell script into even a primitive `run_command()`-based builtin would help performance on Windows in a noticeable manner.

Of course, it would be *even nicer* to avoid the spawning altogether.

> * avoid needless parsing since we have direct access to the C data
> structures.

True that. Turning SHA-1s into strings, spawning, and reparsing the same SHA-1 is quite a lot of unnecessary churn.

The biggest benefit of avoiding needless parsing, however, is not performance. It is avoiding quoting issues. This is particularly so on Windows, where Git is sometimes called from outside a shell environment, where we have to deal with inconsistent quoting because it is every Windows program's own job to parse the command-line, including the quoting.

> * use the internal API as much as possible: share code between the
> builtins (e.g. fmt-merge-msg.c, exposed in fmt-merge-msg.h) in order
> to reduce code complexity.

That is definitely something that even the Git maintainer should be interested in (he does not touch Windows, therefore the performance differences do not concern him): by sharing code paths between different subcommands, you ensure that you have to fix problems only once, not twice or more.

Concrete example: on Windows, we have file locking issues because files that are in use cannot be deleted. For that reason, we have Windows-specific code that is "nice" by trying harder to delete files, giving programs a little time to let their locks go. This locking issue happens also when a virus scanner "uses", say, the .git-rewrite/revs file that was written by `git filter-branch`, while said shell script already wants to delete the file because it is obsolete. If `git filter-branch` were a builtin, the bug would already be fixed due to our override of the `unlink()` function in C. Now we have to fix that bug separately because `filter-branch` is a shell script.

> The biggest wins would definitely be portability, but there may be
> performance improvements, though they are theoretical at this point.
> 
> I'm not exactly sure if the above requirements are sane, which is why
> I'm also CC-ing Dscho who knows the problems of git on Windows more
> than I do.

Thanks for bringing this to my attention. I hope I managed to add useful information to the discussion.

Ciao,
Johannes
