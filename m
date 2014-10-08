From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [BUG?] `config branch.autosetuprebase true` breaks `rev-parse
 --is-inside-work-tree`
Date: Thu, 09 Oct 2014 00:34:16 +0530
Message-ID: <54358AB0.3060002@gmail.com>
References: <CAD77+gTuqbZimEK-=gXY8o4wFqOicFvnQ5MnV6Fq1npuckwYFQ@mail.gmail.com> <xmqqppe2bh1p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 21:04:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbwXI-0007w9-HL
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 21:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbaJHTE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 15:04:28 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:52004 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbaJHTE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 15:04:27 -0400
Received: by mail-pd0-f181.google.com with SMTP id z10so7223854pdj.26
        for <git@vger.kernel.org>; Wed, 08 Oct 2014 12:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5YuUYTRUAFcZA3u96ljoo6+Bqx0EGedhxcJqF5eT7rM=;
        b=Iwvi3O0JWKG2eK0JUvWKr6gji2lXPGjp0edpG5bC5o8RwWvVP8o17ChhhMud/eqOgb
         MoPl9VUsKuHoSIFGDgag5vFIi1xW+u3TGTEyOJP4ygr09Z+lJu0ouEYxxxZSrAZa8qV7
         C7DdyA3pgEu0PQpazk/njoI/NIB2Z5r2Iw30J7Cowismaxyw2xPvgd7rNifuizQnEjDJ
         iHHnv29olh0l0Xlg35nvdFAVP1OKvo1iXYCtp4X7GWLEtZAdHgBVPmntjFAn3Jhy4pl9
         XfzUegvP5ZUuP7mhu8aZwS89zmJ+CUGqLiicaxvm0D+TZb8AOzVYTrtTp+JUewVGuIbZ
         2eoQ==
X-Received: by 10.70.32.33 with SMTP id f1mr13686857pdi.23.1412795067628;
        Wed, 08 Oct 2014 12:04:27 -0700 (PDT)
Received: from [127.0.0.1] ([106.211.91.111])
        by mx.google.com with ESMTPSA id n2sm701677pdh.30.2014.10.08.12.04.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 08 Oct 2014 12:04:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqppe2bh1p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/2014 11:05 PM, Junio C Hamano wrote:
> Richard Hartmann <richih.mailinglist@gmail.com> writes:
> 
>> So this is not a real bug report, more of a "is this intended this way?"
>> richih@titanium  ~/git_test % git rev-parse --is-inside-work-tree
>> error: Malformed value for branch.autosetuprebase
>> fatal: bad config file line 8 in .git/config
>> richih@titanium  ~/git_test % cat .git/config
>> ...
>> [branch]
>> autosetuprebase = true
> 
> It does not seem to be limited to rev-parse but having a malformed
> configuration for that variable would break everything Git, which
> certainly is not how it is supposed to work.  It also seems that the
> breakage dates back very far into the past (I checked 1.7.0 and it
> seems to be broken the same way).
> 
> The same breakage exists for branch.autosetupmerge, I think, e.g.
> 
> 	[branch]
>                 autosetupmerge = garbage
> 
> In config.c, git_default_branch_config() must be corrected to set
> git_branch_track and autorebase to BRANCH_TRACK_MALFORMED and
> AUTOREBASE_MALFORMED and the users of these two variables must be
> fixed to deal with the "malformed in the configuration" cases, I
> think.  The error should happen only in the codepath where we need
> the value, and no other places.

Supporting Junio's claim, there is a function called git_default_config()
which checks and sets a whole load of config values which may or maynot
be relevant to the codepath that called it. (branch.autosetuprebase is a
part of it) So an error may occur printing a seemingly unrelated config value
as the malformed variable as happened in your case.

There are currently 72 callers of git_default_config() in the codebase,
so a malformed config value breaks most of git commands. The only path
to correct this behavior would be either correct the config variable in
the file or we could decouple the huge monolithic function that
git_default_config() has become and use the git_config_get_value() in the
code paths that really need them. This part is doable, albeit slowly. All
the config variables in git_default_config() can be rewritten using the
new non callback based functions easily as demonstrated in an earlier
RFC patch.
