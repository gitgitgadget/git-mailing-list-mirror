From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 07/11] branch: move 'current' check down to the
 presentation layer
Date: Thu, 30 Jul 2015 00:22:31 +0530
Message-ID: <CAOLa=ZRUnF12gO=AKg3E373XETqoykqOXSkPvr7DHCVrOeggAA@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-7-git-send-email-Karthik.188@gmail.com>
 <vpqbnewxwcx.fsf@anie.imag.fr> <CAOLa=ZTy+KX4K_inpDoMy+thzFdF2RF93yMEHJUExzT4OvjPww@mail.gmail.com>
 <vpqk2tjmgeg.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 29 20:53:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKWTU-0003zO-Fu
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 20:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbbG2SxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 14:53:03 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33691 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbbG2SxB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 14:53:01 -0400
Received: by obdeg2 with SMTP id eg2so14241939obd.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 11:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pogkKXBHVdahfWyqe3S8zne8haiZV1v6iL8NgG9WAyI=;
        b=p8twEOPgBNGGrfGndHpfiEBlnYNyIa551P4WygL05jlOFs+bkQh8bNnsAwGp2VnmHN
         smK2lv/hUAYm6FUhODiqShRgqVN1TagdqjWGQBOhvFC+H4DrdJxTs8Dx06bfC/soYx00
         VS4ubdgi0+uGL0ZNMt7rrcciBAGqik+5MlL+6GSH1HJVHARLry3b2dZIEP3I6L7sfTfu
         tA4VV1AkidOKTr4fu9NnKIU/+z9OWHvwinFiNZMLhXq+b6rtdKUhOXMk3+SJrQq34CW+
         nIicKeM0wfyG6p+JBpuzpjw07uheSejV7xo86ae/ZJHWNt57Mw6XOcJ0gyF0TG3E7/SP
         Nk8Q==
X-Received: by 10.182.29.68 with SMTP id i4mr40926638obh.57.1438195980907;
 Wed, 29 Jul 2015 11:53:00 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Wed, 29 Jul 2015 11:52:31 -0700 (PDT)
In-Reply-To: <vpqk2tjmgeg.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274935>

On Wed, Jul 29, 2015 at 3:31 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Tue, Jul 28, 2015 at 6:39 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> We check if given ref is the current branch in print_ref_list().  Move
>>>> this check to print_ref_item() where it is checked right before
>>>> printing.
>>>
>>> This means that the '*' and the different color are coded in C, hence
>>> it's not possible to mimick this using "git for-each-ref --format ...".
>>>
>>> I do not consider this as blocking, but I think the ultimate goal should
>>> be to allow this, so that all the goodies of "git branch" can be made
>>> available to other ref-listing commands.
>>>
>>
>> Not sure what you mean here.
>
> What you already know, but probably badly explained ;-).
>
> Eventually, the output of "git branch" should correspond to a format
> string (so git branch would be almost an alias for "git for-each-ref
> refs/heads/ --format '...'"). Internally, this would mean using
> show_ref_array_item instead of print_ref_item. This is what you managed
> to do for "git tag".
>
> You already identified one difficulty with sha1 alignment in "git branch
> -v". I'm pointing out another which is that displaying the "*" in front
> of the current branch is currently not possible with a format string.
> You would need an atom like %(displayAStarIfTheBranchIsTheCurrentOne)
> (for which you'd need to find a short-and-sweet name ;-) ).
>

What I was thinking of was something like this :

struct strbuf format = STRBUF_INIT;
char c = ' ';
if (current)
    c = '*';
strbuf_addf(&format, "%c....", c, other format options...);
show_ref_array_item(item, format.buf, quote_style, 0);
strbuf_release(&format);

This would remove the need of making the printing of the "*" to be
needed by ref-filter. As this is only needed in branch.c

If going on what you're saying we could have a "%(starifcurrent)" atom or
something, but I don't see a general use for this.


-- 
Regards,
Karthik Nayak
