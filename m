From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] log-tree: fix patch filename computation in "git format-patch"
Date: Fri, 27 Mar 2009 08:15:11 +0100
Message-ID: <200903270815.11888.chriscool@tuxfamily.org>
References: <20090327011301.a5185805.chriscool@tuxfamily.org> <7v3acziot0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 08:17:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln6K2-0006BY-Kq
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 08:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbZC0HQP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2009 03:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbZC0HQP
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 03:16:15 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:32832 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbZC0HQO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 03:16:14 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 3321AE080FF;
	Fri, 27 Mar 2009 08:16:04 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 3EA09E08124;
	Fri, 27 Mar 2009 08:16:02 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7v3acziot0.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114864>

Le vendredi 27 mars 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > When using "git format-patch", "get_patch_filename" in
> > "log-tree.c" calls "strbuf_splice" that could die with
> > the following message:
> >
> > "`pos + len' is too far after the end of the buffer"
> >
> > if you have:
> >
> > 	buf->len < start_len + FORMAT_PATCH_NAME_MAX
> >
> > but:
> >
> > 	buf->len + suffix_len > start_len + FORMAT_PATCH_NAME_MAX
> >
> > This patch tries to get rid of that bug.
>
> hmm, tries to?

Yeah, I was tired last night, when I created and sent this patch so I k=
new=20
that it could be wrong.

>
> > diff --git a/log-tree.c b/log-tree.c
> > index 56a3488..ade79ab 100644
> > --- a/log-tree.c
> > +++ b/log-tree.c
> > @@ -187,16 +187,17 @@ void get_patch_filename(struct commit *commit=
,
> > int nr, const char *suffix,
> >
> >  	strbuf_addf(buf, commit ? "%04d-" : "%d", nr);
> >  	if (commit) {
> > +		int max_len =3D start_len + FORMAT_PATCH_NAME_MAX;
> >  		format_commit_message(commit, "%f", buf, DATE_NORMAL);
> >  		/*
> >  		 * Replace characters at the end with the suffix if the
> >  		 * filename is too long
> >  		 */
> > +		if (buf->len + suffix_len > max_len) {
> > +			int base =3D (max_len > buf->len) ? buf->len : max_len;
> > +			strbuf_splice(buf, base - suffix_len, suffix_len,
> > +				      suffix, suffix_len);
> > +		} else
> >  			strbuf_addstr(buf, suffix);
>
> Your third argument to splice does not look right; if the existing le=
ngth
> is very very long, you would need to remove a lot, and if the existin=
g
> length is slightly long, you would need to remove just a little bit, =
but
> you always seem to remove the fixed amount, to splice the suffix in.
>
> In any case, why does this have to be so complex?
>
> In your buffer, you originally have start_len, and would want to end =
up
> with "%f" expansion, plus the suffix, but you are not allowed to exce=
ed
> FORMAT_PATCH_NAME_MAX to store what you add, and are only allowed to =
chop
> the "%f" expansion if you are short of room.
>
> Shouldn't it be just:
>
> 	size_t max_len =3D start_len + FORMAT_PATCH_NAME_MAX - suffix_len;
>         if (max_len < buf->len)
>                 strbuf_setlen(buf, max_len);
> 	strbuf_addstr(buf, suffix);
>
> The caller must make sure that suffix_len is sufficiently shorter tha=
n
> FORMAT_PATCH_NAME_MAX; I do not know if the current code does that,
> though.

Yes, this looks better.

Thanks,
Christian.
