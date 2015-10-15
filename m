From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3] merge: fix cache_entry use-after-free
Date: Thu, 15 Oct 2015 15:02:44 -0400
Organization: Twitter
Message-ID: <1444935764.20887.1.camel@twopensource.com>
References: <1444860424-8361-1-git-send-email-dturner@twopensource.com>
	 <561F1EE5.5070300@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Keith McGuigan <kmcguigan@twitter.com>
To: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Thu Oct 15 21:02:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zmnng-0003cJ-M8
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbbJOTCs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Oct 2015 15:02:48 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33028 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbbJOTCr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:02:47 -0400
Received: by qkas79 with SMTP id s79so44242106qka.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=fWitAUtRtz1I6BVRKnbmhH4GhJuymsaPCTkVi8xJo64=;
        b=PUZAgPq+/gz9Ug/xLfbOfojqNUH5uvOMSOeqd9MJlYXhy5yI8U00CEUYz6dym4weCw
         WAqIAePFLeGle3Iifk+ZKDJXZQAVrnXF/ZPx8Lu/Oz2PSpQH9WOiA3bEfO6Qcanqa2xq
         zjtBOgtFLfeL/6pi4tOp4t2Rsu9P3op4jAwAgmPHs/4ax1qND4tWqHiHXeDej6Utd0Lk
         vyv6LF2p2Gdd83jcMpapUDFFhEdEG9oRQRumU+fRCIKoUQLIFLkqvLutayT0c9DKJh5V
         MVuWXvhpAw8wgdP3zCu+OFwaDElhW61sIh0S9c38fdizLalRFSazmNzJ3oQgqneHK7Mp
         rS2g==
X-Gm-Message-State: ALoCoQn2GDEKMqmFU5i7pwuUuwjTwzK9XStxqnQnPjmiPgjuuBMJJuXRueSxsDJhoAr/j9LFoMnL
X-Received: by 10.55.207.134 with SMTP id v6mr13846627qkl.53.1444935766035;
        Thu, 15 Oct 2015 12:02:46 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b36sm4816703qge.23.2015.10.15.12.02.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2015 12:02:45 -0700 (PDT)
In-Reply-To: <561F1EE5.5070300@web.de>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279677>

On Thu, 2015-10-15 at 05:35 +0200, Ren=C3=A9 Scharfe wrote:
> Am 15.10.2015 um 00:07 schrieb David Turner:
> > From: Keith McGuigan <kmcguigan@twitter.com>
> >
> > During merges, we would previously free entries that we no longer n=
eed
> > in the destination index.  But those entries might also be stored i=
n
> > the dir_entry cache, and when a later call to add_to_index found th=
em,
> > they would be used after being freed.
> >
> > To prevent this, add a ref count for struct cache_entry.  Whenever
> > a cache entry is added to a data structure, the ref count is increm=
ented;
> > when it is removed from the data structure, it is decremented.  Whe=
n
> > it hits zero, the cache_entry is freed.
> >
> > Signed-off-by: Keith McGuigan <kmcguigan@twitter.com>
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >
> > Fix type of ref_count (from unsigned int to int).
> >
> >
> >   cache.h        | 27 +++++++++++++++++++++++++++
> >   name-hash.c    |  7 ++++++-
> >   read-cache.c   |  6 +++++-
> >   split-index.c  | 13 ++++++++-----
> >   unpack-trees.c |  6 ++++--
> >   5 files changed, 50 insertions(+), 9 deletions(-)
> >
> > diff --git a/cache.h b/cache.h
> > index 752031e..7906026 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -149,6 +149,7 @@ struct stat_data {
> >
> >   struct cache_entry {
> >   	struct hashmap_entry ent;
> > +	int ref_count; /* count the number of refs to this in dir_hash */
> >   	struct stat_data ce_stat_data;
> >   	unsigned int ce_mode;
> >   	unsigned int ce_flags;
> > @@ -213,6 +214,32 @@ struct cache_entry {
> >   struct pathspec;
> >
> >   /*
> > + * Increment the cache_entry reference count.  Should be called
> > + * whenever a pointer to a cache_entry is retained in a data struc=
ture,
> > + * thus marking it as alive.
> > + */
> > +static inline void add_ce_ref(struct cache_entry *ce)
> > +{
> > +	assert(ce !=3D NULL && ce->ref_count >=3D 0);
> > +	ce->ref_count++;
> > +}
> > +
> > +/*
> > + * Decrement the cache_entry reference count.  Should be called wh=
enever
> > + * a pointer to a cache_entry is dropped.  Once the counter drops =
to 0
> > + * the cache_entry memory will be safely freed.
> > + */
> > +static inline void drop_ce_ref(struct cache_entry *ce)
> > +{
> > +	if (ce !=3D NULL) {
> > +		assert(ce->ref_count >=3D 0);
>=20
> Shouldn't this be "> 0" to prevent double frees?

No.  If the ref_count is 1, then there is still some reference to the
ce.  If it is 0, there is no reference to it, and the next check (< 1)
will succeed and the ce will get freed. =20

> > +		if (--ce->ref_count < 1) {
> > +			free(ce);
> > +		}
> > +	}
> > +}
>=20
