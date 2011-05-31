From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH] submodule add: improve message when resolving a relative
 url fails
Date: Tue, 31 May 2011 18:04:15 -0400
Message-ID: <4DE565DF.7050207@cisco.com>
References: <1306792280-12768-1-git-send-email-marcnarc@xiplink.com> <4DE541EC.7010202@web.de> <4DE548C4.2010600@web.de> <4DE5561C.3010200@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 00:04:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRX30-0002gg-Ap
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 00:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721Ab1EaWER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 18:04:17 -0400
Received: from sj-iport-2.cisco.com ([171.71.176.71]:34223 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758298Ab1EaWEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 18:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2517; q=dns/txt;
  s=iport; t=1306879456; x=1308089056;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=WzBpHaBhh3dkvzumxK+m2xlzEZ5djwJPg59ZECyr9v8=;
  b=h8g5pcNLbd2+hvCGxy6TEUGs8RGQaQrhY34hjyjGTdrMkzGXICB95hCy
   +I5WwdaQskeC00Fwe00HSSHYus9tcMCaY0bQpgUrH76E6FRFlXQOCmqbN
   Yls1ULMiOYGE0tmrl8S/hGoMs9fm8SvIn23kAOXr5mVJwM82w0hzCTbK/
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAG9l5U2tJXG//2dsb2JhbABTpiJ3iHGfJJ1Qhh4EkE+EPop4
X-IronPort-AV: E=Sophos;i="4.65,299,1304294400"; 
   d="scan'208";a="367637857"
Received: from rcdn-core2-4.cisco.com ([173.37.113.191])
  by sj-iport-2.cisco.com with ESMTP; 31 May 2011 22:04:14 +0000
Received: from [64.100.104.120] (dhcp-64-100-104-120.cisco.com [64.100.104.120])
	by rcdn-core2-4.cisco.com (8.14.3/8.14.3) with ESMTP id p4VM4DEk025073;
	Tue, 31 May 2011 22:04:13 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DE5561C.3010200@xiplink.com>
X-Enigmail-Version: 1.1.2
X-TagToolbar-Keys: D20110531180415158
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174833>

On 05/31/2011 04:57 PM, Marc Branchaud wrote:
> Thanks for the cogent explanation & patch.  I think the message could be
> improved a bit:
>
> 	Cannot resolve "../sub" relative to this repository's "origin"
> 	remote: The remote's URL is not set in .git/config
>
> However, overall I think this is a pretty fragile way to handle relative
> paths.  Consider:
>
>  - The super-repo must be a clone in order for this to work at all.

Yes, but that constraint (mostly) makes sense to me.  But if 'git
submodule add' did not initialize .git/config, this constraint could be
dropped.

>  - The super-repo cannot be checked out on a detached HEAD.

Why do you think that?  I just tried this and it worked fine for me.  I
can't think of a reason for it to fail.

>  - The current code rewrites the URL so that any relative path is either
>    rejected or munged into an absolute remote URL.

I don't see the URL getting munged away from being relative.  Can you
point to an example?

> It seems to me that this feature will only work in a fairly narrow set of
> circumstances, and even when it does work it's likely to do something
> unexpected (think of a super-repo with several remotes).

I use it this way with several remotes. 

> Back when Junio accepted the original patch, he said "If you maintain and
> serve a set related projects you need to give the users a single URL (per
> where the user is and how to reach the server)."  I'm not sure I understand
> that:  Why would the users be adding their own submodules to the
> superproject?  Wouldn't the superproject define the submodules in for them?
I am a user.  I admin a super-project for other users.  This project
lives at three remotes, remotes/public, remotes/shared and remotes/build. 

I add a new submodule to the superproject like this:

   mkdir sub && cd sub && git init
   cd ..
   git submodule add ../sub sub

This results in the new submodule being inserted into my .gitmodules
file and my .git/config:

   tail -3 .gitmodules
   [submodule "sub"]
       path = sub
       url = ../sub

   tail -2 .git/config
   [submodule "sub"]
       url = public:git/sub

I do have to make sure to push my submodule to the correct location on
each remote before pushing my new .gitmodules.

But the exact same commands work for me if I do this first and then do
'git submodule add ../sub' afterwards. 

So, I don't understand your objections.  Do you understand my use case
any better?

Phil
