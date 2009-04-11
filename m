From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH&RFC] get_short_ref(): add strict mode
Date: Sat, 11 Apr 2009 19:14:46 +0200
Message-ID: <1239470086-13818-1-git-send-email-bert.wesarg@googlemail.com>
References: <36ca99e90810172355n2c578b07pd2868b15e6631ef7@mail.gmail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 11 19:17:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsgpF-0007Vy-2L
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 19:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbZDKROy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 13:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbZDKROx
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 13:14:53 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:59676 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbZDKROw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 13:14:52 -0400
Received: by fxm2 with SMTP id 2so1499038fxm.37
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:references;
        bh=BjW+PIDHMqBnsV8qZgIFhWSpcs1Ccr1KRzaiKqn5XFc=;
        b=rGEDzBmawjAOMgfoDlXrs/aKU376flAuOXBMLFayRJbTqEcLrrf4ZauLHYyg97EPIM
         Q/MQXqZqER4CBztkJFbpvaIqM15LOt8BF234KLSh+kXwuyR66jkANdYh+70S8I5zLADy
         IYIJQl678jr04K9z9bKnxGtL/XDsiOhmjEmhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MKGOMHrkqIf/+yYaD3TwkWS/kywzooTUiTwgK73vA3onQ9vSnaf/GT54F75hK0QewO
         XFzg5KWPmv7Osbc++hIvBew6UYxOYaiqNJUbrlLuN0HQgbK6gdiwECUcSp0RaZiBagvz
         lWMVnFVCmrSo6gVOMDDrRlkZAdwgQ9MoBmZYo=
Received: by 10.103.223.2 with SMTP id a2mr2433420mur.88.1239470090758;
        Sat, 11 Apr 2009 10:14:50 -0700 (PDT)
Received: from localhost (p5B0F4C72.dip.t-dialin.net [91.15.76.114])
        by mx.google.com with ESMTPS id j10sm5686520muh.1.2009.04.11.10.14.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Apr 2009 10:14:50 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.463.g124d4
In-Reply-To: <36ca99e90810172355n2c578b07pd2868b15e6631ef7@mail.gmail.com>
References: <36ca99e90810172355n2c578b07pd2868b15e6631ef7@mail.gmail.com> <36ca99e90904090205g8a6a5a6nea96f8c5f44e076a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116302>

Add the strict mode of abbreviation to get_short_ref(), i.e. the resulting ref
won't trigger the ambiguous ref warning.

The only user of this function ("refname:short") still uses the loose mode.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
Cc: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org

I think of 3 alternatives to use this mode for the "refname" format (and
probably others):

  a) Use core.warnAmbiguousRefs to control strict mode.
     This would change the current default behaviour, because this is true
     by default.

  b) Introduce a new core config variable to control this, either for
     for-each-ref alone ore globally.

  c) Introduce a "refname:short-strict" format to get the strict abbreviation.

I'm currently slighty in favour for option b).

Regards,
Bert

 builtin-for-each-ref.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 5cbb4b0..2f323c6 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -569,7 +569,7 @@ static void gen_scanf_fmt(char *scanf_fmt, const char *rule)
 /*
  * Shorten the refname to an non-ambiguous form
  */
-static char *get_short_ref(struct refinfo *ref)
+static char *get_short_ref(struct refinfo *ref, int strict)
 {
 	int i;
 	static char **scanf_fmts;
@@ -606,6 +606,7 @@ static char *get_short_ref(struct refinfo *ref)
 	/* skip first rule, it will always match */
 	for (i = nr_rules - 1; i > 0 ; --i) {
 		int j;
+		int rules_to_fail = i;
 		int short_name_len;
 
 		if (1 != sscanf(ref->refname, scanf_fmts[i], short_name))
@@ -614,14 +615,25 @@ static char *get_short_ref(struct refinfo *ref)
 		short_name_len = strlen(short_name);
 
 		/*
+		 * in strict mode, all (except the matched one) rules
+		 * must fail to resolve to a valid non-ambiguous ref
+		 */
+		if (strict)
+			rules_to_fail = nr_rules;
+
+		/*
 		 * check if the short name resolves to a valid ref,
 		 * but use only rules prior to the matched one
 		 */
-		for (j = 0; j < i; j++) {
+		for (j = 0; j < rules_to_fail; j++) {
 			const char *rule = ref_rev_parse_rules[j];
 			unsigned char short_objectname[20];
 			char refname[PATH_MAX];
 
+			/* skip matched rule */
+			if (i == j)
+				continue;
+
 			/*
 			 * the short name is ambiguous, if it resolves
 			 * (with this previous rule) to a valid ref
@@ -635,9 +647,9 @@ static char *get_short_ref(struct refinfo *ref)
 
 		/*
 		 * short name is non-ambiguous if all previous rules
-		 * haven't resolved to a valid ref
+		 * doesn't resolved to a valid ref
 		 */
-		if (j == i)
+		if (j == rules_to_fail)
 			return short_name;
 	}
 
@@ -684,7 +696,7 @@ static void populate_value(struct refinfo *ref)
 			if (formatp) {
 				formatp++;
 				if (!strcmp(formatp, "short"))
-					refname = get_short_ref(ref);
+					refname = get_short_ref(ref, 0);
 				else
 					die("unknown refname format %s",
 					    formatp);
-- 
tg: (e37347b..) bw/short_ref-warnAmbiguousRefs (depends on: master)
