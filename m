From: Luke Diamand <luke@diamand.org>
Subject: Solved: why cloning my repo always got the wrong default branch;
 possibly missing featurette?
Date: Sat, 21 Apr 2012 09:08:34 +0100
Message-ID: <4F926B02.3050104@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 21 10:09:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLVO9-00009f-CF
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 10:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799Ab2DUIIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 04:08:44 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:57268 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab2DUIIi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 04:08:38 -0400
Received: by wejx9 with SMTP id x9so6495559wej.19
        for <git@vger.kernel.org>; Sat, 21 Apr 2012 01:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=S/KX3A1RIKnQoM+ZhEK5n747CDfgWuAj+tsnuDjkUSc=;
        b=oXSdh2M2/Pivs44DLzH+p0MIdGf7+SZOHABrTQxYFf3vaXk7Kpub5b7WRTI8s7xhkT
         RqEdJ650FplMb8PCj0sjm6DNzMgCyWMopMNmJH3+b8AWod+mw/zE0IeD3ga63yySAWc4
         h8Q/jBtlsfyZFR1xuN7Z1HRPGLUThgxTw7wOuGPJAsYVy2bMwCElfqRY+qRlwwfBpG+r
         lcMvp2ZelPgK72iTVJEDcQV3zpiaFAoina4fak+xd4Josi9Lwi+VJ0f+wuoVPjVE1cTh
         +JaPluIlXkspbMwdnwcaFlQo/JTibPo1fNNOHKP0Fec5ozCqD9RlbAvqrI6es4WHSvpJ
         FLww==
Received: by 10.180.83.72 with SMTP id o8mr4384848wiy.5.1334995717131;
        Sat, 21 Apr 2012 01:08:37 -0700 (PDT)
Received: from [86.6.30.7] (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id ev10sm3595718wid.10.2012.04.21.01.08.35
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Apr 2012 01:08:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
X-Gm-Message-State: ALoCoQmOwTkiMoedpUcqr9VMbQJ+HwFvb4oiOT1D3hgadk5eRG7W7P9XgA5OKjijNfu/RATN4JJi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196045>

I've been wondering for a while why it is that when I clone one 
particular repo, I always end up with HEAD pointed to origin/master 
regardless of what HEAD *actually* points at (unless I explicitly set 
the branch I want to checkout on the command line).

i.e.

<on myremote>
git symbolic-ref HEAD refs/heads/dev

<on client>
% git clone git://myremote/myrepo
% git branch
* master
% git branch -r
origin/HEAD -> origin/master
origin/foo
origin/bar
origin/dev
...


That doesn't seem right - I thought that setting HEAD on the remote wit 
git symbolic-ref would set the branch that gets cloned?

Here's what's happening.

git fetches the remote refs. But the field *symref* does not get filled 
in (at least for git:// and ssh://). So git gets a list of remote refs 
(HEAD, refs/heads/foo, etc) with no information about whether they are 
real heads or symrefs.

In wanted_peer_refs(), since I haven't given a branch on the 
command-line, it then calls guess_remote_head().

guess_remote_head() would get the right answer if head->symref was set:

/*
  * Some transports support directly peeking at
  * where HEAD points; if that is the case, then
  * we don't have to guess.
  */


But in my case it isn't so it then goes and just looks for a head that 
has the right SHA1.

Unfortunately, my remote 'master' branch and the branch I *really* want 
to use both usually have the same SHA1. That's because my repo is doing 
git/p4 mirroring. So the branch I want to use by default ("dev") is 
being constantly rebased (people push to it and git-p4 then does magic 
on it after which it matches master again).

i.e. the guess_remote_head() works fine if the branch you want doesn't 
have the SHA1 as origin/master, but gets it wrong if it does.

I imagine that occasionally when I clone at just the right moment, I 
*will* get the branch I was expecting!

At a guess, the protocol would need to be changed to put the symbolic 
ref information in somehow (upload-pack.c, send-refs() ?).

Is this a bug, or a feature?

Thank,
Luke





	
