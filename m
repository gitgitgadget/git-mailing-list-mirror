From: John Keeping <john@keeping.me.uk>
Subject: Re: Looking for pre-commit hook to check whitespace errors but not
 for all files
Date: Sat, 14 Dec 2013 16:59:15 +0000
Message-ID: <20131214165914.GJ3163@serenity.lan>
References: <1387034894.4636.9.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Dec 14 18:09:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrsiH-0003N9-UZ
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 18:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821Ab3LNRJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Dec 2013 12:09:09 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:52699 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612Ab3LNRJI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 12:09:08 -0500
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Dec 2013 12:09:08 EST
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 9378622CDE;
	Sat, 14 Dec 2013 16:59:20 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r+2iQVuFnfhj; Sat, 14 Dec 2013 16:59:20 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 4D28722BA6;
	Sat, 14 Dec 2013 16:59:16 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <1387034894.4636.9.camel@mattotaupa>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239311>

On Sat, Dec 14, 2013 at 04:28:14PM +0100, Paul Menzel wrote:
> in coreboot we try to check for whitespace errors before committing. Of
> course a pre-commit hook is the way to go, but unfortunately it is not
> so simple (at least for me) as the following requirements exist.
> 
> 1. Only the files actually committed should be checked. That means
> running `git commit -a`, abort that and then running `git commit
> some/file` should only check `some/file` for whitespace errors.
> 
> 2. There are certain files that are allowed to have whitespace errors.
> In our case these are `*.patch` and `*.diff` files which by design seem
> to contain whitespace error.
> 
> Currently the whole tree is checked, which takes a lot of time [1].
> 
> I tried to come up with a patch [2], but failed so far. Best would be to
> have
> 
>     $ git diff --check --only-committed-files --exclude "*patch$"
> 
> where I could not find a way for the last to switches.
> 
> Currently, I would use
> 
>     $ git diff-index --cached --name-only $against -- | grep -v patch$
> 
> and pass that list to some whitespace check program. Unfortunately that
> still does not fulfill the first requirement.
> 
> What am I missing to solve this elegantly?

I think you want to combine .gitattributes with something like the
diff-index above:

	$ cat >.gitattributes <<-EOF
	*.patch whitespace=false
	*.diff whitespace=false
	EOF

	$ git diff-index --check --cached $against --
