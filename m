From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] fast-export: output reset command for commandline
 revs
Date: Mon, 7 Nov 2011 02:58:47 -0600
Message-ID: <20111107085846.GA30641@elie.hsd1.il.comcast.net>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
 <1320535407-4933-4-git-send-email-srabbelier@gmail.com>
 <20111106050126.GO27272@elie.hsd1.il.comcast.net>
 <CAGdFq_gkSxvw9Di_mUqS5N0bgCWh-dygMe_DWcR+ENAo=A-3=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 09:59:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNL2h-0002GK-Et
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 09:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670Ab1KGI6z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 03:58:55 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44024 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab1KGI6y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 03:58:54 -0500
Received: by iage36 with SMTP id e36so5623242iag.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 00:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=POaR1Z9jqQOT6B8IOO0L/+9K3veGM2MqpDulVGsccZs=;
        b=uIC1Y6UCaJLtNTy3zu4L8AgtD/u5Op7E7OgcdNTPvEGOnu2g52O4evtFn9dQf8wkM/
         dwJIMcPJd1LNfGoKJ5lvG14hW/FcE5Iw/WaECXiplSz4hdeZ78AJRl2e3KWWsyLbnP3K
         8h3HiLWgDS6Qgu/x5woMyj2QbbEMlpv5bf1II=
Received: by 10.43.44.202 with SMTP id uh10mr8252116icb.46.1320656333783;
        Mon, 07 Nov 2011 00:58:53 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id l28sm37302192ibc.3.2011.11.07.00.58.52
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 00:58:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGdFq_gkSxvw9Di_mUqS5N0bgCWh-dygMe_DWcR+ENAo=A-3=A@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184962>

Sverre Rabbelier wrote:
> On Sun, Nov 6, 2011 at 06:01, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:

>> These details seem like good details for the commit message, so the
>> next puzzled person looking at the code can see what behavior is
>> deliberate and what are the incidental side-effects.
>
> All of it? I wasn't sure what part should go in the commit message.

Yeah.  My rule when in doubt has been to just include everything that
would remain meaningful over time that I could be putting in a cover
letter for the patch.  The hard part is to try to be concise in doing
so.

>> The "git fast-export a..$(git rev-parse HEAD^{commit})" case sounds
>> worth a test.
>
> A test_must_fail?

Yep.

>>> +#define REF_HANDLED (ALL_REV_FLAGS + 1)
>>
>> Could TMP_MARK be used for this?
>
> I don't know its usage, is it?

Since handle_tags_and_duplicates() happens after the main revision
traversal, it would be safe.  But it's probably not good style.  Any
later revwalk would be confused by or clobber that flag.

My actual worry was that if there are too many rev flags some day,
this REF_HANDLED could wrap around to 0.  Now I see that custom
per-command flags are not so rare --- it is just this idiom for
allocating them by adding 1 to the all-ones bitmask that is unusual.

The most common idiom is to simply start with 1u<<16:

	#define REF_HANDLED (1u<<16)

unpack-objects uses 1u<<20 instead.  blame starts with 1u<<12.  reflog
starts with 1u<<10.  A part of me wishes the command-specific flags
were allocated in revision.h like the standard ones so one could write

	#define REF_HANDLED REVFLAGSUSR1

by analogy with SIGUSR1, or that there were some other mechanism for
avoiding collisions.

>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dwim_ref(elem->name, st=
rlen(elem->name), elem->item->sha1, &full_name);
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!prefixcmp(full_nam=
e, "refs/tags/") &&
>>
>> What happens if dwim_ref fails, perhaps because a ref was deleted in
>> the meantime?
>
> That would be bad. I assumed that we have a lock on the refs, should =
I
> add back the die check that's done by the other dwim_ref caller?

Sure, there's a lock.  It doesn't stop a non-git process-gone-mad like
/bin/rm from deleting a file under .git/refs. :)

die()-ing on error sounds sane.

[...]
>> If tag_of_filtered_mode =3D=3D ABORT, we are going to die() soon, ri=
ght?
>
> I don't know to be honest, perhaps we would have already died by now?

It's the handle_tag() call, later in handle_tags_and_duplicates().

[...]
>> When does the !get_object_mark() case come up?
>
> Eh, it has something to do with it being a replacement (rather than
> the same), maybe? This is mostly just taken from Dscho's original
> patch.

Ah, this is similar to the mysterious case from patch 2/3.

Probably this is the "git fast-export a..a" case, where 'a' was not
dumped because UNINTERESTING but we still want to reset refs/tags/a to
point to it.  But won't handle_tag() write

	tags refs/heads/a
	from :0
	[tagger, etc]

when we get to it?

Side question: should the

	for (i =3D extra_refs->nr - 1; i >=3D 0; i--) {

loop should be earlier in the function and set REF_HANDLED where
appropriate, to avoid resets for these objects, too?

[...]
>> Just curious: is the REF_HANDLED handling actually needed? =C2=A0Wha=
t
>> would happen if fast-export included the redundant resets?
>
> That would just be sloppy :). I don't think anything particularly bad
> would happen.

I suppose this is needed to avoid pointless changes in output which
could break git's or other projects' test suites without good reason.
Makes sense.

Thanks for the clarifications.
Jonathan
