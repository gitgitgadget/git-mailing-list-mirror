From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Makefile: avoid a fork in Cygwin version check
Date: Mon, 5 Apr 2010 10:11:00 -0500
Message-ID: <20100405151059.GB13761@progeny.tock>
References: <1270161834-9597-1-git-send-email-eblake@redhat.com>
 <7vaatmmju9.fsf@alter.siamese.dyndns.org>
 <4BB5F94F.3090403@redhat.com>
 <20100403074700.GA24176@progeny.tock>
 <4BB9E24E.4090206@redhat.com>
 <20100405143053.GA13093@progeny.tock>
 <4BB9F756.7030701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jon.seymour@gmail.com
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 17:10:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nynwt-0008Ve-CD
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 17:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab0DEPKl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 11:10:41 -0400
Received: from mail-pz0-f193.google.com ([209.85.222.193]:64388 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755192Ab0DEPKj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 11:10:39 -0400
Received: by pzk31 with SMTP id 31so553764pzk.33
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=aBEIO5zrPKx04DaIL1GRsd91/EVIsUpQ9QK0nZxs528=;
        b=AKDpI7xfNMqlRlgrSHstP2yXlRU00XObyTQ2D6WrQ9eQ607lxVGJAckuKbGzRE3Orm
         hDFmWyxgevzpbJ9h1WWkiThfmOB2GvDiQefLOsDJoUsQdtmTSaTnaeRFvyYW1IBDc09y
         1MiR/p7BxXO/iIkRll+N6Xc9itGmbGs4eXQeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=tTbw4pyBYNuDkzHzWBZ+3e8CxCR7ZTlt/BHsYPsrhgP1C1cHjvegHYi6HfKEC9KAhG
         jHvSz3HEoXXVIC14xHTjZ9IdG3/uANS6KgOzWQejlJGOu86Xolny0K7UeT4OkZOr8bT9
         vD7aeAxqQJe8ZCWyunHlCffNrYmjgWY1LTgGE=
Received: by 10.141.23.17 with SMTP id a17mr3630046rvj.294.1270480238270;
        Mon, 05 Apr 2010 08:10:38 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm3612886iwn.10.2010.04.05.08.10.37
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 08:10:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BB9F756.7030701@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143991>

=46rom: Eric Blake <eblake@redhat.com>

It is nice to use fewer processes, since forking is so expensive on
cygwin.  So use a case statement instead of expr.

But does that work to have unbalanced ) in a makefile $(shell)?  On
the other hand, this is already in a chunk guarded by $(uname_S) being
cygwin, and we know that cygwin shells understand:

	case '$(uname_R)' in (1.[1-6].*) echo old;; esac

even though it is not portable to other shells, like NetBSD ash.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Eric Blake wrote:
>> Eric Blake wrote:

>>> ifeq ($(shell case '$(uname_R)' in (1.[1-6].*) echo old;; esac),old=
)
[...]
> Junio mentioned he had already queued your first version of the patch=
;
> are you going to re-submit it with this tweak?

Since the patch to future-proof the version check has already hit maste=
r,
here=E2=80=99s the change as an independent patch against master.

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index e210a42..767fb66 100644
--- a/Makefile
+++ b/Makefile
@@ -831,7 +831,7 @@ ifeq ($(uname_S),SunOS)
 	BASIC_CFLAGS +=3D -D__EXTENSIONS__ -D__sun__ -DHAVE_ALLOCA_H
 endif
 ifeq ($(uname_O),Cygwin)
-	ifeq ($(shell expr "$(uname_R)" : '1\.[1-6]\.'),4)
+	ifeq ($(shell case '$(uname_R)' in (1.[1-6].*) echo old;; esac),old)
 		NO_D_TYPE_IN_DIRENT =3D YesPlease
 		NO_D_INO_IN_DIRENT =3D YesPlease
 		NO_STRCASESTR =3D YesPlease
--=20
1.7.0.3
