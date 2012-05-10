From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] notes: only append a blob to a blob
Date: Thu, 10 May 2012 22:31:23 +0700
Message-ID: <CACsJy8ADE1PBYsQcJnO6U4OFoWQjaEW7=6=3V_UO=t5KNinDCA@mail.gmail.com>
References: <1336658701-9004-5-git-send-email-pclouds@gmail.com>
 <1336661015-14149-1-git-send-email-pclouds@gmail.com> <20120510151904.GB20639@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 10 17:32:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSVLU-0006Pu-Fs
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 17:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384Ab2EJPb4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 11:31:56 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:48042 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757489Ab2EJPbz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2012 11:31:55 -0400
Received: by wgbds11 with SMTP id ds11so625398wgb.1
        for <git@vger.kernel.org>; Thu, 10 May 2012 08:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=L6k5P2j0fcmnlvUuGm42NQ7q7lMV9ovGhR60OP8Ncak=;
        b=I0cJj6gpFXSc1gqV4NuqQqCSWb0unrvEkV5AKttkH/jyeo7OcomLjV5OC4vJo7haPL
         +EQVgqLZNQdl2WhCQckKES+PEFEg6q1BglU1v3Ltzp8YKdIR9ZXyrqDIoq6cjxMO7/Wz
         Qipxa6kMrtzG2y7g/dJJwAZsR90/dbKg3H4B77IXFuPnCVIlBJc9sGgaiKmNspNQNGdV
         QSl64yCct/FoUg+qplEnlvsczaPnzRp40rjTLsOGrijk5WtsFS/RGoIwd107Zg/7wRH5
         NnNZAsnAYeAn8jp+S3L78KdhYR06qcKGGFAPv5IGkGG3OvAZLBcUIIwwLVgF87om+S/r
         EClg==
Received: by 10.180.105.194 with SMTP id go2mr10169269wib.22.1336663914040;
 Thu, 10 May 2012 08:31:54 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Thu, 10 May 2012 08:31:23 -0700 (PDT)
In-Reply-To: <20120510151904.GB20639@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197585>

On Thu, May 10, 2012 at 10:19 PM, Jeff King <peff@peff.net> wrote:
> On Thu, May 10, 2012 at 09:43:35PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> =C2=A0Yeah. It made me look again to see if that was true, and I fou=
nd that
>> =C2=A0my last patch was flawed. Reading object content in memory in =
"add
>> =C2=A0-C" is nonsense, not so much in "append -C".
>
> Yeah. Although you would not want to "append -C" anything but blobs.
> While the tree syntax concatenates, I believe the entries are suppose=
d
> to be in sorted order, no? And you would not want to concatenate comm=
its
> at all.

Exactly. Even for blobs, there are non-safe cases (e.g. binaries) but
that's out of our control (or my attention).

>> +static const char *type_name(enum object_type type)
>> +{
>> + =C2=A0 =C2=A0 switch (type) {
>> + =C2=A0 =C2=A0 case OBJ_BLOB: return _("a blob");
>> + =C2=A0 =C2=A0 case OBJ_TAG: return _("a tag");
>> + =C2=A0 =C2=A0 case OBJ_COMMIT: return _("a commit");
>> + =C2=A0 =C2=A0 case OBJ_TREE: return _("a tree");
>> + =C2=A0 =C2=A0 default:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("BUG: put a new stri=
ng for type %d here", type);
>> + =C2=A0 =C2=A0 }
>> +}
>
> Don't we have object.c:typename for this

The key difference here is _() with an article. It's i18n friendly. I
wanted to make 15 combinations (blob/blob cannot happen) of "cannot
append %s to %s", which is best for translators but probably too much
for C developers.

>> @@ -204,8 +216,12 @@ static void create_note(const unsigned char *ob=
ject, struct msg_arg *msg,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_grow(&(msg->=
buf), size + 1);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (msg->buf.len &&=
 prev_buf && size)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 strbuf_insert(&(msg->buf), 0, "\n", 1);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prev_buf && size)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prev_buf && size) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (type !=3D OBJ_BLOB || msg->type !=3D OBJ_BLOB)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("cannot append %s to %s"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type_name(type), type_nam=
e(msg->type));
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 strbuf_insert(&(msg->buf), 0, prev_buf, size);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> I think this is wrong for the reasons above. You would not want to
> concatenate a tree to a tree.

Hmm.. that would become "if (tree !=3D blob || tree !=3D blob) die();",
exactly your point.
--=20
Duy
