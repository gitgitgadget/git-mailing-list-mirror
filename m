From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH] git-push: update remote tags only with force
Date: Wed, 31 Oct 2012 07:36:41 -0500
Message-ID: <CAEUsAPbpvuvoEEU8g7+dgnF=97dm76CUTgbdWOpDWTY5LoWysg@mail.gmail.com>
References: <1351661875-4307-1-git-send-email-chris@rorvick.com>
	<CAMP44s2T9Rmfjd8r+2+eYh8JBPXEofm3cHuEkkY+R3cW6R6HxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 13:36:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTXXT-0000dH-Tw
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 13:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422712Ab2JaMgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 08:36:43 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46722 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935517Ab2JaMgm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 08:36:42 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1025511lbo.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 05:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Wly9W1D6OnOSt7usiWi2Q3/uNsDUXAUnB/yEt5kP9qQ=;
        b=N8s/I18zTU0hYisUj69Utkke0oSi9Q/xV7tX9KvGNf3eEbmzE6N1EkXRzyO4dYFbJT
         jO7SRwAK/fYqOKhnTR/NoWOW0de/+g59L6vcKgv0g8S+ItP7OJmQLBf/l7k6NCpHnwtX
         7pqobXYEe2bg2InqaOHP/IoKX38jrK1H6KALCBamF+8Pra0dwrwU7fZRMsyVlVwK4ogg
         NxLbh+PnQju2MTKvNQN35jI4xAxmCdKqwuF34zEHjosvkF+dlJiTHecaUljMJ2ocQPIM
         /hUEDwJhSi2OI1cJOxmAO0tbITYzis1cKS6EMguvgAckqkB7uS3TaDlNfua4YKh7/c3h
         Ohxg==
Received: by 10.152.105.103 with SMTP id gl7mr33115609lab.10.1351687001512;
 Wed, 31 Oct 2012 05:36:41 -0700 (PDT)
Received: by 10.114.2.45 with HTTP; Wed, 31 Oct 2012 05:36:41 -0700 (PDT)
In-Reply-To: <CAMP44s2T9Rmfjd8r+2+eYh8JBPXEofm3cHuEkkY+R3cW6R6HxA@mail.gmail.com>
X-Google-Sender-Auth: Vj5k2zobhR49Q3vxUNz0YswlDKc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208815>

(oops, now my email was rejected)

On Wed, Oct 31, 2012 at 12:55 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Hi,
>
> (again because the mailing list rejected it) (Gmal switched interface
> and HTML is the default)
>
> On Wed, Oct 31, 2012 at 6:37 AM, Chris Rorvick <chris@rorvick.com> wrote:
>>
>> References are allowed to update from one commit-ish to another if the
>> former is a ancestor of the latter.  This behavior is oriented to
>> branches which are expected to move with commits.  Tag references are
>> expected to be static in a repository, though, thus an update to a
>> tag (lightweight and annotated) should be rejected unless the update is
>> forced.
>>
>> To enable this functionality, the following checks have been added to
>> set_ref_status_for_push() for updating refs (i.e, not new or deletion)
>> to restrict fast-forwarding in pushes:
>>
>>   1) The old and new references must be commits.  If this fails,
>>      it is not a valid update for a branch.
>>
>>   2) The reference name cannot start with "refs/tags/".  This
>>      catches lightweight tags which (usually) point to commits
>>      and therefore would not be caught by (1).
>>
>> If either of these checks fails, then it is flagged (by default) with a
>> status indicating the update is being rejected due to the reference
>> already existing in the remote.  This can be overridden by passing
>> --force to git push.
>>
>> The new status has the added benefit of being able to provide accurate
>> feedback as to why the ref update failed and what can be done.
>> Currently all ref update rejections are assumed to be for branches.
>
> Makes sense to me. I've believe I've been hit by this a couple of
> times when tags were updated, and a colleague did 'git push' and they
> went all back, or something like that. To handle that case properly
> probably more changes are needed, but this is a change in the right
> direction.
>
>> +test_expect_success 'push tag requires --force to update remote tag' '
>> +       mk_test heads/master &&
>> +       mk_child child1 &&
>> +       mk_child child2 &&
>> +       (
>> +               cd child1 &&
>> +               git tag lw_tag &&
>> +               git tag -a -m "message 1" ann_tag &&
>> +               git push ../child2 lw_tag &&
>> +               git push ../child2 ann_tag &&
>> +               >file1 &&
>> +               git add file1 &&
>> +               git commit -m "file1" &&
>> +               git tag -f lw_tag &&
>> +               git tag -f -a -m "message 2" ann_tag &&
>> +               ! git push ../child2 lw_tag &&
>
> You probably should use test_must_fail.

Thanks, will fix.

> I don't see anything wrong with the patch, but I wonder if it might be
> possible to split it to ease the review.

I initially thought I'd split it into two: 1) to improve the feedback
and 2) to change the behavior.  But (1) was shaping up to be similar
in size to the sum so I scrapped that idea.  I will see what I can do.

Thanks,

Chris
