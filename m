From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/21] list-files: show directories as well as files
Date: Tue, 27 Jan 2015 13:51:29 -0800
Message-ID: <xmqqmw53ki3i.fsf@gitster.dls.corp.google.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
	<1422189476-7518-18-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 22:51:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGE2r-0000el-DV
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 22:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760041AbbA0Vvd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jan 2015 16:51:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50546 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753689AbbA0Vvc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jan 2015 16:51:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B89032580;
	Tue, 27 Jan 2015 16:51:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=z7ApfxydfL5Y
	P5TYKEX9fgCQ/FA=; b=b6jDJuTUCAXUHzd7XKWCJbw4US6egu6zuue+bsq1BGQT
	mBbNkHp4CQwYjcXgijueAseRzeqWFsPzNtteYwIH4acvWpSiuPlk1C0sUtJb6Mgy
	jiBw1urtEoyJOz3GX6MdUDkxGAltuMQW3L0LrVTh0ats0SXguPOpeCPXosTkLcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VH3NLQ
	lpDACRCsJQBVEVmT1ZXLrm5T8YXBcNjRVBwK68DT5eMXbDRqJzkqWQlf1h1l0206
	etNc+yDwKNdk622q7VRcjPG3xq+hQ2auT+RfUFmY/mQdmCPPolVrkIjMPKpQJuAJ
	COyoIK5PQfNkCP7rqGi+rfKxqU2fsFQt+9wLU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 81BCD3257F;
	Tue, 27 Jan 2015 16:51:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0022F3257D;
	Tue, 27 Jan 2015 16:51:30 -0500 (EST)
In-Reply-To: <1422189476-7518-18-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 25
 Jan 2015 19:37:52 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A7391F50-A66E-11E4-8A3A-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263091>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -194,16 +225,31 @@ static void write_ce_name(struct strbuf *sb, co=
nst struct cache_entry *ce)
>  static void show_ce_entry(const char *tag, const struct cache_entry =
*ce)
>  {
>  	static struct strbuf sb =3D STRBUF_INIT;
> -	int len =3D max_prefix_len;
> +	int len =3D max_prefix_len, saved_max_depth;
> =20
>  	if (len >=3D ce_namelen(ce))
>  		die("git ls-files: internal error - cache entry not superset of pr=
efix");
> =20
> +	if (show_dirs) {
> +		/* ignore depth to catch dirs that contain matched entries */
> +		saved_max_depth =3D pathspec.max_depth;
> +		pathspec.max_depth =3D -1;
> +	}
> +
>  	if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
>  			    len, ps_matched,
>  			    S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode)))
>  		return;
> =20
> +	if (show_dirs) {
> +		pathspec.max_depth =3D saved_max_depth;
> +		if (strchr(ce->name, '/') &&
> +		    !match_pathspec(&pathspec, ce->name, ce_namelen(ce),
> +				    prefix_len, NULL, 1) &&
> +		    show_as_directory(ce))
> +			return;
> +	}
> +

My compiler seems to be too stupid to notice that saved_max_depth is
always set before it is used, if it gets used and complains.  Sigh.

=46or now I am tempted to squash this in.  Note that the original does
not seem to restore saved_max_depath when the pathspec does not match
and function returns in the call to match_pathspec() we have in the
code before your patch, which smells like a bug, and the attached
would fix it.

 builtin/ls-files.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 29b5c2e..f28b7e9 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -222,27 +222,38 @@ static void write_ce_name(struct strbuf *sb, cons=
t struct cache_entry *ce)
 	strbuf_release(&quoted);
 }
=20
+static int match_pathspec_with_depth(struct pathspec *ps,
+				     const char *name, int namelen,
+				     int prefix, char *seen, int is_dir,
+				     const int *custom_depth)
+{
+	int saved_depth =3D ps->max_depth;
+	int result;
+
+	if (custom_depth)
+		ps->max_depth =3D *custom_depth;
+	result =3D match_pathspec(ps, name, namelen, prefix, seen, is_dir);
+	if (custom_depth)
+		ps->max_depth =3D saved_depth;
+	return result;
+}
+
 static void show_ce_entry(const char *tag, const struct cache_entry *c=
e)
 {
 	static struct strbuf sb =3D STRBUF_INIT;
-	int len =3D max_prefix_len, saved_max_depth;
+	int len =3D max_prefix_len;
+	static const int infinite_depth =3D -1;
=20
 	if (len >=3D ce_namelen(ce))
 		die("git ls-files: internal error - cache entry not superset of pref=
ix");
=20
-	if (show_dirs) {
-		/* ignore depth to catch dirs that contain matched entries */
-		saved_max_depth =3D pathspec.max_depth;
-		pathspec.max_depth =3D -1;
-	}
-
-	if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
-			    len, ps_matched,
-			    S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode)))
+	if (!match_pathspec_with_depth(&pathspec, ce->name, ce_namelen(ce),
+				       len, ps_matched,
+				       S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode),
+				       show_dirs ? &infinite_depth : NULL))
 		return;
=20
 	if (show_dirs) {
-		pathspec.max_depth =3D saved_max_depth;
 		if (strchr(ce->name, '/') &&
 		    !match_pathspec(&pathspec, ce->name, ce_namelen(ce),
 				    prefix_len, NULL, 1) &&
