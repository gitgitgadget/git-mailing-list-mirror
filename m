From: Ray Donnelly <mingw.android@gmail.com>
Subject: Re: [PATCH 1/2] test-path-utils.c: remove incorrect assumption
Date: Sun, 4 Oct 2015 15:51:22 +0100
Message-ID: <CAOYw7dv4iPQ4cq4Ab1ZeThrp=u51T5v387a1Y8QPO-yj=fyMcg@mail.gmail.com>
References: <CAOYw7dubGJ=m5+EnjGy7jTQxR+b0uBmyG138KEQ5rzX2K7WcgA@mail.gmail.com>
	<xmqqlhbj3mfo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 16:51:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zikdl-0006U8-FP
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 16:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbbJDOvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 10:51:23 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:36504 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbbJDOvX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 10:51:23 -0400
Received: by obcgx8 with SMTP id gx8so112182013obc.3
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 07:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DRu1g1Q8JKnmUtk0xAj5OUqrFcWTE+z/jgg0+l+Ue2k=;
        b=SDm6ucVkibALwq3qo63d4hCdXU+Zjzxg+UG9yTVxnQupTMb2anoB5X5WMYjBt0IyIB
         FgqvvYAcim6NKJAymQjJc4T3V6LEON8rRCg2pDFCHM3Hr7kUFl41v81G/82NPxld+dna
         4xthu+JoNBkvFlGbY5KvE6OWI3sJl83cyhSLrz8641cPMEGM3xOIfdhfCHodeC8qnhcf
         pDfOE7tmU7xw10YOLrtfIrKemUuJLoyZHvJfsHrbQ2gG7SfrxFuRZ2WfN74bdmdUskDv
         BWObFD5Y+/NP8Sem6KxvosBtOwTgUztO/sMgtseiT8DDhwpbx1iFlUzwI/6K7yX4Nebt
         mIFA==
X-Received: by 10.182.205.200 with SMTP id li8mr15402163obc.18.1443970282508;
 Sun, 04 Oct 2015 07:51:22 -0700 (PDT)
Received: by 10.202.15.21 with HTTP; Sun, 4 Oct 2015 07:51:22 -0700 (PDT)
In-Reply-To: <xmqqlhbj3mfo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279000>

On Sat, Oct 3, 2015 at 6:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ray Donnelly <mingw.android@gmail.com> writes:
>
>> In normalize_ceiling_entry(), we test that normalized paths end with
>> slash, *unless* the path to be normalized was already the root
>> directory.
>>
>> However, normalize_path_copy() does not even enforce this condition.
>
> Perhaps the real issue to be addressed is the above, and your patch
> is killing a coalmine canary?
>
> Some callers of this function in real code (i.e. not the one you are
> removing the check) do seem to depend on that condition, e.g. the
> codepath in clone that leads to add_to_alternates_file() wants to
> make sure it does not add an duplicate, so it may end up not noticing
> /foo/bar and /foo/bar/ are the same thing, no?  There may be others.
>
>

Enforcing that normalize_path_copy() removes any trailing '/' (apart
from the root directory) breaks other things that assume it doesn't
mess with trailing '/'s, for example filtering in ls-tree. Any
suggestions for what to do about this? Would a flag be appropriate as
to whether to do this part or not? Though I'll admit I don't like the
idea of adding flags to modify the behavior of something that's meant
to "normalize" something. Alternatively, I could go through all the
breakages and try to fix them up?
