From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Tue, 15 Dec 2015 10:34:41 +0100
Message-ID: <CAP8UFD0ex4JuU=FMDwnSnf9io16=D2_m3x1ajXtCu25OU_DLAw@mail.gmail.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
	<xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com>
	<xmqqfuzck1dp.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
	<xmqq6100ke7v.fsf@gitster.mtv.corp.google.com>
	<xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 10:35:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8m0X-00032W-RM
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 10:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933336AbbLOJeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 04:34:50 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33368 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933293AbbLOJen (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 04:34:43 -0500
Received: by mail-lf0-f50.google.com with SMTP id p203so2222844lfa.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 01:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ayuEwQvFWXbhXB4mHRwWJ9rM6NN++goQNv7BgBNA4Yg=;
        b=StCRYqq97kiWYJvH/DBEaqzn3LMarHP9bFCzaDLnbFRK7pZj5VYFFC7WQIbVkE10QK
         iyw2Tadcu4Yp21WyFPW5nYhAHzJnjVryv2I8LpkJQ6OX/ib3LOLnMEykjH8TEyqwWdMN
         HYItV9Y+8tZ1NiWkvZi7pL4iQvKVxPxzYgspZnR/F5PsV1ahAv6rOhvDZfNmUZ1D0CRX
         PveHyq2/qx8Q2aQY9+xoYD4LkHG1H2NOxRCVr05MhHUiV6BDyPyAXQJyg91zAx7eFajc
         Seh0NI/7nNzZCEnkiM1ha4Hm8SUrynARCbPSe9tfrhtLPyuSQqJUaINqiPjrVBc963mj
         LWmA==
X-Received: by 10.25.86.9 with SMTP id k9mr15492227lfb.36.1450172081961; Tue,
 15 Dec 2015 01:34:41 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Tue, 15 Dec 2015 01:34:41 -0800 (PST)
In-Reply-To: <xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282468>

On Mon, Dec 14, 2015 at 10:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> The primary reason why I do not like your "configuration decides" is
> it will be a huge source of confusions and bugs.  Imagine what
> should happen in this sequence, and when should a stale cached
> information be discarded?
>
>  - the configuration is set to 'yes'.
>  - the index is updated and written by various commands.
>  - more work is done in the working tree without updating the index.
>  - the configuration is set to 'no'.
>  - more work is done in the working tree without updating the index.
>  - the configuration is set to 'yes'.
>  - more work is done in the working tree without updating the index.
>  - somebody asks "what untracked paths are there?"

As far as I understand the UC just stores the mtime of the directories
in the working tree to avoid the need of lstat'ing all the files in
the directories.

When somebody asks "what untracked paths are there", if the UC has not
been discarded when the configuration was set to no, then git will
just ask for the mtimes of the directories in the working tree and
compare them with what is in the UC.

I don't see how it can create confusion and bugs, as the work done in
the working tree should anyway have changed the mtime of the
directories where work has been done.

Maybe as the UC has not been updated for a long time, there will be a
lot of mtimes that are different, so there will not be a big speed up
or it could be even slower than if the UC was not used, but that's
all.

> In the "configuration decides" world, I am not sure how a sane
> implementation efficiently invalidates the cache as needed, without
> the config subsystem having intimate knowledge with the untracked
> cache (so far, the config subsystem is merely a key-value store and
> does not care _what_ it stores; you would want to invalidate the
> cache in the index when somebody sets the variable to 'no', which
> means the config subsystem needs to know that this variable is
> special).

In the current patch series and in the one I am preparing and will
probably send soon, this hunk takes care of removing or addind the UC
if needed:

diff --git a/wt-status.c b/wt-status.c
index 435fc28..3e0fe02 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -586,6 +586,15 @@ static void wt_status_collect_untracked(struct
wt_status *s)
                dir.flags |= DIR_SHOW_IGNORED_TOO;
        else
                dir.untracked = the_index.untracked;
+
+       if (!dir.untracked && use_untracked_cache == 1) {
+               add_untracked_cache();
+               dir.untracked = the_index.untracked;
+       } else if (dir.untracked && use_untracked_cache == 0) {
+               remove_untracked_cache();
+               dir.untracked = NULL;
+       }
+
        setup_standard_excludes(&dir);

        fill_directory(&dir, &s->pathspec);

So when the config option is changed, the UC is removed or recreated
only the next time "git status" (and maybe also "git commit" and a few
other commands) is called.

And anyway I don't think people will change the UC config very often.
Maybe they will play with it a bit when they discover it, but
afterwards they will just set it or not and be done with it. So I
think it is not worth trying to optimize what happens when the config
is set or unset. We should just make sure that it works and it is well
documented.
