From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v3] worktree: add 'list' command
Date: Tue, 11 Aug 2015 07:41:21 -0400
Message-ID: <CANoM8SWeqxD2vWLQmEfxxxn8Dz4yPfjGOoOH=Azn1A3So+wz2Q@mail.gmail.com>
References: <1439239982-42826-1-git-send-email-rappazzo@gmail.com>
 <1439239982-42826-2-git-send-email-rappazzo@gmail.com> <xmqqr3nau74h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 13:41:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZP7wF-0002Ff-GQ
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 13:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934342AbbHKLlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 07:41:44 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36639 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934048AbbHKLlm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 07:41:42 -0400
Received: by oiev193 with SMTP id v193so72755440oie.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 04:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HS+0LFc5x9o3SlTTUS+E6GbQAXHMYSywZLdO4OQH2Bs=;
        b=qCVvDNCL3lgWhjbbrm6jUpyNUH9xzurz7nC8Ou7QU59d7FpLaFIliaOUggkDvfi67r
         fFefs+voEiYAIYPEP/b9NW3pmO5JflpaJ5LZ/7J47+oLwr1Q1mbzKwDYD5bI/qkYnopd
         0JxzQ7VAI9ZS6k1Vs3SbQsbcR4VP1IYVU51hWCoRuzJUTHI3F+OUg/+06WT9gkrC/pRE
         1MCXjQhZZytcPwlr0TWzrJ6UK9NISGE8yltQdLP8tz2I0jI0aWkhYwiMf0fZXBILhY9x
         wv2Q3T/pSv9ZsDECM45zbKxllE7f9q4XOUfI+BnT+ahfENFCZPl+mzbD7uU1hIfr3stK
         zmpw==
X-Received: by 10.202.67.67 with SMTP id q64mr23471988oia.124.1439293301311;
 Tue, 11 Aug 2015 04:41:41 -0700 (PDT)
Received: by 10.202.232.213 with HTTP; Tue, 11 Aug 2015 04:41:21 -0700 (PDT)
In-Reply-To: <xmqqr3nau74h.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275683>

On Mon, Aug 10, 2015 at 6:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Rappazzo <rappazzo@gmail.com> writes:
>
>> +static int list(int ac, const char **av, const char *prefix)
>> +{
>> +     int main_only = 0;
>> +     struct option options[] = {
>> +             OPT_BOOL(0, "main-only", &main_only, N_("only list the main worktree")),
>> +             OPT_END()
>> +     };
>
> Hmm, main-only is still there?

Sorry, I missed that.

>
>> +     int is_bare = is_bare_repository();
>
> Please do not introduce decl-after-stmt.

Since I reused this value below, I thought it would be acceptable.

>> +     if (is_bare) {
>> +             strbuf_addstr(&main_path, absolute_path(common_dir));
>
> Hmm, interesting.
>
> Because .git/config is shared, core.bare read from that tells us if
> the "main" one is bare, even if you start this command from one of
> its linked worktrees.  So in that sense, this test of is_bare
> correctly tells if "main" one is a bare repository.
>
> But that by itself feels wrong.  Doesn't the presense of a working
> tree mean that you should not get "is_bare==true" in such a case
> (i.e. your "main" one is bare, you are in a linked worktree of it
> that has the index and the working tree)?

Is is even correct for a bare repo to be included in the list?  I
think that is part of what you are asking here.

>
>> +             strbuf_strip_suffix(&main_path, "/.");
>
> In any case, what is that stripping of "/." about?  Who is adding
> that extra trailing string?
>
> What I am getting at is (1) perhaps it shouldn't be adding that in
> the first place, and (2) if some other code is randomly adding "/."
> at the end, what guarantees you that you would need to strip it only
> once here---if the other code added that twice, don't you have to
> repeatedly remove "/." from the end?

In the case of a common dir, the value returned is just '.'.  I wanted
to resolve that to the full path, so I called
`absolute_path(common_dir)`.  Hence the trailing "/.".  Similarly, in
the main repo, the common dir is just ".git", and I handled that by
using `get_git_work_tree()`.
