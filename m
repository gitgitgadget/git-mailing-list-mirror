From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] get_sha1_oneline: do not leak or double free
Date: Sun, 12 Dec 2010 22:31:18 -0800
Message-ID: <7voc8q5gll.fsf@alter.siamese.dyndns.org>
References: <1292209275-17451-1-git-send-email-pclouds@gmail.com>
 <7v1v5m6w26.fsf@alter.siamese.dyndns.org>
 <7vvd2y5h63.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 07:31:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS1wo-0000b5-Ud
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 07:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069Ab0LMGbl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 01:31:41 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48048 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab0LMGbk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 01:31:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EFB0020C9;
	Mon, 13 Dec 2010 01:32:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Wfry6qIRipiK
	a9gUsf2WwbKG2Gk=; b=tzrT/kUcXOD4UhxjgzdEE4CejCpK5i7AC+MmqkKM+flZ
	zLwThDByDbQnWoh4l/6jl2bwoyicLUjapdiLYLolD9wTVuB8rDwnwsFHZW66bgRl
	6BYIgP5uSH0NPlmzzDyZn4FZ7GMWMAg8u70WM5XHSFcij8oMsMZZ5i5KxmMZAMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TyXagn
	EDOt07kWQhDslJx1vFDgc/ccvMuSdfF1vTHPvHo1KkoOUP6esOBmtoje+NV3bD3p
	T+x43wZDa8uFKH5PEAFpYXRgzHMAbM9ETot8G/ixZ0su+YIFyw68ZZShBEkY7nyY
	umHOjvGXkWZQYAqBQq5LYrDOeJUw1/XqlpKcQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 41F7820C8;
	Mon, 13 Dec 2010 01:31:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C52B620C7; Mon, 13 Dec 2010
 01:31:45 -0500 (EST)
In-Reply-To: <7vvd2y5h63.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 12 Dec 2010 22\:19\:00 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AE62746A-0682-11E0-A95B-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163517>

=2E.. and this is how your [2/3] would look on top of that.

I didn't change the scratchpad bit assignment in this commit, as that i=
s a
logically separate change and I didn't look at all the codepaths that c=
an
call into this function to make sure they never use TMP_MARK themselves=
=2E

They shouldn't, but it is easier to revert the change if there were.

-- >8 --
=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date: Mon, 13 Dec 2010 10:01:14 +0700
Subject: [PATCH 2/3] get_sha1_oneline: make callers prepare the commit =
list to traverse

This gives callers more control, i.e. which ref will be searched from.
They must prepare the list ordered by committer date.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 2cc7a42..aefae1f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -686,13 +686,13 @@ static int handle_one_ref(const char *path,
 	if (object->type !=3D OBJ_COMMIT)
 		return 0;
 	insert_by_date((struct commit *)object, list);
-	object->flags |=3D ONELINE_SEEN;
 	return 0;
 }
=20
-static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
+static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
+			    struct commit_list *list)
 {
-	struct commit_list *list =3D NULL, *backup =3D NULL, *l;
+	struct commit_list *backup =3D NULL, *l;
 	int found =3D 0;
 	regex_t regex;
=20
@@ -705,9 +705,10 @@ static int get_sha1_oneline(const char *prefix, un=
signed char *sha1)
 	if (regcomp(&regex, prefix, REG_EXTENDED))
 		die("Invalid search pattern: %s", prefix);
=20
-	for_each_ref(handle_one_ref, &list);
-	for (l =3D list; l; l =3D l->next)
+	for (l =3D list; l; l =3D l->next) {
+		l->item->object.flags |=3D ONELINE_SEEN;
 		commit_list_insert(l->item, &backup);
+	}
 	while (list) {
 		char *p, *to_free =3D NULL;
 		struct commit *commit;
@@ -1090,9 +1091,11 @@ int get_sha1_with_context_1(const char *name, un=
signed char *sha1,
 		int stage =3D 0;
 		struct cache_entry *ce;
 		int pos;
-		if (namelen > 2 && name[1] =3D=3D '/')
-			/* don't need mode for commit */
-			return get_sha1_oneline(name + 2, sha1);
+		if (namelen > 2 && name[1] =3D=3D '/') {
+			struct commit_list *list =3D NULL;
+			for_each_ref(handle_one_ref, &list);
+			return get_sha1_oneline(name + 2, sha1, list);
+		}
 		if (namelen < 3 ||
 		    name[2] !=3D ':' ||
 		    name[1] < '0' || '3' < name[1])
