From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/2] rerere: fix overeager gc
Date: Wed, 14 Jul 2010 14:19:25 +0200
Message-ID: <20100714121925.GG15270@neumann>
References: <7vlj9lo6w6.fsf@alter.siamese.dyndns.org>
	<1278978124-3035-2-git-send-email-szeder@ira.uka.de>
	<7v630k6wpg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 14:19:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ0w4-0003gF-F7
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 14:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254Ab0GNMTb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 08:19:31 -0400
Received: from francis.fzi.de ([141.21.7.5]:56296 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752516Ab0GNMTa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 08:19:30 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 14 Jul 2010 14:19:25 +0200
Content-Disposition: inline
In-Reply-To: <7v630k6wpg.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 14 Jul 2010 12:19:25.0958 (UTC) FILETIME=[CCBD7260:01CB234E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150983>

On Mon, Jul 12, 2010 at 05:40:11PM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
> > +static time_t rerere_last_used_at(const char *name)
> > +{
> > +	struct stat st;
> > +	return stat(rerere_path(name, "postimage"), &st) ? (time_t) 0 : s=
t.st_mtime;
> > +}
>=20
> Doesn't has_rerere_resolution() already do a stat on this path?  Ther=
e are
> only two allers of the function so it would probably make sense to pa=
ss a
> pointer to struct stat from the caller to avoid one extra call to sta=
t.

rerere_last_used_at() returns 0 when the stat() on 'postimage' fails,
exactly like has_rerere_resolution().  Consequently, we can use
rerere_last_used_at() to determine whether a resolution exists, too.
And if we do that, we dont have to "pollute" callers of
has_rerere_resolution() with superfluous struct stat variables.

So how about this squashed in instead?

-- >8 --

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 52e4b64..1dc424b 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -50,7 +50,7 @@ static void garbage_collect(struct string_list *rr)
 	DIR *dir;
 	struct dirent *e;
 	int i, cutoff;
-	time_t now =3D time(NULL), then;
+	time_t now =3D time(NULL), then, then_post;
=20
 	git_config(git_rerere_gc_config, NULL);
 	dir =3D opendir(git_path("rr-cache"));
@@ -62,10 +62,9 @@ static void garbage_collect(struct string_list *rr)
 		then =3D rerere_created_at(e->d_name);
 		if (!then)
 			continue;
-		if (has_rerere_resolution(e->d_name)) {
-			then =3D rerere_last_used_at(e->d_name);
-			if (!then)
-				continue;
+		then_post =3D rerere_last_used_at(e->d_name);
+		if (then_post) {
+			then =3D then_post;
 			cutoff =3D cutoff_resolve;
 		} else
 			cutoff =3D cutoff_noresolve;
