From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Fix buffer overflow in git-grep
Date: Wed, 16 Jul 2008 15:54:20 +0400
Message-ID: <20080716115420.GD2925@dpotapov.dyndns.org>
References: <1216203345-18233-1-git-send-email-dpotapov@gmail.com> <alpine.DEB.1.00.0807161232110.8503@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 13:55:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ5bV-0002bq-Ik
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 13:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbYGPLya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 07:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbYGPLya
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 07:54:30 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:55439 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452AbYGPLy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 07:54:29 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2713183ywe.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 04:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QVYOrOtb/NDGlHZvr05wzUVPsli8h3uBybLDseMUd2k=;
        b=Ya2FqLL9PBz3Znoq+QSSz6orFMWes1In2kT2r86sMDamaAVtYHlr3L0LmBGmlnENcc
         WJ9Q74JPZiZClnIgCFJ/l1PcDugZSZYpq5DkN71U/aHX+8GGBosGvqZArS86KMNZqgm+
         f4Eojn9NKTNvxKGvirKcddErkMexjrN1jzmzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NCtUNrocR5Ij4BdoEJThoj990BsSTH9Y/7VWu0VDM6bqQ6+63TKybSgkLAhQXgXqHA
         Xpw+LgUOrOUWhhl51gbHcIZXQcoLDd6n0X1909T9USQe+MlfNIYVhaGxYCA5ulkz2W+U
         zPCIgdRajV4BPH+EO32hUwptHsUhhCQVqlLaI=
Received: by 10.103.213.10 with SMTP id p10mr822063muq.46.1216209267995;
        Wed, 16 Jul 2008 04:54:27 -0700 (PDT)
Received: from localhost ( [85.141.237.219])
        by mx.google.com with ESMTPS id e8sm5722188muf.0.2008.07.16.04.54.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jul 2008 04:54:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807161232110.8503@eeepc-johanness>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88671>

On Wed, Jul 16, 2008 at 12:35:06PM +0200, Johannes Schindelin wrote:
> >  
> >  	while (tree_entry(tree, &entry)) {
> > -		strcpy(path_buf + len, entry.path);
> > +		int te_len = tree_entry_len(entry.path, entry.sha1);
> > +		if (len + te_len >= PATH_MAX + tn_len)
> > +			die ("path too long: %s", path_buf+tn_len);
> > +		memcpy(path_buf + len, entry.path, te_len);
> 
> That is brutal.  Does grep_tree() not work on tree objects in memory?  In 
> that case, you prevent the user from grepping, only because she is on a 
> suboptimal platform, _even if_ even that platform could cope with it.

Sure, but other git commands do not work much better in this case.
In fact, what you called as "brutal" may be considered as very
polite comparing to what other git commands did.

For instance, git show will show you nothing at all and exit with 0.
The same problem with git whatchanged. The whole history mysteriously
disappeared at that commit, and git whatchanged exited with 0 without
any error or warning... Though git log will show you all history, but
if you run it with -p then it will also exit with zero at this commit
silently like previously history do not exist at all. So, I didn't see
any reason to make git grep to work in the situation where practically
any other git command does not. I guess, they should be corrected too,
but I did not have time to look at them yet.

> 
> It's not like the path is ever used to access a file, right?
> 
> Maybe you should convert the path_buf to a strbuf instead.

It is probably a good suggestion, but I just wanted to provided a quick
fix to what may be considered as security issue. Of course, you usually
do not grep on untrusted repos, but if you did and something nasty
happened to you. I don't think it will help Git's reputation as being
secure and reliable...

Now the question is whether we really want to fix all Git commands that
do not touch the work tree to work with filenames longer than PATH_MAX?

Dmitry
