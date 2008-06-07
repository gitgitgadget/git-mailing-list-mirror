From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-archive and unwanted .gitattributes
Date: Sat, 07 Jun 2008 08:47:35 -0700 (PDT)
Message-ID: <m33anpxn63.fsf@localhost.localdomain>
References: <fcaeb9bf0806070821r5ba650c2x1fef7947fc4a2de5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 17:48:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K50en-0000Yv-J7
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 17:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758324AbYFGPrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 11:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758168AbYFGPrk
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 11:47:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:39997 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756184AbYFGPrj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 11:47:39 -0400
Received: by fg-out-1718.google.com with SMTP id 19so990316fgg.17
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 08:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=4wBFhm4WAUx3tbzazEfTkxmw73ALbbqZnafQH/kL3iI=;
        b=H0O9vtcfREovR//ACaYmJCISidVY6ik2f6xBkpLeEZUGFlIqpvahFZyK5+ybnwjk5j
         FRaR/Odj3MJ734FIG8FWkuoKkIevQKhjbVt7VDkAs0ixM51Gm6iB6JCbrMy3/jUotKjW
         hdjWjncXzMAvr7Xj56AKM888eRuakEVhIMbSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=pzZ9Haar2jzlkE0fDJ/zg0SHZwCsA4/C9v+aK1D/ob5N1tf8pgVOjq2mXOGp82vzFQ
         pidqQg3bioCTPHhzvVQVlM7nsd68YYCMRM9csBZRGPWi4e4Lp6CH4DcVPcPQOomdnEyZ
         qfrjVJHRCESd4YOEsvRCCKx1PTZGFxxA1Gu70=
Received: by 10.78.171.20 with SMTP id t20mr710185hue.34.1212853656280;
        Sat, 07 Jun 2008 08:47:36 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.218.155])
        by mx.google.com with ESMTPS id 4sm3475655hud.27.2008.06.07.08.47.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Jun 2008 08:47:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m57FlBEI001507;
	Sat, 7 Jun 2008 17:47:22 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m57Fl00e001497;
	Sat, 7 Jun 2008 17:47:00 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <fcaeb9bf0806070821r5ba650c2x1fef7947fc4a2de5@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84208>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> Currently attr.c will read .gitattributes on disk no matter there is a
> real worktree or not. 

Currently .gitattributes are read _only_ from the work tree.
There isn't even infrastructure to read .gitattributes for commit
(from a tree); git-check-attr, and I guess also internal git API,
deals only with in-tree .gitattribute file.

> This can lead to strange behavior. For example when I do
> 
> mkdir a && cd a
> git init
> echo '$Format:%s$' > a
> git add a && git commit -m initial
> cd ..
> echo 'a export-subst' > .gitattributes # let's assume this is an accident.
> git --git-dir=a/.git archive --format=tar HEAD|tar xO a
> 
> I expect it to show '$Format:%s$', not "initial". git-archive should
> not bother reading that .gitattributes. I thought an
> is_inside_work_tree() check would be enough. Unfortunately, setting
> --git-dir will automatically set worktree too. Any ideas?

And it doesn't work at all for bare repositories.

I guess that might have been caused by the fact, that .gitattributes
are similar to .gitignore file; but in this they are different.  Of
course there is chicken-and-egg problem with attributes affecting
checkout...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
