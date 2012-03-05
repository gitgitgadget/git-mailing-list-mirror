From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (for maint)] gitweb: Fix fixed string (non-regexp) project search
Date: Mon, 5 Mar 2012 09:59:47 +0100
Message-ID: <201203050959.47966.jnareb@gmail.com>
References: <20120228183919.26435.86795.stgit@localhost.localdomain> <201203041035.03133.jnareb@gmail.com> <7vfwdn631i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 10:00:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Tlt-0003KU-Sn
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 09:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756276Ab2CEI7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 03:59:52 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38308 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776Ab2CEI7w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 03:59:52 -0500
Received: by eekc41 with SMTP id c41so1354453eek.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 00:59:51 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.213.7.144 as permitted sender) client-ip=10.213.7.144;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.213.7.144 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.213.7.144])
        by 10.213.7.144 with SMTP id d16mr3156391ebd.54.1330937991131 (num_hops = 1);
        Mon, 05 Mar 2012 00:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=3DM16pHCMS/isK1rm2wXW+gm8VOL+a3TZtpljvMXCOo=;
        b=OYwowpoLQymK2tuXGi12CSJd2mCkaeC/GJ2jOnpS2fzlUPKp6LSURVCc+pcyzG3JVs
         hIYM5CUj9yJ0IjMNirtXtocqoNpJvnFgcO5ckfDc6DNEynpdDl2R1zV9lSc5zO80LUcR
         5s9XZsu4Qee2DTWNsXjpp4Am4LCmbTrFqn90DaEEq0dXYhBlkMhsXX8Lpa9AMqNSKgRH
         A1tf8MlsjyDrZuLEnELBKyryIz7e2MUL3E3u7SJI2zAQ4+zk49IEIiM/V71Fep7GAqVP
         dZ6aiO7OaSFw76b4NvuZeK1bQlEVxnMQfmbdc8aw+TPo4uNmPWB93kkSOYSC8q/L0Ghk
         f4hw==
Received: by 10.213.7.144 with SMTP id d16mr2378788ebd.54.1330937991006;
        Mon, 05 Mar 2012 00:59:51 -0800 (PST)
Received: from [192.168.1.13] (abwg221.neoplus.adsl.tpnet.pl. [83.8.230.221])
        by mx.google.com with ESMTPS id i10sm59323895eea.8.2012.03.05.00.59.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Mar 2012 00:59:50 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vfwdn631i.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192215>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > And here is the patch for maint
> > -->8-- -------------------------------------------------------- -->8--
> > Subject: gitweb: Fix fixed string (non-regexp) project search
> >
> > Use $search_regexp, where regex metacharacters are quoted, for
> > searching projects list, rather than $searchtext, which contains
> > original search term.
> >
> > Reported-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> > Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> > ---
> >  gitweb/gitweb.perl |   20 +++++++++++---------
> >  1 files changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index d5dbd64..e248792 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -5290,9 +5290,11 @@ sub git_project_list_body {
> >  	@projects = fill_project_list_info(\@projects);
> >  	# searching projects require filling to be run before it
> >  	@projects = search_projects_list(\@projects,
> > -	                                 'searchtext' => $searchtext,
> > -	                                 'tagfilter'  => $tagfilter)
> > -		if ($tagfilter || $searchtext);
> > +	                                 'search_regexp' => $search_regexp,
> > +	                                 'tagfilter' => $tagfilter)
> > +		if ($tagfilter || $search_regexp);
> > +	# fill the rest
> > +	@projects = fill_project_list_info(\@projects);
> 
> Hmph, didn't you already call fill_project_list_info(\@projects) before
> search_projects_list() already?

True.  Sorry about that. 

Can you fix that, or should I resend?

-- 
Jakub Narebski
Poland
