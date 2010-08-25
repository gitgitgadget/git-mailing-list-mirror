From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/7] Fix ignoring of pathspecs with rev-list --objects
Date: Thu, 26 Aug 2010 08:11:07 +1000
Message-ID: <AANLkTimguNHXSFyO1EvS+dHbHiXU-dXTNwkWfEsVUbVC@mail.gmail.com>
References: <1282704795-29661-1-git-send-email-newren@gmail.com>
	<1282704795-29661-3-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, gitster <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 00:11:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoOBs-0006PO-GV
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 00:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207Ab0HYWLS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 18:11:18 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62710 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153Ab0HYWLQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 18:11:16 -0400
Received: by wwb28 with SMTP id 28so458677wwb.1
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 15:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JByc7aQVMeD6yS68HCwXh+Rc+qCwXUKk+sxjjhOVTx0=;
        b=uvXoQFk8boBVOFS+9kc744AaAERFBZItc9AjX27O1fKCupy1+pWBClHBsqyN56bfy/
         R7ZEtIhwaBQIs0vIfBvTvaJyTvU3OTEHB/bv8JBjtBR4nCriEj4XZ2AZ08ICRKcz9vFI
         Qn4pLFJRNTtu//1T4WIXWG3xNux9zfjaDFT1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tBwFHyeUBxXWlabARtgyJdyGlYY6NIbj8gZZTc2geer/4LrWwKcqNL8mL25QWLb03U
         V98I5FNJ6Atpot00GkSQ7PVL2A3rmLWp60QlFOATxmjZGmQ+H7i2+/ikXHtcwP56VjzB
         ctq86GIfLNyVmk1hmcL37ZHo5ELCb6+L8Xzfk=
Received: by 10.216.10.11 with SMTP id 11mr65477weu.64.1282774268054; Wed, 25
 Aug 2010 15:11:08 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Wed, 25 Aug 2010 15:11:07 -0700 (PDT)
In-Reply-To: <1282704795-29661-3-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154486>

On Wed, Aug 25, 2010 at 12:53 PM, Elijah Newren <newren@gmail.com> wrot=
e:
> @@ -84,7 +85,24 @@ static void process_tree(struct rev_info *revs,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0init_tree_desc(&desc, tree->buffer, tree->=
size);
>
> - =C2=A0 =C2=A0 =C2=A0 while (tree_entry(&desc, &entry)) {
> + =C2=A0 =C2=A0 =C2=A0 for (; desc.size; update_tree_entry(&desc)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry =3D desc.ent=
ry;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!all_interesti=
ng) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 char *full_path =3D path_name(path, name);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int full_path_len =3D strlen(full_path);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int showit =3D tree_entry_interesting(&desc,
> full_path, full_path_len,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &revs->d=
iffopt);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 free(full_path);

I wonder if we can avoid xmalloc/free so many times here. If full_path
is unchanged, how about moving it outside the loop?

> diff --git a/tree-diff.c b/tree-diff.c
> index cd659c6..2fb670b 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -91,7 +91,7 @@ static int compare_tree_entry(struct tree_desc *t1,=
 struct
> tree_desc *t2, const
> =C2=A0* =C2=A0- zero for no
> =C2=A0* =C2=A0- negative for "no, and no subsequent entries will be e=
ither"
> =C2=A0*/
> -static int tree_entry_interesting(struct tree_desc *desc, const char=
 *base,
> int baselen, struct diff_options *opt)
> +int tree_entry_interesting(struct tree_desc *desc, const char *base,=
 int
> baselen, struct diff_options *opt)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *path;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const unsigned char *sha1;

While at it, can you please also fix its comments? The comments say
pathspec while what it uses is actually path prefix. Maybe something
like this

diff --git a/tree-diff.c b/tree-diff.c
index 3c34c77..514dbca 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -83,7 +83,7 @@ static int compare_tree_entry(struct tree_desc *t1,
struct tree_desc *t2, const
 }

 /*
- * Is a tree entry interesting given the pathspec we have?
+ * Is a tree entry interesting given the path prefix we have?
  *
  * Return:
  *  - 2 for "yes, and all subsequent entries will be"


This patch is good stuff. Please be informed I will steal this patch
for my narrow use.
--=20
Duy
