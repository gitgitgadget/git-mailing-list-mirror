From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git clone -c core.sharedRepository=group not working as expected
 (git v1.8.4 linux/osx)
Date: Tue, 24 Sep 2013 12:06:43 -0700
Message-ID: <20130924190643.GL9464@google.com>
References: <CAFGOX=UiqqeZMxY_TCdA5ns0HpWxVUHHYmUBiEg+Zr1R5ZfHVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Amit Bakshi <ambakshi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 21:06:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOXwi-0002SN-HR
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 21:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024Ab3IXTGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 15:06:48 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:63317 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291Ab3IXTGr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 15:06:47 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so4991226pdi.13
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KcEdJIcwQALIYvDTvj4j9XNGIBjF7vr8x2uqNd2fJjc=;
        b=danDvNt/dl/gdy21qs1XNWaN6Zm/kOpzO4gH9UKZ+64a8kZ7iReUd37OUosFYFBSwZ
         81vwbxl0mDaoxnCsicUtnurbapDI1Ep6ijY7OTWAmooonRF3mA10+jBcavnQJmQIkiON
         uJ0YEcKs+TpmIDVMAeVG+VBnZpxbikLcCihym8ufltwWNsnTy7KM2YNo22Fy3KK+2LfD
         i4e8SbUKwjWdg4YBY63bIKxGLZ1i+FiXJsspRj7z6h7af8nKomE8A1DEOj4GIjQhKUAC
         fPIsL5qZ+7Pyl1y0x8B1UwRrEIBq1D4kcvRBpV4Aqjq1mSDdnHEFmzuBJgfsjl6kyA3C
         Fz2w==
X-Received: by 10.66.221.8 with SMTP id qa8mr6248243pac.188.1380049607406;
        Tue, 24 Sep 2013 12:06:47 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id im8sm42588022pbc.24.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 12:06:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFGOX=UiqqeZMxY_TCdA5ns0HpWxVUHHYmUBiEg+Zr1R5ZfHVA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235308>

(cc-ing Jeff King, "git clone -c" inventor)
Hi,

Amit Bakshi wrote:

>  I'm trying to use this to create a shared repo (group r/w), but it's
> not working as expected. The help for git clone says "Set a
> configuration variable in the newly-created repository; this takes
> effect immediately after the repository is initialized, but before the
> remote history is fetched or any files checked out.", but I'm
> definitely not seeing this. Checked out files have umask applied.
>
> When I use the -c flag to git (ie, git -c core.sharedRepository=group
> clone ...) it does work as expected.

Thanks for an interesting report.

Part of the underlying problem is that unlike 'git init', 'git clone'
does not accept a --shared=(true|false|group|...) option.  Worse, it
does accept a --shared option, with a completely different meaning.
No better option names are coming immediately to mind, but perhaps
someone on the list will have ideas that could let 'git clone' and
'git init' use the same --share-repository=group option?

In any event, the lack of such an option steered you toward '-c'.

Another problem is that once the configuration is written, it is past
the point that some of the sharedrepository setting's effect would
have occured.  The repository, including worktree, object dirs, and so
on has already been created without g+w and setgid bits set.

Worse, when we write the new configuration and then re-read it, we
skip reading some repository-specific configuration
(core.{repositoryformatversion,sharedrepository,bare,worktree})
on the assumption that we should already know what their values would
be.  That assumption is now wrong.

I wonder if something like the following (just a sketch, completely
untested) would make sense.

diff --git i/builtin/clone.c w/builtin/clone.c
index 7ac677d..145a974 100644
--- i/builtin/clone.c
+++ w/builtin/clone.c
@@ -856,7 +856,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	init_db(option_template, INIT_DB_QUIET);
 	write_config(&option_config);
 
+	if (option_bare)
+		git_config_set("core.bare", "true");
+
 	git_config(git_default_config, NULL);
+	check_repository_format();
 
 	if (option_bare) {
 		if (option_mirror)
