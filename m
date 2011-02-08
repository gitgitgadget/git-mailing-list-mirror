From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] checkout: rearrange update_refs_for_switch for clarity
Date: Tue, 8 Feb 2011 04:34:34 -0600
Message-ID: <20110208103434.GD29660@elie>
References: <alpine.DEB.1.10.1102062234010.3788@debian>
 <20110207205934.GD13461@sigill.intra.peff.net>
 <AANLkTinmqTi4cYbR6PtSxt6itCvFQDuT_sE1tjx45a3h@mail.gmail.com>
 <20110207220030.GA19357@elie>
 <7vaai7s9g4.fsf@alter.siamese.dyndns.org>
 <20110207234526.GA28336@sigill.intra.peff.net>
 <20110208005238.GB24340@elie>
 <20110208102605.GA29660@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 08 11:34:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmkuD-0003y9-Dh
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 11:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280Ab1BHKek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 05:34:40 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37750 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab1BHKej (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 05:34:39 -0500
Received: by gxk9 with SMTP id 9so2141181gxk.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 02:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7lCA5+bz3e0fbGkglINbCHtFSCNpQrb7CWpVuAC3Ta4=;
        b=Q1nZoX/o+lrmT4ed4dLRirUghYrKPVTkOutecNBD/n/ndIzKqjHH7wPFj2odTtr81i
         u58wvRfvoNXJOiQcJOZQO44J+QmtvIHTXfhco+4xF0QJ55olBl9IYEHXogjDL/Wtk6OQ
         /D9SAVhbicrwiEElTankrz4C23L21Nk42aluA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZJ1g9jHPlnH1IhsDDYhY/9D299IhkDHgfi35Y8ZVqF97wv8HQBunKclXsieYLlRY8E
         rpuxS4q1Ne+FrWhc82ssQ0Lv6pMl7ydZ2QSmdpBDcvXoD88G9D4chXtTe0T7paFrDQf4
         RImuC0KITl6opwZTLK0txeWNq867YkBquUpyg=
Received: by 10.236.110.172 with SMTP id u32mr3698925yhg.63.1297161278375;
        Tue, 08 Feb 2011 02:34:38 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id i11sm3636964yhd.6.2011.02.08.02.34.36
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 08 Feb 2011 02:34:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110208102605.GA29660@elie>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166348>

Take care of simple, exceptional cases before the meat of the "check
out by branch name" code begins.  After this change, the function
vaguely follows the following pseudocode:

	if (-B or -b)
		create branch;
	if (plain "git checkout" or "git checkout HEAD")
		;
	else if (--detach or checking out by non-branch commit name)
		detach HEAD;
	else if (checking out by branch name)
		attach HEAD;

One nice side benefit is to make it possible to remove handling of
the --detach option from outside switch_branches.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.  Thoughts welcome, as always.

'night,
Jonathan

 builtin/checkout.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 51ec977..179d047 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -542,7 +542,17 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 	strbuf_addf(&msg, "checkout: moving from %s to %s",
 		    old_desc ? old_desc : "(invalid)", new->name);
 
-	if (new->path) {
+	if (!strcmp(new->name, "HEAD") && !new->path && !opts->force_detach) {
+		/* Nothing to do. */
+	} else if (opts->force_detach || !new->path) {	/* No longer on any branch. */
+		update_ref(msg.buf, "HEAD", new->commit->object.sha1, NULL,
+			   REF_NODEREF, DIE_ON_ERR);
+		if (!opts->quiet) {
+			if (old->path && advice_detached_head)
+				detach_advice(old->path, new->name);
+			describe_detached_head("HEAD is now at", new->commit);
+		}
+	} else if (new->path) {	/* Switch branches. */
 		create_symref("HEAD", new->path, msg.buf);
 		if (!opts->quiet) {
 			if (old->path && !strcmp(new->path, old->path))
@@ -564,14 +574,6 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 			if (!file_exists(ref_file) && file_exists(log_file))
 				remove_path(log_file);
 		}
-	} else if (opts->force_detach || strcmp(new->name, "HEAD")) {
-		update_ref(msg.buf, "HEAD", new->commit->object.sha1, NULL,
-			   REF_NODEREF, DIE_ON_ERR);
-		if (!opts->quiet) {
-			if (old->path && advice_detached_head)
-				detach_advice(old->path, new->name);
-			describe_detached_head("HEAD is now at", new->commit);
-		}
 	}
 	remove_branch_state();
 	strbuf_release(&msg);
@@ -679,7 +681,6 @@ static const char *unique_tracking_name(const char *name)
 
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
-				int force_detach,
 				struct branch_info *new,
 				struct tree **source_tree,
 				unsigned char rev[20],
@@ -756,8 +757,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	new->name = arg;
 	setup_branch_path(new);
 
-	if (!force_detach &&
-	    check_ref_format(new->path) == CHECK_REF_FORMAT_OK &&
+	if (check_ref_format(new->path) == CHECK_REF_FORMAT_OK &&
 	    resolve_ref(new->path, branch_rev, 1, NULL))
 		hashcpy(rev, branch_rev);
 	else
@@ -906,8 +906,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			dwim_new_local_branch &&
 			opts.track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts.new_branch;
-		int n = parse_branchname_arg(argc, argv,
-				dwim_ok, opts.force_detach,
+		int n = parse_branchname_arg(argc, argv, dwim_ok,
 				&new, &source_tree, rev, &opts.new_branch);
 		argv += n;
 		argc -= n;
-- 
1.7.4
