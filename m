From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] fast-import: validate entire ident string
Date: Mon, 26 Apr 2010 11:24:22 -0500
Message-ID: <20100426162422.GA10859@progeny.tock>
References: <1272069944-20626-1-git-send-email-lodatom@gmail.com>
 <20100424160608.GA14690@progeny.tock>
 <20100424190419.GA7502@spearce.org>
 <20100424203827.GA24948@progeny.tock>
 <20100424211042.GC24948@progeny.tock>
 <20100426160247.GD7502@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 26 18:24:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6R6L-0005jS-Jn
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 18:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785Ab0DZQXg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 12:23:36 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46936 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748Ab0DZQXb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 12:23:31 -0400
Received: by pwj9 with SMTP id 9so8483814pwj.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4HbMNJutBSz4SqyA+BTKlIasNwFdGj0ljqJal6ZBC1U=;
        b=OmaBskLekppTGCJoo0C7SQEhEaiUAiKSL2d4GQ6kx4GFX/RdWIHk7g/n6hy6rnn1WX
         7sw9XGo50lEF7d+1YrQDovv1RZhzOV3HbydzpYD+6XYt5ZY8CqsaQCNli7pEIeuQW8pl
         LDQNyl94cnqbS1sPB4TdQ4ATbKprPuelRZjqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=JZlWDAiTV0oaRP/L2cobpBP6TiYd9hotDJW22uwFwGGXeNqhX8d7Ifpqh/xt5FLlHG
         31KQIZ0vdIIiPzIQw2OCoO61I3wWuWeJSzTZo3MF8F2f2WjhAiMcurzeJZhggKSLafbt
         pD/vcxhrZx00X9CpDMI6dDyGzfbg5euGwUAoE=
Received: by 10.141.23.13 with SMTP id a13mr3876534rvj.92.1272299009383;
        Mon, 26 Apr 2010 09:23:29 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm3227856iwn.2.2010.04.26.09.23.27
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 09:23:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100426160247.GD7502@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145826>

Shawn O. Pearce wrote:

> Some importers are probably
> writing "committer <bob> ...." when pulling from systems that don't
> have a concept of name vs. email (e.g. CVS or SVN).  I highly suspect
> that requiring two spaces here will cause a lot of importers to fail.
>=20
> If we really need to require two spaces,

It is not a huge deal, but =E2=80=98git commit --amend=E2=80=99 will di=
e with "invalid
commit" if it does not find a =E2=80=9C <=E2=80=9D sequence after the =E2=
=80=9Cauthor =E2=80=9D
string.  Maybe that should be changed.  Patch below.

> I think we need to honor
> the documented input format but rewrite the line inside of the
> import process to match the two space convention.

Yes, that=E2=80=99s doable.

Thanks for the feedback,
Jonathan

diff --git a/builtin/commit.c b/builtin/commit.c
index c5ab683..c56f2c9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -449,19 +449,23 @@ static void determine_author_info(void)
 	date =3D getenv("GIT_AUTHOR_DATE");
=20
 	if (use_message && !renew_authorship) {
-		const char *a, *lb, *rb, *eol;
+		const char *a, *n, *lb, *rb, *eol;
=20
 		a =3D strstr(use_message_buffer, "\nauthor ");
 		if (!a)
 			die("invalid commit: %s", use_message);
=20
-		lb =3D strstr(a + 8, " <");
-		rb =3D strstr(a + 8, "> ");
-		eol =3D strchr(a + 8, '\n');
+		n =3D a + strlen("\nauthor");
+		lb =3D strstr(n, " <");
+		rb =3D strstr(lb + 2, "> ");
+		eol =3D strchr(rb + 2, '\n');
 		if (!lb || !rb || !eol)
 			die("invalid commit: %s", use_message);
=20
-		name =3D xstrndup(a + 8, lb - (a + 8));
+		if (lb =3D=3D n)
+			name =3D xstrndup("", 0);
+		else
+			name =3D xstrndup(n + 1, lb - (n + 1));
 		email =3D xstrndup(lb + 2, rb - (lb + 2));
 		date =3D xstrndup(rb + 2, eol - (rb + 2));
 	}
@@ -470,7 +474,7 @@ static void determine_author_info(void)
 		const char *lb =3D strstr(force_author, " <");
 		const char *rb =3D strchr(force_author, '>');
=20
-		if (!lb || !rb)
+		if (!lb || !rb || rb < lb)
 			die("malformed --author parameter");
 		name =3D xstrndup(force_author, lb - force_author);
 		email =3D xstrndup(lb + 2, rb - (lb + 2));
--=20
