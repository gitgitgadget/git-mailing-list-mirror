From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [GIT GUI PATCH v2] git-gui: tolerate major version changes when comparing
 the git version
Date: Sat, 17 May 2014 21:49:05 +0200
Message-ID: <5377BD31.8040004@web.de>
References: <CAFOYHZBPLZhVuf=bO0hPcUH2_0WXFSqk=_CqoUWBRixQc0L==Q@mail.gmail.com>	<CAFOYHZD=wxwm0nLhtZwvXDAhQ23j0C5maArQunc0CVe_-SF_mQ@mail.gmail.com>	<871tw7xg3o.fsf@fox.patthoyts.tk> <5369E0A3.4040701@gmail.com>	<5369E58D.4030908@gmail.com> <53728D70.4020506@web.de>	<5373200D.7020108@web.de>	<xmqqlhu4jhcb.fsf@gitster.dls.corp.google.com>	<xmqqk39ohvyp.fsf@gitster.dls.corp.google.com> <87k39kbnmg.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
To: patthoyts@users.sourceforge.net, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 21:49:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wlkbq-0003Zl-PO
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 21:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbaEQTtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 15:49:14 -0400
Received: from mout.web.de ([212.227.15.14]:62651 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbaEQTtO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 15:49:14 -0400
Received: from [192.168.2.105] ([87.179.85.170]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MBTTa-1WbGTK49wM-00ATdJ; Sat, 17 May 2014 21:49:09
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <87k39kbnmg.fsf@fox.patthoyts.tk>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:ZO6xUJtO9w3nkOfCwObZgtGqHYrVuPIgnsNNHcOcRcLZMgHMMLv
 2S73jN/xVfOueYTcZWB4GPyZzyv/S/lrg2QMT+rFttxh2uhUuIbgAhZV9+cA7zIlBcKUtjj
 gkIOpvUeQx1eMAHg/8238JSvnGcGYSdfcsEQ2rtia35bDaYXvgWVEdidh/iUhL5fqCqu3vg
 kuTlaNcuoL6HSsFWzGL7g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249491>

Since git 2.0.0 starting git gui in a submodule using a gitfile fails with
the following error:

   No working directory ../../../<path>

   couldn't change working directory
   to "../../../<path>": no such file or
   directory

This is because "git rev-parse --show-toplevel" is only run when git gui
sees a git version of at least 1.7.0 (which is the version in which the
--show-toplevel option was introduced). But "package vsatisfies" returns
false when the major version changes, which is not what we want here.

Fix that for both places where the git version is checked using vsatifies
by appending a '-' to the version number. This tells vsatisfies that a
change of the major version is not considered to be a problem, as long as
the new major version is larger. This is done for both the place that
caused the reported bug and another spot where the git version is tested
for another feature.

Reported-by: Chris Packham <judge.packham@gmail.com>
Reported-by: Yann Dirson <ydirson@free.fr>
Helped-by: Pat Thoyts <patthoyts@users.sourceforge.net>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 17.05.2014 14:23, schrieb Pat Thoyts:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>>
>>>> Junio, I believe this issue needs to be fixed before 2.0 final. Otherwise
>>>> git gui will not work inside submodules anymore due to the major version
>>>> number change from 1 to 2. I'd like to hear Pat's opinion on this; even
>>>> though I think my patch is less risky (as it doesn't change behavior for
>>>> pre-2 versions), he might like Chris' proposal better.
>>>
>>> Thanks; I share the same feeling.
>>
>> So after checking git://repo.or.cz/git-gui.git/ and seeing that I am
>> not missing any commit from there, I tentatively created a fork of
>> it, applied your patch and merged it somewhere on 'pu' that is close
>> to 'next'.  We may want to fast-track it to 2.0 without waiting for
>> an Ack from Pat but let's give him one more day to respond.
>>
> 
> The analysis about the major version number being significant is
> correct. By default vsatisfies assumes that a major version number
> change means all lesser versions are incompatible. However, you can
> prevent that assumption using an unlimited check by appending a - (minus
> sign) to the version to yield an open ended range. Or by giving another
> range. So the only change required is to append a minus.
> 
>   package vsatisfies $::_git_version 1.7.0-
> 
> will suffice.
> 
>   package vsatisfies $::_git_version 1.7.0 2.0.0
> 
> would work but would cause failures when we arrive at git 3.0

Thanks for the review! In this version I added the '-' to the version
passed to vsatisfies and updated the commit message accordingly. I
tested the result and it fixes the regression.

Junio, please replace my old version with this. In the first version
I forgot to add a ">= 0" after the vcompare, which results in all
versions that are /different/ than the one checked against pass the
test. While that fixes the 2.0.0 regression, it will fail for git
versions older than the version that is tested for. So my first
attempt wasn't /that/ different from Chris' proposal ... :-/


 git-gui/git-gui.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index cf2209b..6a8907e 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1283,7 +1283,7 @@ load_config 0
 apply_config

 # v1.7.0 introduced --show-toplevel to return the canonical work-tree
-if {[package vsatisfies $_git_version 1.7.0]} {
+if {[package vsatisfies $_git_version 1.7.0-]} {
 	if { [is_Cygwin] } {
 		catch {set _gitworktree [exec cygpath --windows [git rev-parse --show-toplevel]]}
 	} else {
@@ -1539,7 +1539,7 @@ proc rescan_stage2 {fd after} {
 		close $fd
 	}

-	if {[package vsatisfies $::_git_version 1.6.3]} {
+	if {[package vsatisfies $::_git_version 1.6.3-]} {
 		set ls_others [list --exclude-standard]
 	} else {
 		set ls_others [list --exclude-per-directory=.gitignore]
-- 
1.8.3.1
