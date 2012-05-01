From: Luke Diamand <luke@diamand.org>
Subject: Re: git p4: in-place submit
Date: Tue, 01 May 2012 06:28:55 +0100
Message-ID: <4F9F7497.5050504@diamand.org>
References: <20120430225848.GA2727@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>,
	Michael Horowitz <michael.horowitz@ieee.org>,
	Gary Gibbons <ggibbons@perforce.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue May 01 07:29:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP5eb-0003Zq-IV
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 07:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163Ab2EAF26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 01:28:58 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:48844 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab2EAF25 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 01:28:57 -0400
Received: by wgbdr13 with SMTP id dr13so1170305wgb.1
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 22:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=r2rMAj22cpMejYTyo5g2KBTv3C0ypbRI4L0hx0FD0ac=;
        b=MljC1G2QlGZLygBMAMrmZRPMoth5p2AT391iup7Hpolyn5XLYyCkqIa2u6LCw7M8KA
         L7dPAiHxtCpmMQJtGQwNFf9AVcwLA6Cao4DBW5XsV+LIkRpWuKQWmzRJ3iO3V/FlWFWP
         30g0Z89Jtp/b31eoO+hAMuokbKJI/3RmUGv2cUcPq9Gphd/RByX/c2GADYSdFnFak83V
         JSfl/zaXa28+xCFMyuvZkm4uToeehZCuO66r0Q/+/Cu80pynHxieO8y7icRcEXKZOqjc
         7I8hVaH/f1txJnI35J9XBDQSsVQ4TVIgehbKfXbgI0R5tJRiT+K04SeNtCf/KGggiizL
         H/eg==
Received: by 10.180.106.9 with SMTP id gq9mr2304849wib.17.1335850136407;
        Mon, 30 Apr 2012 22:28:56 -0700 (PDT)
Received: from [86.6.30.7] (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id n20sm53400549wiw.5.2012.04.30.22.28.55
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Apr 2012 22:28:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
In-Reply-To: <20120430225848.GA2727@padd.com>
X-Gm-Message-State: ALoCoQmIeD358O3WOlLIsyFEPMcjYh0Y9NCLTW44I5M++djDT+ie0E5wnvpywoVk2ncsTQJaWpRV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196658>

On 30/04/12 23:58, Pete Wyckoff wrote:
> Tell me if you think this is a good idea.
>
> Now, submit requires a separate workspace.  You have one for git,
> and a separate one used just to push files back into p4.  I'd
> like to see if we can do the submit part from the git workspace
> directly.
>
> My motivation is:
>
>      - managing both a git and a p4 workspace is extra hassle
>
>      - $work repo is big, and having a separate copy just for
>        submits is a waste of space
>
> Setup would go something like:
>
>          # normal clone
>          git p4 clone --destination=/home/pw/p4/proj //depot/proj@all
>
>          # build client at same location
>          p4 client -i<<-EOF
>          Client: pw:proj
>          Description: pw proj client
>          Root: /home/pw/p4/proj
>          View: //depot/proj/... //pw:proj/...
>          EOF
>
>          # set config to tell git p4 what to do
>          cd /home/pw/p4/proj
>          git config git-p4.submit-in-place true   ;# new!
>          git config git-p4.client pw:proj
>          git config git-p4.useClientSpec true
>
> but no "p4 sync".
>
> Then use git to edit/commit, and eventually "git p4 submit" as
> usual.  The new submit-in-place code would:
>
>      - make sure everything is committed
>
>      - find git-p4 latest change number
>          - ensuring linear series of commits back to p4/master
>
>      - warn if latest change in //depot/proj/... is greater, but proceed
>
>      - p4 sync -k @change  ;# -k means don't touch my workspace
>
>      - for each commit in p4/master..branch:
>          - git checkout commit
>          - p4 edit, move, delete, -t text+x, etc to prepare tree
>          - p4 submit
>          - if any files require resolution, fail
>          - chmod +w affected files to undo p4 read-only changes
>          - git checkout --hard HEAD to destroy RCS keyword updates
>
>      - if fail
>          - git checkout --hard HEAD
>          - rebase branch onto last successful commit
>      - else
>          - git p4 sync (as usual)
>          - update branch to p4/master
>          - git checkout branch
>
> Is this a worthwhile change?  What details have I overlooked?
>
>                  -- Pete


So the trick here is the "chmod +w" - without that, you won't be able to 
edit code via git?

I think it would be well worth doing - I've always found having two 
trees a nuisance.

It's still worth keeping the existing scheme. I often find it useful to 
checkout random bits of our p4 depot without the hassle of setting up a 
client workspace if I just want a read-only copy.
