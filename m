From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG?] Patches created with 'diff.noprefix=true' don't 'git
 apply'.
Date: Wed, 30 Apr 2014 19:40:42 -0700
Message-ID: <20140501024042.GX9218@google.com>
References: <CAO8RVvdgN3U5hUEsJjYY9urfeVUDWwHiEur4NQp=H93W37RRnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Nathan Collins <nathan.collins@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 04:40:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfgva-0005Rn-Jx
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 04:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbaEACkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 22:40:46 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59898 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbaEACkq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 22:40:46 -0400
Received: by mail-ob0-f174.google.com with SMTP id gq1so3067491obb.5
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 19:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=snAX3Rbi1OnvoYyD7QeN/e7pk8CsQR7jjeh5A6UgFfI=;
        b=tW4jL+//l8es3Vuxx1Ul1cxCiV71gMhJzGHpSLHhhFSUZf+Kr4UPSv1ogAv2fDHGpw
         CD+ToKRcP7s78j/ttz/Gq4Sv88O/USU3DwqtJKBX+QZHbEcmR7hte0hqqDvU5Eharw+7
         dY9Xh8Q4tPYGF1U6Rm9WB010efmsIcwq3dETHr5Cxa5uEu/E94PSYlpI+n1NrIsNUhnW
         fagDrXOiDmqf25rMjfNW3RCkf+QXqwihDH690pHg8fzXucG2asDiVc1Ms8rqq2Poqd64
         uhHBgyXJq3AwoULb8rC7zWxLbkB0lFghSZybRKzo+qbnIXNjpa0AaPbT+q0bZJM4jamX
         qu9A==
X-Received: by 10.182.102.134 with SMTP id fo6mr7305051obb.10.1398912045646;
        Wed, 30 Apr 2014 19:40:45 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ut8sm56052433obc.22.2014.04.30.19.40.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Apr 2014 19:40:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAO8RVvdgN3U5hUEsJjYY9urfeVUDWwHiEur4NQp=H93W37RRnw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247805>

Hi,

Nathan Collins wrote:

> Patches created with 'diff.noprefix=true' don't 'git apply' without
> specifying '-p0'.
>
> I'm not sure this is a bug -- the 'man git-apply' just says "Reads the
> supplied diff output (i.e. "a patch") and applies it to files" -- but
> I would expect patches I create locally to apply cleanly locally.

Sounds like a documentation bug, at least.  Any ideas for clearer
wording?

>                                                                   In
> real life the 'diff.noprefix=true' is in my ~/.gitconfig, so this was
> pretty confusing.

I personally think setting diff.noprefix is not very sane (it also
breaks "patch -p1"), and I suppose I should have been louder about
that when it was introduced.

Can you say more about the workflow you use that requires
diff.noprefix?  Maybe we can make other changes to improve it, too.

At first glance I don't suspect making diff.noprefix imply -p0 for
"git am" would be great, since that would generate the the opposite
problem when applying patches from the outside world.  But maybe we
need better autodetection and maybe noprefix is a good signal about
when to use it.

Another complication is that unlike 'git diff', 'git apply' is
plumbing that is meant to be useful and reliable for scripts.  And
unlike most plumbing, there is no higher-level command with similar
functionality for which we can experiment more freely with the UI.
Adding a new command to fix that might be a good direction toward
handling noprefix patches better.

[...]
> git show | git apply --reverse

The following which only uses plumbing commands should work:

	git diff-tree -p HEAD^! |
	git apply --reverse

Thanks for some food for thought,
Jonathan
