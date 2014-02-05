From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack.c: rename and unlink pack file if it exists
Date: Wed, 05 Feb 2014 12:06:41 -0800
Message-ID: <xmqq1tzh494e.fsf@gitster.dls.corp.google.com>
References: <xmqqwqha5twg.fsf@gitster.dls.corp.google.com>
	<20140205011632.GA3923@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
	<tboegi@web.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 05 21:37:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB9DU-0007NJ-L2
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 21:37:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbaBEUGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Feb 2014 15:06:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49344 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932239AbaBEUGp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Feb 2014 15:06:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0507F69EDF;
	Wed,  5 Feb 2014 15:06:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nMWDWerpNQ38
	cHWpzc8GU3h1hE8=; b=PM/f1VWoGWc8fgQDMuEyaHSc4ItF2XFaqqypj/PvcU+k
	F+OqOoYmt8Sxcps02dMhbmwl8lq+vib6aTHhjggH6LuPDj0c5KVdpANOjgQeauFr
	H+Qf+oHqDDqs8KbZkdjFGqHsEQl7biDBMhhvEOJF8jIwcrLrRP5GuSsGtHr3xBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rbjPkh
	VklMCcZ1+k+GRteHUQe+eo0xrL4odwkryIp57MqEkEaFdfKIQL2riE6wZp6Jn4Ug
	mgHcKtwiEnjuPbvAqGgYBOrhNhU0NNzStIO56vwuZRbzUXJ93nn6iSFdiBXNABgl
	gLzuXSBVKdTgORCpXa6Bm32fMdUedyKcvHV+Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0BE069EDD;
	Wed,  5 Feb 2014 15:06:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E21D169EDB;
	Wed,  5 Feb 2014 15:06:43 -0500 (EST)
In-Reply-To: <20140205011632.GA3923@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 4 Feb 2014 20:16:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 08C690C2-8EA1-11E3-8A77-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241655>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 04, 2014 at 03:40:15PM -0800, Junio C Hamano wrote:
>
>>  * Somehow this came to my private mailbox without Cc to list, so I
>>    am forwarding it.
>>=20
>>    I think with 1190a1ac (pack-objects: name pack files after
>>    trailer hash, 2013-12-05), repacking the same set of objects may
>>    have less chance of producing colliding names, especially if you
>>    are on a box with more than one core, but it still would be a
>>    good idea to get this part right in the upcoming release.
>
> Actually, since 1190a1ac, if you have repacked and gotten the same pa=
ck
> name, then you do not have to do any rename dance at all; you can thr=
ow
> away what you just generated because you know that it is byte-for-byt=
e
> identical.
>
> You could collide with a pack created by an older version of git that
> used the original scheme, but that is quite unlikely (on the order of
> 2^-160).

Yes, so in that sense this is not so urgent, but I'm tempted to
split the original patch into two and merge only the first one to
'master' before -rc3 (see below).  The renaming of the variables
added enough noise to cause me fail to spot a change mixed within.

-- >8 --
=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>
Date: Sun, 2 Feb 2014 16:09:56 +0100

When a repo was fully repacked, and is repacked again, we may run
into the situation that "new" packfiles have the same name as
already existing ones (traditionally packfiles have been named after
the list of names of objects in them, so repacking all the objects
in a single pack would have produced a packfile with the same name).

The logic is to rename the existing ones into filename like
"old-XXX", create the new ones and then remove the "old-" ones.
When something went wrong in the middle, this sequence is rolled
back by renaming the "old-" files back.

The renaming into "old-" did not work as intended, because
file_exists() was done on "XXX", not "pack-XXX".  Also when rolling
back the change, the code tried to rename "old-pack-XXX" but the
saved ones are named "old-XXX", so this couldn't have worked.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/repack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index bca7710..fe31577 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -260,7 +260,7 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
 	for_each_string_list_item(item, &names) {
 		for (ext =3D 0; ext < 2; ext++) {
 			char *fname, *fname_old;
-			fname =3D mkpathdup("%s/%s%s", packdir,
+			fname =3D mkpathdup("%s/pack-%s%s", packdir,
 						item->string, exts[ext]);
 			if (!file_exists(fname)) {
 				free(fname);
@@ -337,7 +337,7 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
 	for_each_string_list_item(item, &names) {
 		for (ext =3D 0; ext < 2; ext++) {
 			char *fname;
-			fname =3D mkpath("%s/old-pack-%s%s",
+			fname =3D mkpath("%s/old-%s%s",
 					packdir,
 					item->string,
 					exts[ext]);
--=20
1.9-rc2-217-g24a8b2e
