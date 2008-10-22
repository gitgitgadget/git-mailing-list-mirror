From: Deskin Miller <deskinm@umich.edu>
Subject: Re: git archive
Date: Wed, 22 Oct 2008 09:08:29 -0400
Message-ID: <20081022130829.GC2015@riemann.deskinm.fdns.net>
References: <gdmp0p$92r$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kenneth johansson <ken@kenjo.org>
X-From: git-owner@vger.kernel.org Wed Oct 22 15:15:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsdX9-0004RF-58
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 15:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbYJVNL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 09:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbYJVNL5
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 09:11:57 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:57386 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbYJVNL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 09:11:57 -0400
Received: by gxk9 with SMTP id 9so7252728gxk.13
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=sFDJqhS5YBXUuYla0Xm7675sfL6NxtrJQWluoUhdi5I=;
        b=MiR3/9Ekj0qjP9x6ubIh6bdpM+9AkKQt8LifyMNhPaheRyVpVM6XAuuIJAMqbqBkzf
         UE/8kprY4j4gAeeW+aF0/y63fxloMrO+9Fei/lIjdyXTS2MyGBBWgdYdbEZdDi20sPrE
         ZKQrhR2Eag/sw0ayS87zm6JkPNxBdvdVw+RVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=PkyPiC3GAkSlhrKD0s/ItIKorhouRyoOOMYRSSTT62KDB0UI4fKroNJ0GDaZ11L4GL
         rm63fK+STA+usVuYrN5B9JYf6gxhHfALdGk7OlKPy7RsoDhwYku03nno9AjyXCoHU+g7
         HxWsj7raTGmadpzrI07shOMoMdF64jbUSBHVM=
Received: by 10.65.155.7 with SMTP id h7mr8240188qbo.96.1224681114286;
        Wed, 22 Oct 2008 06:11:54 -0700 (PDT)
Received: from riemann.deskinm.fdns.net ([68.40.49.130])
        by mx.google.com with ESMTPS id 28sm9638885qbw.11.2008.10.22.06.11.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Oct 2008 06:11:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <gdmp0p$92r$1@ger.gmane.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98864>

On Wed, Oct 22, 2008 at 08:42:01AM +0000, kenneth johansson wrote:
> I was going to make a tar of the latest stable linux kernel. 
> Done it before but now I got a strange problem. 
> 
> >git archive --format=tar v2.6.27.2
> fatal: Not a valid object name

I had the same thing happen to me, while trying to make an archive of Git.
Were you perchance working in a bare repository, as I was?  I spent some time
looking at it and I think git archive sets up the environment in the wrong
order, though of course I never finished a patch so I'm going from memory:

After looking at the code again, I think the issue is that git_config is called
in builtin-archive.c:cmd_archive before setup_git_directory is called in
archive.c:write_archive.  The former ends up setting GIT_DIR to be '.git' even
if you're in a bare repository.  My coding skills weren't up to fixing it
easily; moving setup_git_directory before git_config in builtin-archive caused
last test of t5000 to fail: GIT_DIR=some/nonexistent/path git archive --list
should still display the archive formats.

Another vote for from me for the discussion carried on here:
http://article.gmane.org/gmane.comp.version-control.git/98800

Deskin Miller
