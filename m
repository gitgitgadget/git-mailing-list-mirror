From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] shared repository settings enhancement.
Date: Fri, 9 Jun 2006 21:39:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606092131150.5498@g5.osdl.org>
References: <5A14AF34CFF8AD44A44891F7C9FF410507957896@usahm236.amer.corp.eds.com>
 <7virnam435.fsf@assigned-by-dhcp.cox.net> <7vver9lu8g.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606091743410.5498@g5.osdl.org> <7v8xo5lleo.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606092103170.5498@g5.osdl.org> <7vver9k5gg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 10 06:40:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FovGW-0005WS-9Z
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 06:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWFJEju (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 00:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWFJEju
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 00:39:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61091 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932283AbWFJEju (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jun 2006 00:39:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5A4dkgt019507
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 21:39:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5A4dj7q009804;
	Fri, 9 Jun 2006 21:39:45 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vver9k5gg.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21597>



On Fri, 9 Jun 2006, Junio C Hamano wrote:
> 
> Yes, the user can mistype "gruop", people would start making
> noises about having "world" as a synonym for "everybody", and
> the parsing becomes somewhat cumbersome, and all that trouble,
> but on the other hand that is probably the easiest to explain.

Actually, it's quite easy to parse using the git config file parsers.

Let's say that 0 means umask, 1 means group, 2 means user and 3 means 
everybody. That leaves "0/1" with the old false/true behaviour, and leaves 
umask as the default.

So we'd have

	enum sharedrepo {
		PERM_UMASK = 0,
		PERM_GROUP,
		PERM_USER,
		PERM_EVERYBODY
	};

	int git_config_perm(const char *var, const char *value)
	{
		if (!strncmp(value, "umask"))
			return PERM_UMASK;
		if (!strncmp(value, "group"))
			return PERM_GROUP;
		if (!strncmp(value, "user"))
			return PERM_USER;
		if (!strncmp(value, "world") || !strncmp(value, "everybody"))
			return PERM_EVERYBODY;
		return git_config_bool(var, value);
	}

and then in check_repository_format_version() you just have

	..
	else if (strcmp(var, "core.sharedrepository") == 0)
		shared_repository = git_config_perm(var, value);
	..

instead of git_config_bool() there, and you're done. That's not so bad, is 
it?

		Linus
