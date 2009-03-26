From: Johan Herland <johan@herland.net>
Subject: Re: [BUG?] How to make a shared/restricted repo?
Date: Thu, 26 Mar 2009 01:22:24 +0100
Message-ID: <200903260122.24770.johan@herland.net>
References: <200903250105.05808.johan@herland.net>
 <7v63hybaqd.fsf@gitster.siamese.dyndns.org>
 <7vwsadw5pz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 01:24:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmdO6-0002QE-1J
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 01:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795AbZCZAWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 20:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752970AbZCZAWa
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 20:22:30 -0400
Received: from mx.getmail.no ([84.208.15.66]:56715 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751897AbZCZAW3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 20:22:29 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH3009UZ7PE8V00@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 26 Mar 2009 01:22:26 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH300E8A7PDVR50@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 26 Mar 2009 01:22:26 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.26.1034
User-Agent: KMail/1.11.1 (Linux/2.6.28-ARCH; KDE/4.2.1; x86_64; ; )
In-reply-to: <7vwsadw5pz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114695>

On Thursday 26 March 2009, Junio C Hamano wrote:
> How about doing it like this, instead?

Looks good, and is obviously much less intrusive than my attempt.

There's still one issue as compared to my series: Hook scripts in
.git/hooks lose their executable bit when copied from template dir.
You probably need to do some kind of special x-bit handling, similar
to what's already done for directories.

Other than that:
Tested-by: Johan Herland <johan@herland.net>

> I think there are more places you could sprinkle adjust_shared_perm() for
> packfiles and other things.  I didn't check, not because I wasn't
> uninterested, but because I am more interested in getting what
> adjust_shared_perm() itself does right.

Here is my #7 patch, re-rolled on top of your patch to call
adjust_shared_perm():

---
 fast-import.c |    2 ++
 http-push.c   |    1 +
 http-walker.c |    1 +
 index-pack.c  |    2 ++
 4 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index beeac0d..d73ee71 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -903,7 +903,9 @@ static char *keep_pack(char *curr_index_name)
        int keep_fd;
 
        chmod(pack_data->pack_name, 0444);
+       adjust_shared_perm(pack_data->pack_name);
        chmod(curr_index_name, 0444);
+       adjust_shared_perm(curr_index_name);
 
        keep_fd = odb_pack_keep(name, sizeof(name), pack_data->sha1);
        if (keep_fd < 0)
diff --git a/http-push.c b/http-push.c
index 6ce5a1d..a5acabf 100644
--- a/http-push.c
+++ b/http-push.c
@@ -750,6 +750,7 @@ static void finish_request(struct transfer_request *request)
        } else if (request->state == RUN_FETCH_LOOSE) {
                fchmod(request->local_fileno, 0444);
                close(request->local_fileno); request->local_fileno = -1;
+               adjust_shared_perm(request->tmpfile);
 
                if (request->curl_result != CURLE_OK &&
                    request->http_code != 416) {
diff --git a/http-walker.c b/http-walker.c
index 0dbad3c..24cfc45 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -233,6 +233,7 @@ static void finish_object_request(struct object_request *obj_req)
 
        fchmod(obj_req->local, 0444);
        close(obj_req->local); obj_req->local = -1;
+       adjust_shared_perm(obj_req->tmpfile);
 
        if (obj_req->http_code == 416) {
                fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
diff --git a/index-pack.c b/index-pack.c
index 7546822..7abe3f0 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -826,6 +826,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
        }
        if (from_stdin)
                chmod(final_pack_name, 0444);
+               adjust_shared_perm(final_pack_name);
 
        if (final_index_name != curr_index_name) {
                if (!final_index_name) {
@@ -837,6 +838,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
                        die("cannot store index file");
        }
        chmod(final_index_name, 0444);
+       adjust_shared_perm(final_index_name);
 
        if (!from_stdin) {
                printf("%s\n", sha1_to_hex(sha1));
-- 
1.6.2.1.473.g92672

-- 
Johan Herland, <johan@herland.net>
www.herland.net
