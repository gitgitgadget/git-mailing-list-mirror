From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Sat, 22 Feb 2014 07:36:06 +0700
Message-ID: <CACsJy8DnjQyzY2ym7=fAQzThuhMuFzGLuKc35JJXn5FfB7r4Gg@mail.gmail.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
 <87r470ssuc.fsf@fencepost.gnu.org> <CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
 <87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com> <xmqqzjlocf28.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, David Kastrup <dak@gnu.org>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 22 01:36:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH0aB-0008Er-1y
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 01:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160AbaBVAgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 19:36:38 -0500
Received: from mail-qc0-f177.google.com ([209.85.216.177]:64397 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494AbaBVAgh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 19:36:37 -0500
Received: by mail-qc0-f177.google.com with SMTP id i8so6865239qcq.22
        for <git@vger.kernel.org>; Fri, 21 Feb 2014 16:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=un5f55jrInJV+slhmUH4AXcZbfA/+YPS/qxc9dLKRrA=;
        b=gWf7nK6YfLd1zNKvAzspb5zUMrRXUgY55nr+Z70QIqp/JYwGiASm4DARQNFZeAEo1z
         sESWkoUSzRsiKlpTEhqYbOrb0rfRS7HvjQfl0rb1UcMVH+hqhMgO3/3wPWMgqr5uW5ZB
         NgVJLNLovOF0mh8UosKz/iKO5uYPdmTeBbe/m0yFmTPCLLS1rA8vclYRqCuy1pKaKkX2
         hxF9KXXnb06WBwQlCbCIojUKYVixFAZ773jbcFgMWHvHnVA+grk2bMFGyNosfVbX0FyX
         EXmQ0LjXJjYR5jdGdQuJV6zEktghoSdw2Q/DqyHEO3cDxdEykJE+7NpF2zEluwZ1XD/e
         qIrA==
X-Received: by 10.140.47.212 with SMTP id m78mr13461781qga.21.1393029397007;
 Fri, 21 Feb 2014 16:36:37 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 21 Feb 2014 16:36:06 -0800 (PST)
In-Reply-To: <xmqqzjlocf28.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242495>

On Wed, Feb 19, 2014 at 3:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I didn't know --agressive was so aggressive myself, as I personally
> never use it. "git repack -a -d -f --depth=32 window=4000" is what I
> often use, but I suspect most people would not be patient enough for
> that 4k window.
>
> Let's do something like this first and then later make --depth
> configurable just like --width, perhaps?  For "aggressive", I think
> the default width (hardcoded to 250 but configurable) is a bit too
> narrow.

OK with git://git.savannah.gnu.org/emacs.git we have

 - a 209MB pack with --aggressive
 - 1.3GB with --depth=50
 - 1.3GB with --window=4000 --depth=32
 - 1.3GB with --depth=20
 - 821MB with --depth=250 for commits --before=2.years.ago, --depth=50
for the rest

So I don't think we should go with your following patch because the
size explosion is just too much no matter how faster it could be. An
immediate action could be just make --depth=250 configurable and let
people deal with it. A better option is something like "3 repack
steps" you described where we pack deep depth first, mark .keep, pack
shallower depth and combine them all into one.

I'm not really happy with --depth=250 producing 209MB while
--depth=250 --before=2.year.ago a 800MB pack. It looks wrong (or maybe
I did something wrong)

>
>  builtin/gc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 6be6c8d..0d010f0 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -204,7 +204,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>
>         if (aggressive) {
>                 argv_array_push(&repack, "-f");
> -               argv_array_push(&repack, "--depth=250");
> +               argv_array_push(&repack, "--depth=20");
>                 if (aggressive_window > 0)
>                         argv_array_pushf(&repack, "--window=%d", aggressive_window);
>         }



-- 
Duy
