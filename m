From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: When Will We See Collisions for SHA-1? (An interesting analysis
 by Bruce Schneier)
Date: Tue, 16 Oct 2012 13:34:41 +0200
Message-ID: <507D4651.6080207@lsrfire.ath.cx>
References: <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com> <CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com> <20121015183438.GB31658@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 13:35:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO5QE-0006eK-LK
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 13:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486Ab2JPLeo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2012 07:34:44 -0400
Received: from india601.server4you.de ([85.25.151.105]:44560 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab2JPLen (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 07:34:43 -0400
Received: from [192.168.2.105] (p4FFDBE50.dip.t-dialin.net [79.253.190.80])
	by india601.server4you.de (Postfix) with ESMTPSA id 70D5C77;
	Tue, 16 Oct 2012 13:34:41 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121005 Thunderbird/16.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20121015183438.GB31658@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207814>

Am 15.10.2012 20:34, schrieb Jeff King:
> On Mon, Oct 15, 2012 at 07:47:09PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>=20
>> On Mon, Oct 15, 2012 at 6:42 PM, Elia Pinto <gitter.spiros@gmail.com=
> wrote:
>>> Very clear analysis. Well written. Perhaps is it the time to update
>>> http://git-scm.com/book/ch6-1.html (A SHORT NOTE ABOUT SHA-1) ?
>>>
>>> Hope useful
>>>
>>> http://www.schneier.com/crypto-gram-1210.html
>>
>> This would be concerning if the Git security model would break down =
if
>> someone found a SHA1 collision, but it really wouldn't.
>>
>> It's one thing to find *a* collision, it's quite another to:
>>
>>   1. Find a collision for the sha1 of harmless.c which I know you us=
e,
>>      and replace it with evil.c.
>>
>>   2. Somehow make evil.c compile so that it actually does something
>>      useful and nefarious, and doesn't just make the C compiler puke=
=2E
>>
>>      If finding one arbitrary collision costs $43K in 2021 dollars
>>      getting past this point is going to take quite a large multiple=
 of
>>      $43K.
>=20
> There are easier attacks than that if you can hide arbitrary bytes
> inside a file. It's hard with C source code. The common one in hash
> collision detection circles is to put invisible cruft into binary
> document formats like PDF or Postscript. Git blobs themselves do not
> have such an invisible place to put it, but you might be storing a
> format that does.
>=20
> But worse, git _commits_ have such an invisible portion. We calculate
> the sha1 over the full commit, but we tend to show only the portion u=
p
> to the first NUL byte. I used that horrible trick in my "choose your =
own
> sha1 prefix" patch. However, we could mitigate that by checking for
> embedded NULs in git-fsck.

=46WIW, I couldn't measure a performance difference for git log with an=
d
without the following patch, which catches commits created with your
hash collision trick, but might be too strict:

diff --git a/commit.c b/commit.c
index 213bc98..4cd1e83 100644
--- a/commit.c
+++ b/commit.c
@@ -262,6 +262,12 @@ int parse_commit_buffer(struct commit *item, const=
 void *buffer, unsigned long s
 	if (item->object.parsed)
 		return 0;
 	item->object.parsed =3D 1;
+
+	if (memchr(buffer, '\0', size)) {
+		return error("bogus commit contains a NUL character: %s",
+			     sha1_to_hex(item->object.sha1));
+	}
+
 	tail +=3D size;
 	if (tail <=3D bufptr + 46 || memcmp(bufptr, "tree ", 5) || bufptr[45]=
 !=3D '\n')
 		return error("bogus commit object %s", sha1_to_hex(item->object.sha1=
));
