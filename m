Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB92C54FC9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 10:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2164C2076C
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 10:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDUKCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 06:02:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:55642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgDUKCs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 06:02:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16104AEC2;
        Tue, 21 Apr 2020 10:02:46 +0000 (UTC)
Message-ID: <6cb9d009026cfb9918b2ceab3e43ec1cbc303de4.camel@suse.com>
Subject: Re: Fetching 24 Linux commits = 1.2 GiB
From:   Martin Wilck <mwilck@suse.com>
To:     Jiri Slaby <jslaby@suse.cz>, git@vger.kernel.org
Cc:     konstantin@linuxfoundation.org
Date:   Tue, 21 Apr 2020 12:02:45 +0200
In-Reply-To: <a5bce92f-ad19-75d4-1e34-dacc73321536@suse.cz>
References: <b7f5bfb9-61fb-2552-4399-b744428728e4@suse.cz>
         <20200415135627.vx75hsphbpmgrquv@chatter.i7.local>
         <a5bce92f-ad19-75d4-1e34-dacc73321536@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2020-04-16 at 08:31 +0200, Jiri Slaby wrote:
> On 15. 04. 20, 15:56, Konstantin Ryabitsev wrote:
> > 
> I tried hard, but cannot reproduce. I noticed a difference between
> 2.25.1 and 2.25.1+protocol.version=2, though:
> 
> $ git config protocol.version 1 # the default in 2.25
> $ git fetch
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 8f3d9f354286745c751374f5f1fcafee6b3f3136
> error: Server does not allow request for unadvertised object
> 8f3d9f354286745c751374f5f1fcafee6b3f3136
> $ git config protocol.version 2
> $ git fetch
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 8f3d9f354286745c751374f5f1fcafee6b3f3136
> remote: Enumerating objects: 1433262, done.
> ...
> 
> Doing fetch v5.7-rc1 (which is 8f3d9f3 above) with proto 1 works. So
> the
> server obviously advertises different set of objects with proto 1 and
> 2.

I just had the same issue with several kernel repos. The affected repo 
is a bare clone of Linus' kernel repo, plus "stable" and various
maintainer repos as additional remotes.

Interestingly, a single "git fetch --dry-run" with protol version 1
"fixed" the issue. I hadn't expected that to happen, so unfortunately I
hadn't made a  backup of the repo before. As this is a 50GB bare repo,
I'd appreciate instructions on how exactly to archive/upload it for
debugging if this should happen again.

mwilck@apollon:linux.git[BARE:master]> git fetch --dry-run -v net
Looking up git.kernel.org ... done.
Connecting to git.kernel.org (port 9418) ... 136.144.49.103 done.
remote: Enumerating objects: 7331255, done.
remote: Counting objects: 100% (7331255/7331255), done.
remote: Compressing objects: 100% (1113751/1113751), done.
^C
mwilck@apollon:linux.git[BARE:master]> git config --get
protocol.version
mwilck@apollon:linux.git[BARE:master]> git config protocol.version 1
mwilck@apollon:linux.git[BARE:master]> git fetch --dry-run -v net
Looking up git.kernel.org ... done.
Connecting to git.kernel.org (port 9418) ... 136.144.49.103 done.
remote: Enumerating objects: 71, done.
remote: Counting objects: 100% (71/71), done.
remote: Compressing objects: 100% (48/48), done.
remote: Total 53 (delta 42), reused 0 (delta 0)
Unpacking objects: 100% (53/53), 8.06 KiB | 5.00 KiB/s, done.
^C

(this fixed the issue despite "--dry-run" and myself interrupting the
process).

mwilck@apollon:linux.git[BARE:master]> git config protocol.version 2
mwilck@apollon:linux.git[BARE:master]> git fetch --dry-run -v net
Looking up git.kernel.org ... done.
Connecting to git.kernel.org (port 9418) ... 136.144.49.103 done.
From git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
   9bacd25..a460fc5      master       -> net/master
 = [up to date]          v2.6.11      -> v2.6.11
...

Regards
Martin


