From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v7 2/2] Verify index file before we opportunistically
 update it
Date: Sat, 12 Apr 2014 17:13:48 +0700
Message-ID: <CACsJy8C=a6a4COBdG9uLo5XNViK6Lb3+ZyWM1P_e9p7qu+shkQ@mail.gmail.com>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
 <1397154681-31803-1-git-send-email-yiannis.marangos@gmail.com>
 <1397154681-31803-2-git-send-email-yiannis.marangos@gmail.com>
 <xmqqppkpvv9m.fsf@gitster.dls.corp.google.com> <CACsJy8A5VJM4gnJGazkzniv5YxRx0xR7YEFpQbU+kVGofQ1b_g@mail.gmail.com>
 <xmqqtx9zsm8p.fsf@gitster.dls.corp.google.com> <xmqqmwfrr3zw.fsf@gitster.dls.corp.google.com>
 <CACsJy8ASAvopmyhawmUkuFk4DjBd2opL1kxu_jtopTDr80BWPg@mail.gmail.com> <7vmwfrmb6a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 12:14:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYux6-0001Z1-Qb
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 12:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346AbaDLKOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 06:14:20 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:33640 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027AbaDLKOS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 06:14:18 -0400
Received: by mail-qg0-f53.google.com with SMTP id f51so5622933qge.26
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 03:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jYQTkUnurnJcm3cWgR0mSI5QZE5B2fa4Jw0kTNmpY3Y=;
        b=cfr/UgRuGudveedN43gpWwuA+csU4Nxcms6qgHZcnTNIPGqDDFr1uhr21OGpAs1v6U
         K+2usHUb/vgP7GGGOgEn5HzHevi1uM5n5HVJzSjMB/Q/WY8ufEn4+BNvDMS7a3GnjDxR
         PgpVQX53kC24FNaTvHqkUSQm4Vln07XWuSFTtNHs0mBeI6xldhc2AEuGWLhEsE0TEybp
         h/MxPVSE7Nk/SfLSsZOCRmci00M1zqj+gJEUfdBopvDBIZYbvc2ojv9nkCdKPE2AM3xz
         5KFbPMjwhflrO2B3w/i6Mv6hw/8VvN0e5AejqAwJi6uFXgeOt9zmPakbBwvBrWwGXxdT
         /nlw==
X-Received: by 10.224.47.8 with SMTP id l8mr32392900qaf.24.1397297658386; Sat,
 12 Apr 2014 03:14:18 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Sat, 12 Apr 2014 03:13:48 -0700 (PDT)
In-Reply-To: <7vmwfrmb6a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246165>

On Sat, Apr 12, 2014 at 11:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sat, Apr 12, 2014 at 3:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Having said that, nobody sane would be running two simultaneous
>>> operations that are clearly write-oriented competing with each other
>>> against the same index file.
>>
>> When it comes to racing, sanity does not matter much. People could
>> just do it without thinking what exactly is happening behind the
>> scene.
>
> Well, "a race is a race is a race" would also be my knee-jerk
> reaction when anybody utters the word "race", but you need to
> realize that we are not talking about races like object creation
> while "gc --auto" running in the background or two pushes trying to
> update the same ref to different values, which are meaningful use
> cases.
>
> What is the race under discussion about?  It is about the index,
> which corresponds one-to-one to the working tree, so in order for
> the "race" to matter, you need to be racing against another process
> that is not cooperating with you (e.g. a continuous and uncontrolled
> "git add" updating the index while you are doing a real work),
> mucking with the index in the same working tree.  How could such a
> workflow any useful in the real life?
>
> In the spectrum between useful and insane, there is a point where we
> should just tell the insane: don't do it then.

The thing is people do not usually have that level of knowledge of how
git works. They could write a cron job to do something in some repos,
not aware at all about these non-cooperations. Telling people not to
automatically touch a git directory at all is a bit extreme. I think
this patch is about guarding the user from shooting themselves. Either
a command works correctly, not not work at all. A process' dying is a
way of telling people "this is insane" without having to draw a line
between dos and dont's in documents.

Serializing write access to make both competing processes is nice, but
that's a separate step that may or may not be worth pursuing. And I'm
towards not worth pursuing. As you metioned in the next mail,
serializing helps two competing processes, but not two command
sequences.
-- 
Duy
