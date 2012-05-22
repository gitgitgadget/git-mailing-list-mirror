From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/7] revert: free revs->cmdline.rev
Date: Tue, 22 May 2012 15:40:15 -0500
Message-ID: <20120522204014.GA19789@burratino>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
 <20120521145610.1911.46356.chriscool@tuxfamily.org>
 <20120521203941.GB28331@burratino>
 <20120522.220142.31626389365969573.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, artagnon@gmail.com,
	nbowler@elliptictech.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue May 22 22:40:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWvsr-0001Dm-G7
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 22:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933293Ab2EVUkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 16:40:31 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56474 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932474Ab2EVUkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 16:40:25 -0400
Received: by yenm10 with SMTP id m10so5840586yen.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 13:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=a9Tik4tkYRZV80fjUeeKQEP2pPJIhadkgunG4crj7kY=;
        b=CBArY7C64/L1DDGoRrrWIcJitbJ0l/4Wu1+Wz7mUTfVh069lNAi4q5IeyCC2TU4Obf
         ETbbkAo7rOHEXngVqWNsGNslQbE3quu6VzNBqx9Jk+JyOCyte1mHDIR/xD9E/UOeZO+K
         XfGKmEYnFJvWqxe5jqMo3CAMCD28hB+v8u/aa36Hu3iWmsQja0I023RUw8V8glOHWPXk
         e1dKUMVqzjZiBOu8yXVC3RfN90c+FpyKSI2CaU4uKfgm7d1aL47aoI1BMzhySSRP0Qgs
         4cAjyfy2gkoYL+61fQfnG+0VwxyQ4p1txy4LN2e/6Vr+9jnEj1QERXuRt6Hd45YcPy9P
         BVHA==
Received: by 10.50.157.136 with SMTP id wm8mr10956030igb.14.1337719224403;
        Tue, 22 May 2012 13:40:24 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id de2sm11018092igc.4.2012.05.22.13.40.22
        (version=SSLv3 cipher=OTHER);
        Tue, 22 May 2012 13:40:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120522.220142.31626389365969573.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198248>

Christian Couder wrote:

> About the constantly growing hash table, perhaps it should be taken
> care of in a try_to_free_routine() used by xmalloc and other such
> functions. And no I don't know much about libgit2.

Hm.  At first glance that sounds interesting (some kind of
mark-and-sweep garbage collection, so at least allocation would never
_fail_ due to too large a multipick).  At second glance it is less
exciting, since the logic would only kick in when malloc() fails, and
if I have a lot of swap then my system will have slowed to a crawl
long before then.

Here are a couple of alternative ideas, with no code to back them up.

A. Save a copy of obj_hash after revision traversal and before
cherry-picking anything, and reset the table to that state after every
(let's say) 5 commits cherry-picked.  Or perhaps empty the table
completely after every 5 commits or so cherry-picked.

B. Re-exec git using "git sequence --continue" so everything gets
allocated anew after every 5 commits or so.

That second idea sounds pretty ugly, but it would probably be
effective.  On Windows it's fork(), not execve(), that is expensive,
right? :)

Just musing,
Jonathan
