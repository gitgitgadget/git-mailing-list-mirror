From: Phil Hord <hordp@cisco.com>
Subject: git-rebase-todo gets popped prematurely
Date: Wed, 02 Apr 2014 18:37:48 -0400
Message-ID: <533C913C.20106@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "phil.hord@gmail.com" <phil.hord@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:38:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVece-000348-41
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933435AbaDBWrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 18:47:13 -0400
Received: from alln-iport-3.cisco.com ([173.37.142.90]:38402 "EHLO
	alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414AbaDBWrM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 18:47:12 -0400
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Apr 2014 18:47:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2613; q=dns/txt; s=iport;
  t=1396478832; x=1397688432;
  h=message-id:date:from:mime-version:to:cc:subject:
   content-transfer-encoding;
  bh=ELXOui91TJNk5XzT1wCe80E0o3+Jo/zA9jux/sMwMtI=;
  b=QrkOJC9GNHZi2sWNifuSHNgWOzZRa9WW0P4vJjFgUQ2uhh51fFGsDKc9
   UzLoAVpzRLhuhKPCAkfXKR/WuMAVn1PI2ju3mrAL/Eq4CGBUUSuNZGoKH
   K+u5nkPo/PzpUuGFqcMF63a4CWFVAua9yDeQfuLvjqsUzN+q+4Vt4GXTJ
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgkFAOGPPFOtJA2G/2dsb2JhbABZgwbEeIEkFnSDJTw0AkwNAQcBAYd1z0wXiUaFKoQ/AQOYWIZPi2qDTA
X-IronPort-AV: E=Sophos;i="4.97,783,1389744000"; 
   d="scan'208";a="32412318"
Received: from alln-core-12.cisco.com ([173.36.13.134])
  by alln-iport-3.cisco.com with ESMTP; 02 Apr 2014 22:37:50 +0000
Received: from [64.100.104.110] (dhcp-64-100-104-110.cisco.com [64.100.104.110])
	by alln-core-12.cisco.com (8.14.5/8.14.5) with ESMTP id s32MboG8020320;
	Wed, 2 Apr 2014 22:37:50 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245688>

During a 'git rebase --continue', I got an error about having left a
file in place which the next commit intended to add as new.  Stupid me.

So I rm'ed the file and tried again.  This time, git rebase --continue
succeeded.  But it accidentally left out the next commit in my rebase-todo.

I looked in the code and it seems that when the "pick" returns an error,
rebase--interactive stops and lets the user clean up.  But it assumes
the index  already tracks a conflicted merge, and so it removes the
commit from the todo list.  In this case, however, the conflicted merge
was avoided by detecting it in advance.  The result is that the "would
be overwritten" conflict evicts the entire commit from the rebase action.

I think the code needs to detect the difference between "merge failed;
conflicted index" and "merge failed; no change".  I think I can do this
with 'git-status -s -uno', maybe.  But I haven't tried it yet and it
feels like I'm missing a case or two also.

I tried to bisect this to some specific change, but it fails the same
way as far back as 1.6.5. 

Test script follows in case anyone has a better idea how to approach
this and wants to understand it better.

    #!/bin/sh

    set -x
    git --version
    rm -rf baz
    git init baz && cd baz
    echo initial>initial && git add initial && git commit -minitial
    echo foo>foo && git add foo && git commit -mfoo
    echo bar>bar && git add bar && git commit -mbar
    git log --oneline

    GIT_EDITOR='sed -i -e s/^pick/edit/ -e /^#/d' git rebase -i HEAD^^
    touch bar
    git rebase --continue
    rm bar
    git rebase --continue
    git log --oneline


And the tail of the output (note the missing "bar" commit even though
"Successfully rebased"):

    + git log --oneline
    fcc9b6e bar
    8121f15 foo
    a521fa1 initial
    + GIT_EDITOR='sed -i -e s/^pick/edit/ -e /^#/d'
    + git rebase -i 'HEAD^^'
    Stopped at 8121f1593ea5c66dc7e9af7719100c1fcf4ab721... foo
    You can amend the commit now, with

        git commit --amend

    Once you are satisfied with your changes, run

        git rebase --continue

    + touch bar
    + git rebase --continue
    error: The following untracked working tree files would be
    overwritten by merge:
        bar
    Please move or remove them before you can merge.
    Aborting
    Could not apply fcc9b6ef2941e870f88362edbe0f1078cebb20e5... bar
    + rm bar
    + git rebase --continue
    Successfully rebased and updated refs/heads/master.
    + git log --oneline
    8121f15 foo
    a521fa1 initial
