From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: Fixed handling of file names with spaces
Date: Sat, 15 Jan 2011 09:35:32 -0500
Message-ID: <20110115143532.GB31622@arf.padd.com>
References: <AANLkTi=Cp=FCuJdthr7JfML6jdNzUiDAUPjrWpTQfWGk@mail.gmail.com>
 <1294944715-5647-1-git-send-email-jerzy.kozera@gmail.com>
 <m28vyncffu.fsf@igel.home>
 <A0F152FE-C659-4F9B-9625-505AA5DAF942@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org,
	gitster@pobox.com, msclrhd@googlemail.com
To: Jerzy Kozera <jerzy.kozera@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 15 15:35:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pe7EG-0003Or-4M
	for gcvg-git-2@lo.gmane.org; Sat, 15 Jan 2011 15:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358Ab1AOOfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 09:35:37 -0500
Received: from honk.padd.com ([74.3.171.149]:50028 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966Ab1AOOfg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 09:35:36 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id A4F1E134;
	Sat, 15 Jan 2011 06:35:34 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 7D5F631958; Sat, 15 Jan 2011 09:35:32 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <A0F152FE-C659-4F9B-9625-505AA5DAF942@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165146>

jerzy.kozera@gmail.com wrote on Fri, 14 Jan 2011 22:45 +0000:
> On 14 Jan 2011, at 22:01, Andreas Schwab wrote:
> > Can those file names also include a double quote or a backquote or a
> > dollar sign?
> 
> 
> Double quote and backquote get escaped by git so they are not a problem:
> $ git diff-tree -r HEAD^ HEAD
> :000000 100644 0000000000000000000000000000000000000000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 A	"\" \\ $"
> 
> But as you can see above, the dollar sign remains intact, so it needs to be handled as well - patch below takes it into account.
[..]
> -    p4_system("reopen -t %s %s" % (p4Type, file))
> +    p4_system("reopen -t %s \"%s\"" % (p4Type, file))

These changes are important for correctness.  Thanks for fixing
them.

It is kind of ugly to have to do file escaping all over the
source.  I'd rather see all the os.system() calls go away, in
favor of subprocess.Popen().  You can use the latter without
going through the shell at all, hence no escapes are needed.
If you feel ambitious, this would be a nice fix.

Spaces can happen in depot paths too.  That isn't handled
current.  All the p4Cmd and p4CmdList calls that work on
depotPaths should avoid going through the shell too.

But at least what you have done already should go in.  If you
feel adventurous, addressing these other space-related issues
would be nice too.

		-- Pete
