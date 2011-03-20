From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git fails to detect subcommand when hook is symlinked to a
 builtin
Date: Sun, 20 Mar 2011 03:20:20 -0500
Message-ID: <20110320082020.GA12663@elie>
References: <20110318151415.GC26236@inocybe.localdomain>
 <7vhbb0rkv4.fsf@alter.siamese.dyndns.org>
 <20110319011445.GL26236@inocybe.localdomain>
 <7voc56rj9f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 09:21:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Dsq-0000sd-VI
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 09:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151Ab1CTIVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 04:21:03 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49425 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab1CTIUc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 04:20:32 -0400
Received: by iyb26 with SMTP id 26so5445129iyb.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 01:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=iVH77coFldyD/5k80+ZoO8KPRHvdQcyYHE0WwTW1tYw=;
        b=XgAz54bd1uHOOvpQRupnpGPc0JrGOZ6t+GFjfY1OkRJeNxNhixE0pf+D1QhpvfaG6D
         4QgkCasfIG+hCbwSy74Db9uJdoWZiAxEf0W9Yz/vZ81ufyi0GNJVuvTB1sJScLkMxAxl
         7VqA0k48De565vmq0xdRelmAcpiX5Ktyq7c58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LyN0su6a2SGZNsVAFw96G9mc2OwKHIyZOj8bMWBx8jJqPSkflVbPJpqXRZIrhq2gQ7
         1ws+ltlZI56NX9NsrDeh2RfNwh9HPNG7oBbV/DlIzwsnLTzNInmUYUgRMocQJMy49ECI
         vTYQkWxmltR1yivI8u4zXcvw7azGLCeyyTPjs=
Received: by 10.231.187.148 with SMTP id cw20mr130996ibb.170.1300609229123;
        Sun, 20 Mar 2011 01:20:29 -0700 (PDT)
Received: from elie ([69.209.56.53])
        by mx.google.com with ESMTPS id s40sm2832012ibg.60.2011.03.20.01.20.27
        (version=SSLv3 cipher=OTHER);
        Sun, 20 Mar 2011 01:20:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7voc56rj9f.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169490>

Junio C Hamano wrote:

> Ok, that explains it.  update-server-info wasn't a built-in, so didn't
> have to look at its name to decide what to do.  It didn't have to spawn
> other git commands from GIT_EXEC_PATH so running the command directly
> without setting the environment variable happened to work.

Nice detective work.

> But such a usage (this doesn't have anything to do with the symlinking)
> was deprecated way before 1.5.4 [*1*], so the answer is still "don't do
> that" ;-)
[...]
> *1* http://thread.gmane.org/gmane.comp.version-control.git/93511

After rereading some of that thread (oops), I feel a small clarification
is in order.  Yes, the dashed named git-update-server-info is not the
name that that command would preferred to be called by, but if I
understand correctly, this is not what you are talking about having
being deprecated and removed.  Instead, the rule is:

 If you set your $PATH to include $(git --exec-path), then you may still
 run traditional git-<command>s using that dashed name.  Otherwise, you
 may be lucky and find it working (which is probably a bug :)) but
 please, just say no.[1]

Rationale: in that thread, the change to $PATH was agreed on as a
long-term workaround for preserving scripts and muscle memory.

Regards,
Jonathan

[1] In practice: the git wrapper adds GIT_EXEC_PATH to the $PATH and
traditional commands rely on finding it there.  For example, when
git-<command> is a shell script, it will tend to begin by reading in
some useful functions by running ". git-sh-setup", which relies on
git-sh-setup lying on the $PATH.
