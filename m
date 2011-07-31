From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 4/4] git-p4: commit time should be most recent p4 change
 time
Date: Sun, 31 Jul 2011 11:14:55 +0100
Message-ID: <4E352B1F.4070402@diamand.org>
References: <20110731003557.GA4867@arf.padd.com> <20110731003953.GE4867@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 12:15:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnT3A-0004jM-Hk
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 12:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064Ab1GaKPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 06:15:00 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45125 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab1GaKO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 06:14:58 -0400
Received: by wyg8 with SMTP id 8so997080wyg.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 03:14:57 -0700 (PDT)
Received: by 10.227.202.14 with SMTP id fc14mr4772341wbb.83.1312107297571;
        Sun, 31 Jul 2011 03:14:57 -0700 (PDT)
Received: from [86.30.143.167] (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id eo18sm3239192wbb.29.2011.07.31.03.14.56
        (version=SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 03:14:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110402 Iceowl/1.0b2 Icedove/3.1.9
In-Reply-To: <20110731003953.GE4867@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178235>

On 31/07/11 01:39, Pete Wyckoff wrote:
> When importing a repo, the time on the initial commit had been
> just "now".  But this causes problems when trying to share among
> git-p4 repos that were created identically, although at different
> times.  Instead, use the time in the top-most p4 change as the
> time for the git import commit.

Ack.


>
> Signed-off-by: Pete Wyckoff<pw@padd.com>
> ---
>   contrib/fast-import/git-p4 |   15 ++++++++++++++-
>   t/t9800-git-p4.sh          |   14 ++++++++++++++
>   2 files changed, 28 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 98d2aee..6b9de9e 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -1649,7 +1649,8 @@ class P4Sync(Command, P4UserMap):
>       def importHeadRevision(self, revision):
>           print "Doing initial import of %s from revision %s into %s" % (' '.join(self.depotPaths), revision, self.branch)
>
> -        details = { "user" : "git perforce import user", "time" : int(time.time()) }
> +        details = {}
> +        details["user"] = "git perforce import user"
>           details["desc"] = ("Initial import of %s from the state at revision %s\n"
>                              % (' '.join(self.depotPaths), revision))
>           details["change"] = revision
> @@ -1689,6 +1690,18 @@ class P4Sync(Command, P4UserMap):
>               fileCnt = fileCnt + 1
>
>           details["change"] = newestRevision
> +
> +        # Use time from top-most change so that all git-p4 clones of
> +        # the same p4 repo have the same commit SHA1s.
> +        res = p4CmdList("describe -s %d" % newestRevision)
> +        newestTime = None
> +        for r in res:
> +            if r.has_key('time'):
> +                newestTime = int(r['time'])
> +        if newestTime is None:
> +            die("\"describe -s\" on newest change %d did not give a time")
> +        details["time"] = newestTime
> +
>           self.updateOptionDict(details)
>           try:
>               self.commit(details, self.extractFilesFromCommit(details), self.branch, self.depotPaths)
> diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
> index 24a8b79..1b5f4b2 100755
> --- a/t/t9800-git-p4.sh
> +++ b/t/t9800-git-p4.sh
> @@ -265,6 +265,20 @@ test_expect_success 'not preserving user with mixed authorship' '
>   	p4_check_commit_author usernamefile3 alice
>   '
>
> +# Sleep a bit so that the top-most p4 change did not happen "now".  Then
> +# import the repo and make sure that the initial import has the same time
> +# as the top-most change.
> +test_expect_success 'initial import time from top change time' '
> +	p4change=$(p4 -G changes -m 1 //depot/... | marshal_dump change)&&
> +	p4time=$(p4 -G changes -m 1 //depot/... | marshal_dump time)&&
> +	sleep 3&&
> +	"$GITP4" clone --dest="$git" //depot&&
> +	test_when_finished cleanup_git&&
> +	cd "$git"&&
> +	gittime=$(git show -s --raw --pretty=format:%at HEAD)&&
> +	echo $p4time $gittime&&
> +	test $p4time = $gittime
> +'
>
>   test_expect_success 'shutdown' '
>   	pid=`pgrep -f p4d`&&
