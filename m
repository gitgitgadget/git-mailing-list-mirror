From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] git-bundle: assorted fixes
Date: Thu, 22 Feb 2007 20:36:07 -0500
Message-ID: <45DE4507.7090206@verizon.net>
References: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702221913250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net, Nicolas Pitre <nico@cam.org>,
	Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 23 02:36:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKPMV-0004hE-TQ
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 02:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1749667AbXBWBg3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 20:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750696AbXBWBg3
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 20:36:29 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:39563 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667AbXBWBg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 20:36:28 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDW00GHA74488H4@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 22 Feb 2007 19:36:05 -0600 (CST)
In-reply-to: <Pine.LNX.4.63.0702221913250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40406>

Johannes Schindelin wrote:

I built this under cygwin, it is running but I find two regressions 
compared to my git-bundle.sh:

1) git bundle create --all  <whatever> does not record any references, 
while it should record all references (heads and tags). From shell, this 
requires use of both git-rev-parse and git-show-ref:
    gitrevargs=$(git-rev-parse --symbolic --revs-only $args) || exit 1

    # find the refs to carry along and get sha1s for each.
    refs=
    fullrevargs=
    for arg in $gitrevargs ; do
        #ignore options and basis refs, get full ref name for things
        # we will transport rejecting anything ambiguous (e.g., user
        # gives master, have heads/master and remotes/origin/master, we
        # keep the former).
        case "$arg" in
            -* | ^*) fullrevargs="$fullrevargs $arg";;
            *)  ref=$(git-show-ref "$arg")
                test "$(echo $ref | wc -w)" = "2" || die "Ambigous 
reference: $arg
$ref"
                fullrevargs="$fullrevargs ${ref#* }"
                refs="$refs $ref";;
        esac
    done

2) git bundle verify  reports only a single sha1 if prerequisites are 
not met. git-bundle.sh would loop through finding each missing one, 
annotating with the one line commit message. The prerequisites were 
stored using:

    (for p in $prereqs ; do
        git-rev-list --pretty=one --max-count=1 $p
    done) > "$prerequisites"

and then verify does:
    test -z "$prereqs" && return 0
    bad=$(echo "$prereqs" | cut -b-40 | git-rev-list --stdin --not --all 
2>&1)
    if test -n "$bad" ; then
        test "$1" = "--silent" && return 1
        echo "error: $bfile requires the following commits you lack:"
        echo "$prereqs" |
        while read sha1 comment ; do
            missing=$(git-rev-list $sha1 --not --all 2>&1)
            test -n "$missing" && echo "$sha1 $comment"
        done
        exit 1
    fi
    return 0

The difference is

    fatal: bad object 59e4aa84d4b4f7c6393317c68649ef7db3c4440c
    error: At least one prerequisite is lacking.

vs.

    error: /home/mlevedahl/bundle2 requires the following commits you lack:
    59e4aa84d4b4f7c6393317c68649ef7db3c4440c Merge remote branch 
'rvaas05/gem.418' into lcb.418
    8eb8c8274c28be9435da8534f8bb598503f4f85a Merge remote branch 
'rvaas05/gem.418' into lcd.419

This was Junio's suggestion originally, and I think it a very good one. 
The latter error message is far more helpful to some poor soul trying to 
fix a problem.


Also,  I did track down the issue that forced me to use tar (or at least 
*some* archiver) in cygwin: it is a known bug without a planned fix that 
precludes saving mixed text and binary in one file from bash, and seems 
to be tied deeply into bash, fork, and pipes. Basically, doing
    echo "some text data" > file
    echo "some binary data" >>file
is totally confused as the underlying pipe / fork mechanism thinks file 
is text mode on the second operation. This happens regardless of mount 
mode or CYGWIN=binmode. The end result is under bash the binary data 
unconditionally suffers crlf->lf translation. You can look at at 
http://www.mail-archive.com/cygwin@cygwin.com/msg76319.html for more 
information.

Mark
