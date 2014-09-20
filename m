From: Daniel Hahler <genml+git-2014@thequod.de>
Subject: diff-index does not consider a removed submodule to be staged with
 --ignore-submodules
Date: Sat, 20 Sep 2014 18:20:42 +0200
Message-ID: <541DA95A.2030407@thequod.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 18:27:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVNVD-0001H4-PQ
	for gcvg-git-2@plane.gmane.org; Sat, 20 Sep 2014 18:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961AbaITQ1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2014 12:27:12 -0400
Received: from hahler.de ([188.40.33.212]:41333 "EHLO elfe.thequod.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752868AbaITQ1L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2014 12:27:11 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Sep 2014 12:27:11 EDT
Received: from localhost (amavis [10.122.1.24])
	by elfe.thequod.de (Postfix) with ESMTP id B0092620C3
	for <git@vger.kernel.org>; Sat, 20 Sep 2014 18:20:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thequod.de; h=
	content-transfer-encoding:content-type:content-type:subject
	:subject:mime-version:user-agent:from:from:date:date:message-id
	:received:received; s=postfix2; t=1411230042; bh=D9BLtN4kghmbCYv
	HAXqAe94g1YJt2/ttzJPzK1sNWEg=; b=CizQ7RvfVEwpI2OfMUkqDQw6PVLjTSp
	UCYSEXmuvLG7mZj27q8fmZ3cnqaKuGzkBA4AjHyifV8GnVH1227Stdd2ywrJr0mA
	4BHGo2JrdXU2sMOQDdWMf+5TPvh3L0absbxTzv24d9wCH5hM+RZBtiEfrv1fe46G
	Br47S5CQ4Fzw=
Received: from elfe.thequod.de ([10.122.1.25])
	by localhost (amavis.thequod.de [10.122.1.24]) (amavisd-new, port 10026)
	with ESMTP id RAKCM5QFqVKN for <git@vger.kernel.org>;
	Sat, 20 Sep 2014 18:20:42 +0200 (CEST)
Received: from lenny.thequod.de (unknown [91.64.37.19])
	(Authenticated sender: daniel@hahler.de)
	by elfe.thequod.de (Postfix) with ESMTPSA
	for <git@vger.kernel.org>; Sat, 20 Sep 2014 18:20:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257327>

After staging the removal of a submodule, diff-index does not consider this when "--ignore-submodules" is being used:

    # In a repository with submodule "sm":
    % git rm --cached sm
    % git diff-index --cached --quiet --ignore-submodules HEAD
    % echo $?
    0
    % git status
    On branch master
    Changes to be committed:
      (use "git reset HEAD <file>..." to unstage)

        deleted:    sm

"git status --ignore-submodules" behaves the same.

>From the man page of "--ignore-submodules" it looks like the option is meant to prevent scanning of submodules itself, but in this case the main repository is affected.

This command is used by zsh's vcs_info module (in Functions/VCS_Info/Backends/VCS_INFO_get_data_git):

    if (( querystaged )) ; then
        if ${vcs_comm[cmd]} rev-parse --quiet --verify HEAD &> /dev/null ; then
            ${vcs_comm[cmd]} diff-index --cached --quiet --ignore-submodules HEAD 2> /dev/null
            (( $? && $? != 128 )) && gitstaged=1

Is this a bug/oversight in Git or by design?
Is there a better way to detect if there are any staged changes?


Regards,
Daniel.

-- 
http://daniel.hahler.de/
