From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it to ignore instead?
Date: Sun, 18 Oct 2015 10:58:39 -0700
Message-ID: <xmqqfv18awj4.fsf@gitster.mtv.corp.google.com>
References: <CAM-tV-_JPazYxeDYogtQTRfBxONpSZwb3u5pPanB=F9XnLnZyg@mail.gmail.com>
	<CAM-tV-_eOgnhqsTFN6kKW=tcS7gAPYaxskBaxnJZo3bsx02HZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Noam Postavsky <npostavs@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Oct 18 19:58:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnsEJ-0006hA-QH
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 19:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbbJRR6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 13:58:43 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35004 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbbJRR6m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 13:58:42 -0400
Received: by pasz6 with SMTP id z6so6429290pas.2
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 10:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+w8zOdjkukWRR0odK1XOPo3CMIWOz4Y2o4giWTHhS74=;
        b=mWHEW9SmxPKeQvcLdcqnoLyg4nwXS6msfW+y2M/UuByumq+0h3OHnmurQHA/F77ZLb
         cjnEqzB9AQKpuZDSe2zbxD7mZK5sPySA76kxpjYzfQwUbJMuwuWgOpaHJoW184wEh5+T
         Nvcs+yMlRBvSRzX8rJBbgzNSbN22kMogcCJxJBCYuU4o6X0O60IhBc4zNzYbyhGg7a3t
         2UFtEnGugvwqsMQ8NlL+cjZJ5CQZtGUYoGoRKIlsAtES5dOc2oylRkmJjfMEUAlYEmDj
         2h7KBlto1f6fsMMd+UD8I1kbIiHd9B5eAdpAIISUu13lF2pMQyUn0iAjbf7ZnmPb8D9d
         IcJA==
X-Received: by 10.66.227.72 with SMTP id ry8mr30277815pac.105.1445191121874;
        Sun, 18 Oct 2015 10:58:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:305b:5af5:2c51:11cd])
        by smtp.gmail.com with ESMTPSA id z12sm31956759pbt.30.2015.10.18.10.58.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Oct 2015 10:58:40 -0700 (PDT)
In-Reply-To: <CAM-tV-_eOgnhqsTFN6kKW=tcS7gAPYaxskBaxnJZo3bsx02HZg@mail.gmail.com>
	(Noam Postavsky's message of "Sun, 18 Oct 2015 11:15:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279818>

Noam Postavsky <npostavs@users.sourceforge.net> writes:

> On Sat, Oct 10, 2015 at 12:45 PM, Noam Postavsky
> <npostavs@users.sourceforge.net> wrote:
>> I noticed that git-credential-cache--daemon quits on SIGHUP. This
>> seems like surprising behaviour for a daemon. Would it be acceptable
>> to change it to ignore SIGHUP?
>
> ping?

Thanks for pinging.  I guess this either fell in the cracks while
people were busy discussing other topics, or nobody agreed with the
reasoning behind the change, or perhaps a bit of both.  In any case,
it is a prodent thing to ping on the thread after a week or so,
which is what you did.  Very much appreciated.

I cannot speak for the person who was primarily responsible for
designing this behaviour, but I happen to agree with the current
behaviour in the situation where it was designed to be used.  Upon
the first use in your session, the "daemon" is auto-spawned, you can
keep talking with that same instance during your session, and you do
not have to do anything special to shut it down when you log out.
Isn't that what happens here?

If this were "when you start the system you start this free-standing
daemon once, and it will stay around until it gets shut down. If you
are staying around in logged-in state is immaterial" kind of daemon,
I'd expect it, upon being killed with HUP, to do something useful,
like re-reading its configuration file, and continue, instead of
dying.

Perhaps you can tweak the system to get both, by making it continue
upon HUP by default, but teaching it an option not to (i.e. the
current behaviour).  Pass that option when spawn_daemon() in
credential-cache.c starts the daemon.  When using the daemon as a
free-standing one (against the way its documentation expects you
to---see "git help credential-cache--daemon"), you do not pass that
option and your "daemon" will ignore HUP.

Hmm?
