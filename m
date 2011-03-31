From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] reset: update help text
Date: Thu, 31 Mar 2011 13:42:46 -0500
Message-ID: <20110331184246.GA19264@elie>
References: <1301404805-12095-1-git-send-email-pclouds@gmail.com>
 <20110329210457.GA14031@elie>
 <AANLkTiknvWE9Fe3u88Jbis4Cgxd5ubqaR6MzYOJZ-AtM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 20:43:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Mpt-0000uu-Lb
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 20:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759007Ab1CaSnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 14:43:08 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56920 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758919Ab1CaSnG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 14:43:06 -0400
Received: by gwaa18 with SMTP id a18so1092831gwa.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 11:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=B9s4XSdCwrIQ7fOvd3mxQtdL/TLd7om570uy4qS9Cgw=;
        b=hKTLnmK+RTYkDG0+Aj20QaEvktiMKWRzRfUSq39MwUY8iRpHdwTFbesrOokADuE41w
         7orOXGOclUQwrFFkCxmjg6jcboV9twpSknInxmW9w5AB6BOAjStYaKApm/khw18NCoDI
         EThAa+sOHdyWdoPsv8+UnYnftZh6/z9BdK+sQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZIktMo4URlHugcw9m0U3+KdoO+vi8Ftf93We05Gbe+D3R8uRU827FD9DMrt05no5FJ
         F8giWjR/XAe8EMqN9NQfNOd5I9WfaCrZ64fx30PDgb4zRH0KeBrr0kHIKyQXhGAFyQqs
         ENnqWJY3TxHkKAn+XIiUr6zA3mj3eDf5MYa+0=
Received: by 10.150.74.20 with SMTP id w20mr2870449yba.228.1301596984524;
        Thu, 31 Mar 2011 11:43:04 -0700 (PDT)
Received: from elie (adsl-68-255-107-98.dsl.chcgil.ameritech.net [68.255.107.98])
        by mx.google.com with ESMTPS id m12sm2904327ybn.12.2011.03.31.11.43.01
        (version=SSLv3 cipher=OTHER);
        Thu, 31 Mar 2011 11:43:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTiknvWE9Fe3u88Jbis4Cgxd5ubqaR6MzYOJZ-AtM@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170510>

Nguyen Thai Ngoc Duy wrote:

> To be honest, I have no idea what the above describes. I read 9bc454d
> (reset: add option "--keep" to "git reset" - 2010-01-19) and figured
> that --keep is like --merge except that "git diff" before and after
> the reset is exactly the same, is it? I have never used --keep before.

I use "git reset --keep" to

 - discard a bad commit: git reset --keep HEAD^
 - start working against a different commit:

	git checkout -b topic &&
	... hack hack hack without committing ... &&
	: "oops, I thought I was on master but I was somewhere else" &&
	git reset --keep master

The spirit of the thing[1] is:

 * if the diff "HEAD -> <commit>" touch paths in which we have local
   changes, error out;
 * otherwise, checkout the relevant paths from <commit> but leave the
   paths in which we have local changes alone.

which indeed means "git diff --cached" and "git diff" before and after
would be exactly the same.  But there are some edge cases, in which
the diff "HEAD -> <commit>" makes the same change we did and the
reset --keep is still allowed.

This is totally different from --merge.  The only legitimate use of
--merge is to cancel a merge you just performed, imho --- the effect
otherwise is too scary ("git add <path>; git reset --merge elsewhere"
--- bye, bye, changes made at <path>).

Hope that helps,
Jonathan

[1] Detailed semantics: for each path listed by "git diff --name-only
HEAD <commit>":

 * if the worktree, index, and HEAD match, make the index and worktree
   match <commit>.

 * otherwise, if it is "not easy" to keep local changes, error out.
   We are not going to do a three-way merge.  That is,

   - if the index matches neither HEAD nor <commit>, error out;
   - if the index matches HEAD but not the worktree, error out.

 * otherwise, it is "easy", so keep local changes.

   - if the index already matches <commit>, leave the index and
     worktree alone.
   - if the index and worktree match HEAD, make them match the
     <commit> instead.

These are the same rules used by fast-forward merges and plain
"git checkout".
