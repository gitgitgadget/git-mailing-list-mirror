From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Fri, 30 Sep 2011 10:09:05 -0600
Organization: CAF
Message-ID: <201109301009.05583.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <201109291411.06733.mfick@codeaurora.org> <4E8587E8.9070606@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Sep 30 18:09:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9feD-0005VT-Bq
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 18:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193Ab1I3QJI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 12:09:08 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:38992 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511Ab1I3QJH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2011 12:09:07 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6484"; a="123659197"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 30 Sep 2011 09:09:06 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 24B8110004BE;
	Fri, 30 Sep 2011 09:09:06 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <4E8587E8.9070606@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182490>

On Friday, September 30, 2011 03:12:08 am Ren=C3=A9 Scharfe=20
wrote:
> OK, and what happens if you apply the following patch on
> top of my first one?  It avoids going through all the
> refs a second time during cleanup, at the cost of going
> through the list of all known objects.  I wonder if
> that's any faster in your case.


This patch helps a bit more.  It seems to shave about=20
another .5s off in packed and non packed case w or w/o=20
binary search.

-Martin



> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 84e0cdc..a4b1003 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -596,15 +596,14 @@ static int
> add_pending_uninteresting_ref(const char *refname,
> return 0;
>  }
>=20
> -static int clear_commit_marks_from_one_ref(const char
> *refname, -				      const unsigned=20
char *sha1,
> -				      int flags,
> -				      void *cb_data)
> +static void clear_commit_marks_for_all(unsigned int
> mark) {
> -	struct commit *commit =3D
> lookup_commit_reference_gently(sha1, 1); -	if (commit)
> -		clear_commit_marks(commit, -1);
> -	return 0;
> +	unsigned int i, max =3D get_max_object_index();
> +	for (i =3D 0; i < max; i++) {
> +		struct object *object =3D=20
get_indexed_object(i);
> +		if (object && object->type =3D=3D OBJ_COMMIT)
> +			object->flags &=3D ~mark;
> +	}
>  }
>=20
>  static void describe_one_orphan(struct strbuf *sb,
> struct commit *commit) @@ -690,8 +689,7 @@ static void
> orphaned_commit_warning(struct commit *commit) else
>  		describe_detached_head(_("Previous HEAD=20
position
> was"), commit);
>=20
> -	clear_commit_marks(commit, -1);
> -	for_each_ref(clear_commit_marks_from_one_ref, NULL);
> +	clear_commit_marks_for_all(ALL_REV_FLAGS);
>  }
>=20
>  static int switch_branches(struct checkout_opts *opts,
> struct branch_info *new) --
> To unsubscribe from this list: send the line "unsubscribe
> git" in the body of a message to
> majordomo@vger.kernel.org More majordomo info at=20
> http://vger.kernel.org/majordomo-info.html

--=20
Employee of Qualcomm Innovation Center, Inc. which is a=20
member of Code Aurora Forum
