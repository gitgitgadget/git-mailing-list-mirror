From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/19] pull: check if in unresolved merge state
Date: Wed, 10 Jun 2015 10:14:16 -0700
Message-ID: <xmqq381zmqon.fsf@gitster.dls.corp.google.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-12-git-send-email-pyokagan@gmail.com>
	<xmqqsia0uzaa.fsf@gitster.dls.corp.google.com>
	<xmqqr3pjocgm.fsf@gitster.dls.corp.google.com>
	<CACRoPnSQd_YEp4mNFbqDZtBJGztkHLXWbDojcAJRNvpynFRCew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 19:14:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2ja3-00027B-PK
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 19:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbbFJROU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 13:14:20 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34547 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964977AbbFJROS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 13:14:18 -0400
Received: by iebmu5 with SMTP id mu5so38875747ieb.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 10:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=J7/zkKprm2oulG8/9MqQwXcRLhfEYAU+syYLzJ71rI4=;
        b=evFLQr6njOfg2Znv0O1O9GqxZZBAMwdvin2DmWuXmZMLri5Ic3PD7dz2skYW17mx21
         dannwd2KLTuSfbe8CFEnSNRNRlwvIS9Zl11a2ioX+CeDCAHzlbSDtiDdCD3OMGdU7Z+w
         hNcOLJTTbXXZXzspLZoIWMR3o3fI4Rx4W7nqmvBrj+HKIJci064U+ElrUcaNvoXu6UIr
         pjkkr5YiiHWiddgJ7j1205DBtVXsyZ+9HPMHbifTgN8/FaW6iBZg5Tohm+aUyO3fqlcI
         jj18nunzFLCI4mJnD6OxTW4mhOv1Apfg3erfMfabOf67sJIWRpYC0pR9/JEiR8GRQg++
         U7QQ==
X-Received: by 10.50.178.230 with SMTP id db6mr7243295igc.26.1433956457964;
        Wed, 10 Jun 2015 10:14:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id f82sm6377802iod.44.2015.06.10.10.14.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 10:14:17 -0700 (PDT)
In-Reply-To: <CACRoPnSQd_YEp4mNFbqDZtBJGztkHLXWbDojcAJRNvpynFRCew@mail.gmail.com>
	(Paul Tan's message of "Wed, 10 Jun 2015 23:12:06 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271330>

Paul Tan <pyokagan@gmail.com> writes:

> On Wed, Jun 10, 2015 at 10:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> If you are going to do the git_config() call yourself, it might make
>>> more sense to define git_pull_config() callback and parse the pull.ff
>>> yourself, updating the use of the lazy git_config_get_value() API you
>>> introduced in patch 10/19.
>>>
>>> The above "might" is stronger than my usual "might"; I am undecided
>>> yet before reading the remainder of the series.
>>
>> Let me clarify the above with s/stronger/with much less certainty/;
>
> Uh, I have no idea what a "strong might" or a "less certain might" is. :-/
>
> Parsing all the config values with a git_config() callback function is
> certainly possible, but I was under the impression that we are moving
> towards migrating use of all the git_config() callback loops to the
> git_config_get_X() API.
>
> In this case though, we have to use git_config() to initialize the
> advice.resolveConflict config setting, but I don't see why it must be
> in conflict with the above goal.

I (or at least some part of me) actually view git_config_get_*() as
"if you are only going to peek a few variables, you do not have to
do the looping yourself" convenience, which leads me (or at least
that part of me) to say "if you are doing the looping anyway, you
may be better off picking up the variables you care about yourself
in that loop".

By calling git_config() before calling any git_config_get_*()
functions, you would be priming the cache layer with the entire
contents of the configuration files anyway, so later calls to
git_config_get_*() will read from that cache, so there is no
performance penalty in mixing the two methods to access
configuration data.  That is why I felt less certain that the
suggestion to stick to one method (instead of mixing the two) is a
good thing to do (hence "less certain 'might'").
