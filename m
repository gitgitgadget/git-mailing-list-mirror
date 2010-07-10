From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Sat, 10 Jul 2010 16:40:50 -0500
Message-ID: <20100710214050.GA3680@burratino>
References: <20091230065442.6117@nanako3.lavabit.com>
 <20091229223123.GA12965@vidovic>
 <20091230121238.6117@nanako3.lavabit.com>
 <20100710065549.GA24296@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Jul 10 23:41:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXhno-0001BK-NY
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 23:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab0GJVlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jul 2010 17:41:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43574 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab0GJVlf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jul 2010 17:41:35 -0400
Received: by iwn7 with SMTP id 7so3410637iwn.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 14:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1NxE/Bp96RzQIqm1uRh9Hsf5bxXeYymGwk4yU/bLyJI=;
        b=bRAcFl8xijy9z/2Uawr5N1nDHpotmHD1M3TPLclWE7zHNKCxuQhlSeQamloBusQSTp
         IR52dZbQbh9qi45SMwN0//ZziZgqTcWPjfD/XdJJ5CH4RV+hPvTM/bBe51qpyNOzmCpE
         No/wGhYoJKCSdQ4GZst0c6koo0Jp5oCfIEXDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=b2gGIgdeh8IQ6UDgtx21k33Qeua1KiK9AImR+qlDJ6v9rDVGOfMtwrUeEJBVQYTsGk
         cUAxMWXegnbstXDKiG1n5fGeRWe8akiQV81zA3L/1iKvJ2/NgszAKGB1rOMnW9Hwba4c
         wm0/jguYSWYP+hOZ30K7ZEEyV/Zhtx9+U28AU=
Received: by 10.231.39.134 with SMTP id g6mr12095709ibe.8.1278798094418;
        Sat, 10 Jul 2010 14:41:34 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm11085106ibk.9.2010.07.10.14.41.33
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 14:41:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100710065549.GA24296@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150731>

Clemens Buchacher wrote:

>          Maybe the real solution is a reflog for deleted branch
> heads, rather than being too careful about whether or not a branch
> can be deleted.

Yes, I think so.  Would there be any bad side effects to this?

diff --git a/refs.c b/refs.c
index b540067..7ed0154 100644
--- a/refs.c
+++ b/refs.c
@@ -1084,7 +1084,6 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	 */
 	ret |= repack_without_ref(refname);
 
-	unlink_or_warn(git_path("logs/%s", lock->ref_name));
 	invalidate_cached_refs();
 	unlock_ref(lock);
 	return ret;
-- 
