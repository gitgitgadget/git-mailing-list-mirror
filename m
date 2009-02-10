From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 11:11:59 +0100
Message-ID: <4ac8254d0902100211p6a52e040je10e11c4f79ea488@mail.gmail.com>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com>
	 <7vr627qd4p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 11:13:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWpcS-0001XG-Ql
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 11:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbZBJKMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 05:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbZBJKME
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 05:12:04 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:57947 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbZBJKMB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 05:12:01 -0500
Received: by bwz5 with SMTP id 5so2435486bwz.13
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 02:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W7pzWVYW4+wNGiuTjBgr5vk8zTNgJY83t0yQQl4mRyI=;
        b=xRZjKPiYKKw7AnKYTOkK+0gvxhjCCPysY7SSI10vR+8wdezjZb3ESfmKInW7S/x0Sl
         iA2ZSob9VKcg813iOA9mlIPn2Wp0xBg5sCjTCWqLzb0Wq/LFIHRNCUFACXwvv10yPvJH
         +SN21/uQjOp0E3huGU++ZfucmCAn2XBqEo8tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=flu7mSTGUVhfV06RAnhctmG5PBGR7g3OhPyIeH5HZ68z4HJtEEqSpYI+64G840F9xG
         NVtcbZjzPCL3NHPm7rWT75gJz8XZfYvScvsZd2x1U3NZ6p2Hdty1R0B+BP4MA11J4Fj4
         oXmSmFcIgJ+SOXM1B7grzdcQbt4xn85S1FAkU=
Received: by 10.223.107.20 with SMTP id z20mr1262fao.28.1234260719680; Tue, 10 
	Feb 2009 02:11:59 -0800 (PST)
In-Reply-To: <7vr627qd4p.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109193>

On Tue, Feb 10, 2009 at 2:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Tuncer Ayaz <tuncer.ayaz@gmail.com> writes:
>
>> Adding git 'shortstatus --mini' to PS1 is not noticeable or 1sec
>> maximum in my tree. As a worst case it takes 10secs in a clone
>> of WebKit.git.

Junio, if I leave out my --mini experiment would you be interested
in merging shortstatus without any additions except maybe
removing the index_score? Is it useful enough in your eyes? If yes
I will resubmit it and decouple the --mini case completely as
possible future work.

> Frankly, I think having to spend one second to add only one or two bits to
> PS1 is simply spending one second too much.

ACK. it will get worse with time.

>> diff --git a/builtin-commit.c b/builtin-commit.c
>> index d6a3a62..9267d26 100644
>> --- a/builtin-commit.c
>> +++ b/builtin-commit.c
>> @@ -821,6 +827,88 @@ static int parse_and_validate_options(int argc, const char *argv[],
>>       return argc;
>>  }
>>
>> +int cmd_shortstatus(int argc, const char **argv, const char *prefix)
>> +{
>> +     struct wt_status s;
>> +     int i;
>> +     int c, a, u;
>> +
>> +     c = a = u = 0;
>> +
>> +     argc = parse_and_validate_options(argc, argv, builtin_shortstatus_usage, prefix);
>> +     read_cache();
>> +     refresh_cache(REFRESH_QUIET);
>> +     wt_status_prepare(&s);
>> +     wt_status_collect_changes(&s);
>> +     if (mini) {
>> +             for (i = 0; i < s.change.nr; i++) {
>> +                     struct wt_status_change_data *d;
>> +                     struct string_list_item *it;
>> +
>> +                     it = &(s.change.items[i]);
>> +                     d = it->util;
>> +                     switch (d->index_status) {
>> +                             case DIFF_STATUS_ADDED:
>> +                                     a = 1;
>> +                                     break;
>> +                             case 0:
>> +                             case DIFF_STATUS_COPIED:
>> +                             case DIFF_STATUS_DELETED:
>> +                             case DIFF_STATUS_MODIFIED:
>> +                             case DIFF_STATUS_RENAMED:
>> +                             case DIFF_STATUS_TYPE_CHANGED:
>> +                                     c = 1;
>> +                                     break;
>
> If you at the end discard information by squashing renamed, copied,
> deleted and modified into a single "changed" category, I do not think you
> would want wt_status_collect_changes() to spend the cost of rename
> detection in the first place.  Sure, you can tell between "git mv old new"
> and "git add new", because you won't show "+" for "new" if you run rename
> detection, but that is about the only thing I think you are getting.

actually I can leave out all but case 0 to get the current behavior.
I am not sure but (presumably) have the suspicion from what I
have read that these extra cases are irrelevant in this case.
I may err.

> Is it worth extra 1 second (or 10 seconds)?

1 second is noticeable and therefore bad but it is a definite
improvement compared to what I had before with
'git status|grep' calls. it is slow for PS1, yes.

> What are you really trying to achieve?  Do you want to see if you have any
> change to the index since you checked out?  Do you want to further tell
> the user that the work tree has more changes that are not staged yet
> (which --mini does not seem to do)?
>
> Do you really need more than "diff-index --cached --exit-code" in your
> $PS1 code, and so why?  Does the added feature your "shortstatus --mini"
> offers over "diff-index --cached --exit-code" justify the latency penalty
> to the user?
>

What I and others need - based on the fact that the PS1
enhancement was inspired by someone else's PS1 - is not
diff-index --cached. It should include changes in the
index plus those not.
The feature is there to display that a repo is dirty and if
possible in an instant way also display that there are not
only untrackeds but also modifications and/or additions not
yet committed with separate symbols (+,*,?).
If this is not currently implementable fast enough let's forget
about it for now and tackle it once the future unfolds and shows
us a better path or someone comes up with a bright idea :).
