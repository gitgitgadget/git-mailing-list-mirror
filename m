From: David Pisoni <dpisoni@gmail.com>
Subject: Re: RFC proposal: set git defaults options from config
Date: Thu, 12 May 2011 15:36:16 -0700
Message-ID: <2235D93D-4F02-42D7-88B1-74F692D58AA5@gmail.com>
References: <D80C1130-8DE6-457E-B203-FCF25B8ED72C@gmail.com> <4DCB88C1.20105@drmicha.warpmail.net> <20110512080425.GA11870@sigill.intra.peff.net> <4DCB96F9.2020700@drmicha.warpmail.net> <20110512082210.GA16813@sigill.intra.peff.net> <4DCBF01F.9040009@warpmail.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	GIt Mailing List <git@vger.kernel.org>,
	Git Maintainer <gitster@pobox.com>
To: Michael J Gruber <drmicha@warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 13 00:36:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKeUc-0004MV-Sw
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 00:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757335Ab1ELWgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 18:36:21 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44018 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758869Ab1ELWgU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 18:36:20 -0400
Received: by pvg12 with SMTP id 12so899788pvg.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 15:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=JRBQxLRbTHyZir1dKnmOwCczEWOnD5rhgisMqOJG6TA=;
        b=HtiACQEhI9L2IGEvfimJk10+xfcBPW0BSuVc44WDdGFgZbM9joJGmNatlb8Nz6z265
         hHARI9m5aGANzmhlHodaYxN6PYK5w4yGZJhGOzpqagVfn6/RWpGA2NN2hOCPPkgI/fQ/
         oo/JAMdpkc/gNanIam/rY/KtufZn4GDuOsE5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=KZnm4foifBkwFJYR5alf9AwPkCmBSL2rNRmcn0s6P8bRBCH29h4aW3FGGFpu0HTohh
         hq8muMOYbq1NT5eHdQe6r47se4UGHWscdbRu3bTqyJDnDE7ExYlKS8P2o8ouo9kJ5P2k
         IdbsQ2d+Wd/DRNjsx4b34iRw549vaQiBE+EhU=
Received: by 10.68.64.193 with SMTP id q1mr1012557pbs.488.1305239780334;
        Thu, 12 May 2011 15:36:20 -0700 (PDT)
Received: from [192.168.1.150] (76-217-18-248.lightspeed.irvnca.sbcglobal.net [76.217.18.248])
        by mx.google.com with ESMTPS id v8sm932380pbk.95.2011.05.12.15.36.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 May 2011 15:36:19 -0700 (PDT)
In-Reply-To: <4DCBF01F.9040009@warpmail.net>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173501>

This has some interesting implications.  Consider the case at hand:
git-stash --index is a boolean switch.  It was not the default state,  
and it lacked any configuration override, so there was no '--no-index'  
switch provided.  If we make this change to git, presumably EVERY  
boolean flag like this in all the git subcommands needs to be backed  
with a '--no' counterpart.

Thinking this through a little further, there is the potential to want  
to override the configured value (in the case of non-booleans) with an  
explicit command line switch.  So now we have "precedence rules" for  
subcommand options. Probably simple to handle this for single vars,  
but harder for multivars.

My $0.02,
David

On May 12, 2011, at 7.35 , Michael J Gruber wrote:

> Mechanism
> =========
>
> I propose the following mechanism for setting default command line
> options from the config:
>
> options.<cmd> = <value>
>
> is a "multivar" in git-config speak, i.e. it can appear multiple  
> times.
> When running "git <cmd> <opts>", our wrapper executes
>
> git <cmd> <values> <opt>
>
> where <values> is determined by the following rule in pseudocode:
>
> if $GIT_OPTIONS_<cmd> is unset:
>  <values> := empty
> else:
>  for <value> in $(git config --get-all options.cmd):
>    if <value> matches the regexp in $GIT_OPTIONS_<CMD>:
>      append <value> to <values>
>
> Examples
> ========
>
> * By default, no options can be overriden from config (other than  
> those
> which have config vars already, of course).
>
> * A script which wants to protect options "foo" and "bar" of "cmd"  
> from
> being set by config sets GIT_OPTIONS_CMD="!(foo|bar)".
>
> * A script which wants to allow overriding options "foo" and "bar" of
> "cmd" by config (but nothing else) sets GIT_OPTIONS_CMD="foo|bar"
>
> NOTES
> =====
>
> * This can be done by commit_pager_choice() or by a call right after
> that in those places.
> * regexp notation/version to be decided
> * We should probably do this for long options only (and insert
> "--<value>" rather than "<value>" to spare the "--" in config).
> * We should probably do a prefix match.
> * We could use GIT_OPTIONS_<CMD>_ALLOW and GIT_OPTIONS_<CMD>_DENY  
> rather
> than rely on negated regexps (if DENY matches deny, otherwise if ALLOW
> matches allow, otherwise deny).
> * We can get rid of a few config vars then...and may need to clean up
> our option names.
>
> Taking cover...
>
> Michael
