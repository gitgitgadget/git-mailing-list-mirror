From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fix support for repository directories with spaces
Date: Mon, 16 Jun 2008 18:38:02 -0700 (PDT)
Message-ID: <m3k5goon7v.fsf@localhost.localdomain>
References: <1213664977-23964-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lea Wiemann <LeWiemann@gmail.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 03:39:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8QA6-0001QT-3O
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 03:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbYFQBiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 21:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752684AbYFQBiJ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 21:38:09 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:21300 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbYFQBiI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 21:38:08 -0400
Received: by ik-out-1112.google.com with SMTP id c28so4361930ika.5
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 18:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=+tmJho1D4mbuj15qt0w3KbAy6TfENBvjW1/PsPoxISA=;
        b=fd6p0stGjMKX0OPRRdwcN53dijGYlMyPybZlan2L+IHRKrH7pRE907YzudDJgSPG99
         mCn2LygbrZEUwNUsc5W5BhE6mXIvJa/Y/emjFk0jAJaTIsjRTOqGgw8OI/homP4yW/sw
         EW5SCVEZLiSWfIomPLJDcgQ6CHBThohfPx6RQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=aqbgK2dXBbRApZCsKodtCrBd3hLh5epnZDohugxiPvJsHkQ1h90b+7J8xLduGDCs37
         iP9Fbulkn6HoBI2Tvk08eTxOHr+Y2SJ2v6bnVCphnFDNz5g/3PV89L/f4G1H2KlDe3Qd
         Ca50BoE3Y43+k27NTfrY70R/VCwvH/3080IRc=
Received: by 10.210.70.14 with SMTP id s14mr6890642eba.33.1213666683281;
        Mon, 16 Jun 2008 18:38:03 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.236.117])
        by mx.google.com with ESMTPS id c22sm9638234ika.1.2008.06.16.18.38.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 18:38:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5H1bxVS029368;
	Tue, 17 Jun 2008 03:37:59 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5H1buLo029365;
	Tue, 17 Jun 2008 03:37:56 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1213664977-23964-1-git-send-email-LeWiemann@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85256>

Lea Wiemann <lewiemann@gmail.com> writes:

> git_cmd_str does not quote the directory names without this patch.
> 
> Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
> ---
> git_cmd_str is really really bad from a security POV: Where it is
> used, command lines are passed to the shell, which (I believe) just
> *happen* to open no security holes.  Hence the function should
> ultimately go away.  However, let's make the tests work for the
> meantime while it's still there.

I'd like to do away with need for git_cmd_str(), but unfortunately it
is needed in a place where git has to form pipeline, namely in
creating externally compressed snapshot (in git_snapshot), and to
redirect stderr to /dev/null in git_object.

Perhaps we could simply do without second, but this pipeline is here
to stay (there was pipeline in git-search, but was replaced by
invoking git-log instead of rev-list | diff-tree pipeline).  And it is
not easy to create pipeline using some variant of list form of open;
if you search git mailing list archive you can find aborted (RFC only)
attempt to create pipeline safely
  http://thread.gmane.org/gmane.comp.version-control.git/76566

If you are extending Git.pm (please do not foget Cc Petr Baudis, as it
is mainly his code) for gitweb, you can try to add this.  It doesn't
have to be very generic...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
