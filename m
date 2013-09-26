From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] merge-recursive: fix parsing of "diff-algorithm" option
Date: Thu, 26 Sep 2013 22:13:31 +0100
Message-ID: <20130926211331.GD27238@serenity.lan>
References: <689bf88b6f1d33e123cc786042cc6dba23464351.1380225743.git.john@keeping.me.uk>
 <20130926204720.GH9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Luke Noel-Storr <luke.noel-storr@integrate.co.uk>,
	Michal Privoznik <mprivozn@redhat.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 23:13:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPIsm-00087Y-Ua
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 23:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222Ab3IZVNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 17:13:48 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:40389 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124Ab3IZVNp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 17:13:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id F1E1F606560;
	Thu, 26 Sep 2013 22:13:44 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7R268UZqfenN; Thu, 26 Sep 2013 22:13:39 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id BF132606566;
	Thu, 26 Sep 2013 22:13:33 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130926204720.GH9464@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235436>

On Thu, Sep 26, 2013 at 01:47:20PM -0700, Jonathan Nieder wrote:
> John Keeping wrote:
> 
> > The "diff-algorithm" option to the recursive merge strategy takes the
> > name of the algorithm as an option, but it uses strcmp on the option
> > string to check if it starts with "diff-algorithm=", meaning that this
> > options cannot actually be used.
> >
> > Fix this by switching to prefixcmp.  At the same time, clarify the
> > following line by using strlen instead of a hard-coded length, which
> > also makes it consistent with nearby code.
> >
> > Reported-by: Luke Noel-Storr <luke.noel-storr@integrate.co.uk>
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> 
> Thanks, both.
> 
> [...]
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -2069,8 +2069,8 @@ int parse_merge_opt(struct merge_options *o, const char *s)
> >  		o->xdl_opts = DIFF_WITH_ALG(o, PATIENCE_DIFF);
> >  	else if (!strcmp(s, "histogram"))
> >  		o->xdl_opts = DIFF_WITH_ALG(o, HISTOGRAM_DIFF);
> > -	else if (!strcmp(s, "diff-algorithm=")) {
> > -		long value = parse_algorithm_value(s+15);
> > +	else if (!prefixcmp(s, "diff-algorithm=")) {
> > +		long value = parse_algorithm_value(s + strlen("diff-algorithm="));
> >  		if (value < 0)
> >  			return -1;
> 
> While we're here:
> 
> Part of the problem is that there are no tests for this option (or for
> 'git diff --diff-algorithm', or for the '[diff] algorithm'
> configuration), so we didn't notice it didn't work until someone
> actually tried it.
> 
> Do you have any examples of a diff or merge that works better with
> some particular diff algorithm, that could be used in tests?

The following is the same diff, but the first time using histogram and
then with myers.

I'm not sure whether we should encode specific diff output into general
tests though - I assume there's a reason why there aren't already tests
for this, but perhaps it's just that no one's written them yet.

-- >8 --
diff --git a/test.c b/test.c
index f3eae9e..55f0c37 100644
--- a/test.c
+++ b/test.c
@@ -1,9 +1,9 @@
-void bye(void)
-{
-	printf("goodbye\n");
-}
-
 void hello(void)
 {
 	printf("hello\n");
 }
+
+void bye(void)
+{
+	printf("goodbye\n");
+}


diff --git a/test.c b/test.c
index f3eae9e..55f0c37 100644
--- a/test.c
+++ b/test.c
@@ -1,9 +1,9 @@
-void bye(void)
+void hello(void)
 {
-	printf("goodbye\n");
+	printf("hello\n");
 }
 
-void hello(void)
+void bye(void)
 {
-	printf("hello\n");
+	printf("goodbye\n");
 }
