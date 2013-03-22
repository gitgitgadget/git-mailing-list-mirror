From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: feature request - have git honor nested .gitconfig files
Date: Fri, 22 Mar 2013 11:22:11 -0700
Message-ID: <20130322182211.GD12223@google.com>
References: <CAM2RUGOOWnxRd2=04-NmKTC+tvnCD=ebgmmiexHas5bwyYrm4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Josh Sharpe <josh.m.sharpe@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 19:22:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ6c0-0004X2-3S
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 19:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422690Ab3CVSWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 14:22:17 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:53712 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422649Ab3CVSWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 14:22:16 -0400
Received: by mail-pb0-f49.google.com with SMTP id xa12so3271900pbc.36
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 11:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bpBUIMGKgF1xONymq6UkK3eN3sEIu7eK0BAyVBxNS00=;
        b=Z9CvhcMtvf3BE6LGAZV65Y9OZLcDbmHYqee9Tw6ge4XNBMDVNbExu0LTBG1GN1YoKL
         yATH5UTuOe1iet9t65+U++NyhZOHQMSKA0EmKCSx1m23vumkrsGP1mTz+hAz02C76hjI
         K/jE1sMQugCRbiwCqf1TGcFiCDPOl9r9xP55Kh/4g3GAcNPAgQOHxOCl0HPZNkaSeRF2
         Aeja3O54p0dtYjkANeNkOCSIgiavFbvd0ZYEi+t3A1XVHxDPSI8JLrzhXzjH0CTi6RiU
         bSx6+15iNwhTkyz/ImmXkZknHt3MwySJ2zQXVd8nbNSqLrsnVabfYWtZhxBDhDSwsgrs
         c04A==
X-Received: by 10.66.228.225 with SMTP id sl1mr3195235pac.54.1363976535898;
        Fri, 22 Mar 2013 11:22:15 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ti8sm3224646pbc.12.2013.03.22.11.22.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 11:22:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAM2RUGOOWnxRd2=04-NmKTC+tvnCD=ebgmmiexHas5bwyYrm4w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218830>

Hi Josh,

Josh Sharpe wrote:

> For example, I have my ~/.gitconfig that has one email address in it,
> but I also have multiple repos inside ~/dev which I want to use a
> different email address for.  The only way to do that now is to edit
> all of these: ~/dev/*/.git/conf -- and there are lots of them, and new
> repos get added all the time - and I forget.

A couple of ideas using existing git features:

 - A wrapper script around "git init" can take care of setting up the
   shared configuration appropriately based on the repository path.

 - The extra configuration can be applied on a per-cwd instead of a
   per-repository basis.  Some shells provide a PROMPT_COMMAND
   facility that can be used to run a command (for example set up
   environment) each time the prompt is displayed.  A PROMPT_COMMAND
   could set the environment variable EMAIL or GIT_EMAIL based on the
   value of $PWD.

Room for improvement:

 * A new repository can be created by "git init" or "git clone" and
   the path where the repository will live is not immediately obvious
   from the command line, so setting up thorough wrappers is not
   actually that easy.

   So this sounds like a good place to provide a hook.  (It could be
   called new-repository or something.)

 * Maintaining configuration per repository to record a rather simple
   is more complicated than ideal.  It would be easier to understand
   the configuration if ~/.gitconfig could spell out the rule
   explicitly:

	[include]
		path = cond(starts_with($GIT_DIR, ~/dev/),
			    ~/.config/git/dev-config,
			    ~/.config/git/nondev-config)

   This means supporting an extension language in the config file.
   It sounds hard to do right, especially considering use cases like
   "User runs into trouble, asks a privileged sysadmin to try running
   a command in her untrusted repository", but it is worth thinking
   about how to do.

 * The "Includes" facility is annoyingly close to being helpful.
   An include.path setting from ~/.gitconfig cannot refer to $GIT_DIR
   by name.

Hope that helps,
Jonathan
