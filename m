From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv5 1/3] submodule: Reimplement `module_list` shell function
 in C
Date: Thu, 3 Sep 2015 12:18:51 -0700
Message-ID: <CAGZ79kb5_VJwJoBpvUdVMC43qvJThKa1utQFO68HjM1sciZ6-w@mail.gmail.com>
References: <1441230146-26921-1-git-send-email-sbeller@google.com>
	<1441230146-26921-2-git-send-email-sbeller@google.com>
	<xmqqio7rjppv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 21:18:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXa2C-0001wX-58
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 21:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbbICTSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 15:18:53 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33257 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbICTSw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 15:18:52 -0400
Received: by ykei199 with SMTP id i199so53864438yke.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 12:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=M1xKFlwE4NvSaGHqo9Zc1CZLv7rPUy7f/lir1vkkX5s=;
        b=ikQQ1fdwltJ0+ErR35RnbqA06kED5m/8B5ylSAHKmNd7CNAFMax//vQVRztv4RgoUI
         MftMQqjMP2SrEEv8ofgF3sN9vt3wLk8wW4Fy/LWfb44CddKzLDG960a8aTbSU/TeX5Ni
         gK5LEWKvw5peLm3pMKEso94MbeoNKAafzruFegFqOBZ80nJRM6Gka/z0sRN897NZyRV2
         +VM4A/5xefxoA514SnnPiCqlZZJzHTXvSxpunkDIXnqNbW03U4h9t/oQhrrPvVFdNgD9
         raavOCWLfGJ/yANcpNhMgeT2cmT7cFc0MLlFj6HfIY9dJPl3WUTs1uPO/OXp8/ZtTwKd
         ZkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=M1xKFlwE4NvSaGHqo9Zc1CZLv7rPUy7f/lir1vkkX5s=;
        b=A6W1hFTwcX0tMaEd99yEn/SgUhc1YIH2IK6V6Qw7mOCDag1eqJHhPPpvNrqjppt9uW
         aS5jDkIAz6yFJVKBJTYH76pGM2EGrj0/DZbCkPDf+njOToaOvSqu43uwa/8Yn9OvFqJX
         0QFkUi03aPLtlEgCD3gyUSZ66krvNNSpifYdEMYvtrxCvzdg2/uZRW0GExfwB6CqhkQq
         b3usGHa28iIUxvTYtycCufnvcluB2AryoSu/24BuOBo8u+FNsRyUhi/Hd+LiR5YnI2Dw
         5l1EJiEdj5TIwahiL57aJORNvkvilEbTjZWDqH6ck0ryRPc10UFRwy0j1LqpenVppiGq
         Cenw==
X-Gm-Message-State: ALoCoQmn4eKcPHUGOuNZiR3KNnvKuOknihBwqLDnTv9CwFka10RHqONUlwRJHIguwkN85JzVHbqA
X-Received: by 10.170.198.198 with SMTP id p189mr12666122yke.56.1441307931720;
 Thu, 03 Sep 2015 12:18:51 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Thu, 3 Sep 2015 12:18:51 -0700 (PDT)
In-Reply-To: <xmqqio7rjppv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277241>

On Thu, Sep 3, 2015 at 11:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> It is customary to use X_alloc, X_nr for an array X_something that
> is managed by ALLOC_GROW(), I think.  I'd also suggest wrapping
> these in a struct and passing it between module_list_compute() and
> its callers.

I did not take the suggestion as a strong suggestion at the time, but the
looking at resulting squash proposal it looks way better.

> I may have said this already, but unlike tree entries, the index
> entries will never be a directory.  S_ISDIR() check here is
> meaningless [*1*].

Right. I was too focused on the other bug, of checking S_ISGITLINK after
the pathspec matching, that I overlooked the ISDIR again. :(

>> +int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>> +{
>> +     int i;
>> +     if (argc < 2)
>> +             die(_("fatal: submodule--helper subcommand must be "
>> +                   "called with a subcommand"));
>> +
>> +     for (i = 0; i < ARRAY_SIZE(commands); i++)
>> +             if (!strcmp(argv[1], commands[i].cmd))
>> +                     return commands[i].fn(argc - 1, argv + 1, prefix);
>> +
>> +     die(_("fatal: '%s' is not a valid submodule--helper "
>> +           "subcommand"), argv[1]);
>> +}
>
> Nice and clean code structure.  I like it ;-).

It took a good while of discussion and reviews to arrive at
that structure eventually.

The squash proposal looks good to me.
