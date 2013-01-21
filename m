From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Hiding some refs in ls-remote
Date: Mon, 21 Jan 2013 18:03:39 -0500
Message-ID: <20130121230339.GC17156@sigill.intra.peff.net>
References: <1358555826-11883-1-git-send-email-gitster@pobox.com>
 <20130119165042.GB12307@sigill.intra.peff.net>
 <7vpq0zn2za.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, spearce@spearce.org, mfick@codeaurora.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 00:04:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxQPb-0001t1-Dm
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 00:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763Ab3AUXDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 18:03:42 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41791 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554Ab3AUXDl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 18:03:41 -0500
Received: (qmail 20413 invoked by uid 107); 21 Jan 2013 23:05:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Jan 2013 18:05:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Jan 2013 18:03:39 -0500
Content-Disposition: inline
In-Reply-To: <7vpq0zn2za.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214170>

On Sun, Jan 20, 2013 at 10:06:33AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> 	[uploadPack]
> >> 		hiderefs = refs/changes
> >
> > Would you want to do the same thing on receive-pack? It could benefit
> > from the same reduction in network cost (although it tends to be invoked
> > less frequently than upload-pack).
> 
> Do *I* want to do?  Not when there already is a patch exists; I'd
> rather take existing and tested patch ;-)

The patch we have is below, but I do not think you want it, as it is
missing several things:

  - docs and tests

  - handling multiple values

  - anything but raw prefix matching (you even have to put in the "/"
    yourself).

It was not my patch originally, and I never bothered to clean and
upstream it because I didn't think it was something anybody else would
be interested in. I'm happy to do so, but if you are working in the area
anyway, it would make sense to be part of your series.

-Peff

---
diff --git b/builtin/receive-pack.c a/builtin/receive-pack.c
index 0afb8b2..b22670c 100644
--- b/builtin/receive-pack.c
+++ a/builtin/receive-pack.c
@@ -39,6 +39,7 @@ static void *head_name_to_free;
 static int auto_gc = 1;
 static const char *head_name;
 static void *head_name_to_free;
+static const char *hide_refs;
 static int sent_capabilities;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
@@ -113,11 +114,19 @@ static void show_ref(const char *path, const unsigned char *sha1)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.hiderefs") == 0) {
+		git_config_string(&hide_refs, var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
 static void show_ref(const char *path, const unsigned char *sha1)
 {
+	if (hide_refs && strncmp(path, hide_refs, strlen(hide_refs)) == 0)
+		return 0;
+
 	if (sent_capabilities)
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
 	else
