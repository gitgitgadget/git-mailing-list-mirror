From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] clone: do not segfault when specifying a nonexistent branch
Date: Mon, 7 Oct 2013 17:46:23 +0700
Message-ID: <CACsJy8D+a=agXppSRT0C_w_9a5nGwomDp=8tiN5GPWtrpCKHRQ@mail.gmail.com>
References: <524EC896.3050703@opensoftware.pl> <1380896459-6451-1-git-send-email-stefanbeller@googlemail.com>
 <CACsJy8BX_fWdsCGa4jnh4CbkSMxp7btOFjwzB9K0eRtjUR_F-Q@mail.gmail.com> <52512CF8.2070205@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	robert.mitwicki@opensoftware.pl,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 07 12:47:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VT8L4-0001YH-CO
	for gcvg-git-2@plane.gmane.org; Mon, 07 Oct 2013 12:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285Ab3JGKqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Oct 2013 06:46:54 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:49646 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429Ab3JGKqx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Oct 2013 06:46:53 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so6834208pbb.20
        for <git@vger.kernel.org>; Mon, 07 Oct 2013 03:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ut78SC3HoytJatJE4D6ddcXkKtZ1j/BTvouz8q0gteU=;
        b=fsJDwVapuD9Y0DJXonFpnixNJRD9+XLYLa8hnTNNvcZYAVQEYdxvs4hU0gahOIPcpw
         wYDehKnhf6Qz4WAm3fLq9w1nt9YOqIuIMNIn9ts5gD7e8xJr5/nIGs4aAFb8lxzIoLfy
         FXDAT/xY32rs+wpRhdQrd5zjyzleq+LgCssAto/sCMv9jbwlJsfW0bP+CJDZc6FPCHPW
         FjSo8rMUgWLJITTYOkKeG4rfxflL9beMfYp3jXG88LaP8bdlaeSWkOZvWFbFylulpFTt
         xBTtu0ZjITfOBklqU2OFZz3b8/AfRn7yaP3r1ro+EHV7mMun5bMa2CoH+BezsP7p6kAH
         v1hg==
X-Received: by 10.68.241.132 with SMTP id wi4mr29758425pbc.45.1381142813071;
 Mon, 07 Oct 2013 03:46:53 -0700 (PDT)
Received: by 10.70.66.33 with HTTP; Mon, 7 Oct 2013 03:46:23 -0700 (PDT)
In-Reply-To: <52512CF8.2070205@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235756>

On Sun, Oct 6, 2013 at 4:27 PM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
>>> @@ -688,7 +688,7 @@ static void write_refspec_config(const char* src_ref_prefix,
>>>
>>>         if (option_mirror || !option_bare) {
>>>                 if (option_single_branch && !option_mirror) {
>>> -                       if (option_branch) {
>>> +                       if (option_branch && our_head_points_at) {
>>>                                 if (strstr(our_head_points_at->name, "refs/tags/"))
>>>                                         strbuf_addf(&value, "+%s:%s", our_head_points_at->name,
>>>                                                 our_head_points_at->name);
>>
>> This prevents the segfault, but what about remote.*.fetch? Should we
>> setup standard refspec for fetch or..?
>>
>
> Looking at the code a few lines below, this comment comes up:
>
>         /*
>          * otherwise, the next "git fetch" will
>          * simply fetch from HEAD without updating
>          * any remote-tracking branch, which is what
>          * we want.
>          */
>
> This behavior was good for the case (!option_branch && !remote_head_points_at)
> Now we extend that behavior doing nothing to
>          ((!option_branch || !our_head_points_at) &&  !remote_head_points_at)
>
> I am not sure how to handle that case best. The user has given a non existing branch,
> so it doesn't make sense to track that branch, but only have that
> registered as a remote*.fetch?
>
> Reading the documentation enhancements of 31b808a
> (2012-09-20, clone --single: limit the fetch refspec to fetched branch), doesn't
> talk about this corner case. So maybe the remote.*.fetch shall be set, but no branch
> should be checked out, when running
> git clone --depth 1 -b test https://github.com/mitfik/coredump.git /tmp/coredump.git
>
> Does that make sense?

Looking further back to 86ac751 (Allow cloning an empty repository -
2009-01-23), the reason to allow cloning an empty repository is so
that the user does not have do manual configuration, so I agree with
your "maybe". git-clone.txt should have a short description about this
too in case somebody runs into this and cares enough to check the
document before heading to Stack Overflow.
-- 
Duy
