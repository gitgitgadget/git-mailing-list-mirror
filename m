From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 12/18] revert: Make pick_commits functionally act on a
 commit list
Date: Mon, 1 Aug 2011 22:53:34 +0530
Message-ID: <CALkWK0nszs-=vvnPJXvvDD3f5BbbX3iHXkprFHtNX8jDKqeBew@mail.gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
 <1311871951-3497-13-git-send-email-artagnon@gmail.com> <201107312252.50467.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 19:24:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnwDi-0008OQ-Di
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 19:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab1HARX5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 13:23:57 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51760 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374Ab1HARXz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 13:23:55 -0400
Received: by wwe5 with SMTP id 5so5872279wwe.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 10:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kqwDXiwaoqI/1hNdi/QnU1bnxkcOo/DWbx1r4CY0Wm8=;
        b=ikcRNTDXT8erXlxpCQlYU0bK3fY4UZtKgpww0ajDMk4xR69owqrbQvKngq97b33pQt
         9GXCeyGQLVpMru74kKEyABki2thuwQRMxw5tbsXi4R3LWkknegfe4ThseSufXk52ItX3
         7ebVTRlrbfh+OxiaVjN3iYn30NOo8Tvsy4rF0=
Received: by 10.216.198.146 with SMTP id v18mr890935wen.94.1312219434118; Mon,
 01 Aug 2011 10:23:54 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Mon, 1 Aug 2011 10:23:34 -0700 (PDT)
In-Reply-To: <201107312252.50467.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178357>

Hi Christian,

Christian Couder writes:
> On Thursday 28 July 2011 18:52:25 Ramkumar Ramachandra wrote:
>> + =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0* Decide what to do depending on the arguments=
; a fresh
>> + =C2=A0 =C2=A0 =C2=A0* cherry-pick should be handled differently fr=
om an existing
>> + =C2=A0 =C2=A0 =C2=A0* one that is being continued
>> + =C2=A0 =C2=A0 =C2=A0*/
>
> It is strange to me that you add this comment only here and not below=
 in
> cmd_cherry_pick(). So I'd suggest to put it before the definition of
> pick_revisions() instead.

=46ixed.

>> + =C2=A0 =C2=A0 if (get_sha1("HEAD", sha1)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (opts->action =3D=3D =
REVERT)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die(_("Can't revert as initial commit"));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("Can't cherry-pick=
 into empty head"));
>> + =C2=A0 =C2=A0 } else
>
> This "else" could be removed.

=46ixed.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 save_head(sha1_to_hex(sh=
a1));
>> + =C2=A0 =C2=A0 save_opts(opts);
>> + =C2=A0 =C2=A0 save_todo(todo_list, opts);
>
> This save_todo() could be removed too as pick_commits() already does =
it.

Consider what effect this will have: pick_commits() may die before it
calls the save_todo() in a couple of ways:
1. The opts->allow_ff assertion block fails.  Although this can't
happen now (due to parse_args already catching it), it might happen
sometime in the future when we have a public API.  The question we
should be asking is: Is it alright to persist the todo in this case?
I'd say no -- the caller needs to be fixed, and persisting the todo
really isn't something I'd expect as an end user at this point.
2. read_and_refresh_cache fails.  Same question: Is it alright to
persist the todo in this case?  Failing to read or refresh the index
is quite a serious error, and persisting a todo is the last thing a
user would expect at this point anyway.  So, no again.

Result: Fixed.

Thanks.

-- Ram
