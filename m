From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/3] avoiding unintended consequences of git_path()
 usage
Date: Fri, 18 Nov 2011 10:33:49 +0700
Message-ID: <20111118033349.GA20827@tre>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-4-git-send-email-artagnon@gmail.com>
 <20111106002645.GE27272@elie.hsd1.il.comcast.net>
 <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 <7v7h33oifq.fsf@alter.siamese.dyndns.org>
 <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
 <20111115095225.GB23139@elie.hsd1.il.comcast.net>
 <7v7h31wduv.fsf@alter.siamese.dyndns.org>
 <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com>
 <20111116075955.GB13706@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 04:30:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRF9T-000805-QV
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 04:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab1KRD34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 22:29:56 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45281 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107Ab1KRD3z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 22:29:55 -0500
Received: by ghbz2 with SMTP id z2so65540ghb.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 19:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XzJJw1OV3KTJMY5yQUFld9gezh+dH9kiqQWsRS6lYJ4=;
        b=GxpiLiLXfsFItJgU59eV1pkNiMqMUd6TGTbyp4U55inC1lLCVDq76oO96GGoJfpBV4
         0oJPad0Ibry2ZPtFDFcUKipsBWpBRSZ+avYCV86rmY5caAodcFolrZn9U7npZBeqevBw
         gX/Ub/ILnSs7HKq76scHx5vjJn1g1Bj+e0L0A=
Received: by 10.50.100.232 with SMTP id fb8mr1369314igb.8.1321586994523;
        Thu, 17 Nov 2011 19:29:54 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id g16sm65726656ibs.8.2011.11.17.19.29.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 19:29:53 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Fri, 18 Nov 2011 10:33:49 +0700
Content-Disposition: inline
In-Reply-To: <20111116075955.GB13706@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185626>

On Wed, Nov 16, 2011 at 01:59:55AM -0600, Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
> > Junio C Hamano wrote:
> 
> >> Or perhaps http://thread.gmane.org/gmane.comp.version-control.git/184963/focus=185436
> >
> > I noticed that sha1_to_hex() also operates like this.  The
> > resolve_ref() function is really important, but using the same
> > technique for these tiny functions is probably an overkill
> 
> I don't follow.  Do you mean that not being confusing is overkill,
> because the function is small that no one will bother to look up the
> right semantics?  Wait, that sentence didn't come out the way I
> wanted. ;-)
> 
> Jokes aside, here's a rough series to do the git_path ->
> git_path_unsafe renaming.  While writing it, I noticed a couple of
> bugs, hence the two patches before the last one.  Patch 2 is the more
> interesting one.

Or perhaps we can use per-file buffer rings instead of a global one.
This means git_path() can only interfere another one in the same file,
making the interaction simpler and hopefully simple enough for reviewers
to catch 90% bugs, therefore safe enough to avoid the _unsafe suffix.

Adding static variable declaration in cache.h is ugly, but that could be
moved to a separate header file.

diff --git a/cache.h b/cache.h
index 2e6ad36..437bc3a 100644
--- a/cache.h
+++ b/cache.h
@@ -660,9 +660,13 @@ extern char *git_snpath(char *buf, size_t n, const char *fmt, ...)
 extern char *git_pathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 
+#define git_path(...) git_path_1(pathname_array[3 & ++pathname_index], __VA_ARGS__)
+static char pathname_array[4][PATH_MAX];
+static int pathname_index;
+
 /* Return a statically allocated filename matching the sha1 signature */
 extern char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
-extern char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+extern char *git_path_1(char *pathname, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 extern char *git_path_submodule(const char *path, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
diff --git a/path.c b/path.c
index b6f71d1..3c95db1 100644
--- a/path.c
+++ b/path.c
@@ -101,10 +101,9 @@ char *mkpath(const char *fmt, ...)
 	return cleanup_path(pathname);
 }
 
-char *git_path(const char *fmt, ...)
+char *git_path_1(char *pathname, const char *fmt, ...)
 {
 	const char *git_dir = get_git_dir();
-	char *pathname = get_pathname();
 	va_list args;
 	unsigned len;
 
