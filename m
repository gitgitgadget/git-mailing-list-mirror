From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (bugfix)] gitweb: Fix unintended "--no-merges" for regular Atom feed
Date: Wed,  4 Apr 2012 14:25:44 +0200
Message-ID: <1333542344-20421-1-git-send-email-jnareb@gmail.com>
References: <4F79D76D.80805@pipping.org>
Cc: Sebastian Pipping <sebastian@pipping.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 14:26:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFPHq-0005sh-M9
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 14:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078Ab2DDM0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 08:26:01 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54561 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab2DDM0A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 08:26:00 -0400
Received: by bkcik5 with SMTP id ik5so217568bkc.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 05:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=trF03k2Y8bhFcb8b9l/ZRUM5CnmxIk9f395rq2LRScw=;
        b=MBgNDCMDstxIS4fR059bmT85aiWm3gTpKMZvOis1CeK62QNIM+0ViVHphtn6sNirij
         3XTBAGBuDx56Kc3b47OMR6brrIEBV3tatLNc7SOhMmLtYAiUIOf1sVf5w2U1KP8C7Al/
         psM8ctKIKO/ca+zj3Vq1uR/RWaxbtpzrVi6TyQHGZDbE+LwSyoyg1z7SaCjSLeeJlUs/
         eUIKnG8bKWh15+XJIqD7mwnrmlCbXIFE8L3d8/JpqWniL+3P/RHUwNLV8wyg57a4O+Ou
         2cNu4PMuVvu8K+CXOQ4ExDbj/NCoF8NNoDfh3LpbnyB8aWlxD7t3tczqW/uJW+MCAdiX
         5fjA==
Received: by 10.205.122.77 with SMTP id gf13mr7621881bkc.15.1333542358962;
        Wed, 04 Apr 2012 05:25:58 -0700 (PDT)
Received: from localhost.localdomain (epp57.neoplus.adsl.tpnet.pl. [83.20.57.57])
        by mx.google.com with ESMTPS id f5sm1483444bke.9.2012.04.04.05.25.57
        (version=SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 05:25:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <4F79D76D.80805@pipping.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194695>

From: Sebastian Pipping <sebastian@pipping.org>

The print_feed_meta() subroutine generates links for feeds with and
without merges, in RSS and Atom formats.  However because %href_params
was not properly reset, it generated links with "--no-merges" for all
except the very first link.

Before:
<link rel="alternate" title="[..] - Atom feed" href="/?p=.git;a=atom;opt=--no-merges" type="application/atom+xml" />
<link rel="alternate" title="[..] - Atom feed (no merges)" href="/?p=.git;a=atom;opt=--no-merges" type="application/atom+xml" />

After:
<link rel="alternate" title="[..] - Atom feed" href="/?p=.git;a=atom" type="application/atom+xml" />
<link rel="alternate" title="[..] - Atom feed (no merges)" href="/?p=.git;a=atom;opt=--no-merges" type="application/atom+xml" />

Signed-off-by: Sebastian Pipping <sebastian@pipping.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Sebastian Pipping wrote:

> Please excuse that I send the patch as an attachment and consider
> application.  Thanks!

Beside sending this patch as an attachement instead of putting it
inline (what was the cause of this?) it was also lacking
Signed-off-by... which I have forged.

I have added explanation of this error in the commit message, and
changed from using '' to undef to get rid of 'opt' / 'extra_options'
parameter instead of having it empty.  It is a better way of doing the
reset.

Junio, the bug is very minor, so I don't know if it is worth fixing
for 1.7.10.

 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a8b5fad2..ca6f038 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3886,6 +3886,7 @@ sub print_feed_meta {
 				'-type' => "application/$type+xml"
 			);
 
+			$href_params{'extra_options'} = undef;
 			$href_params{'action'} = $type;
 			$link_attr{'-href'} = href(%href_params);
 			print "<link ".
-- 
1.7.9
