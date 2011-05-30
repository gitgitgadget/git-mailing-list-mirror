From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 3/3] verify_path: consider dos drive prefix
Date: Mon, 30 May 2011 11:32:37 +0200
Message-ID: <BANLkTikdeq7cuhi0uo7Q6wqDJK3nxjmP-g@mail.gmail.com>
References: <1306512040-1468-1-git-send-email-kusmabite@gmail.com>
 <1306512040-1468-4-git-send-email-kusmabite@gmail.com> <4DDFF473.7030104@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	Theo Niessink <theo@taletn.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon May 30 11:33:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQyqg-0000bK-Tn
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 11:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665Ab1E3JdS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 05:33:18 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56243 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170Ab1E3JdR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 05:33:17 -0400
Received: by pwi15 with SMTP id 15so1571552pwi.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 02:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=bdAFKU6eThyJmJVz07Kcios2zj4+2Y77mgAIyHJJdwM=;
        b=q92ZDBGYQSnSeZVuMgvQHcUXljSt3H8zogmKC7fa7A/iuxftsXhreSFeYqS5kzPFCd
         Yj4TpwUeogmVpooQqE405OoS9kHkl4eevCZdbyy5CnokO6SoFcslhOIgjQWf2yu8sHb+
         sauSOGopjnebwoVoNic3XpyfsLmpYhRwnyTHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=oPP73z8zEmtswK8zWQh4/HvsUhpIyN6vtHAw4oo24cVRR7XQaMY3OCbcsuNry3r7js
         m+IgP2Tg9+GFaksCIOuJ02OIdKG+3t6I9KRawwertgLuq6uGkhcizNb3Qsor4/obbesF
         wlVjwoxdYg2ibCHIxOegsMrGgaFx0XQL84M8c=
Received: by 10.68.17.234 with SMTP id r10mr1887088pbd.98.1306747997029; Mon,
 30 May 2011 02:33:17 -0700 (PDT)
Received: by 10.68.47.131 with HTTP; Mon, 30 May 2011 02:32:37 -0700 (PDT)
In-Reply-To: <4DDFF473.7030104@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174735>

On Fri, May 27, 2011 at 8:58 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 27.05.2011 18:00, schrieb Erik Faye-Lund:
>> If someone manage to create a repo with a 'C:' entry in the
>> root-tree, files can be written outside of the working-dir. This
>> opens up a can-of-worms of exploits.
>>
>> Fix it by explicitly checking for a dos drive prefix when verifying
>> a paht. While we're at it, make sure that paths beginning with '\' i=
s
>> considered absolute as well.
>
> I think we do agree that the only way to avoid the security breach is=
 to
> check a path before it is used to write a file. In practice, it means=
 to
> disallow paths in the top-most level of the index that are two
> characters long and are letter-colon.
>
> IMHO, it is pointless to avoid that an evil path enters the repositor=
y,
> because there are so many and a few more ways to create an evil repos=
itory.
>

Yes, but this patch doesn't prevent that; it prevents an evil path
from entering the index and from being checked out if the index is
evil.

>> diff --git a/read-cache.c b/read-cache.c
>> index f38471c..68faa51 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -753,11 +753,14 @@ int verify_path(const char *path)
>> =A0{
>> =A0 =A0 =A0 char c;
>>
>> + =A0 =A0 if (has_dos_drive_prefix(path))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>
> Isn't verify_path used to avoid that a bogus path enters the index? (=
I
> don't know, I'm not familiar with this infrastructure.)
>

Yes, it's being used to do that. But it's also being used when reading
the index into memory, which is "the good stuf" for our purposes.

This is the same guard which makes Git on Linux bard on an index
containing paths like "/tmp/foo"

>> =A0 =A0 =A0 goto inside;
>> =A0 =A0 =A0 for (;;) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!c)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (c =3D=3D '/') {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (is_dir_sep(c)) {
>> =A0inside:
>
> And if so, at this point, all backslashes should have been converted =
to
> forward-slashes already. If not, then this would just paper over the
> real bug.

SHOULD, yes. But we could have an evil tree/index which doesn't, and
this if intended to make sure we reject such paths.

So I don't see how this is papering over the bug; this IS the bug (as
far as I can tell).

But I think I might have been a bit too care-less; I didn't fix the
switch-case to check for multiple backslashes on Windows. It's not
immediately obvious if this is needed or not, but I don't think it can
cause harm; we should never have created an index like that anyway.

So something like this on top, perhaps?


diff --git a/read-cache.c b/read-cache.c
index 68faa51..9367349 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -763,15 +763,11 @@ int verify_path(const char *path)
 		if (is_dir_sep(c)) {
 inside:
 			c =3D *path++;
-			switch (c) {
-			default:
-				continue;
-			case '/': case '\0':
-				break;
-			case '.':
+			if (c =3D=3D '.') {
 				if (verify_dotfile(path))
 					continue;
-			}
+			} else if (!is_dir_sep(c) && c !=3D '\0')
+				continue;
 			return 0;
 		}
 		c =3D *path++;
