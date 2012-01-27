From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/4] config: add include directive
Date: Fri, 27 Jan 2012 18:03:38 +0100
Message-ID: <4F22D8EA.6080003@web.de>
References: <20120126073547.GA28689@sigill.intra.peff.net> <20120126073752.GA30474@sigill.intra.peff.net> <7vipjy2nbi.fsf@alter.siamese.dyndns.org> <20120126225140.GB12855@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 27 18:03:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqpDJ-0004cG-MD
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 18:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab2A0RDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 12:03:44 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:60837 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab2A0RDo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 12:03:44 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate03.web.de (Postfix) with ESMTP id 70EA91B072306
	for <git@vger.kernel.org>; Fri, 27 Jan 2012 18:03:42 +0100 (CET)
Received: from [192.168.178.43] ([91.3.168.128]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MSJ0V-1S1Vcz0Qnb-00T19o; Fri, 27 Jan 2012 18:03:42
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <20120126225140.GB12855@sigill.intra.peff.net>
X-Provags-ID: V02:K0:TRnNzCUNZWslbvc739ncIoYy64x+oKO11T+Z7AWlhoZ
 co1KZewMee67PxRDPx/yGM6/GqNWdVYFOvonZTvDYJwTs8UUFq
 mkqMQ3cFez4RAMIESdm2SshMoohEcB2zuvWKiDVgMHzj17gnyc
 uqhbnSZn+06csRvoUwV9TL/zYYyg3MQj/l/muRT9+wFRaEPpnA
 UOcb4+E6P3GRVhRXVkzDw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189225>

Am 26.01.2012 23:51, schrieb Jeff King:
> However, I didn't think about the fact that git-submodule.sh would be
> calling git-config separately, and that is accidentally changed by my
> patch.  Even if we changed git-submodule to use "git config
> --no-includes" that would break any third-party scripts that use "git
> config" to read git-like files.
> 
> But it would be nice for callers doing "git config foo.bar" to get the
> includes by default. So maybe the right rule is:
> 
>   1. In C:
>      a. git_config() respects includes automatically.
>      b. other callers do not do so automatically (e.g., gitmodules via
>         submodule.c).
> 
>     (i.e., what is implemented by this patch)
> 
>   2. Callers of git-config:
>      a. respect includes for lookup that checks all of the "normal"
>         config spots in sequence: .git/config, ~/.gitconfig, and
>         /etc/gitconfig. These are the shell equivalent of calling
>         git_config().
> 
>      b. when we are looking in a specific file (via GIT_CONFIG or "git
>         config -f"), do not respect includes (but allow --includes if
>         the caller chooses). This specific file may be something like
>         .gitmodules. Or perhaps somebody is saying "no, I really just
>         want to know what is in _this_ file, not what the config
>         ecosystem tells me in general".
> 
> And then because of 1a and 2a, most programs should Just Work without
> any changes, but because of 1b and 2b, any special uses will have to
> decide manually whether they would want to allow includes.
> 
> Does that make sense?

To me it really does. It lets submodule.c:gitmodules_config and
"git config -f .gitmodules" behave in the same way, which is very
important for consistent behavior between the submodule script and
the submodule functionality that is already handled in c. And I don't
know of a use case for includes in .gitmodules (the main reason for
adding includes seems to be to enable users to have configuration
stored in the repo, which the .gitmodules file already is. And if it
is about having out of repo configuration blended in, .gitmodules
settings are always overridden by those in .git/config, and you can
use includes there).

The only thing I'm not so sure about is the GIT_CONFIG case. I don't
know if using this is rather a "I moved my config there, but please
respect includes there too" or a "I want git config to look at a
completely different file" use case. Probably both. But also the
question of where to look for relative paths seems not so easy to
answer for the GIT_CONFIG case, so it might be best to just disable
includes there too.
