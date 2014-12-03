From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] rerere: error out on autoupdate failure
Date: Wed, 3 Dec 2014 10:52:16 -0800
Message-ID: <20141203185216.GA31609@google.com>
References: <20141203042049.GI6527@google.com>
 <xmqqy4qoiqmu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 19:52:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwF2O-0005i0-84
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 19:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbaLCSw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 13:52:27 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:61929 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaLCSw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 13:52:27 -0500
Received: by mail-ie0-f178.google.com with SMTP id tp5so14350445ieb.37
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 10:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=N9TSjMI7nS5NyqNK9G8vM46KcLM3Y/LK6VIhjrZcyJ4=;
        b=f5prWuP0uZT+N/IW2HyCzlYFZnKH4lvfcgAzIfHAAyzWEFvP6bPjKIcAlREzLJpMqg
         FhuYUxU+VK44yOdRi2XCmFox3O9razomwGJatdNl07Ru9BS6GSFEHZly7y5Wr+07EHlQ
         8nX2AhmJlmgPRBJKm5S+XP0JL26yY9VfNLK0Qmzt1hSFzxv1jTbu9/QTy0b7f8lf+T41
         0zXTCZ24ZyJaBOWFg6pc7CMayutcko1r+TE9nr0AGCGVDOLAOAf0EgYVWBB9lcE8HNmJ
         PLJJugrowfNI9CVCvKNAec3FWnkGTnkKTu9Hg1BbI+r4o92revMEsLxxHAnfSIkznSiS
         APRQ==
X-Received: by 10.107.11.88 with SMTP id v85mr6074616ioi.46.1417632746586;
        Wed, 03 Dec 2014 10:52:26 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id s10sm13989092igr.2.2014.12.03.10.52.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 10:52:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqy4qoiqmu.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260677>

We have been tolerating errors by returning early with an error that
the caller ignores since rerere.autoupdate was introduced in
v1.6.0-rc0~120^2 (2008-06-22).  So on error (for example if the index
is already locked), rerere can return success without updating the
index or with only some items in the index updated.

Better to treat such failures as a fatal error so the operator can
figure out what is wrong and fix it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>  	for (i = 0; i < update->nr; i++) {
>>  		struct string_list_item *item = &update->items[i];
>>  		if (add_file_to_cache(item->string, ADD_CACHE_IGNORE_ERRORS))
>> -			status = -1;
>> +			die("staging updated %s failed", item->string);
>
> Instead of crafting a new message, why not just stop passing IGNORE_ERRORS
> and have add_file_to_cache() report the failure?  That is:
> 
> 	if (add_file_to_cache(item->string, 0))
>         	return -1;

Good catch.  It turns out that add_file_to_index does not even pay
attention to the IGNORE_ERRORS flag.  On error it unconditionally
prints a message using 'return error()'.

builtin/add.c uses the IGNORE_ERRORS to flag to decide whether to
avoid die()-ing on error (and it still lets add_file_to_index print the
error to stderr in that case, so --ignore-errors is a bit of a misnomer).

	if (add_file_to_cache(dir->entries[i]->name, flags)) {
		if (!ignore_add_errors)
			die(_("adding files failed"));
		exit_status = 1;
	}

The message always says which file it failed to index, so I agree that
it makes sense to simply exit(128) here.

 rerere.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/rerere.c b/rerere.c
index 1b0555f..dbb2545 100644
--- a/rerere.c
+++ b/rerere.c
@@ -477,27 +477,26 @@ out:
 
 static struct lock_file index_lock;
 
-static int update_paths(struct string_list *update)
+static void update_paths(struct string_list *update)
 {
 	int i;
-	int fd = hold_locked_index(&index_lock, 0);
-	int status = 0;
 
-	if (fd < 0)
-		return -1;
+	hold_locked_index(&index_lock, 1);
 
 	for (i = 0; i < update->nr; i++) {
-		struct string_list_item *item = &update->items[i];
-		if (add_file_to_cache(item->string, ADD_CACHE_IGNORE_ERRORS))
-			status = -1;
+		if (add_file_to_cache(update->items[i].string, 0))
+			/*
+			 * add_file_to_cache() printed an error
+			 * with the pathname, so we don't have to.
+			 */
+			exit(128);
 	}
 
-	if (!status && active_cache_changed) {
+	if (active_cache_changed) {
 		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 			die("Unable to write new index file");
-	} else if (fd >= 0)
+	} else
 		rollback_lock_file(&index_lock);
-	return status;
 }
 
 static int do_plain_rerere(struct string_list *rr, int fd)
