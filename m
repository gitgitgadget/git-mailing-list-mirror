From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Export from bzr / Import to git results in a deleted file re-appearing
Date: Fri, 13 Jul 2012 11:04:21 +0200
Message-ID: <m2pq80uj56.fsf@igel.home>
References: <87ehogrham.fsf@bitburger.home.felix>
	<20120712210138.GA15283@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felix Natter <fnatter@gmx.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 13 11:04:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Spbng-0005f0-Vq
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 11:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038Ab2GMJEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 05:04:31 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:41489 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097Ab2GMJE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 05:04:29 -0400
Received: from frontend4.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3WYSlz3Plzz3hhd1;
	Fri, 13 Jul 2012 11:05:35 +0200 (CEST)
Received: from igel.home (ppp-93-104-150-219.dynamic.mnet-online.de [93.104.150.219])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3WYSkY5smszbbyc;
	Fri, 13 Jul 2012 11:04:21 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 774AFCA2A2; Fri, 13 Jul 2012 11:04:21 +0200 (CEST)
X-Yow: ..Am I in a SOAP OPERA??
In-Reply-To: <20120712210138.GA15283@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 12 Jul 2012 17:01:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201398>

Jeff King <peff@peff.net> writes:

> On Thu, Jul 12, 2012 at 08:00:17PM +0200, Felix Natter wrote:
>
>> I am trying to move freeplane's repository (GPL-project) from bzr to
>> git, but when I do this:
>> 
>> $ mkdir freeplane-git1
>> $ cd freeplane-git1
>> $ git init .
>> $ bzr fast-export --export-marks=../marks.bzr ../trunk/ | git fast-import --export-marks=../marks.git
>> $ git checkout
>> 
>> then there are no errors, but the resulting working index is broken:
>>  freeplane-git1/freeplane_plugin_formula/src/org/freeplane/plugin/formula
>>  contains SpreadSheetUtils.java which belongs to package
>>  'org.freeplane.plugin.spreadsheet' and which is no longer in the bzr
>>  trunk that I imported!
>
> If you run only the bzr half of your command and inspect the output, you
> will see that the file in question is mentioned twice.  Once in a commit
> on "refs/heads/master" that renames into it from another file:
>
>   R freeplane_plugin_spreadsheet/src/org/freeplane/plugin/spreadsheet/SpreadSheetUtils.java
>     freeplane_plugin_formula/src/org/freeplane/plugin/formula/SpreadSheetUtils.java

That same revision also removes it, but is uses the original name for
the deletion (the bzr revision actually renames the containing
directory).  That's probably what confuses git fast-import.

Here is a test case:

bzr init
mkdir a
bzr add a
touch a/b
bzr add a/b
bzr ci -m a
bzr mv a b
bzr rm b/b
bzr ci -m b
bzr fast-export .

The output contains these lines:

R a/b b/b
D a/b

Changing the second line to D b/b fixes the bug.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
