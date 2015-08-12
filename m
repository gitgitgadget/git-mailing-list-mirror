From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/4] notes: teach git-notes about notes.<ref>.merge option
Date: Tue, 11 Aug 2015 19:26:08 -0700
Message-ID: <xmqqy4hhmedb.fsf@gitster.dls.corp.google.com>
References: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
	<1439326641-9447-5-git-send-email-jacob.e.keller@intel.com>
	<CALKQrgeDuRkXm2LzDOuZDZLOBRXjLmmRvhtXfXScWfLKX+9t=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 04:26:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPLk7-0004Fx-JZ
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 04:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933478AbbHLC0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 22:26:11 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:35466 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933064AbbHLC0K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 22:26:10 -0400
Received: by pdrg1 with SMTP id g1so1766715pdr.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 19:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Z+OkLbmZuTZN9M58QIR9A7ZDGX0fXRxD1PjIp5ZZm/s=;
        b=O+29QZGI/zMdesVQhXXOW0luNdkRRrYATb1ztSwRd1RjI+jWziJWPau2MX/fG459SF
         iqv2nPXM20XklD/9uRah8+HglBl0Zbwfj3oa2aZySNEfC4uuAm5QqbLzX5/TyN/rsH/D
         5mr8cfgSC2seNUKP2Bd1tY5vlcswuJ+liv6S1VK+pfaDPo99iSJ+AvV+2LttnaYTKfvb
         tTVRKp3bhGo18op2NOsHgsoMSZFet3YcmSkixnxXNTFq07SEnBNmob/UC4aPKxKFyfHt
         AgW/vKqHsv+ijMMVwWoDMRC8TLKDP72Z9vDsn8xwpoB9M1jhLmuFSr5R7jBhe9hckBsH
         VTgQ==
X-Received: by 10.70.41.100 with SMTP id e4mr62822972pdl.169.1439346369649;
        Tue, 11 Aug 2015 19:26:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id fx4sm4268859pbb.92.2015.08.11.19.26.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 19:26:08 -0700 (PDT)
In-Reply-To: <CALKQrgeDuRkXm2LzDOuZDZLOBRXjLmmRvhtXfXScWfLKX+9t=g@mail.gmail.com>
	(Johan Herland's message of "Wed, 12 Aug 2015 02:34:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275752>

Johan Herland <johan@herland.net> writes:

> I know that we don't yet have a "proper" place to put remote notes refs,
> but the <ref> in notes.<ref>.merge _must_ be a "local" notes ref (you even
> use the <localref> notation in the documentation below). Thus, I believe
> we can presume that the local notes ref must live under refs/notes/*,
> and hence drop the "refs/notes/" prefix from the config key (just like
> branch.<name>.* can presume that <name> lives under refs/heads/*).

I am OK going in that direction, as long as we promise that "notes
merge" will forever refuse to work on --notes=$ref where $ref does
not begin with refs/notes/.

> Except that this patch in its current form will occupy the .merge config
> key...
>
> Can you rename to notes.<name>.mergestrategy instead?

This is an excellent suggestion.

> Or even better, take inspiration from branch.<name>.mergeoptions,

Please don't.

That is one of the design mistakes that was copied from another
design mistake (remotes.*.tagopt).  I'd want to see us not to repeat
these design mistakes.

These configuration variables were made to take free-form text value
that is split according to shell rules, primarily because it was
expedient to implement.  Read its value into a $variable and put it
at the end of the command line to let the shell split it.  "tagopt"
was done a bit more carefully in that it made to react only with a
fixed string "--no-tags", so it was hard to abuse, but "mergeoptions"
allowed you to override something that you wouldn't want to (e.g. it
even allowed you to feed '--message=foo').

Once you start from such a broken design, it would be hard to later
make it saner, even if you wanted to.  You have to retroactively
forbid something that "worked" (with some definition of "working"),
or you have to split, parse and then reject something that does not
make sense yourself, reimplementing dequote/split rule used in the
shell---which is especially problematic when you no longer write in
shell scripts.

So a single string value that names one of the supported strategy
stored in notes.<name>.mergestrategy is an excellent choice.  An
arbitrary string in notes.<name>.mergeoptions is to be avoided.

Thanks.
