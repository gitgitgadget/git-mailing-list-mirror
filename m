From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] Document pack v4 format
Date: Fri, 6 Sep 2013 16:48:44 +0700
Message-ID: <CACsJy8AWa0NFViO+3Cnp_0Gqzqidcbx9vPd1wxCuY1jjWhyFaQ@mail.gmail.com>
References: <1377917393-28460-1-git-send-email-pclouds@gmail.com>
 <1378433643-15638-1-git-send-email-pclouds@gmail.com> <alpine.LFD.2.03.1309052319310.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Sep 06 11:49:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHsfI-0003Xh-7R
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 11:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139Ab3IFJtQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Sep 2013 05:49:16 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:43915 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab3IFJtP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Sep 2013 05:49:15 -0400
Received: by mail-ob0-f173.google.com with SMTP id ta17so3189112obb.4
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 02:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=d+GN22UPCkBCwHjExpfbO6PYB3+RKlSnLvHL7bccbVo=;
        b=ETsiu4rjEVH2qtDW/kIq0XvK/mj4xapAHK0OGdXef+xq8jlkKyyGNQdmalV6ay5f89
         7qzivYTTmfYENoyRESPWrqtIu66lvHcSQOyplHFqDQ0YrUL8FnyqmIssAdjHHVG682kA
         CP9E3mNnBDJEj0igc+q3oGyvdr5RIqakYQKc+oX7LvPIMQ7OMHCtUD1zJwbWq+K/7qgx
         dImykVSFIQknAZMva6l5Nf5u7/7RCs3Q0Y2pjlctA6/a+PPKeJ0qPG+XXyjTbu75wFTe
         ry2U0lSOlV7dz+6bUcPPRnt4up06kDwAw7F6aDdZZE+0oH3/dNOmCKEDJyFcGSq0Nd+/
         eYQg==
X-Received: by 10.182.81.65 with SMTP id y1mr1171787obx.89.1378460954629; Fri,
 06 Sep 2013 02:49:14 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Fri, 6 Sep 2013 02:48:44 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309052319310.20709@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234031>

On Fri, Sep 6, 2013 at 10:23 AM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Fri, 6 Sep 2013, Nguy=C2=ADn Th=C3=A1i Ng=C3=B7c Duy wrote:
>
>>
>> Signed-off-by: Nguy=C2=ADn Th=C3=A1i Ng=C3=B7c Duy <pclouds@gmail.co=
m>
>> ---
>>  Should be up to date with Nico's latest implementation and also cov=
er
>>  additions to the format that everybody seems to agree on:
>>
>>   - new types for canonical trees and commits
>>   - sha-1 table covering missing objects in thin packs
>
> Great!  I've merged this into my branch with the following amendment:

I'd like to propose another change in the format to basically limit
the use of sha1ref format "\0<SHA-1>" to tree entries only. All forms
of deltas must have non-zero sha1 index (i.e. reference to SHA-1
table). It will simplify handling code, and I think it makes sense too

diff --git a/Documentation/technical/pack-format.txt
b/Documentation/technical/pack-format.txt
index d0c2cde..399416b 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -74,7 +74,8 @@ Git pack format

      Blobs and tags are deltified and compressed the same way in
      v3. Commits are not deltified. Trees are deltified using
-     special copy sequences.
+     special copy sequences. The base object name index in deltified
+     format must not be zero (i.e. it must point to SHA-1 table).

      Trees and commits in canonical types are in the same format as
      v2: in canonical format and deflated. They can be used for
@@ -166,6 +167,8 @@ Git pack format
     set, it will be followed by a base tree SHA-1. If it's not set,
     the last base tree will be used.

+    base_sha1_index cannot be zero and followed by full SHA-1.
+
 =3D=3D Original (version 1) pack-*.idx files have the following format=
:

   - The header consists of 256 4-byte network byte order
--=20
Duy
