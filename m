From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 05/17] revert: Propogate errors upwards from
 do_pick_commit
Date: Tue, 12 Jul 2011 12:32:20 -0500
Message-ID: <20110712173220.GA14120@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 19:32:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qggp4-0000ox-LZ
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 19:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470Ab1GLRce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 13:32:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38624 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab1GLRcd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 13:32:33 -0400
Received: by iwn6 with SMTP id 6so4831205iwn.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 10:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zH5qE1fVEuc4rbovPnCssifcuEjR9GE61acQ0rFgAm8=;
        b=AsXeXMA5kkMXN+g/+W3Ap+FQduJDgzinhQz83HgY76LfvMR3+2W+3K2K2Pr19Nz+bU
         ab5FhK2wiLs/tF81L2xKfDNuIIBPPr8uHRn43JifdpElKm2zPWVv+VnYsuXfMjqwcTvj
         guVBVMQswEmO/ApyLWhiXNMG4zLFQFRDXzAVo=
Received: by 10.42.144.6 with SMTP id z6mr104008icu.483.1310491952527;
        Tue, 12 Jul 2011 10:32:32 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.ameritech.net [69.209.70.6])
        by mx.google.com with ESMTPS id d6sm15151106icx.13.2011.07.12.10.32.29
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 10:32:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310396048-24925-6-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176955>

Ramkumar Ramachandra wrote:

> Currently, the return value from revert_or_cherry_pick is a
> non-negative number representing the intended exit status from `git
> revert` or `git cherry-pick`.  Change this by replacing some of the
> calls to "die" with calls to "error", so that it can return negative
> values too.  Postive return values indicate conflicts, while negative
> ones indicate other errors.  This return status is propogated updwards
> from do_pick_commit, to be finally handled in cmd_cherry_pick and
> cmd_revert.

As mentioned at [1], this accurately describes the effect, but not the
motivation.  (In tricky cases like this, knowing the motivation would
help with review immensely.)

[...]
> While the full benefits of this patch will only be seen once all the
> "die" calls are replaced with calls to "error", its immediate impact
> is to change some of the "die:" messages to "error:" messages and
> print a new "fatal: cherry-pick failed" message when the operation
> fails.

I think by "die:" you mean "fatal:".

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
[...]
> @@ -373,12 +368,12 @@ static int do_pick_commit(void)
>  		 * to work on.
>  		 */
>  		if (write_cache_as_tree(head, 0, NULL))
> -			die (_("Your index file is unmerged."));
> +			return error(_("Your index file is unmerged."));

write_cache_as_tree() locks the index and does not always commit or
roll it back except on success.  Current callers aren't likely to try
to lock the index again (since they just die()), but presumably the
goal of returning error() here is to allow for callers that want to
stay alive and do something more.  How should they recover (i.e., what
is the intended API)?

Similar questions probably apply to calls to other APIs that return -1
to mean "I failed; please print an appropriate message about that and
exit".  I haven't checked carefully, since the answer to this example
could help in knowing what to look for in the others.

[1] http://thread.gmane.org/gmane.comp.version-control.git/176647/focus=176664
