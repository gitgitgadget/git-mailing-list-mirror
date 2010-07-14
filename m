From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rerere: fix overeager gc
Date: Wed, 14 Jul 2010 09:23:17 -0700
Message-ID: <7v1vb6yqve.fsf@alter.siamese.dyndns.org>
References: <7vlj9lo6w6.fsf@alter.siamese.dyndns.org>
 <1278978124-3035-2-git-send-email-szeder@ira.uka.de>
 <7v630k6wpg.fsf@alter.siamese.dyndns.org> <20100714121925.GG15270@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Jul 14 18:23:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ4kB-0001BA-73
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 18:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757211Ab0GNQX3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 12:23:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756979Ab0GNQX2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 12:23:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A3E6C4169;
	Wed, 14 Jul 2010 12:23:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GB9E5rxGPzLH
	QK/Dx+lWCv7ou9Q=; b=UKa/Xbi+nRgPFYpA1GpRUP8Q288qw+ZpHxxATQrMZwYR
	O/mwQVF4STJxN9d5ncPEBDc9l6F5bMurHvdovy+PRdk69Y0cJjLwq2pFxvSBEEAu
	Ah8GKEgoVig3Oz/wad7hU3W8eUue0qO+T1IJg5TcFnpikX5Xyo8eWW7bhDo4HL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tiEbZZ
	iInpCt9MR7TJGWpJ4PqtScwTzPGYxVNbsa8Xcg4X8Mp6cpI1F/GpaSdWDELQMaMg
	Eb8fkXTJShMzI5TXxCQuaBBJV/tV4O8zMYPuPP23NJHBZn/U1+ms14G+afW1U4F1
	zDW4hj4hqonkSJ0GYId9dLkZMsEUk99rkN0To=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 17295C4168;
	Wed, 14 Jul 2010 12:23:23 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2742BC4165; Wed, 14 Jul
 2010 12:23:19 -0400 (EDT)
In-Reply-To: <20100714121925.GG15270@neumann> ("SZEDER =?utf-8?Q?G=C3=A1bo?=
 =?utf-8?Q?r=22's?= message of "Wed\, 14 Jul 2010 14\:19\:25 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1F65D6B6-8F64-11DF-83A1-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151005>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Mon, Jul 12, 2010 at 05:40:11PM -0700, Junio C Hamano wrote:
>> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>> > +static time_t rerere_last_used_at(const char *name)
>> > +{
>> > +	struct stat st;
>> > +	return stat(rerere_path(name, "postimage"), &st) ? (time_t) 0 : =
st.st_mtime;
>> > +}
>>=20
>> Doesn't has_rerere_resolution() already do a stat on this path?  The=
re are
>> only two allers of the function so it would probably make sense to p=
ass a
>> pointer to struct stat from the caller to avoid one extra call to st=
at.
>
> rerere_last_used_at() returns 0 when the stat() on 'postimage' fails,
> exactly like has_rerere_resolution().  Consequently, we can use
> rerere_last_used_at() to determine whether a resolution exists, too.

"When was this last used?" is answered with "infinitely long time ago" =
for
an item that does not exist.  Between the ones that have never been
resolved (i.e. no "postimage") and the ones that have not been used for=
 a
long time, there is no material difference in the expiration, as long a=
s
"long time" exceeds rerere-unresolved.  Ok; I can see the logic in that=
=2E

I wonder if swapping the order of things to check may make it easier to
read, though.  If it was used, we want to compare gc.rerereresolved wit=
h
that timestamp, and otherwise we want to compare gc.rerereunresolved wi=
th
the timestamp of the creation.  I.e. something like this...

 builtin/rerere.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 7e45afe..6d1b580 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -59,16 +59,16 @@ static void garbage_collect(struct string_list *rr)
 	while ((e =3D readdir(dir))) {
 		if (is_dot_or_dotdot(e->d_name))
 			continue;
-		then =3D rerere_created_at(e->d_name);
-		if (!then)
-			continue;
-		if (has_rerere_resolution(e->d_name)) {
-			then =3D rerere_last_used_at(e->d_name);
+
+		then =3D rerere_last_used_at(e->d_name);
+		if (then) {
+			cutoff =3D cutoff_resolve;
+		} else {
+			then =3D rerere_created_at(e->d_name);
 			if (!then)
 				continue;
-			cutoff =3D cutoff_resolve;
-		} else
 			cutoff =3D cutoff_noresolve;
+		}
 		if (then < now - cutoff * 86400)
 			string_list_append(e->d_name, &to_remove);
 	}
