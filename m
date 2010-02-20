From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: fix bug in symlink handling
Date: Sat, 20 Feb 2010 09:05:00 -0500
Message-ID: <20100220140500.GA23423@arf.padd.com>
References: <6682cfcf1002160044i7aacd1b0t7bb351380b1bd27c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Simon Hausmann <simon@lst.de>, Luke Diamand <luke@diamand.org>
To: Evan Powers <evan.powers@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 15:12:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Niq4X-0007rW-4c
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 15:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742Ab0BTOMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 09:12:36 -0500
Received: from honk.padd.com ([209.17.171.228]:42168 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755574Ab0BTOMg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 09:12:36 -0500
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Feb 2010 09:12:36 EST
Received: from arf.padd.com (pool-71-111-229-253.rlghnc.dsl-w.verizon.net [71.111.229.253])
	by honk.padd.com (Postfix) with ESMTPSA id 8754978C09C;
	Sat, 20 Feb 2010 06:05:02 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id DD74231AEA; Sat, 20 Feb 2010 09:05:00 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <6682cfcf1002160044i7aacd1b0t7bb351380b1bd27c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140530>

evan.powers@gmail.com wrote on Tue, 16 Feb 2010 00:44 -0800:
> Fix inadvertent breakage from b932705 in the code that strips the
> trailing '\n' from p4 print on a symlink. (In practice, contents is of
> the form ['target\n', ''].)
> 
> Signed-off-by: Evan Powers <evan.powers@gmail.com>

Acked-by: Pete Wyckoff <pw@padd.com>

This was indeed an inadvertent bug introduced by that commit.
Old code just appended all the data sections so did not see the
null.  This fix works for me.

		-- Pete

> ---
> This patch Works For Me, but I didn't take the time to understand the
> entire code path so it might be equally valid to replace contents.pop()
> with contents.pop(0) and call it a day.
> 
>  contrib/fast-import/git-p4 |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index e7c4814..cd96c6f 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -967,9 +967,8 @@ class P4Sync(Command):
>          elif file["type"] == "symlink":
>              mode = "120000"
>              # p4 print on a symlink contains "target\n", so strip it off
> -            last = contents.pop()
> -            last = last[:-1]
> -            contents.append(last)
> +            data = ''.join(contents)
> +            contents = [data[:-1]]
> 
>          if self.isWindows and file["type"].endswith("text"):
>              mangled = []
> -- 
> 1.6.6
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
