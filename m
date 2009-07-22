From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH v3] grep: Add --max-depth option.
Date: Wed, 22 Jul 2009 18:00:38 +0200
Message-ID: <20090722180038.16a76b95@gmail.com>
References: <1248213064-1541-1-git-send-email-michal.kiedrowicz@gmail.com>
	<4A66BB64.5070106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 18:01:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTeFv-0000N5-EF
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 18:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbZGVQAo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 12:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbZGVQAo
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 12:00:44 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:51120 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbZGVQAn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 12:00:43 -0400
Received: by ewy26 with SMTP id 26so327400ewy.37
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=ILrrzP4SvWOH2OsbxB6vbkHMESaKUhUCyn4plH39i68=;
        b=qPGkziZy2Mq1Ts5kVM7Fls1OObl2/kv5IS44lQCe6GA5rpF1DoJPRTowqiklvFJIiq
         G3pDMUh8FLCQgLhpN20FU2UKBCOCq39aKG6/xZ8l0NmgkJCFtoP7+evCZ/Yzvedua9VS
         6iuEntB8R/a2ZPzatbHp8zkeHcjxfrhc81nS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=lgg4BTg40ZqILksCQv4oAMMfDDBFBRPSVpAdazp+qwo5QuXBEK/xZAyjxeUpxzwdA0
         m35dtBR69+8YHC85fykk7J4bqO7IT5K24JyC/fFGPr0uVmsDMlIzSbm8rOLeu2lpWahn
         Ilk0dI7EESOoKIfq4Iq4WYgku/0Di0VzLW03w=
Received: by 10.210.115.15 with SMTP id n15mr805023ebc.30.1248278442212;
        Wed, 22 Jul 2009 09:00:42 -0700 (PDT)
Received: from localhost (87-205-60-143.adsl.inetia.pl [87.205.60.143])
        by mx.google.com with ESMTPS id 5sm10742eyf.28.2009.07.22.09.00.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 09:00:42 -0700 (PDT)
In-Reply-To: <4A66BB64.5070106@gmail.com>
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123753>

Stephen Boyd <bebarino@gmail.com> wrote:

> Micha=C5=82 Kiedrowicz wrote:
> >
> > Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> > ---
>=20
> Would have been nice to see a comment here saying what's changed sinc=
e
> v2.=20

Sorry, I did that when I sent v2, but this time when I remembered about
ti, it was already too late :)

> Looks like you renamed it to --max-depth, added some new inline
> functions, and fixed up the test style issues?
>=20

Yes, I followed your and Ren=C3=A9's suggestions and added ability to
specify max number of levels.

> >
> > diff --git a/builtin-grep.c b/builtin-grep.c
> > index f477659..2ed2507 100644
> > --- a/builtin-grep.c
> > +++ b/builtin-grep.c
> > @@ -52,26 +52,58 @@ static int grep_config(const char *var, const
> > char *value, void *cb) return git_color_default_config(var, value,
> > cb); }
> > =20
> > +static inline int count_chars(const char *str, char c)
> > +{
> > +	int num =3D 0;
> > +
> > +	if (!str)
> > +		return 0;
> > +
> > +	for (; *str; str++)
> > +		if (*str =3D=3D c)
> > +			num++;
> > +	return num;
> > +}
> > +
> > +static inline int accept_subdir(const char *path, int max_depth)
> > +{
> > +	return max_depth < 0 || count_chars(path, '/') <=3D
> > max_depth; +}
> > +
>=20
> If count_chars() is only used by accept_subdir() why not just manuall=
y
> inline the loop in accept_subdir()? Plus, you rightly return early if
> max_depth is -1, but what if max_depth is something small like 1? The=
n
> you still count all the slashes when you could return upon seeing the
> second slash.

Yep, that's true. My primary reason for writing two functions was to
split logic in accept_subdir() from dull counting in count_chars().
Also, count_chars() is a generic function and may be used anywhere.

>=20
> >
> > @@ -692,6 +724,8 @@ int cmd_grep(int argc, const char **argv, const
> > char *prefix) OPT_SET_INT('I', NULL, &opt.binary,
> >  			"don't match patterns in binary files",
> >  			GREP_BINARY_NOMATCH),
> > +		OPT_INTEGER(0, "max-depth", &opt.max_depth,
> > +				"descend at most <n> levels"),
>=20
> Please use OPTION_INTEGER here so you can use "<depth>" instead of
> "<n>". This will make it more consistent with the documentation.

I can do that.

Thanks for your comments.

Micha=C5=82 Kiedrowicz
