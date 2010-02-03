From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [RFC/PATCH 1/6] revert: libify cherry-pick and revert functionnality
Date: Wed, 03 Feb 2010 08:40:40 -0800
Message-ID: <4B69A708.9030300@gmail.com>
References: <20100201074835.3929.11509.chriscool@tuxfamily.org> <20100201075542.3929.38404.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 17:41:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NciHg-0006QA-Hx
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 17:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502Ab0BCQku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 11:40:50 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:45978 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757363Ab0BCQkt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 11:40:49 -0500
Received: by fg-out-1718.google.com with SMTP id 19so14153fgg.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 08:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=U2EmSG+/MfaqN8QZZ8FQ9+YofWCw7SHX4h2nFrpmLho=;
        b=tynZjY+0+JAeA9MI5zc4TBS9WwSVjSefthDlubWlAcsbicPraBs4/+TMazx/vroL+K
         B4umDFtaMzXymT319KR1CFS2yaXKVI9pMKAGKzM7pUExBMdeZCXOoOH9I9FzeW/FS1jc
         4JeHiU+68jJluannpFMGRFcf/nycYoRuutLGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=KDV+DldH7ZmncoEPWz3vrgggqMIRlatULXuiqRj73ju1HL0UinXByFk9+KkzbxcQ20
         jKOPiSqwPm+SCVcjlCaYxsXcigg0uxiZJ6e9tFU8ypd9qk4HAnePqKFA/1/rON5bwBZp
         yQh7FfTNqcWXafst5uFOXNWvSpS4uh3mBFsX4=
Received: by 10.87.21.36 with SMTP id y36mr181619fgi.17.1265215247665;
        Wed, 03 Feb 2010 08:40:47 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 3sm13834470fge.21.2010.02.03.08.40.43
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 08:40:46 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <20100201075542.3929.38404.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138847>

On 01/31/2010 11:55 PM, Christian Couder wrote:
> +	if (flags&  PICK_REVERSE) {
> +		char *oneline_body = strchr(oneline, ' ');
> +
> +		base = commit;
> +		next = parent;
> +		strbuf_addstr(msg, "Revert \"");
> +		strbuf_addstr(msg, oneline_body + 1);
>    

Why not do the oneline_body + 1 during the strchr()? Seems like 
oneline_body is pointing to before the actual string we want.

> +		for (i = 0; i<  active_nr;) {
> +			struct cache_entry *ce = active_cache[i++];
> +			if (ce_stage(ce)) {
> +				strbuf_addstr(msg, "\t");
> +				strbuf_addstr(msg, ce->name);
> +				strbuf_addstr(msg, "\n");
>    

use strbuf_addch() for characters.

--->8----

diff --git a/pick.c b/pick.c
index bb04c68..1e1628a 100644
--- a/pick.c
+++ b/pick.c
@@ -145,12 +145,12 @@ int pick_commit(struct commit *pick_commit, int mainline,
         oneline = get_oneline(message);

         if (flags&  PICK_REVERSE) {
-               char *oneline_body = strchr(oneline, ' ');
+               char *oneline_body = strchr(oneline, ' ') + 1;

                 base = commit;
                 next = parent;
                 strbuf_addstr(msg, "Revert \"");
-               strbuf_addstr(msg, oneline_body + 1);
+               strbuf_addstr(msg, oneline_body);
                 strbuf_addstr(msg, "\"\n\nThis reverts commit ");
                 strbuf_addstr(msg, sha1_to_hex(commit->object.sha1));

@@ -196,9 +196,9 @@ int pick_commit(struct commit *pick_commit, int mainline, in
                 for (i = 0; i<  active_nr;) {
                         struct cache_entry *ce = active_cache[i++];
                         if (ce_stage(ce)) {
-                               strbuf_addstr(msg, "\t");
+                               strbuf_addch(msg, '\t');
                                 strbuf_addstr(msg, ce->name);
-                               strbuf_addstr(msg, "\n");
+                               strbuf_addch(msg, '\n');
                                 while (i<  active_nr&&  !strcmp(ce->name,
                                                 active_cache[i]->name))
                                         i++;
