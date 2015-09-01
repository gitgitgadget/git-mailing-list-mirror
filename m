From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 2/6] date: make "local" orthogonal to date format
Date: Tue, 1 Sep 2015 23:33:08 +0100
Message-ID: <20150901223308.GI30659@serenity.lan>
References: <20150901083731.GE30659@serenity.lan>
 <cover.1441144343.git.john@keeping.me.uk>
 <35b1313d4eb084ddc2bd70510d56e11a1d84e993.1441144343.git.john@keeping.me.uk>
 <xmqqwpw9pyy5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:33:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWu7I-0004mY-SE
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 00:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbbIAWdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 18:33:21 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:56069 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbbIAWdU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 18:33:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 31A0BCDA594;
	Tue,  1 Sep 2015 23:33:20 +0100 (BST)
X-Quarantine-ID: <ATmlgqf6DMMg>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_20=-0.001, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ATmlgqf6DMMg; Tue,  1 Sep 2015 23:33:19 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 514E8CDA56C;
	Tue,  1 Sep 2015 23:33:10 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqwpw9pyy5.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277063>

On Tue, Sep 01, 2015 at 03:16:50PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > This is Jeff's original patch with my fixup for DATE_STRFTIME squashed
> > in and a new change to reject "raw-local" (in both Documentation/ and
> > date.c).
> 
> Even in --date=raw, we do show the timezone offset, so I do not
> necessarily agree that raw-local is nonsensical.  That's the only
> difference between the one I queued yesterday and this one.

I suspect it depends on the interpretation of "raw"; the code currently
interprets raw to mean "exactly what exists in the commit/tag", in which
case converting it to the local timezone is wrong.  But the
documentation describes "raw" as "the raw Git %s %z format", and if we
interpret it to mean "Git's internal date format" then "raw-local" makes
sense.

The alternative would be the patch below as a preparatory step.

-- >8 --
diff --git a/date.c b/date.c
index f048416..345890f 100644
--- a/date.c
+++ b/date.c
@@ -175,12 +175,6 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 	struct tm *tm;
 	static struct strbuf timebuf = STRBUF_INIT;
 
-	if (mode->type == DATE_RAW) {
-		strbuf_reset(&timebuf);
-		strbuf_addf(&timebuf, "%lu %+05d", time, tz);
-		return timebuf.buf;
-	}
-
 	if (mode->type == DATE_RELATIVE) {
 		struct timeval now;
 
@@ -193,6 +187,12 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 	if (mode->local)
 		tz = local_tzoffset(time);
 
+	if (mode->type == DATE_RAW) {
+		strbuf_reset(&timebuf);
+		strbuf_addf(&timebuf, "%lu %+05d", time, tz);
+		return timebuf.buf;
+	}
+
 	tm = time_to_tm(time, tz);
 	if (!tm) {
 		tm = time_to_tm(0, 0);
