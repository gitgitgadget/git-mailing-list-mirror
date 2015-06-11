From: David Aguilar <davvid@gmail.com>
Subject: Re: "git difftool" is not working as expected during MERGING
Date: Thu, 11 Jun 2015 02:22:06 -0700
Message-ID: <20150611092205.GA93332@gmail.com>
References: <CALzBCsGSJJZhWRoSVW6-tb+grxnFTOWSQ8kQFmwk05sC-30Q6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Bossert, Andre" <anb0s@anbos.de>
X-From: git-owner@vger.kernel.org Thu Jun 11 11:22:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2ygl-0002Id-Oz
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 11:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbbFKJWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 05:22:15 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:33183 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbbFKJWM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 05:22:12 -0400
Received: by qcnj1 with SMTP id j1so394402qcn.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 02:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jNnEn4RoH2aMvrKyCO7uDdp2tkuk2Jt1OHqcfUqbTXU=;
        b=cmArhZSz7RdXz3ZfLF6/WzxrV63Gy6//Nsw6UnERDed5rp3dQaKy9wBKcqBUMo3K99
         Xzj+KoL2IrD1ySWrtMu/uyByNbvSCUuCXxRLimjhLzNlV0cCN8vDWZ8/EoEwmBlk/jh6
         yx3VA+XBaDwnqafkxPInB3w0YGWcQpFt8b7B7UFryGw9HIw18GYjzLBjmDo1MafoEoa8
         aWF+L1aOTGUqGG5oPX3xbqqfSlr+C2cK+Ymz9HqEDGmukq7BFe/sW4KiN3B0PalsfuBd
         thRfsgkjTaFmIX7ZR0urd3Bfz1Zom7Fm58IOvWB569Ni+tciWOCStiXttrZdBPLv8xNy
         UadA==
X-Received: by 10.55.16.165 with SMTP id 37mr16264288qkq.76.1434014531903;
        Thu, 11 Jun 2015 02:22:11 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id 68sm25016qgk.9.2015.06.11.02.22.10
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jun 2015 02:22:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALzBCsGSJJZhWRoSVW6-tb+grxnFTOWSQ8kQFmwk05sC-30Q6w@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271377>

On Wed, Jun 10, 2015 at 03:12:21PM +0200, Bossert, Andre wrote:
> Hello,
> 
> i've tested "git difftool" with -t --ext-cmd and other options to see
> my diff with external tools, but it always show internal text-diff in
> console. The same tests with "git mergetool" working as expected. I've
> compared (nanually reviewed) git-mergetool.sh with git-difftool.pl and
> see that difftool is mixed / shared implementation with normal "git
> diff" command. So during MERGING state there is no possibility to call
> external difftool with this command. Any ideas why this was
> implemented this way?
> 
> -- 
> Regards
> Andre (anb0s)
> eMail: anb0s@anbos.de

The "why" behind this behavior is likely, "historical reasons".

The behavior you described is an unfortunate side-effect of how
it's implemented under the hood.  As you discovered, difftool is
built upon git-diff's GIT_EXTERNAL_DIFF feature.

That feature is not invoked when the index contains multiple
stages (i.e. when merging) and the combined diff is printed
instead.

A logical extension to the GIT_EXTERNAL_DIFF machinery might be
something like supporting a GIT_EXTERNAL_MERGE_DIFF variable to
handle the 3-way case.  We could then plug this edge case by
creating a new handler that reuses the mergetool code[1].

Alternatively, we could make "git diff" stricter and teaach it
to die() when doing a mergy diff and GIT_EXTERNAL_DIFF is set.
That might break existing setups, though, so having a new
feature does seem preferable over making it stricter.

As you mentioned, using "git mergetool" works.  That's because
mergetool is the intended tool for that use case.  The fact that
difftool prints a combined diff when when your worktree is in
the middle of a conflicted merge is simply an unpolished edge
case.

If you've already resolved all of your conflicts, and everything
is staged, then "git difftool --staged" will work too.

Let me know if you have any questions.  If you're interested in
implementing the idea described in [1] then I'd be happy to help
review and test the code, but for now you can probably just use
"git mergetool".

cheers,
-- 
David
