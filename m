From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb.perl suggestion
Date: Thu, 08 Jul 2010 08:30:54 -0700 (PDT)
Message-ID: <m339vum1od.fsf@localhost.localdomain>
References: <19509.14862.368282.470934@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Thu Jul 08 17:31:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWt4h-0004Wx-70
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 17:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756196Ab0GHPbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 11:31:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56569 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240Ab0GHPbg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 11:31:36 -0400
Received: by bwz1 with SMTP id 1so507531bwz.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=uEWIyHX2KM/CjklQ/bHWloqFR8gDHbm01pulE5sjg5w=;
        b=L3GW9VKMvKc1RLoaVci6uuTLsn+Y7yVpoWmr9+BNObi28DdaMCgLQWqliW+DRktK3c
         WAj1wipnIH6lq2GP7r7ILdPoPEjURCwMNUuoqRCkPAefKmaEfL5hTcpSPZfvzlpikxG7
         rIAApAFtUpWM0EBh0bbFEwCpV8nw55Mm6qbtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=A9bRUCKHFr6wR4yryDy8YX/TfsCHy2pMllOG/82u+l2oEMeIXUc2O8kSUokPwJeVv0
         CmvOhBhsnp+dS7pVZnGtfOwIRGeIXAa8QOg0h28xz2+Z5qkqqq666T2hfBUcjGStWUUt
         vPNYKFHH5AR29RY8Z3b+Ef8Fy5tg1Uqph8yTs=
Received: by 10.204.82.91 with SMTP id a27mr6381517bkl.3.1278603058359;
        Thu, 08 Jul 2010 08:30:58 -0700 (PDT)
Received: from localhost.localdomain (abvu212.neoplus.adsl.tpnet.pl [83.8.218.212])
        by mx.google.com with ESMTPS id x19sm33449438bkv.21.2010.07.08.08.30.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 08:30:54 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o68FUMGQ017423;
	Thu, 8 Jul 2010 17:30:33 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o68FUBwR017420;
	Thu, 8 Jul 2010 17:30:11 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <19509.14862.368282.470934@winooski.ccs.neu.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150583>

Eli Barzilay <eli@barzilay.org> writes:

> Currently, if I go to
> 
>   http://server/gitweb/project/<commit-sha1>
> 
> I get to the shortlog page, which is not as useful as the commit
> page.  But changing this to have a default `commit' action isn't right
> either since the shortlog is more appropriate with
> 
>   http://server/gitweb/project/<commit-sha1>..<other-commit-sha1>
> 
> So how about changing this:
> 
>   $input_params{'action'} ||= "shortlog";
> 
> to this:
> 
>   $input_params{'action'} ||= ((defined $parentrefname) ? "shortlog" : "commit");
> 
> which will make the first case show the commit, and the second show
> the shortlog?

Thanks for noticing and informing about this issue.

Unfortunately for having a fast fixup, you have hit upon larger issue.
Namely how gitweb guesses action if there isn't provided one.

Currently there is one set of rules for evaluate_path_info (used with
path_info URL like e.g. http://server/gitweb/project/<sha1>), and
another in dispath() after evaluating path info and query params (query
params version would be http://server/gitweb?p=project;h=<sha1>).

  path_info                    | action
  -----------------------------+--------------------------
  object:dirname/              | tree
  object:filename              | blob_plain
  objectA..objectB:filename    | blobdiff_plain
  object                       | shortlog
  objectA..objectB             | shortlog

  query params                 | action
  -----------------------------+---------------------------
  h=object                     | git_get_type(object)
  hb=object;f=filename [*]     | git_get_type(object:filename)

[*] There is no optimization that if it ends in '/' it is 'tree' object,
and if it is not, then it is 'blob' (file) object.

Finally if project is defined, default action is 'summary', and if it
isn't then default action is 'project_list'.


So your proposed solution is good enough, but perhaps better would be to
leave 'action' unset if there is no parent info?  Then dispatch would
guess action, instead of doing it in less sophisticated way in
evaluate_path_info().

-- 
Jakub Narebski
Poland
ShadeHawk on #git
