From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: segmentation fault (nullpointer) with git log --submodule -p
Date: Thu, 24 Jan 2013 20:40:47 +0700
Message-ID: <CACsJy8B9O=A26_=sv1JEYdtazsWa4khZkqpTgFSSTs_RGGPZqQ@mail.gmail.com>
References: <20130123143816.GA579@krypton.darkbyte.org> <20130123200222.GB19832@sigill.intra.peff.net>
 <510124F5.9090505@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Armin <netzverweigerer@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 14:41:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyN3l-00087p-R1
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 14:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286Ab3AXNlU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 08:41:20 -0500
Received: from mail-oa0-f53.google.com ([209.85.219.53]:33870 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab3AXNlT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2013 08:41:19 -0500
Received: by mail-oa0-f53.google.com with SMTP id l20so1880287oag.12
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 05:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=/kMHAGx9Bp15I04TS3JTaIxts4kVHGfMYRLZ8LZ13dw=;
        b=uaKISUSM51SIXO1kbkPIVEWteCYi8G2et8pi1/LogydKApHe0yhc/HIWSkRDv2Grxo
         hSdZ+rfoSmxLgfq5dksVzfn5WTYrBm6ldwUpIKXHI63rX8s5g1DhUZh4ic8twLfTpVaE
         fFkbGDQpJ2rm1I1cHu44+RiOFyWjfjNqL7JBE91/ishJVzgPvd/cMsBQL+CKJocQP5Q/
         fIw+z7vRoA9ZzPTpCJyvm39AgHTl6u5a+a4Ft4MFDPAtJ0joTeQlIYA4hmGsDG6MzxZj
         dnUxi8vYAcuXvKEzJHB/4+53/twm6zI235uIy8/7DoRzv9OndUGYPnqWzbqOgjNQkuE8
         qa2g==
X-Received: by 10.60.29.66 with SMTP id i2mr1505809oeh.2.1359034877629; Thu,
 24 Jan 2013 05:41:17 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Thu, 24 Jan 2013 05:40:47 -0800 (PST)
In-Reply-To: <510124F5.9090505@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214429>

On Thu, Jan 24, 2013 at 7:11 PM, Stefan N=C3=A4we
<stefan.naewe@atlas-elektronik.com> wrote:
>> Does it fail with older versions of git? If so, can you bisect?
>
> I did. My bisection told me this is the suspect:
>
> ccdc603 (parse_object: try internal cache before reading object db)

diff --git a/object.c b/object.c
index d8d09f9..6b06297 100644
--- a/object.c
+++ b/object.c
@@ -191,10 +191,15 @@ struct object *parse_object(const unsigned char *=
sha1)
        enum object_type type;
        int eaten;
        const unsigned char *repl =3D lookup_replace_object(sha1);
-       void *buffer =3D read_sha1_file(sha1, &type, &size);
+       void *buffer;
+       struct object *obj;
+
+       obj =3D lookup_object(sha1);
+       if (obj && obj->parsed)
+               return obj;

Any chance obj->parsed is 1 but ((struct commit*)obj)->buffer is NULL?
What if you change that "if" to

if (obj && obj->parsed && (obj->type !=3D OBJ_COMMIT || ((struct commit
*)obj)->buffer))

??

Also you did not encode commits in any specific encoding, nor set
i18n.logOutputEncoding?
--=20
Duy
