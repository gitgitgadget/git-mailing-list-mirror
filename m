From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: Re: [PATCH v3 3/4] setup: Add 'abspath_part_inside_repo' function
Date: Sat, 1 Feb 2014 02:31:21 +0100
Message-ID: <20140201013121.GA14729@mule>
References: <1390781250-20389-2-git-send-email-martinerikwerner@gmail.com>
 <20140131202248.GD9731@mule>
 <52EC25A9.1050807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, richih@debian.org, gitster@pobox.com,
	pclouds@gmail.com
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Feb 01 02:31:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9PQh-0007Hd-Kp
	for gcvg-git-2@plane.gmane.org; Sat, 01 Feb 2014 02:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407AbaBABb1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jan 2014 20:31:27 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:48277 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145AbaBABb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 20:31:27 -0500
Received: by mail-lb0-f179.google.com with SMTP id l4so3961507lbv.38
        for <git@vger.kernel.org>; Fri, 31 Jan 2014 17:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Cpzh8WXbLKXGalgPMDcb11zfdTh/3YLGiop5ymteTWc=;
        b=A5EFK2ukYwaJQoVbYe9wVqAPQuWWsmfYCH8dWTkGGHCRgF5M11eLJ0nUYAJaujyWXS
         W7hVr96Qulgg+9OwZdYfZEXhWXVYA2ydE2z6+ikvb0lzh2S4do5puphrW/zAVcP8CVFu
         8fjSViHQKZZhTtUl1SOCAgS1ga454fQJD+5a/YDavHf6qEkyouZepJc94q+ZQfZ/u3+J
         alFDPtm/ORLfkILKebGAFZV7lrGMsa31NBP+1Rmp91lxdlkmzCaauI7TKypbWzz0lezY
         OzYrp6cQnooV6UDKjtud/jIaH+55uypNYtiRz6RbuK9BUYmKFo+J2+q2CVKNJzXaELHy
         sinA==
X-Received: by 10.112.50.197 with SMTP id e5mr15023606lbo.4.1391218285253;
        Fri, 31 Jan 2014 17:31:25 -0800 (PST)
Received: from mule (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id bn5sm12101282lbc.10.2014.01.31.17.31.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jan 2014 17:31:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52EC25A9.1050807@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241328>

On Fri, Jan 31, 2014 at 11:37:29PM +0100, Torsten B=F6gershausen wrote:
> On 2014-01-31 21.22, Martin Erik Werner wrote:
> > In order to extract the part of an absolute path which lies inside =
the
> > repo, it is not possible to directly use real_path, since that woul=
d
> > dereference symlinks both outside and inside the work tree.
> >
> > Add an 'abspath_part_inside_repo' function which incrementally chec=
ks
> > each path level by temporarily NUL-terminating at each '/' and comp=
aring
> > against the work tree path. When a match is found, it copies the
> > remainder (which will be the in-repo part) to a destination
> > buffer.
> >
> > The path being the filesystem root or exactly equal to the work tre=
e are
> > special cases handled separately, since then there is no directory
> > separator between the work tree and in-repo part.
> >
> > Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
> > ---
> >  cache.h |  1 +
> >  setup.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
> >  2 files changed, 64 insertions(+)
> >
> > diff --git a/cache.h b/cache.h
> > index ce377e1..242f27d 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -426,6 +426,7 @@ extern void verify_filename(const char *prefix,
> >  			    int diagnose_misspelt_rev);
> >  extern void verify_non_filename(const char *prefix, const char *na=
me);
> >  extern int path_inside_repo(const char *prefix, const char *path);
> > +extern int abspath_part_inside_repo(char *dst, const char *path);
> abspath_part_inside_repo() is only used in setup.c, isn't it?
> In this case we don't need it in cache.h, it can be declared inside s=
etup.c as
>=20
> static int abspath_part_inside_repo(char *dst, const char *path);
> (or "static inline" )
>=20
> -----------------
> (And not in this patch: see the final setup.c:)
>=20
>         if (g) {
>             free(npath);
>             return NULL;
>         }
>=20
> If this is the only caller of abspath_part_inside_repo(),
> then  do we need npath 2 times as a parameter ?
> Or can we re-write it to look like this:
>=20
> static inline int abspath_part_inside_repo(char *path)
> [
> ]

I guess I've over-generalised it a bit too much, that should rather be
done if-and-when, I presume?

It is indeed only used in setup.c and only by the prefix_path_gently
function so static inline then?

Hmm, for single-parameter it should suffice to simply move the paramete=
r
down into the function, like so?:
  const char* src;
  src =3D dst;
and carry on as before (obviously also renaming the variables sensibly)=
,
or did you have something else in mind?

(I added two parameters since I was glancing at 'normalize_path_copy_le=
n'
for inspiration, and was thinking about (purely theoretical) re-use in
other cases rather than minimizing it for the time being.)

What do you mean with the "(And not in this patch"... bit; what "final
setup.c"?

--
Martin Erik Werner <martinerikwerner@gmail.com>
