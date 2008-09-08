From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-symbolic-ref: comment on the use of
 "resolve_ref" with reading == 0
Date: Sun, 07 Sep 2008 17:33:26 -0700
Message-ID: <7v63p7jx2h.fsf@gitster.siamese.dyndns.org>
References: <20080906095543.c627b692.chriscool@tuxfamily.org>
 <7vwshpsi1g.fsf@gitster.siamese.dyndns.org>
 <200809061403.14592.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Sep 08 02:34:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcUiG-00007A-4s
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 02:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbYIHAdd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Sep 2008 20:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbYIHAdd
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 20:33:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbYIHAdc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Sep 2008 20:33:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6536E5EB91;
	Sun,  7 Sep 2008 20:33:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5DD8F5EB90; Sun,  7 Sep 2008 20:33:28 -0400 (EDT)
In-Reply-To: <200809061403.14592.chriscool@tuxfamily.org> (Christian Couder's
 message of "Sat, 6 Sep 2008 14:03:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C34C4444-7D3D-11DD-8FE7-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95200>

Christian Couder <chriscool@tuxfamily.org> writes:

> Le samedi 6 septembre 2008, Junio C Hamano a =C3=A9crit :
>> Christian Couder <chriscool@tuxfamily.org> writes:
>> ...
>> > +	 * It doesn't seem logical to use "resolve_ref" with reading =3D=
=3D 0
>> > +	 * as we are just checking if a ref exists,...
>> > ...
>> > +	 */
>>
>> I have to say that this comment is confused.
>>
>> When you have a full ref (as opposed to an abbreviated one that you =
might
>> give to dwim_ref()), you can use it for two kinds of things:
>>
>>  (1) You can use it to find out what _object_ the ref points at.  Th=
is is
>>      "reading" the ref, and the ref, if it is not symbolic, has to e=
xist,
>>      and if it is symbolic, it has to point at an existing ref, beca=
use
>>      the "read" goes through the symref to the ref it points at.
>
> Then the parameter should perhaps be=20
> called "get_object", "get_target", "full_dereference" or something li=
ke=20
> that instead of "reading".

Another way to think about this is the difference is between:

	open(2)+read(2)+close(2)
        readlink(2)

> In "resolve_ref" in refs.c there is the following comment:
>
> 		/* Special case: non-existing file.
> 		 * Not having the refs/heads/new-branch is OK
> 		 * if we are writing into it, so is .git/HEAD
> 		 * that points at refs/heads/master still to be
> 		 * born.  It is NOT OK if we are resolving for
> 		 * reading.
> 		 */
>
> that seems to mean that we are either "writing" or "reading".

I never said the current comments are perfect.

Your patch was about adding comments to help later developers.  If you
think this "if we are writing into it" is wrong because implies "it is =
Ok
to be missing only when we are writing into it", I would very much agre=
e
with _that_ observation.

But then, _this_ comment is what needs to be clarified.

Instead, your patch adds an incorrect observation in a single caller; t=
hat
is hardly an improvement.  The observation being incorrect would not he=
lp
later people, and one caller being commented would not help as much as =
the
callee getting correct comments.

So how about improving the comment that is misleading?

I am not sure what the right re-wording for "reading" would be.  It is
similar to "*_gently()" interface, but it is different.  You could call=
 it
"must_exist", but I am not sure if that is much an improvement either.

 refs.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git i/refs.c w/refs.c
index 39a3b23..a712077 100644
--- i/refs.c
+++ w/refs.c
@@ -409,12 +409,15 @@ const char *resolve_ref(const char *ref, unsigned=
 char *sha1, int reading, int *
 		if (--depth < 0)
 			return NULL;
=20
-		/* Special case: non-existing file.
-		 * Not having the refs/heads/new-branch is OK
-		 * if we are writing into it, so is .git/HEAD
-		 * that points at refs/heads/master still to be
-		 * born.  It is NOT OK if we are resolving for
-		 * reading.
+		/*
+		 * Special case: non-existing file.
+		 * Not having the refs/heads/new-branch is not OK
+		 * we are resolving for reading.  But not everybody
+		 * calls this function to learn what object the ref
+		 * points at.  E.g. it can be called to learn what the
+		 * symref points at.  Also if we are writing into it,
+		 * it is Ok for .git/HEAD to point at refs/heads/master
+		 * that does not exist yet.
 		 */
 		if (lstat(path, &st) < 0) {
 			struct ref_list *list =3D get_packed_refs();
