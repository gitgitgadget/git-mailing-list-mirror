From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 8/9] fetch doc: add a section on configured remote-tracking branches
Date: Tue,  3 Jun 2014 15:16:31 -0700
Message-ID: <1401833792-2486-9-git-send-email-gitster@pobox.com>
References: <1401833792-2486-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 00:17:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrx1W-0005Zr-5M
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 00:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbaFCWRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 18:17:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52491 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965709AbaFCWRS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 18:17:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 94C191DD9F;
	Tue,  3 Jun 2014 18:17:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=E2EG
	WVYPyIRADNM9RKr4cHladPo=; b=PM7SWgUPCLAvMfbZ0Gf+LubpXPQVbczgJHDt
	pR+RatZiBKhdYr1i+dNLrnA3mWmFSIXFs8azOA/JIf8rvXZDg41WuByfCLFiJcbD
	7lT2/P3iMzm4ceZ163wm0AUdZxcAyq/jBSlqzSLYo0JjIfwDhAJUgrbH6F0DGpC8
	Knc4RgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=JqxjiI
	02zvIdGVSMpdRiMM8TJ2q3okBuJvYPnzWQWTRaQML5CAzweRLMfoaQyV3lqd8XAm
	CNHpNuKvirWZrmDld8MoOi2o49UtuLtlkoHkUqbHBKalW3syET4BeffDCPg9Re0a
	fv8e7WX+UOKKFZXwj5jVvyQ+oBB2XmTZqb6Pw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8BA241DD9E;
	Tue,  3 Jun 2014 18:17:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C45D71DD88;
	Tue,  3 Jun 2014 18:17:13 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-518-g8437b4f
In-Reply-To: <1401833792-2486-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D07DC57C-EB6C-11E3-AD5E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250702>

To resurrect a misleading mention removed in the previous step,
add a section to explain how the remote-tracking configuration
interacts with the refspecs given as the command-line arguments.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-fetch.txt | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 06106b9..d09736a 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -51,6 +51,49 @@ include::pull-fetch-param.txt[]
 include::urls-remotes.txt[]
 
 
+CONFIGURED REMOTE-TRACKING BRANCHES
+-----------------------------------
+
+You would often interact with the same remote repository by
+regularly and repeatedly fetching from it.  In order to keep track
+of the progress of such a remote repository, `git fetch` allows you
+to configure `remote.<repository>.fetch` configuration variable.
+
+Typically such a variable may look like this:
+
+------------------------------------------------
+[remote "origin"]
+	fetch = +refs/heads/*:refs/remotes/origin/*
+------------------------------------------------
+
+This configuration is used in two ways:
+
+* When `git fetch` command is run without specifying what branches
+  and/or tags to fetch on the command line, e.g. `git fetch origin`
+  or `git fetch`, the values configured to this variable are used as
+  the refspecs to be used to fetch.  The example above will fetch
+  all branches that exist on the `origin` (i.e. any ref that matches
+  the left-hand side of the value, `refs/heads/*`) and update the
+  corresponding remote-tracking branches in `refs/remotes/origin/*`
+  hierarchy.
+
+* When `git fetch` command is run with explicit branches and/or tags
+  to fetch on the command line, e.g. `git fetch origin master`, the
+  <refspec> given on the command line (e.g. `master` in the example,
+  which is a short-hand for `master:`, which in turn would mean
+  "fetch the 'master' branch but I do not explicitly say what
+  remote-tracking branch to update with it from the command line")
+  determines what are to be fetched, and the example command will
+  fetch _only_ the 'master' branch.  The values of the variable are
+  used to map the branch (i.e. `master`) to determine which
+  remote-tracking branch, if any, is updated.  When used in this
+  way, the values of the configuration variable do not have any
+  effect in deciding _what_ gets fetched (i.e. the values are not
+  used as refspecs when the command-line lists refspecs); they are
+  only used to decide _where_ the refs that are fetched are stored
+  by acting as a mapping.
+
+
 EXAMPLES
 --------
 
-- 
2.0.0-511-g1433423
