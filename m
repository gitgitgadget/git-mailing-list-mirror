From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 18/20] refs.c: remove lock_ref_sha1
Date: Tue, 26 Aug 2014 17:35:38 -0700
Message-ID: <20140827003538.GS20185@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140826000354.GW20185@google.com>
 <xmqqlhqbge3a.fsf@gitster.dls.corp.google.com>
 <20140826221448.GY20185@google.com>
 <20140827002804.GA20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 02:35:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMRDJ-0007i5-6U
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 02:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586AbaH0Afn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 20:35:43 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:38655 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516AbaH0Afl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 20:35:41 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so24386245pab.6
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 17:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZkCn+NswvXCVWjRWiC/k9G7k9fmsA0xWBDz6SXBwE3s=;
        b=X/STQFAkh2eBUh2HvO33m9lfvxNiw95t5mU0G1NZTVTZL/TLHyznNHMqXLfHvrLZba
         tTuZroKfABHH2uJWswov2/GO4GILcFfUG3kUUwHU61tLm+HCbF8eqoGynvrHJwyKjQDQ
         2wzMmrW5sgI4OXHd+DfDW3cSINrvzBIBNrtUa6oGB8SEUrLYVRUsb+cGTAQINQVMcpyn
         ob7FJTMtXiKOm2IKRSSAQN+fFhDKtdkF4mxJ8/+l9KO4LRxUzWDGWDXAWHMH/XGsg4cM
         zdTifOtSUVpPKCvTlxt8m6P/xx1/c6uOhYKfoduOuo7rnsIDiPWbMMjQyhEHDu2GR4Oc
         iCww==
X-Received: by 10.66.65.162 with SMTP id y2mr40675762pas.55.1409099741424;
        Tue, 26 Aug 2014 17:35:41 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:4ba:9bd4:148:77e4])
        by mx.google.com with ESMTPSA id fl15sm6809662pdb.92.2014.08.26.17.35.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Aug 2014 17:35:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140827002804.GA20185@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255974>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Tue, 29 Apr 2014 15:45:52 -0700

lock_ref_sha1 was only called from one place in refs.c and only provided
a check that the refname was sane before adding back the initial "refs/"
part of the ref path name, the initial "refs/" that this caller had already
stripped off before calling lock_ref_sha1.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index ef7660a..f0883d0 100644
--- a/refs.c
+++ b/refs.c
@@ -2173,15 +2173,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-static struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
-{
-	char refpath[PATH_MAX];
-	if (check_refname_format(refname, 0))
-		return NULL;
-	strcpy(refpath, mkpath("refs/%s", refname));
-	return lock_ref_sha1_basic(refpath, old_sha1, 0, NULL);
-}
-
 struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
@@ -2391,8 +2382,12 @@ static void try_remove_empty_parents(char *name)
 /* make sure nobody touched the ref, and unlink */
 static void prune_ref(struct ref_to_prune *r)
 {
-	struct ref_lock *lock = lock_ref_sha1(r->name + 5, r->sha1);
+	struct ref_lock *lock;
 
+	if (check_refname_format(r->name + 5, 0))
+		return;
+
+	lock = lock_ref_sha1_basic(r->name, r->sha1, 0, NULL);
 	if (lock) {
 		unlink_or_warn(git_path("%s", r->name));
 		unlock_ref(lock);
-- 
2.1.0.rc2.206.gedb03e5
