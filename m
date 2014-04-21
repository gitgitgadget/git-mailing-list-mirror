From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [SECURITY PATCH] git-prompt.sh: don't put unsanitized branch
 names in $PS1
Date: Mon, 21 Apr 2014 17:07:18 -0400
Message-ID: <53558886.5080102@bbn.com>
References: <1398107248-32140-1-git-send-email-rhansen@bbn.com> <20140421202454.GA6062@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sitaramc@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 21 23:07:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcLRT-0002x4-VB
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 23:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527AbaDUVHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 17:07:52 -0400
Received: from [128.33.0.80] ([128.33.0.80]:52798 "EHLO smtp.bbn.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754467AbaDUVHu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 17:07:50 -0400
Received: from socket.bbn.com ([192.1.120.102]:40967)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WcLQs-000D2h-Od; Mon, 21 Apr 2014 17:07:18 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 92DBB3FFDD
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140421202454.GA6062@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246639>

On 2014-04-21 16:24, Jeff King wrote:
> On Mon, Apr 21, 2014 at 03:07:28PM -0400, Richard Hansen wrote:
> 
>> Both bash and zsh subject the value of PS1 to parameter expansion,
>> command substitution, and arithmetic expansion.  Rather than include
>> the raw, unescaped branch name in PS1 when running in two- or
>> three-argument mode, construct PS1 to reference a variable that holds
>> the branch name.  Because the shells do not recursively expand, this
>> avoids arbitrary code execution by specially-crafted branch names such
>> as '$(IFS=_;cmd=sudo_rm_-rf_/;$cmd)'.
> 
> Cute. We already disallow quite a few characters in refnames (including
> space, as you probably discovered), and generally enforce that during
> ref transfer. I wonder if we should tighten that more as a precuation.
> It would be backwards-incompatible, but I wonder if things like "$" and
> ";" in refnames are actually useful to people.

That's a tough call.  I imagine those that legitimately use '$', ';', or
'`' would be annoyed but generally accepting given the security benefit.

I wonder how many repos at sites like GitHub use unusual punctuation in
ref names.

Perhaps the additional character restrictions could be controlled via a
config option.  It would default to the more secure mode but
developers/repo admins could relax it where required.

If imposing additional character restrictions is unpalatable, hooks
could be used to reject funny branch names in shared repos.  But this
would require administrator action -- it's not as secure by default.

> 
> Did you look into similar exploits with completion? That's probably
> slightly less dire (this one hits you as soon as you "cd" into a
> malicious clone, whereas completion problems require you to actually hit
> <tab>). I'm fairly sure that we miss some quoting on pathnames, for
> example. That can lead to bogus completion, but I'm not sure offhand if
> it can lead to execution.

I have not looked at the completion code.

-Richard
