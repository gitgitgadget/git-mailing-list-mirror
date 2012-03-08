From: Dominique Quatravaux <domq@google.com>
Subject: Re: [PATCH 1/2] rebase -i: optimize the creation of the todo file
Date: Thu, 8 Mar 2012 12:48:24 +0100
Message-ID: <CAJh6GrGWfyKguhgf9dJR4yG3qYjh2jJz7OzzN8wao0rWLcohoA@mail.gmail.com>
References: <1331203358-28277-1-git-send-email-domq@google.com> <87boo7pdvc.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 08 12:49:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5bqA-0004HS-JJ
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 12:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757172Ab2CHLss convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 06:48:48 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:37540 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757043Ab2CHLsp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 06:48:45 -0500
Received: by wejx9 with SMTP id x9so250155wej.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 03:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=/79aOJQBUsnnlcfOK3fWpFVGikm8j4zTiw6/xYW9QpQ=;
        b=TdYDveBKMGerfpJjxJs6+C64zDAagFc/UnTrrwsfND5GBIIyd1+20NsumgObcYhwd/
         pK4O8CEp0uaOasE6u/XEPr1Y3FiHwv/zfLJkyqoyQd09tm2hx0TMtIpk9zSZm9BhSBBt
         HDIP/kTkSWTsz0RPIfEfdX6xJYPM6B8qjb7PevDrnhu17/Tx5Zr7zRUuGS3Kje0teN+M
         TSLn8HybrFyovm6qEDh1aKaUXCdn2FyZlM9Vyc02aZypjekuErZwDtICAKipvCu7eyOp
         +jjTqgdIY27y+LgmgJ8EYF/2ZetN+I71pMTvNL2ETIXEyPW2/Dqu4OPLcYcVlf+jbzJE
         WsoQ==
Received: by 10.180.95.34 with SMTP id dh2mr12038324wib.15.1331207324606;
        Thu, 08 Mar 2012 03:48:44 -0800 (PST)
Received: by 10.180.95.34 with SMTP id dh2mr12038281wib.15.1331207324321; Thu,
 08 Mar 2012 03:48:44 -0800 (PST)
Received: by 10.227.7.138 with HTTP; Thu, 8 Mar 2012 03:48:24 -0800 (PST)
In-Reply-To: <87boo7pdvc.fsf@thomas.inf.ethz.ch>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQneivV13QHhV+KO7GwbdmVDnDMy4GAsyLOMkAYVuSPuz9hO4oWrLwVa21bFj7QJEgu7uak5/9nyHTGtQeGOXPJRyIDatbxUx5AEI0O7H8JdH/18lb0mp0sFJxp8HOTi8YetVv6/1PDZTcHf3DXtZa+ZR/LEdw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192572>

On Thu, Mar 8, 2012 at 11:48 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Dominique Quatravaux <domq@google.com> writes:
>
>> Instead of obtaining short SHA1's from "git rev-list" and hitting th=
e repository
>> once more with "git rev-parse" for the full-size SHA1's, obtain long=
 SHA1's from
>> "git rev-list" and truncate them with "cut".
>
> That doesn't work if there are 7-digit SHA1 collisions in the repo.

I don't see how my patch changes the picture wrt SHA1 collisions. In
the current state, the rebase todo already uses short SHA1s.

> Even my git.git has a bunch of them, as checked with
>
> =A0git rev-list --objects --all | cut -c1-7 | sort | uniq -d
>
> and I expect a bigger project would have collisions beyond the 9th
> digit.
>
> What you can, however, do:
>
>> -git rev-list $merges_option --pretty=3Doneline --abbrev-commit \
>> - =A0 =A0 --abbrev=3D7 --reverse --left-right --topo-order \
>> +git rev-list $merges_option --pretty=3Doneline --no-abbrev-commit \
>> + =A0 =A0 --reverse --left-right --topo-order \
>> =A0 =A0 =A0 $revisions | \
>
> rev-list can give you *both* the abbreviated and full SHA1s if you sa=
y
>
> =A0git rev-list $merges_option --format=3D"%>%h %H %s" <...etc...>

Interesting, thanks! It seems that %h works with find_unique_abbrev
which according to the name, should Do The Right Thing. I'll update my
patch.


--=20
=A0 Dominique Quatravaux
=A0 +41 79 609 40 72
