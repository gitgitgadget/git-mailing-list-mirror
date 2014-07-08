From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/4] cache-tree: Write updated cache-tree after commit
Date: Tue, 08 Jul 2014 12:15:06 -0700
Message-ID: <xmqq61j7achx.fsf@gitster.dls.corp.google.com>
References: <1404619619-4774-1-git-send-email-dturner@twitter.com>
	<1404619619-4774-4-git-send-email-dturner@twitter.com>
	<xmqq61j9c4xb.fsf@gitster.dls.corp.google.com>
	<xmqq7g3obsqm.fsf@gitster.dls.corp.google.com>
	<CACsJy8C20oFdATHKTLK=9U3_kHu1QsuS4i74RPgQn0aTwVCC8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 21:16:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4asq-0000bt-68
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 21:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbaGHTPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 15:15:19 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65211 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932366AbaGHTPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 15:15:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 644C42655D;
	Tue,  8 Jul 2014 15:15:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ROoRUjvMsqiKXG9KuKL8PzgeOpw=; b=yHYz7R
	Xx/iCRVZVKDcoDDuqAJBRfRofHxaqexy/mfz86e8TRruf9kS1sfnZpmqu63n98yn
	QA6UM5frwYDzWMRmZVG6j7eyRUiE8kbS8K211tvNu2R5vmRr/POmgup2uaAUHUyW
	u029fA9DRkUvH1DMcQJw360C+6AZFHE7+1rqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jSN95lD1VGz3ruWsrR6+sdAWewmOgQTG
	a2mDoSpr61qi+PBZaE7gOO8u7vRaWormrnuNMPWMNITufM0X0l5QcqkpB3cetv91
	IUFVQLGv5qTxlKfNnmWepMvSsIKEGat1tB+RUIVBdneJY5V+aCHaK/Z21cw9VAuU
	ShzbXdh0suI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D36512655A;
	Tue,  8 Jul 2014 15:15:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C25B62654F;
	Tue,  8 Jul 2014 15:14:54 -0400 (EDT)
In-Reply-To: <CACsJy8C20oFdATHKTLK=9U3_kHu1QsuS4i74RPgQn0aTwVCC8w@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 8 Jul 2014 17:32:20 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 24CAE538-06D4-11E4-B257-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253039>

Duy Nguyen <pclouds@gmail.com> writes:

> Writing cache tree early in prepare_index() does help hooks, but I
> would say hooks are uncommon case and we could add an option to
> update-index to explicitly rebuild cache-tree, then hooks that do diff
> a lot (or other operations that use cache-tree) could rebuild
> cache-tree by themselves.

Yes, "update-index --update-cache-tree" would be a good addition for
completeness; scripts working with plumbing should be able to do
what built-in Porcelains can.  They can of course do "write-tree" in
the meantime so I do not see it as a very high priority, though.

This should apply on top of 'master', and if the series under
discussion turns out to be a good idea, the new call to
update-main-cache-tree I added to this code path should use the
option added by the series that only repairs parts of cache-trees
that can be repaird without writing out new trees, so it is just to
give hints to future people (iow I am not going to apply this patch
myself right now).

 builtin/update-index.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index ebea285..1ce2274 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -26,6 +26,7 @@ static int allow_remove;
 static int allow_replace;
 static int info_only;
 static int force_remove;
+static int update_cache_tree;
 static int verbose;
 static int mark_valid_only;
 static int mark_skip_worktree_only;
@@ -762,6 +763,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "unmerged", &refresh_args.flags,
 			N_("refresh even if index contains unmerged entries"),
 			REFRESH_UNMERGED),
+		OPT_BOOL(0, "update-cache-tree", &update_cache_tree,
+			 N_("update cache-tree before writing the result out")),
 		{OPTION_CALLBACK, 0, "refresh", &refresh_args, NULL,
 			N_("refresh stat information"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
@@ -918,6 +921,11 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
+	if (update_cache_tree && !unmerged_cache()) {
+		update_main_cache_tree(0);
+		active_cache_changed = 1; /* force write-out */
+	}
+
 	if (active_cache_changed) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
