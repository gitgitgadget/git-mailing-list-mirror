From: Andreas Ericsson <ae@op5.se>
Subject: Re: git performance
Date: Thu, 23 Oct 2008 09:41:21 +0200
Message-ID: <49002AA1.80203@op5.se>
References: <000801c93483$2fdad340$8f9079c0$@com> <20081022203624.GA4585@coredump.intra.peff.net> <000901c93490$e0c40ed0$a24c2c70$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Edward Ned Harvey <git@nedharvey.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 09:42:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsuqD-0006AW-S2
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 09:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbYJWHlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 03:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbYJWHlb
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 03:41:31 -0400
Received: from mail.op5.se ([193.201.96.20]:34707 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbYJWHlb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 03:41:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B17991B800A6;
	Thu, 23 Oct 2008 09:35:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.92
X-Spam-Level: 
X-Spam-Status: No, score=-3.92 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.479, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8XztbiYX8u2A; Thu, 23 Oct 2008 09:35:08 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 3F6021B800B0;
	Thu, 23 Oct 2008 09:35:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <000901c93490$e0c40ed0$a24c2c70$@com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98944>

Edward Ned Harvey wrote:
>> Yes, it does stat all the files. How many files are you talking
>> about, and what platform?  From a warm cache on Linux, the 23,000
>> files kernel repo takes about a tenth of a second to stat all files
>> for me (and this on a several year-old machine). And of course many
>> operations don't require stat'ing at all (like looking at logs, or
>> diffs that don't involve the working tree).
> 
> No worries.  No solution can meet everyone's needs.
> 
> I'm talking about 40-50,000 files, on multi-user production linux,

Umm... using git to track a production server? I think there's something
in your specific use-case that eluded pretty much everyone here the
first time you asked about it.

git was built to maintain the linux kernel with its patch-and-merge based
workflow, 117k commits and 25k files. It's *good* at that sort of thing,
but a lot of features are "source-code management" specific. It sounds to
me you're asking for something that will keep a backup of most of your
entire system (apart from /home), which it's not really suited for. For
instance, it doesn't keep track of mode-bits on files (apart from
"executable or not").

> which means the cache is never warm, except when I'm benchmarking.
> Specifically RHEL 4 with the files on NFS mount.  Cold cache "svn st"
> takes ~10 mins.  Warm cache 20-30 sec.  Surprisingly to me,
> performance was approx the same for files on local disk versus NFS.
> Probably the best solution for us is perforce, we just don't like the
> pricetag.
> 
> Out of curiosity, what are they talking about, when they say "git is
> fast?"

Merges, patch application, committing, history walking and data
transfers are all extremely quick operations under git.

Actually, history walking isn't extremely quick, but several neat
tricks are in place that make it *seem* quick. Running
"git log drivers/net/wireless" on the linux kernel with a cold
cache starts spitting out output after about 1 second on my measly
laptop (where the kernel has 117k commits on 25k files).

>  Just the fact that it's all local disk, or is there more to
> it than that?  I could see - git would probably outperform perforce
> for versioning of large files (let's say iso files) to benefit from
> sustained local disk IO, while perforce would probably outperform
> anything I can think of, operating on thousands of tiny files,
> because it will never walk the tree.
> 

Git doesn't *have* to walk the tree either. "git status" obviously
has to do that, since you're asking "what files have changed in this
tree since I last added stuff to the index", but you can use git just
fine without ever issuing "git status" (assuming you're the one
controlling the changes, that is).

"git rm" and "git add" won't walk the tree. They're just interested in
the paths you give them and won't touch anything else.

"git commit path1 path2" won't walk the tree. It has to walk the paths
(which can be entire subdirectories, or all of them), but not more than
that.

"git push" (ie, send your changes upstream) won't walk the tree. It'll
just look at the history and how they differ.

"git merge" (and therefore also "git pull") doesn't walk the tree. It
only makes sure paths that are touched by the merge are up-to-date.

Apart from that, it would be trivial to hack up some inotify config
and scripts that stages changes in a separate index-file and then
add a simple wrapper that operates on the separate index-file rather
than the "regular" one.

Sample "giti" wrapper:
--%<--%<--%<--
#!/bin/sh
# giti - inotify driven git wrapper
GIT_INDEX=.git/inotify-index
export GIT_INDEX
case "$@" in
	status)
		git diff --name-only --cached
		exit $?
		;;
esac

git "$@"
--%<--%<--%<--

Sample inotify script:
--%<--%<--%<--
#!/bin/sh
GIT_INDEX=.git/inotify-index git add $1
--%<--%<--%<--

Sample incrontab(5) entry:
--%<--%<--%<--
/watched/path IN_CLOSE_WRITE inotify.git $@/$#
--%<--%<--%<--

Totally untested ofcourse, so it probably needs tweaking. It should
work rather well though, assuming you're somewhat careful what
arguments you send to the "giti" wrapper and make sure to never
use any git-commands that *have* to walk the entire tree (such as
"git commit -a").

Let us know how it pans out.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
