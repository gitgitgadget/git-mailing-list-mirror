From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] merge-recursive: options to ignore whitespace changes
Date: Thu, 26 Aug 2010 00:51:47 -0500
Message-ID: <20100826055147.GG9708@burratino>
References: <20100823205915.GA4484@ns1.cockos.com>
 <20100826054158.GB9708@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	eyvind.bernhardsen@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Justin Frankel <justin@cockos.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 07:53:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoVP6-0004Qb-R9
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 07:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098Ab0HZFxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 01:53:30 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38817 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab0HZFx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 01:53:29 -0400
Received: by gxk23 with SMTP id 23so502712gxk.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 22:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3ZpHCap26SOZDG8L4Bcxb00k5qNmSaWJbFy5XcRy08M=;
        b=rVyNk752VVE1ghQHrng959Z9p42HAWWs5WRxLT1XfbLHxfrJ1Cc9/4bdkEpEWduIoa
         L5m7+EgElPWB92UxqvatHL9fTRmkvL3hlp6rhWG2TYzQb4+/zyNp1gChs7hKRfH8H7Qr
         0Wj21zB5gQ3nHHQZBtgnG/1hfHoAGKsjh2yfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gXrGtk43Bi7Bt2sdS0K6eQAhzD7x3G5n6bhBCSoY9nX/KP/MsFTYZ8PUEnquZdK/40
         uCY6axP6K0YZMNTznG/1QTMKi6c1sxn+3GdfG63r/5EgeMR4aIh9bFa2tmVmw1Obe6WC
         1dLMhuD0o6LboksiTOefSBALraE48ynrJ1w3o=
Received: by 10.150.50.10 with SMTP id x10mr9658254ybx.397.1282802008500;
        Wed, 25 Aug 2010 22:53:28 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id 18sm7136218ybk.7.2010.08.25.22.53.27
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 22:53:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100826054158.GB9708@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154515>

From: Justin Frankel <justin@cockos.com>

Add support for merging with ignoring line endings (specifically
--ignore-space-at-eol) when using recursive merging.  This is
as a strategy-option, so that you can do:

	git merge --strategy-option=ignore-space-at-eol <branch>

and

	git rebase --strategy-option=ignore-space-at-eol <branch>

This can be useful for coping with line-ending damage (Xcode 3.1 has a
nasty habit of converting all CRLFs to LFs, and VC6 tends to just use
CRLFs for inserted lines).

The only option I need is ignore-space-at-eol, but while at it,
include the other xdiff whitespace options (ignore-space-change,
ignore-all-space), too.

[jn: with documentation]

Signed-off-by: Justin Frankel <justin@cockos.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.  Thoughts (and tests) welcome, as
always.

 Documentation/merge-strategies.txt |   15 +++++++++++++++
 merge-recursive.c                  |    8 ++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index a5ae14f..91faba5 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -47,6 +47,21 @@ patience;;
 	this when the branches to be merged have diverged wildly.
 	See also linkgit:git-diff[1] `--patience`.
 
+ignore-space-change;;
+ignore-all-space;;
+ignore-space-at-eol;;
+	Treats lines with the indicated type of whitespace change as
+	unchanged for the sake of a three-way merge.  Whitespace
+	changes mixed with other changes to a line are not ignored.
+	See also linkgit:git-diff[1] `-b`, `-w`, and
+	`--ignore-space-at-eol`.
++
+* If 'their' version only introduces whitespace changes to a line,
+  'our' version is used;
+* If 'our' version introduces whitespace changes but 'their'
+  version includes a substantial change, 'their' version is used;
+* Otherwise, the merge proceeds in the usual way.
+
 renormalize;;
 	This runs a virtual check-out and check-in of all three stages
 	of a file when resolving a three-way merge.  This option is
diff --git a/merge-recursive.c b/merge-recursive.c
index 3e67f81..944ca19 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1515,6 +1515,14 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 		o->subtree_shift = s + strlen("subtree=");
 	else if (!strcmp(s, "patience"))
 		o->xdl_opts |= XDF_PATIENCE_DIFF;
+	else if (!strcmp(s, "ignore-space-change"))
+		o->xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
+	else if (!strcmp(s, "ignore-all-space"))
+		o->xdl_opts |= XDF_IGNORE_WHITESPACE;
+	else if (!strcmp(s, "ignore-space-at-eol"))
+		o->xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
+	else if (!strcmp(s, "ignore-space-at-eol"))
+		o->xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
 	else if (!strcmp(s, "renormalize"))
 		o->renormalize = 1;
 	else if (!strcmp(s, "no-renormalize"))
-- 
1.7.2.2
