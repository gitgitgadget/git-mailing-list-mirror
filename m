From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3] merge: fix cache_entry use-after-free
Date: Fri, 16 Oct 2015 03:05:40 -0400
Organization: Twitter
Message-ID: <1444979140.20887.19.camel@twopensource.com>
References: <1444860424-8361-1-git-send-email-dturner@twopensource.com>
	 <561F1EE5.5070300@web.de> <1444935764.20887.1.camel@twopensource.com>
	 <xmqqfv1bhn2t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	git@vger.kernel.org, Keith McGuigan <kmcguigan@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 09:05:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zmz5I-000565-Tu
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 09:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbbJPHFo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Oct 2015 03:05:44 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34790 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbbJPHFn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 03:05:43 -0400
Received: by payp3 with SMTP id p3so64537743pay.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 00:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=Q6oy4wcaQQRvmBreDPJT69T8YySYcai9ZJYW/DCePWE=;
        b=dKFenlVQMO4QxW4727reKrM7eMgm3TLWrFWamBLWKpmu+v/4MEfalmiovA0KzqxxYb
         q+cUBwlSQYlIHCObkjrZPs+fPgB1ZGQNCGuvHon52MByFg4JNdzgbGOSrocgPGLSLlqA
         O0gHSQ9pk3Mcw3xVAXOFlQQ/kf8mfbKCKtTpZj5M9Y5K/eAV/CjgnOhfGOU+F7LLYbuF
         YXereAovijZN/OLugeRnKsJGVtw7a4QZhBYEr1Pg9qWwcgoy/tuD0kzNuKRnxuddzj2B
         OP+J3STlcAYqfPYStyLnfUnb+mSZBNgeerSD5zZjHdowZWR8a5EJcudGu8jcCdjE+3bM
         gahw==
X-Gm-Message-State: ALoCoQmw62ulk4PNTO+IcWo62ktSBSStZ2vXJd1K+3lobnOBws0gLnJEBRofXFwbyxhmOlMTLj6w
X-Received: by 10.68.68.167 with SMTP id x7mr14599683pbt.140.1444979143458;
        Fri, 16 Oct 2015 00:05:43 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id sl7sm19211248pbc.54.2015.10.16.00.05.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Oct 2015 00:05:42 -0700 (PDT)
In-Reply-To: <xmqqfv1bhn2t.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279731>

On Thu, 2015-10-15 at 13:51 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
>=20
> >> > +static inline void drop_ce_ref(struct cache_entry *ce)
> >> > +{
> >> > +	if (ce !=3D NULL) {
> >> > +		assert(ce->ref_count >=3D 0);
> >>=20
> >> Shouldn't this be "> 0" to prevent double frees?
> >
> > No.  If the ref_count is 1, then there is still some reference to t=
he
> > ce.  If it is 0, there is no reference to it, and the next check (<=
 1)
> > will succeed and the ce will get freed. =20
> >
> >> > +		if (--ce->ref_count < 1) {
> >> > +			free(ce);
> >> > +		}
> >> > +	}
> >> > +}
>=20
> Hmm, but it still feels fuzzy, no?  I cannot tell from the above
> exchange if a ce with ref_count=3D=3D0 upon entry to this function is
> supposed to have somebody pointing at it, somebody just assigned
> NULL (or another pointer) to the last pointer that was pointing at
> it, or what else.  If the expected calling sequence were:
>=20
> 	drop_ce_ref(thing->ce);
> 	thing->ce =3D NULL;
>=20
> and the original thing->ce were the last reference to the cache
> entry about to be freed, its refcnt is better be 1 not 0.  And when
> this function decrements refcnt down to 0, the cache entry is freed.
>=20
> Admittedly, if the original refcnt were 0, with signed refcnt, it
> will decrement to -1 and it will be freed, too, but I do not think
> that is what was intended---refcnt is initialized to 0 upon creating
> an unreferenced cache entry, and set_index_entry() and friends that
> store a pointer to anything calls add_ce_ref(), so I read the code
> as intending to make "0 means no pointer points at it".
>=20
> As far as I can tell, the only effect of this assert() that uses >=3D=
0
> not >0 is to avoid triggering it on this calling sequence:
>=20
>     new_ce =3D new_cache_entry();
>     drop_ce_ref(new_ce);
>=20
> that is, you create because you _might_ use it, and then later
> decide not to use it (and the free() part wouldn't have worked
> correctly with unsigned refcnt ;-).

You and Ren=C3=A9 are right: there is an off-by-one here.  Will fix and
re-roll.  Thanks.

> By the way, the log message says "During merges, we would previously
> free entries that we no longer need in the destination index.  But
> those entries might also be stored in the dir_entry cache," as if
> this issue were present and waiting to trigger for all merges for
> all people.  Given that Linus does hundreds of merges in a day
> during the merge window (and I do several dozens a day), I am quite
> surprised that nobody noticed this issue.  If there is a more
> specific condition that allows this bug to trigger (e.g. "dir-entry
> cache is used only under such and such conditions") that the log
> message does not talk about to explain why this bug was not seen
> widely, it would be a good thing to add.  It is very puzzling
> otherwise.

We also do dozens or hundreds of merges per day and only saw this quite
rarely.  Interestingly, we could only trigger it with an alternate
hashing function for git's hashmap implementation, and only once a
certain bug in that implementation was *fixed*.  But that was just a
trigger; it was certainly not the cause.  The bug would, in general,
have caused more hash collisions due to worse mixing, but I believe it
is possible that some particular collision would have been present in
the non-bugged version of the code but not in the bugged version.

It may have also had something to do with a case-insensitive filesystem=
;
we never saw anyone reproduce it on anything but OS X, and even there i=
t
was quite difficult to reproduce.

In short, I don't think we know why the bug was not seen widely.
