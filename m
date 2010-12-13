From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] get_sha1_oneline: do not leak or double free
Date: Sun, 12 Dec 2010 22:19:00 -0800
Message-ID: <7vvd2y5h63.fsf@alter.siamese.dyndns.org>
References: <1292209275-17451-1-git-send-email-pclouds@gmail.com>
 <7v1v5m6w26.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 07:22:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS1ni-0006eR-2G
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 07:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554Ab0LMGTX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 01:19:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab0LMGTW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 01:19:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F23103F41;
	Mon, 13 Dec 2010 01:19:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2OFuNib03EkY
	lE97xXNxKYwAY9w=; b=XHHPJ2O+7Z6d8Se9vC3nwN4mpMZEdwq28DOuytX0slxg
	HV2tudkwzVSHBLvJ33K3sEaHfjIHeNFpizhRA+6iq3Rdzfk5BKTsZ1Gv8Yw/hshV
	ghA0H8WQSlh8G+8obGQ5ke0Zuzuhc3yx2/GfTpZbUuckmW13MATZa9mdtASkdLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FiYHh0
	qJGbL+2NxlvcPqgrR8OlhyOrnHTd8fooRXnftq/QBGAiu14j90jdOEG36lpIHChN
	6yXq8sl9fUb0+FsTBBAHsdlty/9cR4YeoUQlvsHFyvOcwNH0PPB8NTXJCHXhLIRY
	liHuzGwI+urzExuFegBm26wYtjgRAOweupjaY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 68E003F3E;
	Mon, 13 Dec 2010 01:19:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EF01C3F39; Mon, 13 Dec 2010
 01:19:27 -0500 (EST)
In-Reply-To: <7v1v5m6w26.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 12 Dec 2010 22\:12\:01 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F698C47A-0680-11E0-8D6C-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163515>

Junio C Hamano <gitster@pobox.com> writes:

> I think the following is easier to read and conveys what the code is
> trying to do more clearly.  No?

This time with a proposed log message...

-- >8 --
Subject: [PATCH] get_sha1_oneline: fix lifespan rule of temp_commit_buf=
fer variable

This is trying to free only what we ourselves read (as opposed to what
we borrowed from commit->buffer) but do so lazily only to work around
the fact that the code has many irregular exit points, and doing it rig=
ht
makes it necessary to call free() from many different places in the loo=
p.

Rewrite the structure of the code inside the loop so that the variable
has to live within a single iteration, ever.  This should make the logi=
c
easier to follow as well.

Also we didn't free a temporary commit list we kept to hold the origina=
l
set of commits.  Free it.

Noticed-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 2c3a5fb..2cc7a42 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -693,8 +693,7 @@ static int handle_one_ref(const char *path,
 static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 {
 	struct commit_list *list =3D NULL, *backup =3D NULL, *l;
-	int retval =3D -1;
-	char *temp_commit_buffer =3D NULL;
+	int found =3D 0;
 	regex_t regex;
=20
 	if (prefix[0] =3D=3D '!') {
@@ -710,37 +709,40 @@ static int get_sha1_oneline(const char *prefix, u=
nsigned char *sha1)
 	for (l =3D list; l; l =3D l->next)
 		commit_list_insert(l->item, &backup);
 	while (list) {
-		char *p;
+		char *p, *to_free =3D NULL;
 		struct commit *commit;
 		enum object_type type;
 		unsigned long size;
+		int matches;
=20
 		commit =3D pop_most_recent_commit(&list, ONELINE_SEEN);
 		if (!parse_object(commit->object.sha1))
 			continue;
-		free(temp_commit_buffer);
 		if (commit->buffer)
 			p =3D commit->buffer;
 		else {
 			p =3D read_sha1_file(commit->object.sha1, &type, &size);
 			if (!p)
 				continue;
-			temp_commit_buffer =3D p;
+			to_free =3D p;
 		}
-		if (!(p =3D strstr(p, "\n\n")))
-			continue;
-		if (!regexec(&regex, p + 2, 0, NULL, 0)) {
+
+		p =3D strstr(p, "\n\n");
+		matches =3D p && !regexec(&regex, p + 2, 0, NULL, 0);
+		free(to_free);
+
+		if (matches) {
 			hashcpy(sha1, commit->object.sha1);
-			retval =3D 0;
+			found =3D 1;
 			break;
 		}
 	}
 	regfree(&regex);
-	free(temp_commit_buffer);
 	free_commit_list(list);
 	for (l =3D backup; l; l =3D l->next)
 		clear_commit_marks(l->item, ONELINE_SEEN);
-	return retval;
+	free_commit_list(backup);
+	return found ? 0 : -1;
 }
=20
 struct grab_nth_branch_switch_cbdata {
--=20
1.7.3.3.763.g91c7d
