From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH maint-1.7.6] fast-import: leakfix for 'ls' of dirty trees
Date: Fri, 9 Mar 2012 21:20:34 -0600
Message-ID: <20120310032034.GB3008@burratino>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
 <1331184656-98629-1-git-send-email-davidbarr@google.com>
 <20120308070951.GA2181@burratino>
 <7vty1zdp2b.fsf@alter.siamese.dyndns.org>
 <20120310031228.GA3008@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 04:20:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6CrM-0007gM-8T
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 04:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759425Ab2CJDUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 22:20:39 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52336 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481Ab2CJDUi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 22:20:38 -0500
Received: by iagz16 with SMTP id z16so3182923iag.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 19:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=k5xOGZ/EmrkrwFHNvUb2/7G//79qFUOUhT6P3L/3yKo=;
        b=sqp7l9o2svRA4LRgQCvL8FUO2L/gGXc0dNY6zR2BqXH7UtKtyQrANOmxScNi19g7vA
         ARHPleQtptPgUKmGxz8Oda0DzQ3157uVhpGI+HZV8xbwpGc66cqbPqPaxFu7vz6AdPvY
         msIt5RoGwA3m4PmRPFyUtG++OMCrjuhwIYus8SWoXs05hHJfLT68fN2q4vZc3owOB3hd
         bUAj62obNuBIaQgbG6UJ425SLSiSfkAvTJIwCisUoleAvuEY06OlSxHZmphPMZcSTPMt
         ekA38ezNe6zyizH7tYz1Zka19j0stRLENN8ulWPuTCVPxfyhqfkpcP43cGov2IfOgFjC
         /qAQ==
Received: by 10.182.174.101 with SMTP id br5mr1795773obc.0.1331349638023;
        Fri, 09 Mar 2012 19:20:38 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id g10sm3916283oei.9.2012.03.09.19.20.36
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Mar 2012 19:20:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120310031228.GA3008@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192764>

When the chosen directory has changed since it was last written to
pack, "tree_content_get" makes a deep copy of its content to scribble
on while computing the tree name, which we forgot to free.

This leak has been present since the 'ls' command was introduced in
v1.7.5-rc0~3^2~33 (fast-import: add 'ls' command, 2010-12-02).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Sorry to have missed this buglet for so long.  (Doubly so because it
was noticed and commented on half a year ago before being promptly
forgotten.)  Patch is against commit 8dc6a373d2 which introduced the
leaky 'ls' support.

 fast-import.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fast-import.c b/fast-import.c
index 6c37b840..fff285cd 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2987,6 +2987,8 @@ static void parse_ls(struct branch *b)
 		store_tree(&leaf);
 
 	print_ls(leaf.versions[1].mode, leaf.versions[1].sha1, p);
+	if (leaf.tree)
+		release_tree_content_recursive(leaf.tree);
 	if (!b || root != &b->branch_tree)
 		release_tree_entry(root);
 }
-- 
1.7.9.2
