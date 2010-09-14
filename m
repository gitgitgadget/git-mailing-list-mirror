From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] disallow branch names that start with a hyphen
Date: Tue, 14 Sep 2010 13:38:06 -0700 (PDT)
Message-ID: <m3eicwkqog.fsf@localhost.localdomain>
References: <20100822140801.GA6574@localhost>
	<7vsk262vla.fsf@alter.siamese.dyndns.org>
	<20100823043701.GA11822@localhost>
	<7vtyls6qa7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 22:38:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvcGd-0006XQ-9B
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 22:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414Ab0INUiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Sep 2010 16:38:10 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48299 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab0INUiI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 16:38:08 -0400
Received: by bwz11 with SMTP id 11so5917952bwz.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 13:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=FGHiJmVPGfC736ebntF/RLf85ODLVaKzE+PpX4ZVJRs=;
        b=FCL5HUQudIK/nLF1c2XWC0sgOWRvEsFqxKveFwWUBUDSc/UmpTNqWBBFO7nt+8cI6R
         Wxfh0g/OOZlU2RtwjoQyZXhAtSZLCPMsaDYSmy6Fw5wU311zMadnCCMa9tKKu04Ly4cR
         j1wtB3njISIpdkoY3J75AhQMBer9pBA9uqkeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Tt0HxJVop+bO2dD5l6mMOwrSRnxsNXyLTk6JJxm04UQ1BC6mIcG0PnX+f2hpqc1f7G
         uWcV2+LDu3axqc084QsFO+fz75lpo8pfh4hSdWz3lvTqE1xTzv+yl6r0lOBCIB8HCXcQ
         +ZCuXJUV5MtX0URIaWsCojX1HmpHvQs9mk4ps=
Received: by 10.204.160.90 with SMTP id m26mr379076bkx.45.1284496687573;
        Tue, 14 Sep 2010 13:38:07 -0700 (PDT)
Received: from localhost.localdomain (abwn161.neoplus.adsl.tpnet.pl [83.8.237.161])
        by mx.google.com with ESMTPS id s34sm576244bkk.13.2010.09.14.13.38.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 13:38:06 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8EKbUYC024843;
	Tue, 14 Sep 2010 22:37:41 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8EKb3CC024838;
	Tue, 14 Sep 2010 22:37:03 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vtyls6qa7.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156210>

Junio C Hamano <gitster@pobox.com> writes:

> Subject: disallow branch names that start with a hyphen
> 
> The current command line parser overly lax in places and allows a branch
> whose name begins with a hyphen e.g. "-foo" to be created, but the
> parseopt infrastructure in general do not like to parse anything that
> begin with a dash as a short-hand refname.  "git checkout -foo" won't
> work, nor "git branch -d -foo" (even though "git branch -d -- -foo" works,
> it does so by mistake; we should not be taking anything but pathspecs
> after double-dash).
> 
> All the codepath that creates a new branch ref, including the destination
> of "branch -m src dst", use strbuf_check_branch_ref() to validate if the
> given name is suitable as a branch name.  Tighten it to disallow such a
> name.
> 
> You can still get rid of historical mistake with
> 
>   $ git update-ref -d refs/heads/-foo
> 
> and third-party Porcelains are free to keep using update-ref to create
> refs with path component that begins with "-".
> 
> Issue originally raised by Clemens Buchacher.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
> diff --git a/strbuf.c b/strbuf.c
> index bc3a080..65b4cf4 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -399,6 +399,8 @@ int strbuf_branchname(struct strbuf *sb, const char *name)
>  int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
>  {
>  	strbuf_branchname(sb, name);
> +	if (name[0] == '-')
> +		return CHECK_REF_FORMAT_ERROR;
>  	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
>  	return check_ref_format(sb->buf);
>  }

Shouldn't it include update to Documentation/git-check-ref-format.txt?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
