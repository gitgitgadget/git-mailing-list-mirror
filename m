From: Junio C Hamano <gitster@pobox.com>
Subject: Re: storing cover letter of a patch series?
Date: Thu, 10 Sep 2015 11:39:49 -0700
Message-ID: <xmqqzj0u2k5m.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
	<xmqqh9n241el.fsf@gitster.mtv.corp.google.com>
	<18979417.pyyHNUINeQ@mfick1-lnx>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>, repo-discuss@googlegroups.com
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Sep 10 20:40:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za6lN-0003Nn-3h
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 20:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791AbbIJSjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 14:39:53 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33241 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbbIJSjv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 14:39:51 -0400
Received: by pacex6 with SMTP id ex6so50365213pac.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 11:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ee1pWtC/C6B9x5m+ueJInAbw/uBcU+29rIMzulZmR6s=;
        b=EjGtxUCBBnHs4ZwvjgSNTk3YJun/OOLqI9wFbU/OPXjr6vI351CkaBf6zoxXJAT+4w
         Js9v76s1vqDSob3xWjltG9rpQg5Bmz5LD2ATCy6wSqLY46Jez7JDk3bqz8Uu605lLeXL
         Uxxal+nS0tM+nhXOXH+p08/474J4lUWrlirSFfKCAXpdALLd+eK4w2coeFstu909I5tb
         UPk6TeS4v5DxeBWcJbaI+hCZMw24HnkoDFsSFuO1pUt5eEHsWx90Xl6xyrfpFEV00zus
         B82GBj2ubF2Jqm9Y3UwTHBLcRuHjC3THntPRmsGTGz63mnP3mgdcPqwia5KUA7e+2xPA
         rG/A==
X-Received: by 10.68.175.3 with SMTP id bw3mr85492960pbc.106.1441910390977;
        Thu, 10 Sep 2015 11:39:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8419:5a5:3940:dfa0])
        by smtp.gmail.com with ESMTPSA id hz5sm13361545pbb.39.2015.09.10.11.39.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Sep 2015 11:39:50 -0700 (PDT)
In-Reply-To: <18979417.pyyHNUINeQ@mfick1-lnx> (Martin Fick's message of "Thu,
	10 Sep 2015 12:02:02 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277624>

Martin Fick <mfick@codeaurora.org> writes:

> As a Gerrit developer and user, I would like a way to 
> see/review cover letters in Gerrit.  We have had many 
> internal proposals, most based on git notes, but we have 
> also used the empty commit trick.  It would be nice if there 
> were some standard git way to do this so that Gerrit and 
> other tools could benefit from this standard.  I am not 
> suggesting that git need to be modified to do this, but 
> rather that at least some convention be established.

Some of what you would write in the cover letter is not meant for
anywhere in the permanent history (e.g. description of what changed
since the previous reroll), but some other would be a concise
summary of what the entire series is about, and it would be nice if
it can be made part of the permanent record.

The problem with "empty commit trick" is that it is a commit whose
sole purpose is to describe the series, and its presence makes it
clear where the series ends, but the topology does not tell where
the series begins, so it is an unsatisifactory half-measure.

Ideally, I would think that you want that information when the
series is fully cooked and gets merged to a more permanent place in
the log message of the merge commit.  At that point, where the
series started may become more clear from the topology (i.e. the set
difference X^..X for the resulting merge is what got merged).  One
possible "hacky" convention could be

 - Developers keep rerolling with the "empty commit with cover
   letter material at the tip".  topic@{upstream}..topic~1 are the
   real changes, topic~0 is an empty "cover letter material".

 - When the series is fully cooked, a new "git merge" option notices
   that the topic is structured in a "strange" way, uncaps its tip
   commit and merges the remainder of the series and adds the cover
   letter material when presenting the editor to record the merge
   commit.  That is

	$ git merge --cover-at-tip topic

   would work roughly by doing the following:

    - verify that "git rev-parse topic^^{tree} topic^{tree}" shows that
      they record the same tree; otherwise it will error out, saying
      the tip is not a pure cover.

    - verify that "git rev-list ..topic^" shows that there is
      something to merge after the tip is removed; otherwise it will
      error out, saying that there is nothing to merge.

    - run "git merge --no-ff --edit topic^1" but with the log
      message of topic^{commit} in the editor's template.
