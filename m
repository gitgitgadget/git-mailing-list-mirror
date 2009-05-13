From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 1/2] Quote LF in urls git fetch saves in FETCH_HEAD
Date: Wed, 13 May 2009 20:08:53 +0200
Message-ID: <20090513180853.GB26288@blimp.localdomain>
References: <200905112208.21017.Hugo.Mildenberger@namir.de> <200905121557.18542.Hugo.Mildenberger@namir.de> <81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com> <200905121900.00625.Hugo.Mildenberger@namir.de> <81b0412b0905121018lbccda1fvf6c4c19417cdde00@mail.gmail.com> <20090512172452.GA32594@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 20:09:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4ItG-0000jC-Ea
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 20:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759931AbZEMSJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 14:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758971AbZEMSJE
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 14:09:04 -0400
Received: from mout0.freenet.de ([195.4.92.90]:51066 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755610AbZEMSJB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 14:09:01 -0400
Received: from [195.4.92.22] (helo=12.mx.freenet.de)
	by mout0.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #88)
	id 1M4It0-0005fS-H7; Wed, 13 May 2009 20:08:58 +0200
Received: from x4098.x.pppool.de ([89.59.64.152]:51440 helo=tigra.home)
	by 12.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1M4Isz-0007zf-Vv; Wed, 13 May 2009 20:08:58 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 8AF2D277D8;
	Wed, 13 May 2009 20:08:53 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 4BED436D28; Wed, 13 May 2009 20:08:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090512172452.GA32594@blimp.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119080>

The fmt-merge-msg does a strong syntax checking of its input and fails
with if it is incorrect. The LF character is the only character
important for fmt-merge-msg. As the url in FETCH_HEAD plays only
informational role, a quoted representation of the url should be good
and true enough.
The url often comes from either user-editable config or command line,
so it is reasonable to expect all kinds of characters in it, including
the characters which the format of FETCH_HEAD considers special (line
separator in this case).

Noticed and reported by Hugo Mildenberger.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Alex Riesen, Tue, May 12, 2009 19:24:52 +0200:
> Alex Riesen, Tue, May 12, 2009 19:18:33 +0200:
> > 2009/5/12 Hugo Mildenberger <Hugo.Mildenberger@namir.de>:
> > > hm@localhost /var/tmp/bluetooth-testing.git $ git pull
> > > fatal: Error in line 2:
> > 
> > That's already fixed. Will send the fix in a minute.
> 
> Here
> 

That one has a bug which breaks t5515: printing an unterminated
string ('note').

 builtin-fetch.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 3c998ea..ec75df0 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -353,12 +353,18 @@ static int store_updated_refs(const char *url, const char *remote_name,
 						    kind);
 			note_len += sprintf(note + note_len, "'%s' of ", what);
 		}
-		note_len += sprintf(note + note_len, "%.*s", url_len, url);
-		fprintf(fp, "%s\t%s\t%s\n",
+		note[note_len] = '\0';
+		fprintf(fp, "%s\t%s\t%s",
 			sha1_to_hex(commit ? commit->object.sha1 :
 				    rm->old_sha1),
 			rm->merge ? "" : "not-for-merge",
 			note);
+		for (i = 0; i < url_len; ++i)
+			if ('\n' == url[i])
+				fputs("\\n", fp);
+			else
+				fputc(url[i], fp);
+		fputc('\n', fp);
 
 		if (ref)
 			rc |= update_local_ref(ref, what, note);
-- 
1.6.3.28.ga852b
