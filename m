From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Tue, 23 Sep 2008 12:06:37 -0700
Message-ID: <20080923190637.GJ3669@spearce.org>
References: <20080923140144.GN21650@dpotapov.dyndns.org> <20080923153148.GI3669@spearce.org> <20080923171209.GP21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 21:08:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiDEj-00009j-5K
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 21:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbYIWTGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 15:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbYIWTGj
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 15:06:39 -0400
Received: from george.spearce.org ([209.20.77.23]:55670 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbYIWTGi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 15:06:38 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E659D3835F; Tue, 23 Sep 2008 19:06:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080923171209.GP21650@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96584>

Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Tue, Sep 23, 2008 at 08:31:48AM -0700, Shawn O. Pearce wrote:
> > 
> > I wonder, should this be controlled by an environment variable?
> > 
> > Given your description of the feature it seems to be more a property
> > of the specific repository, as it is based upon where the repository
> > lives within the Cygwin namespace.  Should this be controlled instead
> > by say a "core.cygwinnativestat = true" configuration property?
> 
> I am not sure that you will find many people who will want to set this
> option per repository, yet Git has the configuration file, and I agree
> it is better to place it there.

If you want it globally you can do:

  git config --global core.cygwinnativestat true

and then disable it on a per-repository basis if you and a specific
repository which has this inner mount problem:

  git config core.cygwinnativestat false

Which is a lot more powerful than an environment variable.
 
> However, this option is Cygwin specific, so I am not sure where it
> should be read. Should I place it in git_default_core_config like
> this:
> 
> #ifdef __CYGWIN__
> 	if (!strcmp(var, "core.cygwinnativestat")) {
> 		cygwin_native_stat = git_config_bool(var, value);
> 		return 0;
> 	}
> #endif

I would have the two initial stat functions swap themselves out with
the default Cygin stat implementations, run a parse over the config
to load that one bool, then install the proper implementations based
upon its value.  Hence all Cygwin code is kept inside of the Cygwin
compat code, and no #ifdef is necessary

Of course that config file parse can only happen after the repository
has been entered, which means you need to somehow rely on the real
Cygwin stat functions until setup_git_directory() has completed,
and then on the next stat call (re)parse the config and swap the
implementation.

-- 
Shawn.
