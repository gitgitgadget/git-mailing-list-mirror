From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3 4/4] fast-export: make sure refs are updated properly
Date: Tue, 30 Oct 2012 18:33:04 -0700
Message-ID: <CAGdFq_jNM_48muXJ0BX2ehC=k8T9GLui_QtRO8D8C7h6b5jyHg@mail.gmail.com>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
 <1351623987-21012-5-git-send-email-felipe.contreras@gmail.com> <20121031003721.GV15167@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 02:34:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTNBx-0007EU-U5
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 02:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759005Ab2JaBdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 21:33:46 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:53428 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757087Ab2JaBdp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 21:33:45 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so2601534qad.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 18:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=a1J2pcFhSnGXLTI30b9Uru4RgDgT+qwzVLz5/vwBT28=;
        b=r63ojuOd1GDP5d/6koIO+qLtGRA6NtqsSXfAz7PkyaMudtBHuCrULc6HGpBUsKfHVJ
         0PJmvu5AZPhGbd7SYTMtuK8Z32d1xvyEMv+zfSm5QUDRe9/QqGP5GIEShXziL14bjhsh
         1NfMOKKMyFkIeXriLb8eV9dVfvwzm76YE8Ssg8ZdnBv7Uha6N681FdpkHweEZD0YYbbz
         GAoW47BrBZ+6P2/KqBz06amAh5RHdXHFbRLuuLIvYZdVfoZNvOS/qLKSUtg0dNOTzN+7
         U5Bn2W/eJ/4rYhpaFFyqzbaRMJILNqhm/Q173VlGbvVXRQC7/ZnNnegbERMYb3/M5lrx
         gpbA==
Received: by 10.224.17.68 with SMTP id r4mr15131641qaa.21.1351647224435; Tue,
 30 Oct 2012 18:33:44 -0700 (PDT)
Received: by 10.49.36.195 with HTTP; Tue, 30 Oct 2012 18:33:04 -0700 (PDT)
In-Reply-To: <20121031003721.GV15167@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208779>

On Tue, Oct 30, 2012 at 5:37 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>> --- a/builtin/fast-export.c
>> +++ b/builtin/fast-export.c
>> @@ -523,11 +523,16 @@ static void get_tags_and_duplicates(struct object_array *pending,
>>                               typename(e->item->type));
>>                       continue;
>>               }
>> -             if (commit->util) {
>> -                     /* more than one name for the same object */
>> +
>> +             /*
>> +              * This ref will not be updated through a commit, lets make
>> +              * sure it gets properly upddated eventually.
>> +              */
>> +             if (commit->util || commit->object.flags & SHOWN) {
>>                       if (!(commit->object.flags & UNINTERESTING))
>>                               string_list_append(extra_refs, full_name)->util = commit;
>> -             } else
>> +             }
>> +             if (!commit->util)
>>                       commit->util = full_name;
>
> Here's an explanation of why the above makes sense to me.
>
> get_tags_and_duplicates() gets called after the marks import and
> before the revision walk.  It walks through the revs from the
> commandline and for each one:
>
>  - peels it to a refname, and then to a commit
>  - stores the refname so fast-export knows what arg to pass to
>    the "commit" command during the revision walk
>  - if it already had a refname stored, instead adds the
>    (refname, commit) pair to the extra_refs list, so fast-export
>    knows to add a "reset" command later.
>
> If the commit already has the SHOWN flag set because it was pointed to
> by a mark, it is not going to come up in the revision walk, so it will
> not be mentioned in the output stream unless it is added to
> extra_refs.  That's what this patch does.
>
> Incidentally, the change from "else" to "if (!commit->util)" is
> unnecessary because if a commit is already SHOWN then it will not be
> encountered in the revision walk so commit->util does not need to be
> set.
>
> If the commit does not have the SHOWN or UNINTERESTING flag set but it
> is going to get the UNINTERESTING flag set during the walk because of
> a negative commit listed on the command line, this patch won't help.

Thanks for the thorough explanation. Perhaps some of that could make
it's way into the commit message?

-- 
Cheers,

Sverre Rabbelier
