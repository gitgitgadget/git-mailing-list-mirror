From: Dragos Foianu <dragos.foianu@gmail.com>
Subject: Re: [BUG] Segfault on git describe
Date: Wed, 19 Mar 2014 22:34:29 +0000 (UTC)
Message-ID: <loom.20140319T224201-156@post.gmane.org>
References: <532975FB.9030803@mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 23:35:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQP4d-0004Kw-Og
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 23:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049AbaCSWez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 18:34:55 -0400
Received: from plane.gmane.org ([80.91.229.3]:54824 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753890AbaCSWey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 18:34:54 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WQP4X-0004CY-Mg
	for git@vger.kernel.org; Wed, 19 Mar 2014 23:34:53 +0100
Received: from 109.100.93.176 ([109.100.93.176])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 23:34:53 +0100
Received: from dragos.foianu by 109.100.93.176 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 23:34:53 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.100.93.176 (Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Firefox/24.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244504>

Sylvestre Ledru <sylvestre <at> mozilla.com> writes:

> 
> Hello,
> 
> Trying to do some stats using the Firefox git repository
> (https://github.com/mozilla/gecko-dev), I found a bug
> on git describe. The following command will segfault:
> git describe --contains a9ff31aebd6dbda82a3c733a72eeeaa0b0525b96
> 
> Please note that the Firefox history is a pretty long and this commit
> date is 2001.
> 
> I experience this issue with the git version, and Debian packages
> (1.9.0-1 and 2.0~next.20140214-2)
> 
> As attachment, the backtrace. I removed about 87250 calls to the
> name_rev function. I guess that is a potential source of problem.
> 
> Full is available here:
> http://people.mozilla.org/~sledru/bt-git-on-ff.txt (21 MB)
> 
> I am available to test patches if needed.
> 
> Thanks,
> Sylvestre
> PS: I am not registered, please cc me.

Hello,

The name_rev function recursively calls itself which is why the backtrace is
so big. Unfortunately, for repos with long histories it can lead to Stack
Overflows. This is pretty much what happened in your case.

I tested it on my computer and I get the same results. I managed to get it
working by doubling my default stacksize:

ulimit -S -s 16192

Considering your project is a very large one and merely allocating a few
more resources fixes the problem, I'm not sure it warrants rewriting the
function to use less stack. You will have to wait for one of the maintainers
to give you a definitive answer.

All the best,
Dragos
