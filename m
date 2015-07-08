From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 2/8] cherry-pick: treat CHERRY_PICK_HEAD and
 REVERT_HEAD as refs
Date: Wed, 08 Jul 2015 19:41:24 -0400
Organization: Twitter
Message-ID: <1436398884.4542.25.camel@twopensource.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
		 <1436316963-25520-2-git-send-email-dturner@twopensource.com>
		 <559D6208.8090607@kdbg.org> <1436382962.4542.8.camel@twopensource.com>
	 <559D92CF.7000408@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 01:41:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCyyJ-0004SG-A9
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 01:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbbGHXli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 19:41:38 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:32928 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbbGHXl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 19:41:27 -0400
Received: by qgef3 with SMTP id f3so58218286qge.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 16:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=OwJj8A16V9BrkFeChDwb1Q3bFM0d6TiAhIDtKou70/4=;
        b=cnFxAgwygEw+7bSznNfPho6SuXCPcYeVtkhM9nQegyGnBROVdVBciZDWukCKZmgugl
         K/qxGZdW+ahuntRKBJ+MIwbZZEYaAzsN8YFkE7FVbS8fPzDY5Uq0SS/+joD/krqnFY1d
         NHUTchHCZKBbVbvd3S+IbX2FnEQYrKKIpDqvXJOKTm5LWSHaJU98iR8ueMC3nQ11wEfJ
         jzGNAKGX+/muFQ+qvu6LBSfSibkhWVCbB2XHScLalyI9G3hvDuvRqR2NCZOwZ7OkM/ql
         71wktbcVggAREYeN8hrQro5/w1gYX1VqVwXHSQS8fZaFsdeL59/cPb2nor0+Co5pSUEf
         7+0A==
X-Gm-Message-State: ALoCoQl1sTqfNRo+dLkQqvM0jEIcqvj7+bltDehVYAB1MfiZRYPfRpf8xoR8EzJL21Lge8E6lvn8
X-Received: by 10.55.15.103 with SMTP id z100mr20598181qkg.7.1436398886357;
        Wed, 08 Jul 2015 16:41:26 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id y11sm2136976qky.42.2015.07.08.16.41.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 16:41:25 -0700 (PDT)
In-Reply-To: <559D92CF.7000408@kdbg.org>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273719>

On Wed, 2015-07-08 at 23:14 +0200, Johannes Sixt wrote:
> Am 08.07.2015 um 21:16 schrieb David Turner:
> > On Wed, 2015-07-08 at 19:46 +0200, Johannes Sixt wrote:
> >> Am 08.07.2015 um 02:55 schrieb David Turner:
> >>> Instead of directly writing to and reading from files in
> >>> $GIT_DIR, use ref API to interact with CHERRY_PICK_HEAD
> >>> and REVERT_HEAD.
> >>>
> >>> Signed-off-by: David Turner <dturner@twopensource.com>
> >>> ---
> >> ...
> >>> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> >>> index 366f0bc..e2c5583 100644
> >>> --- a/contrib/completion/git-prompt.sh
> >>> +++ b/contrib/completion/git-prompt.sh
> >>> @@ -415,9 +415,9 @@ __git_ps1 ()
> >>>    			fi
> >>>    		elif [ -f "$g/MERGE_HEAD" ]; then
> >>>    			r="|MERGING"
> >>> -		elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
> >>> +		elif git rev-parse --quiet --verify "CHERRY_PICK_HEAD" >/dev/null; then
> >>>    			r="|CHERRY-PICKING"
> >>> -		elif [ -f "$g/REVERT_HEAD" ]; then
> >>> +		elif git rev-parse --quiet --verify "REVERT_HEAD" >/dev/null; then
> >>>    			r="|REVERTING"
> >>>    		elif [ -f "$g/BISECT_LOG" ]; then
> >>>    			r="|BISECTING"
> >>
> >> We are trying very hard not to spawn any new processes in __git_ps1().
> >> So, I raise a moderate veto against this hunk.
> >
> > Do you have an alternate suggestion about how to accomplish the same
> > thing? Here are my ideas:
> >
> > We could special-case CHERRY_PICK_HEAD and REVERT_HEAD to be files
> > independent of the ref backend, but that tends to complicate the
> > backends.  I think this is a mistake.
> >
> > We could reduce the number from two to one by providing a new
> > git-am-status command which outputs one of "CHERRY-PICKING",
> > "REVERTING", or "" (or maybe it would also handle rebase and am).  We
> > could also generalize it to "git-prompt-helper" or something by moving
> > that entire bunch of if statements inside.  This would replace calls to
> > "git describe".
> >
> > But you probably have a better idea.
> 
> Isn't it mere coincidence that the content of these two files looks like 
> a non-packed ref? Wouldn't it be better to consider the two akin to 
> MERGE_HEAD (which is not a ref because it records more than just a 
> commit name)?

There appears to be a bit of code that assumes they can be read as refs,
and the tests test this functionality.  Indeed, I wrote most of this
code by replacing the backend and fixing failing tests.

At least some people seem to use the rev-ness of CHERRY_PICK_HEAD:
https://mnaoumov.wordpress.com/2014/12/03/bulk-cherry-picking-process-and-magic-ref-cherry_pick_head/

So I think it's best to keep the feature.
