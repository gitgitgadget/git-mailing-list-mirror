From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Enable minimal stat checking
Date: Tue, 22 Jan 2013 09:21:28 -0800
Message-ID: <7va9s19lrb.fsf@alter.siamese.dyndns.org>
References: <7v4niblhr6.fsf@alter.siamese.dyndns.org>
 <1358840962-12316-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j sixt <j.sixt@viscovery.net>,
	Shawn Pearce <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 18:21:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxhXp-0002wy-VV
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 18:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894Ab3AVRVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 12:21:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44104 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753512Ab3AVRVg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 12:21:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB085CF22;
	Tue, 22 Jan 2013 12:21:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+9n/v5Iy59eqjHOx8xTVYyJlp+0=; b=bD2WH+
	AtKV1+S704/tlvjQkvhuBtGewWTWGj9r7+5zVQB+0TWMtl51zW2+aoOb4c9lcnIv
	gXc01a1EKhtmOx68qKFGzocIoCYk0ceQrNi9ipPNrzTo0Urx/GVgfy8zI744uqY0
	OKOPlVZQAVEYCtHB+oWKIr9kSKpcI1MljP/LE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cgwwHMIsZJkjy1Gbjj6BNlE4yQhfSvHT
	qXyP4o1F7ikCGmU3bLNjraOgZcgfKdMkjRKUw3ZDwYmp8EBuG8t4aUT/RGMRENSk
	UDaLpYe0H5zjQdhiwxWFJb2sSBHmLU0TpP+epgV+V3rlsKydAP9XQq/7f+TQargO
	2WWtdIBwFJo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF1DBCF20;
	Tue, 22 Jan 2013 12:21:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C46FCF1E; Tue, 22 Jan 2013
 12:21:30 -0500 (EST)
In-Reply-To: <1358840962-12316-1-git-send-email-robin.rosenberg@dewire.com>
 (Robin Rosenberg's message of "Tue, 22 Jan 2013 08:49:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 291FBD80-64B8-11E2-84F7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214240>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Specifically the fields uid, gid, ctime, ino and dev are set to zero
> by JGit. Other implementations, eg. Git in cygwin are allegedly also
> somewhat incompatible with Git For Windows and on *nix platforms
> the resolution of the timestamps may differ.
>
> Any stat checking by git will then need to check content, which may
> be very slow, particularly on Windows. Since mtime and size
> is typically enough we should allow the user to tell git to avoid
> checking these fields if they are set to zero in the index.
>
> This change introduces a core.checkstat config option where the
> the user can select to check all fields (default), or just size
> and the whole second part of mtime (minimal).
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

The "trust_ctime ? check_stat : trust_ctime/*false*/" gave me the
same "Huh?" as it did to J6t, so I locally fixed them while
applying.

Also, even though we settled on "default/minimal", we may regret in
the future if old implementations died on an unrecognized value, as
that will forbid users from using an old Git and a new Git on the
same repository at the same time, so I'd suggest removing the "if
not default or minimal, die" and replacing it with "treat unknown
token as a do-no-harm no-op".

Interdiff would look like this.

Thanks.

 config.c     |  2 --
 read-cache.c | 12 ++++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index 2b58c75..3f638e3 100644
--- a/config.c
+++ b/config.c
@@ -571,8 +571,6 @@ static int git_default_core_config(const char *var, const char *value)
 			check_stat = 1;
 		else if (!strcasecmp(value, "minimal"))
 			check_stat = 0;
-		else
-			die_bad_config(var);
 	}
 
 	if (!strcmp(var, "core.quotepath")) {
diff --git a/read-cache.c b/read-cache.c
index 23db681..827ae55 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -197,16 +197,16 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	}
 	if (ce->ce_mtime.sec != (unsigned int)st->st_mtime)
 		changed |= MTIME_CHANGED;
-	if (trust_ctime ? check_stat : trust_ctime/*false*/)
-		if (ce->ce_ctime.sec != (unsigned int)st->st_ctime)
-			changed |= CTIME_CHANGED;
+	if (trust_ctime && check_stat &&
+	    ce->ce_ctime.sec != (unsigned int)st->st_ctime)
+		changed |= CTIME_CHANGED;
 
 #ifdef USE_NSEC
 	if (check_stat && ce->ce_mtime.nsec != ST_MTIME_NSEC(*st))
 		changed |= MTIME_CHANGED;
-	if (trust_ctime ? check_stat : trust_ctime/*false*/)
-		if (ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
-			changed |= CTIME_CHANGED;
+	if (trust_ctime && check_stat &&
+	    ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
+		changed |= CTIME_CHANGED;
 #endif
 
 	if (check_stat) {
