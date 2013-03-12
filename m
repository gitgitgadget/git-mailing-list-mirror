From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [RFC/PATCH] Documentation/technical/api-fswatch.txt: start with
 outline
Date: Wed, 13 Mar 2013 00:21:00 +0100
Message-ID: <513FB85C.5010106@gmail.com>
References: <1362946623-23649-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 00:21:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFYVh-00047b-K4
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 00:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933434Ab3CLXVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 19:21:06 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:44418 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932593Ab3CLXVC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 19:21:02 -0400
Received: by mail-ea0-f173.google.com with SMTP id h14so147033eak.32
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 16:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=W+McjaIIeGoyX9+R8mnQxeHlf3vl9plRl3kCpFCXPnk=;
        b=TO9jzo3djK8jIBzfZaDh8+WpAIAOWpzvK8k9qt4m4FSgoYRuKFhNLEfUrCElL40RZg
         iRdSg9wooxXNskDIC8eKwVkgx9SpWW0QByLBMirdhd0GVKFyIuyHwfUoZh8dy6OkxNzj
         YRpjOzIRYSjvanKKp2Y8FGo9hjApnV5/ZdKDHj84bSs+CDx1thSprFicbu/h1WmyP1uD
         UTqAQ3qEHOqDioOrmmoUoumcJQZrD0QrrB1Ts7Z9NDGyIdDqKCpBY0MUknXJtwpbh8SJ
         Fq7dMzge2Uo41T+hyf95zzYywSIGJ+Kr47GexdqfeuBZMlxLR46LEggWpma9IQIx1u8K
         90Wg==
X-Received: by 10.14.1.130 with SMTP id 2mr52675753eed.15.1363130460739;
        Tue, 12 Mar 2013 16:21:00 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id z45sm32491954eeu.10.2013.03.12.16.20.59
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Mar 2013 16:21:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <1362946623-23649-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218009>

Am 10.03.2013 21:17, schrieb Ramkumar Ramachandra:
> git operations are slow on repositories with lots of files, and lots
> of tiny filesystem calls like lstat(), getdents(), open() are
> reposible for this.  On the linux-2.6 repository, for instance, the
> numbers for "git status" look like this:
> 
>   top syscalls sorted     top syscalls sorted
>   by acc. time            by number
>   ----------------------------------------------
>   0.401906 40950 lstat    0.401906 40950 lstat
>   0.190484 5343 getdents  0.150055 5374 open
>   0.150055 5374 open      0.190484 5343 getdents
>   0.074843 2806 close     0.074843 2806 close
>   0.003216 157 read       0.003216 157 read
> 
> To solve this problem, we propose to build a daemon which will watch
> the filesystem using inotify and report batched up events over a UNIX
> socket.

[...]

> +
> +The credential C API is meant to be called by Git code which needs
> +information aboutx filesystem changes.  It is centered around an
> +object representing the changes the filesystem since the last
> +invocation.
> +

Hmmm...I don't see how filesystem changes since last invocation can solve the problem, or am I missing something? I think what you mean to say is that the daemon should keep track of the filesystem *state* of the working copy, or alternatively the deltas/changes to some known state (such as .git/index)?

I'm also still skeptical whether a daemon will improve overall performance. In my understanding its essentially a filesystem cache in user-mode. The difference to using the OS filesystem cache directly (via lstat/readdir) is that we replace ~50k sys-calls with a single IPC call (i.e. the git <--> fswatch daemon communication is less 'chatty'). However, the 'chattyness' is still there between the fswatch daemon and the OS / inotify. Consider 'git status; make; make clean; git status'...that's a *lot* of changes to process for nothing (potentially slowing down make).

Then there's the issue of stale data in the cache. Modifying porcelain commands that use 'git status --porcelain' to compile their changesets will want 100% exact data. I'm not saying its not doable, but adding another platform specific, caching daemon to the tool chain doesn't exactly simplify things...

But perhaps I'm too pessimistic (or just stigmatized by inherently slow and out-of-date TGitCache/TSvnCache on Windows :-)
