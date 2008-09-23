From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Wed, 24 Sep 2008 00:04:56 +0400
Message-ID: <20080923200456.GR21650@dpotapov.dyndns.org>
References: <20080923140144.GN21650@dpotapov.dyndns.org> <20080923153148.GI3669@spearce.org> <20080923171209.GP21650@dpotapov.dyndns.org> <20080923190637.GJ3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 23 22:08:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiE9G-0000sd-Aw
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 22:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbYIWUFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 16:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbYIWUFE
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 16:05:04 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:50205 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbYIWUFC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 16:05:02 -0400
Received: by ey-out-2122.google.com with SMTP id 6so664858eyi.37
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 13:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=O91vW0d0KZ/pwl5Wg9JTzmCakpU852Fdd8hnEis2j7c=;
        b=ppTXVVrRi0afhrNIWDk1oQIyQ/SK5Vpju8OMN4n07HiEj3Oq10ETp1/r5YJiiUK9Zx
         3RopUxW3EctJCdSTP8mmML6ZTU/IU/r7XYM7dy/sog1uTHhDBXjXdYz9JNIAaJJyE8X+
         cc2XJ6W/7E07hMQdFhVd/80rzkAumCJvjihrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kMCNA1BdL2vugizN9BO6FybOarnQGHBWPIJxKtl5Gigcnnrywl+7O5n4bTFMVykqKD
         NsanPzXZbJNRiJMAtYlGSb2Wge2992iAtLmmztSAI61TjVUiiYFPffgxWEVMmXF+hEMY
         4L/mcr5HHJaK2H/5cmWYEeaug42GoYyEs/o7E=
Received: by 10.210.90.8 with SMTP id n8mr7138387ebb.128.1222200300958;
        Tue, 23 Sep 2008 13:05:00 -0700 (PDT)
Received: from localhost (ppp85-140-170-49.pppoe.mtu-net.ru [85.140.170.49])
        by mx.google.com with ESMTPS id 10sm3398904eyd.6.2008.09.23.13.04.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Sep 2008 13:05:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080923190637.GJ3669@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96588>

On Tue, Sep 23, 2008 at 12:06:37PM -0700, Shawn O. Pearce wrote:
> 
> and then disable it on a per-repository basis if you and a specific
> repository which has this inner mount problem:
> 
>   git config core.cygwinnativestat false
> 
> Which is a lot more powerful than an environment variable.

I already said that I completely agree that is a good idea even I don't
know the real need for having per-repository configuration in practice.

>  
> > However, this option is Cygwin specific, so I am not sure where it
> > should be read. Should I place it in git_default_core_config like
> > this:
> > 
> > #ifdef __CYGWIN__
> > 	if (!strcmp(var, "core.cygwinnativestat")) {
> > 		cygwin_native_stat = git_config_bool(var, value);
> > 		return 0;
> > 	}
> > #endif
> 
> I would have the two initial stat functions swap themselves out with
> the default Cygin stat implementations, run a parse over the config
> to load that one bool, then install the proper implementations based
> upon its value.  Hence all Cygwin code is kept inside of the Cygwin
> compat code, and no #ifdef is necessary

Do I understand you correctly that you propose to add the code like
this in compat/cygwin.c:

static int native_stat;

static int git_cygwin_config(const char *var, const char *value, void
*cb)
{
	if (!strcmp(var, "core.cygwinnativestat"))
		cygwin_native_stat = git_config_bool(var, value);
	return 0;
}

static void init_stat(void)
{
	git_config(git_cygwin_config, NULL);
	cygwin_stat_fn = native_stat ? cygwin_stat : stat;
	cygwin_lstat_fn = native_stat ? cygwin_lstat : lstat;
}

static int cygwin_stat_choice(const char *file_name, struct stat *buf)
{
	init_stat();
	return (*cygwin_stat_fn)(file_name, buf);
}

static int cygwin_lstat_choice(const char *file_name, struct stat *buf)
{
	init_stat();
	return (*cygwin_lstat_fn)(file_name, buf);
}

Dmitry
