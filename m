From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] revert: add --ff option to allow fast forward when
 cherry-picking
Date: Sat, 20 Mar 2010 21:01:20 -0500
Message-ID: <20100321020120.GA30915@progeny.tock>
References: <20100228222038.2260.25016.chriscool@tuxfamily.org>
 <201003010800.13996.chriscool@tuxfamily.org>
 <7v635g4ec2.fsf@alter.siamese.dyndns.org>
 <201003040306.16580.chriscool@tuxfamily.org>
 <7vhbowoj8y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 03:00:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtASr-0004zQ-Fu
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 03:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab0CUCAY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 22:00:24 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53819 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659Ab0CUCAX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 22:00:23 -0400
Received: by gyg8 with SMTP id 8so2130110gyg.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 19:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ky/QkaXKTH8SV6/KnfAHtZhhrLRqiPSQ34sX6osA7BQ=;
        b=LziRMa0btMgE9LiozTQkp3aHSKd20kzkPvzAzu0usmMCdqeT8nohi3K5l5xsX+Qv+7
         IIFAWWGjdG248O8NW13Qv7jQR5edGSTgcvNJzNUJ/rt9v4UbWBM8nhIyZW6F2T1IYI5o
         kZV1/HUDovF+NwotqvsLN7MSldmEdMeyuD2xY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=eqfIlEQG/Pgdpmgv4PN4MIJhfYEGa7zlDGJvF8kPpgg7CQ9URbwppPVUMcLX/hpmaw
         tjXq1GRYprNSEM3s1BKrahpKZF6rdqKhosoFiXEAgB/qSLwWPgQGzpY8o0AfyqPKl/Ui
         NbC5Bps5sNib5XazwasjDxvNKhEKQ9af/VFZQ=
Received: by 10.100.233.26 with SMTP id f26mr12107234anh.1.1269136822764;
        Sat, 20 Mar 2010 19:00:22 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm1048602iwn.9.2010.03.20.19.00.20
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 19:00:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhbowoj8y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142785>

Junio C Hamano wrote:

> diff --git a/builtin-revert.c b/builtin-revert.c
> index eff5268..bfe75c8 100644
> --- a/builtin-revert.c
> +++ b/builtin-revert.c
> @@ -314,6 +346,10 @@ static int revert_or_cherry_pick(int argc, const=
 char **argv)
>  	else
>  		parent =3D commit->parents->item;
> =20
> +	if (action =3D=3D CHERRY_PICK && allow_ff
> +	    && !hashcmp(parent->object.sha1, head))
> +		return fast_forward_to(commit->object.sha1, head);
> +
>  	if (!(message =3D commit->buffer))
>  		die ("Cannot get commit message for %s",
>  				sha1_to_hex(commit->object.sha1));

Here=E2=80=99s a small fix to go on top.

-- %< --
Subject: revert: fix tiny memory leak in cherry-pick --ff

We forgot to free defmsg when returning early for a fast-forward.

=46ixing this should reduce noise during test suite runs with valgrind.
More importantly, once cherry-pick learns to pick multiple commits,
the amount of memory leaked would start to add up.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin-revert.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 476f41e..9a3c14c 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -274,7 +274,7 @@ static int revert_or_cherry_pick(int argc, const ch=
ar **argv)
 	int i, index_fd, clean;
 	char *oneline, *reencoded_message =3D NULL;
 	const char *message, *encoding;
-	char *defmsg =3D git_pathdup("MERGE_MSG");
+	char *defmsg =3D NULL;
 	struct merge_options o;
 	struct tree *result, *next_tree, *base_tree, *head_tree;
 	static struct lock_file index_lock;
@@ -364,6 +364,7 @@ static int revert_or_cherry_pick(int argc, const ch=
ar **argv)
 	 * reverse of it if we are revert.
 	 */
=20
+	defmsg =3D git_pathdup("MERGE_MSG");
 	msg_fd =3D hold_lock_file_for_update(&msg_file, defmsg,
 					   LOCK_DIE_ON_ERROR);
=20
--=20
1.7.0.2
