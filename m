From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 2/4] path: optimize common dir checking
Date: Fri, 14 Aug 2015 16:54:20 -0400
Organization: Twitter
Message-ID: <1439585660.8855.102.camel@twopensource.com>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com>
	 <1439416645-19173-2-git-send-email-dturner@twopensource.com>
	 <55CC5DED.5050304@alum.mit.edu>
	 <xmqqtws1iyxn.fsf@gitster.dls.corp.google.com>
	 <1439582644.8855.89.camel@twopensource.com>
	 <xmqq1tf5ipju.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	chriscool@tuxfamily.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:54:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQLzi-0003IT-Aa
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 22:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbbHNUyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 16:54:25 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35443 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbbHNUyW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 16:54:22 -0400
Received: by qkbm65 with SMTP id m65so29606399qkb.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 13:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=nTWDF5iHrJE7dwRZ8G7+Wi6WWECq1ZOkTjG1NyN06gw=;
        b=TjCYeuKn53Qpm1zqOwpBq/MHmElxtu5jeV2cI/OX3u5G1c5ETK09V59VynlZr8EON2
         YbGjCBXQNBNR0UHiGy+EWWzqYYMSbq6NnCy83/0AjkMJbQBD+vTZESeDvuXN0MfjfJZI
         b/YajZ3/+98mndCkBudYsKMksQI78umLy7gl32k+/rNfC8+fMpEC2SSNovmWMFEWM/eS
         +NB+JAfDVqiH2I1eKx5u5FFvE8DQ7iA5tGwgNHdZYAK5TRIngiilL74Hk8Ee6oqMZzRm
         BfDhxs36hFsASxHLzFC5ZPcjlJKd6inq7Ly629MWnfXPmLYAK7A3XlcUKkaDuMeZ6aEa
         LhgA==
X-Gm-Message-State: ALoCoQkH0WlNKDcldpbeNfGBbMPnLMTQZmrk7sd0NPZ8/UPrPGVOJErApiR4Od1O3yUThiklV9gV
X-Received: by 10.55.204.13 with SMTP id r13mr7254274qki.99.1439585662072;
        Fri, 14 Aug 2015 13:54:22 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id 108sm3704902qgz.17.2015.08.14.13.54.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2015 13:54:21 -0700 (PDT)
In-Reply-To: <xmqq1tf5ipju.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275949>

On Fri, 2015-08-14 at 13:27 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > Random side note: the present workspace path name component is not
> > acceptable for this if alternate ref backends use a single db for
> > storage across all workspaces.  That's because you might create a
> > workspace at foo, then manually rm -r it, and then create a new one also
> > named foo.  The database wouldn't know about this series of events, and
> > would then have stale per-workspace refs for foo.
> 
> The users can do "Create, manuallly rm -r and recreate" dance all
> they want, but the result must still honor the invariant:
> 
>     For any $workspace, $workspace/.git is a "gitdir:" file that
>     points at one subdirectory in $GIT_COMMON_DIR/worktrees/.
> 
> The "name" I had in mind was the names of the directories in
> $GIT_COMMON_DIR/worktrees/ that by definition has to be unique.
> 
> Another invariant 
>
>    $GIT_COMMON_DIR/worktrees/$that_subdirectory has commondir file
>    that points at the $GIT_COMMON_DIR/.
>
> must also be preserved by "Create, manuallly rm -r and recreate"
> dance, but it is not important to define what the workspace ID is.

My worry was that workspace would get deleted and
recreated without the refs db finding out.  Then the refs db would
retain per-workspace references from the deleted version of the
worskace.  That is, these names are unique at any given time, but not
across time.

My idea was just to have `git workspace add` create per-workspace
"workspace_id" file with a long random number in it. The id would be
$that_subdirectory/$random_number; we would know to split it at / and
double-check that the workspace id is still current before assuming that
our refs data was valid for the workspace.  

Alternately, git workspace add could inform the refs backend that a
workspace is being added, which would solve the problem in a different
way.

But given my refs lmdb backend design, I can actually ignore this for
now, so that's what I'm going to do.
