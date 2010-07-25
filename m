From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Possible bug with `export-subst' attribute
Date: Sun, 25 Jul 2010 17:15:39 -0500
Message-ID: <20100725221539.GA21813@burratino>
References: <19531.65276.394443.190317@winooski.ccs.neu.edu>
 <20100725130935.GA22083@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org,
	Will Palmer <wmpalmer@gmail.com>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Jul 26 00:16:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od9V7-0003Kj-9s
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 00:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531Ab0GYWQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 18:16:47 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33653 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab0GYWQr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 18:16:47 -0400
Received: by ywh1 with SMTP id 1so254995ywh.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 15:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3g4C7KefpVIy3wPh02tZq+CLWulygQapodNhruHLJWU=;
        b=QA6uj5DpiNeIDqTq1OpncTxywqBcSencfT3uHZxNRaH7skAcn6bIiCKu0OhS6123eZ
         bhn/dw6F1qt5uChzrVCk0QX0e7QVBs4GwZbD1eY2W4lqDJkol/JyRBgYKJJNl/VWsyzP
         +1J4oBonduzDeaHUMSEw1sJyZTDRYTNj+Bhd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GQUtmTH6ZHQ3G05yU0xOCciGtrXBm0v1LI6Llk/p9swRItIzVPd+zKrs0wXpDQOUQ2
         uEGdjN3o1Ckhurg6IoWFwevsTInrpNuIkALwGu4ovkwHXly0e1QAhUO3SFw7de1gOVef
         EgHajk5JSiFWnKvOkuHtVWnoEQW8QhDrLs/Is=
Received: by 10.150.31.12 with SMTP id e12mr1733447ybe.79.1280096206212;
        Sun, 25 Jul 2010 15:16:46 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id m11sm5066163ybn.16.2010.07.25.15.16.44
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 15:16:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100725130935.GA22083@LK-Perkele-V2.elisa-laajakaista.fi>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151795>

Ilari Liusvaara wrote:

> I remember seeing similar stuff. It isn't just archive, I also rember seeing
> commit printing full hashes in that informational line it prints when it has
> made the commit (IIRC, normally that hash is abbrevated).

My bad.  Would something like this fix it?

-- 8< --
Subject: archive, commit: use --abbrev by default again

v1.7.1.1~17^2~3 (pretty: Respect --abbrev option, 2010-05-03) taught
git log --format=%h to respect the --abbrev option instead of
always abbreviating, with the side-effect that we have to pay
attention to the abbrev setting now.

For example, the "git archive" export-subst feature and the
informational line printed by "git commit" are using unabbreviated
object names now, the former because full object names are the
low-level default, the latter because it was first written to imitate
plumbing.

Fix them.  While at it, remove a similar confusing
assignment of 0 to rev.abbrev in "git checkout" which had
no effect.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git i/archive.c w/archive.c
index d700af3..edd6853 100644
--- i/archive.c
+++ w/archive.c
@@ -33,6 +33,7 @@ static void format_subst(const struct commit *commit,
 	struct strbuf fmt = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
 	ctx.date_mode = DATE_NORMAL;
+	ctx.abbrev = DEFAULT_ABBREV;
 
 	if (src == buf->buf)
 		to_free = strbuf_detach(buf, NULL);
diff --git i/builtin/checkout.c w/builtin/checkout.c
index 1994be9..eef2b48 100644
--- i/builtin/checkout.c
+++ w/builtin/checkout.c
@@ -279,7 +279,6 @@ static void show_local_changes(struct object *head)
 	struct rev_info rev;
 	/* I think we want full paths, even if we're in a subdirectory. */
 	init_revisions(&rev, NULL);
-	rev.abbrev = 0;
 	rev.diffopt.output_format |= DIFF_FORMAT_NAME_STATUS;
 	if (diff_setup_done(&rev.diffopt) < 0)
 		die("diff_setup_done failed");
diff --git i/builtin/commit.c w/builtin/commit.c
index a78dbd8..ae4831e 100644
--- i/builtin/commit.c
+++ w/builtin/commit.c
@@ -1163,7 +1163,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	init_revisions(&rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 
-	rev.abbrev = 0;
+	rev.abbrev = DEFAULT_ABBREV;
 	rev.diff = 1;
 	rev.diffopt.output_format =
 		DIFF_FORMAT_SHORTSTAT | DIFF_FORMAT_SUMMARY;
-- 
