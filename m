From: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: [PATCH v10 3/4] add `config_set` API for caching config-like
 files
Date: Fri, 18 Jul 2014 12:03:52 +0200 (CEST)
Message-ID: <912531111.2607532.1405677832726.JavaMail.zimbra@imag.fr>
References: <1405675142-20300-1-git-send-email-tanayabh@gmail.com> <1405675142-20300-4-git-send-email-tanayabh@gmail.com> <1849775492.2606791.1405676407530.JavaMail.zimbra@imag.fr> <53C8EE71.5000703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 12:04:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X851Y-0007hT-Of
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 12:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbaGRKEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 06:04:05 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39548 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755203AbaGRKEB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 06:04:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6IA3qJN019452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 Jul 2014 12:03:53 +0200
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6IA3qQt020500;
	Fri, 18 Jul 2014 12:03:52 +0200
In-Reply-To: <53C8EE71.5000703@gmail.com>
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF30 (Linux)/8.0.6_GA_5922)
Thread-Topic: add `config_set` API for caching config-like files
Thread-Index: 4xaLD4wG7/RvkvxtFbdwYqAcsw9eTQ==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 18 Jul 2014 12:03:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6IA3qJN019452
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1406282635.93273@6V9IWdnEwMYC3E5BJVzIwQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253808>

I think my proposal is a fix, and yours is a workaround. Semantically, calling setup_git_directory changes the config, so it should invalidate the cache. Your proposal consists in not filling-in the cache before it is invalidated, which works, but isn't very future-proof: if anybody fills-in the cache before the setup in the future, it will break it.

Now, both options can go together, then moving the check_pager_config call after setup_git_directory would avoid re-filling-in the cache. Intuitively, I'd say it's even needed in case git is started from a subdirectory and the .git/config contains pager-relevant stuff, but there might be complications.

----- Original Message -----
> 
> 
> On 7/18/2014 3:10 PM, Matthieu Moy wrote:
> > ----- Original Message -----
> >>  Documentation/technical/api-config.txt | 137 +++++++++++++++++
> >>  cache.h                                |  30 ++++
> >>  config.c                               | 263
> >>  +++++++++++++++++++++++++++++++++
> >>  3 files changed, 430 insertions(+)
> > 
> > I think the added call to git_config_clear() I proposed yesterday in
> > setup_git_directory_gently_1 should be part of this patch (with the
> > associated comment), just like this call:
> >
> 
> Oh, my bad, I thought you meant that I incorporate it with the
> git_config_raw() patch.
> I wanted to ask, can we call setup_git_directory_gently() earlier in
> execv_dashed_external()
> in git.c, which calls check_pager_config() for the first time which causes
> the
> incomplete cache to formed.
> If we can do it, we won't have to clear the cache every time
> setup_git_directory_gently_1()
> is called.
> 
> >> @@ -1707,6 +1967,9 @@ int git_config_set_multivar_in_file(const char
> >> *config_filename,
> >>  	lock = NULL;
> >>  	ret = 0;
> >>  
> >> +	/* Invalidate the config cache */
> >> +	git_config_clear();
> >> +
> >>  out_free:
> >>  	if (lock)
> >>  		rollback_lock_file(lock);
> > 
> > I have limited access to my email and no way to apply the patches today, so
> > I can't do a detailed review. But other than the remark above, I guess the
> > patch series is now all right and ready to cook in pu.
> > 
> 

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
