From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Migrating svn to git with heavy use of externals
Date: Tue, 8 Apr 2008 17:01:05 -0400
Message-ID: <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
References: <47F15094.5050808@et.gatech.edu> <47FBB448.3060900@et.gatech.edu>
	 <32541b130804081306q6e06af20u794357eba9d434e@mail.gmail.com>
	 <47FBDA77.2050402@et.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: stuart.freeman@et.gatech.edu
X-From: git-owner@vger.kernel.org Tue Apr 08 23:02:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjKwz-0002nR-TL
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 23:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbYDHVBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 17:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbYDHVBI
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 17:01:08 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:46494 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbYDHVBH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 17:01:07 -0400
Received: by mu-out-0910.google.com with SMTP id i10so3071099mue.5
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 14:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rq82XKTnicxLwtThPNTXWHTwKVo5Fg7tAuZqKmu48Vk=;
        b=rXoNDhTE4joVbfz56gQ97Db/Z4W/Vb2bEGyy8LomqsYGEaADDt4p2Rk8kUGZmwued+LKTXu67sGxDZSKZbF5Hoq7s0EzHgfbHluboDurXVHpQC2RpWWB5azFtgitvG0KtnHxU5WT1lHcXxRLdodtbWtwb5lDaLe2Joh3aJS8qB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q66Kbils3FRAFkaRbxgX2vHuFCEGRTJnkiVPO+nFVuMiv85S0p0ya59Ncd2eKktkR7VEYqL1+wagctDwIWTeF9AvVjMPjJ8hVLQ/TPuap0beWZgTfJe5c6hkzAYewBOoVlFlpkZ1TnT8CemQf5urP2JM0r0M8E7yco2wIomNAWE=
Received: by 10.82.154.5 with SMTP id b5mr10767374bue.10.1207688465535;
        Tue, 08 Apr 2008 14:01:05 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Tue, 8 Apr 2008 14:01:05 -0700 (PDT)
In-Reply-To: <47FBDA77.2050402@et.gatech.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79031>

On Tue, Apr 8, 2008 at 4:49 PM, D. Stuart Freeman
<stuart.freeman@et.gatech.edu> wrote:
>  It's possible to have svn:externals point at a specific revision, but
>  that's not the point.

Right, I forgot that they added that.

>  cd ../access
>  git checkout -b 2-5-x sakai_2-5-x  # sakai_2-5-x is an svn import
>  cd ../sakai
>  git checkout -b 2-5-x sakai_2-5-x
>  git submodule add -b 2-5-x ../access access
>
>  Which gives me an error about access already existing.

You should only ever need to add a given submodule once.  As far as I
can tell, this is a bit of confusion in the way git-submodule works,
but I don't have any suggestions for what to do about it yet so I
don't complain :)

The way to understand git-submodule's operation is in terms of what it
actually does.  Roughly speaking, git-submodule-add puts things into
.gitmodules and .git/config; git-submodule-init copies that stuff from
.gitmodules to .git/config (so if you're the guy who did the add, you
can skip this step).  Then git-commit actually checks the submodule
reference into the parent tree, and someone who pulls your parent tree
needs to run git-submodule-update in order to actually retrieve the
new submodule pointer.

In other words, git-submodule is very powerful, but also very
complicated, and at least one of the things I said up above is
probably wrong :)  By comparison, svn:externals is at least easy to
understand.

Anyway, in this case, what you need to know is that .git/config
already contains your submodule information.  Sadly, .gitmodules is
probably sitting somewhere on your original branch, so it probably
doesn't exist.  You could remove the entry from .git/config by hand
and use git-submodule-add again (thus putting it in both places), or
copy the .gitmodules file from the original branch, or git-cherry-pick
the commit where you added it.

You should *also* cd into the access subdir and checkout the right
revision there; at that time, the next commit to the sakai repository
will make sure the submodule reference is to the right place.

Phew, I hope that made things more clear instead of less clear. :)

Have fun,

Avery
