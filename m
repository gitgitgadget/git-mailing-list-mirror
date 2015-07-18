From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v5 12/44] builtin-am: implement --skip
Date: Sat, 18 Jul 2015 23:22:12 +0800
Message-ID: <20150718152212.GA22976@yoshi.chippynet.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
 <1436278862-2638-13-git-send-email-pyokagan@gmail.com>
 <CAGZ79kaWV-hMEgJ8HJP2Jgq78su+YbyBbcYD3sZ0474UUNw=pA@mail.gmail.com>
 <CACRoPnRri5Nu5rj9O7id+PyiDBJpZkBDk8kB0WCuB3Uef76M3g@mail.gmail.com>
 <CAGZ79kYYJughaqBD7hzzDBO4xmrJ7P3VT7m=qG-SRLXiK-f_vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 17:23:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGTxa-0008HM-Sn
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 17:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbbGRPWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 11:22:19 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33544 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbbGRPWS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 11:22:18 -0400
Received: by pdbnt7 with SMTP id nt7so6570180pdb.0
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 08:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Tn4OCDBm2P19nIrIVi7q+5Fs+eVKTH/6dJvYatw9G9A=;
        b=E4jpCe3mQVb735Z/r+eSJXutnvjqpVbE7Fl/H47q+VT+cUif9o+UQqIyYHLUi1dpQQ
         nGWJXhHOHME+Ewf+gRZQOpnwOChD5mr3YNmgS/J25eFC0jLfOlooRJCZQFxqYdeDemDg
         GOtluhr0vNCPMXk/wqu+Pj/jd4zryw6sXkK2cKwmn9FtaWousntmnpVn8DbPNZZcZyKv
         ei6JiacWhadVE/2DlrMQ3r/fTEtTxG1KR222X8Jo6AIcyjogrkTxGC5PdtpX8CwyH7+q
         gjQOdhHxVqXh+X3ePFNgxrfaGvBWAOOwwvIWLu2xEw4DgJapByR+iLDVRjnCjK6eRQP8
         01GA==
X-Received: by 10.68.205.196 with SMTP id li4mr40401476pbc.122.1437232938376;
        Sat, 18 Jul 2015 08:22:18 -0700 (PDT)
Received: from yoshi.chippynet.com ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id fl6sm14693165pab.12.2015.07.18.08.22.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2015 08:22:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGZ79kYYJughaqBD7hzzDBO4xmrJ7P3VT7m=qG-SRLXiK-f_vA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274164>

On Tue, Jul 14, 2015 at 09:54:10AM -0700, Stefan Beller wrote:
> So what I meant to suggest, was to only allocate the memory if we really need it
> by moving the allocation further down.
> 
> static int clean_index(const unsigned char *head, const unsigned char *remote)
> {
>        struct lock_file *lock_file;
> ...
> ... // includes return -1, which would not leak the memory already allocated
> ...
>        lock_file = xalloc (...);
>        hold_locked_index(lock_file, 1);

Ah, sorry, I misinterpreted your message ><. Thanks for catching this.

I've moved all the lock file memory allocation to just before the
hold_locked_index() calls on my end.

diff --git a/builtin/am.c b/builtin/am.c
index c597325..dc8e862 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1138,13 +1138,12 @@ static const char *msgnum(const struct am_state *state)
  */
 static void refresh_and_write_cache(void)
 {
-	static struct lock_file lock_file;
+	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
-	hold_locked_index(&lock_file, 1);
+	hold_locked_index(lock_file, 1);
 	refresh_cache(REFRESH_QUIET);
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 		die(_("unable to write index file"));
-	rollback_lock_file(&lock_file);
 }
 
 /**
@@ -1923,13 +1922,14 @@ next:
  */
 static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 {
-	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
+	struct lock_file *lock_file;
 	struct unpack_trees_options opts;
 	struct tree_desc t[2];
 
 	if (parse_tree(head) || parse_tree(remote))
 		return -1;
 
+	lock_file = xcalloc(1, sizeof(struct lock_file));
 	hold_locked_index(lock_file, 1);
 
 	refresh_cache(REFRESH_QUIET);
@@ -1962,7 +1962,7 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
  */
 static int clean_index(const unsigned char *head, const unsigned char *remote)
 {
-	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
+	struct lock_file *lock_file;
 	struct tree *head_tree, *remote_tree, *index_tree;
 	unsigned char index[GIT_SHA1_RAWSZ];
 	struct pathspec pathspec;
@@ -1992,6 +1992,7 @@ static int clean_index(const unsigned char *head, const unsigned char *remote)
 
 	memset(&pathspec, 0, sizeof(pathspec));
 
+	lock_file = xcalloc(1, sizeof(struct lock_file));
 	hold_locked_index(lock_file, 1);
 
 	if (read_tree(remote_tree, 0, &pathspec)) {

Thanks,
Paul
