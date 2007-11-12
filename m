From: Andreas Ericsson <ae@op5.se>
Subject: git diff woes
Date: Mon, 12 Nov 2007 10:44:45 +0100
Message-ID: <4738208D.1080003@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 10:45:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrVqq-0000bF-VY
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 10:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920AbXKLJot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 04:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755606AbXKLJos
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 04:44:48 -0500
Received: from mail.op5.se ([193.201.96.20]:41314 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755484AbXKLJos (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 04:44:48 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id BB1B61F08754
	for <git@vger.kernel.org>; Mon, 12 Nov 2007 10:44:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uqZTjjM8jBYj for <git@vger.kernel.org>;
	Mon, 12 Nov 2007 10:44:46 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id D1A721F08753
	for <git@vger.kernel.org>; Mon, 12 Nov 2007 10:44:45 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64583>

I recently ran into an oddity with the excellent git diff output
format. When a function declaration changes in the same patch as
something else in a function, the old declaration is used with the
diff hunk-headers.

Consider this hunk:
---%<---%<---%<---
@@ -583,75 +346,100 @@ double jitter_request(const char *host, int *status){
        if(verbose) printf("%d candiate peers available\n", num_candidates);
        if(verbose && syncsource_found) printf("synchronization source found\n")
        if(! syncsource_found){
-               *status = STATE_UNKNOWN;
+               status = STATE_WARNING;
                if(verbose) printf("warning: no synchronization source found\n")
        }
---%<---%<---%<---

It definitely looks like a bug, but really isn't, since an earlier hunk
(pasted below) changes the declaration. There were several hunks between
these two, so it was far from obvious when I saw it first.

---%<---%<---%<---
@@ -517,19 +276,22 @@ setup_control_request(ntp_control_message *p, uint8_t opco
 }
 
 /* XXX handle responses with the error bit set */
-double jitter_request(const char *host, int *status){
-       int conn=-1, i, npeers=0, num_candidates=0, syncsource_found=0;
-       int run=0, min_peer_sel=PEER_INCLUDED, num_selected=0, num_valid=0;
+int ntp_request(const char *host, double *offset, int *offset_result, double *j
+       int conn=-1, i, npeers=0, num_candidates=0;
+       int min_peer_sel=PEER_INCLUDED;
        int peers_size=0, peer_offset=0;
+       int status;
---%<---%<---%<--- 
 
This makes it impossible to trust the hunk-header info if the declaration
changes. It might be better to not write it out when the header-line is
also part of the patch. That would at least force one to go back and find
the real declaration. Best would probably be to write the new declaration,
but I'm unsure if that could cause some other confusion.

I haven't started looking into it yet, and as I'm sure there are others
who are much more familiar with the xdiff code I'm shamelessly hoping
someone will beat me to a fix.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
