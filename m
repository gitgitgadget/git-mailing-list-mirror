From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Setting file timestamps to commit time (git-checkout)
Date: Mon, 9 Dec 2013 12:48:16 -0800
Message-ID: <20131209204815.GV29959@google.com>
References: <20131209112528.GA5309@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 09 21:48:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq7kf-0004JS-4h
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 21:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933206Ab3LIUsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 15:48:20 -0500
Received: from mail-qe0-f50.google.com ([209.85.128.50]:58399 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216Ab3LIUsU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 15:48:20 -0500
Received: by mail-qe0-f50.google.com with SMTP id 1so3282188qec.37
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 12:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=w9wImE4vd73MS4KlR20QdOYqehO42WCrlcXKshACr6c=;
        b=CU3IG6gJej1Q2O4UzEWFv/5gGC8CEeLdEok0yKMxU+c0cCUhLNMg+gGTDPFYWpd4z7
         ZxkIurpDLHxRQbIJmp+lU6d3rRvTwFxXdlaPALcKYj6ghXDi9lvU0wnHwRLLOLUjd5Tu
         Z5fGY+UYqWcOZ/947MhEz1tKwrxKjqm36aLPkyGJ3oL4Ls4ZTsUVZSYT6LwQFQGWucOU
         NFH7lc2HeqP6q2upaqiPvYetDl7MKW7//jrpTbxGkACxSajMCUlo8IPDN6iGpgzVhkMS
         LY+oGP72ypZsIcsX4woVmj2IJbiRrlAWQKxHISjFmAKynQ4EbL0ZLjm3QwhJLmzDSlDe
         zuLg==
X-Received: by 10.49.2.132 with SMTP id 4mr37008673qeu.15.1386622099528;
        Mon, 09 Dec 2013 12:48:19 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id fc16sm22049844qeb.3.2013.12.09.12.48.18
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 09 Dec 2013 12:48:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131209112528.GA5309@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239093>

Hi,

Dominik Vogt wrote:

>                                                            Now,
> when I switch to one of the other branches, said file is not
> identical anymore and stamped with the _current_ time during
> checkout.  Although branch b and c have not changed at all, they
> will now be rebuilt completely because the timestamp on that files
> has changed.  I.e. a chance on one branch forces a rebuild on n
> other branches, which can take many hours.
>
> I think this situation could be improved with an option to
> git-checkout with the following logic:
>
> $ git checkout <new branch>
>   FOR EACH <file> in working directory of <new branch>
>     IF <file> is identical to the version in the <old branch>
>       THEN leave the file untouched
>     ELSE IF <commit timestamp> of the HEAD of the <new branch>
>             is in the future
>       THEN checkout the new version of <file> and stamp it with
>            the current time
>     ELSE (commit timestamp is current or in the past)
>       THEN checkout the new version of <file> and stamp it with
>            the commit timestamp of the current HEAD of <new branch>

Wouldn't that break "make"?  When you switch to an old branch, changed
files would then a timestamp *before* the corresponding build targets,
causing the stale (wrong function signatures, etc) build results from
the newer branch to be reused and breaking the build.

I suspect the simplest way to accomplish what you're looking for would
be to keep separate worktrees for each branch you regularly build.
It's possible to do that using entirely independent clones, clones
sharing some objects (using "git clone --shared" from some master
copy), or even multiple worktrees for the same clone (using the
git-new-workdir script from contrib/workdir/).

See [1] and [2] for more hints.

[...]
> (Please do not cc me on replies, I'm subscribed to the list.)

The convention on this list is to always reply-to-all, but I'm happy
to make an exception. :)

Hope that helps,
Jonathan

[1] https://git.wiki.kernel.org/index.php/Git_FAQ#Why_isn.27t_Git_preserving_modification_time_on_files.3F
[2] https://git.wiki.kernel.org/index.php/ExampleScripts#Setting_the_timestamps_of_the_files_to_the_commit_timestamp_of_the_commit_which_last_touched_them
