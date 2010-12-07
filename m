From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cmd_cherry in builtin/log.c?
Date: Tue, 7 Dec 2010 11:39:23 -0600
Message-ID: <20101207173923.GA21483@burratino>
References: <AANLkTikXmc-3BBkxy-D8GNLAMXUOPghp78GpStZ-_wBW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, rene.scharfe@lsrfire.ath.cx
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 18:39:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ1Vv-0006RL-55
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 18:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738Ab0LGRji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 12:39:38 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55852 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab0LGRjh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 12:39:37 -0500
Received: by wwa36 with SMTP id 36so162339wwa.1
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 09:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=k0jbDnA9uyTAOLMPfCLWCvOgvBgdqufsvwksWEb0XJk=;
        b=e9OGW92G0XWfCfKySBoSO7cYfAsLXiwt1GXBVu1llhg80XHqFM083Anmgq/v84d/rm
         vrSYvexgVsOUgG5zovhx8/3VrXxmq0DgjZGAJLVHgUEuYUrHEm15i2wtdYNSlty+KFDO
         7/Q4oQZQ/+mmpwGGwGL0c7kOZkt7FGO3VlvNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KqGSmxn3c5iuzFivI8LvtcU8yyoAmQegGgYcNnb4DVPbobK9K0nenquKf6z5o0k75Y
         IsXW8FIsZKAaxoum5duKOlZZzyyZljNjWQkegcFWOo9L9aAXPYEUScmsw7qIU56a0J0Q
         UinWLxs9kTaTlogzvCLlMpecyNBJBP0qw8lFE=
Received: by 10.227.141.130 with SMTP id m2mr7616271wbu.125.1291743576259;
        Tue, 07 Dec 2010 09:39:36 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id y80sm3076865weq.3.2010.12.07.09.39.33
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 09:39:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikXmc-3BBkxy-D8GNLAMXUOPghp78GpStZ-_wBW@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163095>

Hi,

Thiago Farina wrote:

> I was looking into builtin/log.c to see how it does --reverse and I
> saw that cmd_cherry is there.
> 
> I'm wondering, why is it there?

Good question.  So let's check.

 $ git log --oneline -Scmd_cherry builtin/log.c
 81b50f3 Move 'builtin-*' into a 'builtin/' subdirectory

That wasn't too helpful.  Okay, okay.

 $ git log --oneline -Scmd_cherry -- builtin-log.c
 81b50f3 Move 'builtin-*' into a 'builtin/' subdirectory
 e827633 Built-in cherry

Running "git show e827633" reveals that the core of the original
script is

	for c in $inup
	do
		git-diff-tree -p $c
	done | git-patch-id |
	while read id name
	do
		echo $name >>$patch/$id
	done

while the core of the builtin version is

	get_patch_ids(&revs, &patch_id_opts, prefix);

The latter function is static, introduced by v1.4.1~12^2~5
(format-patch: introduce "--ignore-if-in-upstream", 2006-06-25).

So the answer is that "git cherry" is considered a variant on
"git log" (like format-patch, show, and whatchanged) and that it uses
"git log" internals.

Hope that helps,
Jonathan
