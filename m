From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Sat, 10 Jul 2010 14:57:35 -0700 (PDT)
Message-ID: <m3lj9jknlr.fsf@localhost.localdomain>
References: <20091230065442.6117@nanako3.lavabit.com>
	<20091229223123.GA12965@vidovic>
	<20091230121238.6117@nanako3.lavabit.com>
	<20100710065549.GA24296@localhost> <20100710214050.GA3680@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 10 23:57:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXi3L-0005pB-Um
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 23:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959Ab0GJV5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jul 2010 17:57:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57521 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634Ab0GJV5i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jul 2010 17:57:38 -0400
Received: by fxm14 with SMTP id 14so1726342fxm.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 14:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=exjEIuMcTIIx9Iz7JtYSCmWGWoiQD9Jzuo2sXbi+Pbk=;
        b=Svl5qiBEbLSMtjbDSanTVlgrRoCEGT0rrK0Hjx2Egnt4usWSzvnN1PdOjWUrkBu607
         V/yoyGYjJmQyaT6gMSJgLEDWXRMRagfpv45//aeFbK8+CZe8JQS7VvXAGUXALkGYCQXG
         S8u0xVEB762Gj3aJGbCN9o8LmBdPLGckltSyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=gE+wGQ/399s4Sr6R8rfUFfHrnlkIDWF9x6OX/kLB3B3jUmfXlYW29dvtD+rHEzHUvM
         YnmJ2lEsN+Ru+gz+BRsQSa0zmXj/LgLnpVTR959ijvrRfRFvcAxdnm/gI8vD1nm7PTXC
         2pyEeUT/dT6jXjTO7+AMr0tHXLuO9++KUwwyg=
Received: by 10.223.114.194 with SMTP id f2mr9779353faq.95.1278799056612;
        Sat, 10 Jul 2010 14:57:36 -0700 (PDT)
Received: from localhost.localdomain (aeho219.neoplus.adsl.tpnet.pl [79.186.196.219])
        by mx.google.com with ESMTPS id s17sm5177011faa.45.2010.07.10.14.57.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 14:57:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o6ALuoqI025355;
	Sat, 10 Jul 2010 23:57:00 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o6ALuH9x025347;
	Sat, 10 Jul 2010 23:56:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100710214050.GA3680@burratino>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150732>

Jonathan Nieder <jrnieder@gmail.com> writes:
> Clemens Buchacher wrote:
> 
> >          Maybe the real solution is a reflog for deleted branch
> > heads, rather than being too careful about whether or not a branch
> > can be deleted.
> 
> Yes, I think so.  Would there be any bad side effects to this?
> 
> diff --git a/refs.c b/refs.c
> index b540067..7ed0154 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1084,7 +1084,6 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
>  	 */
>  	ret |= repack_without_ref(refname);
>  
> -	unlink_or_warn(git_path("logs/%s", lock->ref_name));
>  	invalidate_cached_refs();
>  	unlock_ref(lock);
>  	return ret;

It's unfortunately not so easy.  The problem you have to solve is D/F
conflict: if you have 'foo/bar' branch, you can't create 'foo' branch,
but after deleting 'foo/bar' you want to be able to create 'foo'
branch and reflog for 'foo' branch.

Therefore there were ideas for various "Attic"-like areas for reflogs
for deleted branches...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
