From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] Bisect reset: remove bisect refs that may have been packed.
Date: Thu, 15 Nov 2007 03:49:34 -0500
Message-ID: <20071115084934.GN14735@spearce.org>
References: <20071115081807.06fe092b.chriscool@tuxfamily.org> <7vwssj6hw8.fsf@gitster.siamese.dyndns.org> <473C02F9.4020402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 09:50:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsaQ9-0001T7-Fu
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 09:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbXKOItl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 03:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbXKOItl
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 03:49:41 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34583 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbXKOItk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 03:49:40 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IsaPm-0002FI-R8; Thu, 15 Nov 2007 03:49:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7235520FBAE; Thu, 15 Nov 2007 03:49:34 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <473C02F9.4020402@viscovery.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65090>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> Junio C Hamano schrieb:
> >+	git for-each-ref --format='%(refname) %(objectname)' refs/bisect/\* 
> >refs/heads/bisect |
> >+	while read ref hash
> 
> If you also swap %(refname) and %(objectname), then this is also not prone 
> to whitespace in refnames. (Yes, I know, there shouldn't be such, but...)

What's this obsession with whitespace in refnames?  Twice in like
two days people are talking about whitespace in refnames.

WHITESPACE IS NOT PERMITTED IN REFNAMES.

Do we need to apply the following patch, to keep people from creating
refs by hand with whitespace in them?  Is this really that common?

	git rev-parse HEAD >'.git/refs/heads/..i have spaces hah!'


diff --git a/refs.c b/refs.c
index aff02cd..b95bf83 100644
--- a/refs.c
+++ b/refs.c
@@ -246,6 +246,7 @@ static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
 			struct stat st;
 			int flag;
 			int namelen;
+			int check;
 
 			if (de->d_name[0] == '.')
 				continue;
@@ -261,6 +262,9 @@ static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
 				list = get_ref_dir(ref, list);
 				continue;
 			}
+			check = check_ref_format(ref);
+			if (check != 0 && check != -2)
+				continue;
 			if (!resolve_ref(ref, sha1, 1, &flag)) {
 				error("%s points nowhere!", ref);
 				continue;

-- 
Shawn.
