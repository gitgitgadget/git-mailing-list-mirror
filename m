From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/12] rerere: never renormalize
Date: Thu, 5 Aug 2010 06:30:26 -0500
Message-ID: <20100805113026.GM13779@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
 <20100804032338.GF19699@burratino>
 <7vocdifdrk.fsf@alter.siamese.dyndns.org>
 <20100805110822.GB13779@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 13:31:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogyfv-0000l7-Ix
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 13:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933152Ab0HELbp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 07:31:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35120 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758838Ab0HELbo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 07:31:44 -0400
Received: by iwn33 with SMTP id 33so96750iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 04:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=x/Rhnu7+P1R2MSpRPdbi/aCE3h76eokSFhkycbjIFys=;
        b=l1Ut6CTOZxdRg+m/LOHKMmu+ciWMKbJIyCNvyfGZ1piE2QgnRgNUSsUvGQK6M8Qljs
         Rjqcpd3rfwyePNnnOz3lMhOTXLVVZGbh+hKjclVLrGmCNNB7OnN3G/3M7oN1RFTrj5mw
         CnQhCNxumBoJxDBKUyMicT7hAvclA2nDb7ryg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=FGcrIczpK/BhbhaCBOnz5tzs0MYt3k5cqpsJXJLs3Fe/tpnBv5KM9tqPwMrHbeAjOd
         5oOirL6aksvHjxDgb7FXYTlTFbj+igXeAJ5YU8z5mgKxfXZlkhZKvjiwf76lf58MkL7v
         yFLzoWwXHXxNUtycV7iWyvvpTr5jeBfGIdu9w=
Received: by 10.231.13.130 with SMTP id c2mr7039652iba.24.1281007904427;
        Thu, 05 Aug 2010 04:31:44 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r3sm59368ibk.13.2010.08.05.04.31.43
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 04:31:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100805110822.GB13779@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152643>

plain rerere performs three tasks; let us consider how the new
merge.renormalize option should apply to each.

After an unsuccessful merge, rerere records conflict hunks from the
work tree under .git/rr-cache.  If the merge was performed with
merge.renormalize enabled, both sides of the conflict hunk use the
current work tree=E2=80=99s end-of-line and smudge rules; there is not =
really
much of a choice.

After a successful manual resolution, rerere records the postimage.
Here, also, the file will be in the current work tree=E2=80=99s canonic=
al
format and there is not much to do about it.

When encountering that conflict again, merge looks up the preimage
and postimage using the conflict hunk as a key and runs a three-way
merge to apply that resolution to the work tree.  Since the conflict
hunk used the current work tree=E2=80=99s canonical format, chances are=
 the
version in the work tree, the preimage, and the postimage will, too.
In fact using the merge.renormalize machinery is exactly the wrong
thing to do, since its result has been run through convert_to_git
and therefore is not suitable for writing to the work tree.

The only affected caller is "git merge".

NEEDSWORK: lacks test

Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 rerere.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/rerere.c b/rerere.c
index 9dd4c7e..e40af0d 100644
--- a/rerere.c
+++ b/rerere.c
@@ -365,7 +365,7 @@ static int find_conflict(struct string_list *confli=
ct)
 	return 0;
 }
=20
-static int merge(const char *name, int renormalize, const char *path)
+static int merge(const char *name, const char *path)
 {
 	int ret;
 	mmfile_t cur =3D {NULL, 0}, base =3D {NULL, 0}, other =3D {NULL, 0};
@@ -380,8 +380,7 @@ static int merge(const char *name, int renormalize,=
 const char *path)
 		ret =3D 1;
 		goto out;
 	}
-	ret =3D ll_merge(&result, path, &base, NULL, &cur, "", &other, "",
-			renormalize ? LL_OPT_RENORMALIZE : 0);
+	ret =3D ll_merge(&result, path, &base, NULL, &cur, "", &other, "", 0)=
;
 	if (!ret) {
 		FILE *f =3D fopen(path, "w");
 		if (!f)
@@ -429,7 +428,7 @@ static int update_paths(struct string_list *update)
 	return status;
 }
=20
-static int do_plain_rerere(struct string_list *rr, int fd, int renorma=
lize)
+static int do_plain_rerere(struct string_list *rr, int fd)
 {
 	struct string_list conflict =3D { NULL, 0, 0, 1 };
 	struct string_list update =3D { NULL, 0, 0, 1 };
@@ -474,7 +473,7 @@ static int do_plain_rerere(struct string_list *rr, =
int fd, int renormalize)
 		const char *name =3D (const char *)rr->items[i].util;
=20
 		if (has_rerere_resolution(name)) {
-			if (!merge(name, renormalize, path)) {
+			if (!merge(name, path)) {
 				if (rerere_autoupdate)
 					string_list_insert(path, &update);
 				fprintf(stderr,
@@ -558,7 +557,7 @@ int rerere(int flags)
 	fd =3D setup_rerere(&merge_rr, flags);
 	if (fd < 0)
 		return 0;
-	return do_plain_rerere(&merge_rr, fd, merge_renormalize);
+	return do_plain_rerere(&merge_rr, fd);
 }
=20
 static int rerere_forget_one_path(const char *path, struct string_list=
 *rr)
--=20
1.7.2.1.544.ga752d.dirty
