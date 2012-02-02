From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] Use correct grammar in diffstat summary line
Date: Thu, 2 Feb 2012 21:22:55 +0700
Message-ID: <20120202142255.GA25871@do>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
 <7vhaza2qjw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 15:23:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsxZg-0000LP-TD
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 15:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756330Ab2BBOXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 09:23:40 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53443 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756168Ab2BBOXj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 09:23:39 -0500
Received: by pbdu11 with SMTP id u11so2047854pbd.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 06:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+IuJzJWv2qPD2l2kRCs4ULBGRtPmqO3Z7Pc/y00lG18=;
        b=CGNuFoK3ChDyeGgcK8mVz+2XrOQeg+ubdqhFbZA7Y91PuxxbdK3So5yiQGS0agueqp
         Q+a8pDNO8ENpwtXVKsAo/PDqN17eAj+dsdGKOR8ZP8DpEZvuZ5jSgcNOWkBKnElk+rYG
         J3wDek4IW1Iv+8UPcDJP4Cojohh7ep5Gxx9hA=
Received: by 10.68.73.100 with SMTP id k4mr8349708pbv.55.1328192618926;
        Thu, 02 Feb 2012 06:23:38 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.57.120])
        by mx.google.com with ESMTPS id li19sm6015841pbb.17.2012.02.02.06.23.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 06:23:37 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 02 Feb 2012 21:22:55 +0700
Content-Disposition: inline
In-Reply-To: <7vhaza2qjw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189644>

On Wed, Feb 01, 2012 at 01:26:43PM -0800, Junio C Hamano wrote:
> Nice.  Will queue

Please also squash this in (resend looks ugly and it's hard to point
out changes). It makes the code look less ugly, use Q_() for gettext
poisoning and revert am input text back as Jonathan suggested.

I take it --summary is un-i18n-able, should we introduce.. umm..
--nice-summary or something that can support i18n?

-- 8< --
diff --git a/diff.c b/diff.c
index 5f3ce97..07c94f2 100644
--- a/diff.c
+++ b/diff.c
@@ -1325,6 +1325,7 @@ static void fill_print_name(struct diffstat_file *file)
 int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
 {
 	struct strbuf sb = STRBUF_INIT;
+	const char *fmt;
 	int ret;
 
 	if (!files) {
@@ -1332,10 +1333,8 @@ int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
 		return fputs(_(" 0 files changed\n"), fp);
 	}
 
-	strbuf_addf(&sb,
-		    ngettext(" %d file changed", " %d files changed",
-			     files),
-		    files);
+	fmt = Q_(" %d file changed", " %d files changed", files);
+	strbuf_addf(&sb, fmt, files);
 
 	/*
 	 * For binary diff, the caller may want to print "x files
@@ -1346,25 +1345,17 @@ int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
 	 * but nothing about added/removed lines? Is this a bug in Git?").
 	 */
 	if (insertions || deletions == 0) {
-		strbuf_addf(&sb,
-			    /*
-			     * TRANSLATORS: "+" in (+) is a line addition marker;
-			     * do not translate it.
-			     */
-			    ngettext(", %d insertion(+)", ", %d insertions(+)",
-				     insertions),
-			    insertions);
+		/* TRANSLATORS: "+" in (+) is a line addition marker,
+		   do not translate it */
+		fmt = Q_(", %d insertion(+)", ", %d insertions(+)", insertions);
+		strbuf_addf(&sb, fmt, insertions);
 	}
 
 	if (deletions || insertions == 0) {
-		strbuf_addf(&sb,
-			    /*
-			     * TRANSLATORS: "-" in (-) is a line removal marker;
-			     * do not translate it.
-			     */
-			    ngettext(", %d deletion(-)", ", %d deletions(-)",
-				     deletions),
-			    deletions);
+		/* TRANSLATORS: "-" in (-) is a line removal marker,
+		   do not translate it */
+		fmt = Q_(", %d deletion(-)", ", %d deletions(-)", deletions);
+		strbuf_addf(&sb, fmt, deletions);
 	}
 	strbuf_addch(&sb, '\n');
 	ret = fputs(sb.buf, fp);
diff --git a/t/t0023-crlf-am.sh b/t/t0023-crlf-am.sh
index 18fe27b..12a3d78 100755
--- a/t/t0023-crlf-am.sh
+++ b/t/t0023-crlf-am.sh
@@ -12,7 +12,7 @@ Subject: test1
 
 ---
  foo |    1 +
- 1 file changed, 1 insertion(+)
+ 1 files changed, 1 insertions(+)
  create mode 100644 foo
 
 diff --git a/foo b/foo
-- 8< --

-- 
Duy
