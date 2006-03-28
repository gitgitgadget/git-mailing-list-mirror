From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH] xdiff: Show function names in hunk headers.
Date: Tue, 28 Mar 2006 15:03:14 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne2ik1i.s3g.mdw@metalzone.distorted.org.uk>
References: <11435126113456-git-send-email-mdw@distorted.org.uk> <7vfyl3m7vy.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 28 17:03:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOFjA-0002Pt-Ud
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 17:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWC1PDU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 10:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWC1PDU
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 10:03:20 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:43103 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1750741AbWC1PDT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 10:03:19 -0500
Received: (qmail 510 invoked by uid 110); 28 Mar 2006 15:03:14 -0000
To: git@vger.kernel.org
Received: (qmail 497 invoked by uid 9); 28 Mar 2006 15:03:14 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1143558194 495 172.29.199.2 (28 Mar 2006 15:03:14 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Tue, 28 Mar 2006 15:03:14 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18123>

Junio C Hamano <junkio@cox.net> wrote:

> GNU diff -p does "^[[:alpha:]$_]"; personally I think any line
> that does not begin with a whitespace is good enough.

Hmm.  I think my approach is wrong.  I've noticed that targets of the
form `$(FOO): ...' in Makefiles would make nice hunk headers, but my
current hack won't notice them.  Without a shift of approach, I think
I run the risk of deluging the list with little fixes to this bit of
code, which sounds like a pile of no fun.

So, I have two main suggestions.  The first is /very/ stupid, and just
asks for two non-whitespace characters at the start of a line.

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index ad5bfb1..822f991 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -83,11 +83,9 @@ static void xdl_find_func(xdfile_t *xf, 
        *ll = 0;
        while (i-- > 0) {
                len = xdl_get_rec(xf, i, &rec);
-               if (len > 0 &&
-                   (isalpha((unsigned char)*rec) || /* identifier? */
-                    *rec == '_' ||     /* also identifier? */
-                    *rec == '(' ||     /* lisp defun? */
-                    *rec == '#')) {    /* #define? */
+               if (len >= 2 &&
+                   !isspace((unsigned char)rec[0]) &&
+                   !isspace((unsigned char)rec[1])) {
                        if (len > sz)
                                len = sz;
                        if (len && rec[len - 1] == '\n')

The second suggestion is slightly refined, but a little more
complicated.  We ask for a line which starts /either/ with two
non-whitespace characters, or with an alphanumeric.  Why?  Because text
documents have a tendency to have headings of the form `7 Heading!' and
I want to catch them.

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index ad5bfb1..bcb3e47 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -83,11 +83,10 @@ static void xdl_find_func(xdfile_t *xf, 
        *ll = 0;
        while (i-- > 0) {
                len = xdl_get_rec(xf, i, &rec);
-               if (len > 0 &&
-                   (isalpha((unsigned char)*rec) || /* identifier? */
-                    *rec == '_' ||     /* also identifier? */
-                    *rec == '(' ||     /* lisp defun? */
-                    *rec == '#')) {    /* #define? */
+               if (len && !isspace((unsigned char)*rec) &&
+                   ((len >= 2 && !isspace((unsigned char)rec[1])) ||
+                    isalnum((unsigned char)*rec) ||
+                    *rec == '_')) {
                        if (len > sz)
                                len = sz;
                        if (len && rec[len - 1] == '\n')

Another possibility I just thought of: insist that the line starts with
a non-space, and contains another non-space somewhere.  This will get
caught out by `{       /* ... rest of comment */', which I've seen a few
places, though.

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index ad5bfb1..81b38ce 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -79,15 +79,18 @@ static void xdl_find_func(xdfile_t *xf, 
 
        const char *rec;
        long len;
+       long j;
 
        *ll = 0;
        while (i-- > 0) {
                len = xdl_get_rec(xf, i, &rec);
-               if (len > 0 &&
-                   (isalpha((unsigned char)*rec) || /* identifier? */
-                    *rec == '_' ||     /* also identifier? */
-                    *rec == '(' ||     /* lisp defun? */
-                    *rec == '#')) {    /* #define? */
+               if (len && !isspace((unsigned char)*rec)) {
+                       for (j = 1; j < len; j++) {
+                               if (!isspace((unsigned char)rec[j]))
+                                       goto good;
+                       }
+                       continue;
+               good:
                        if (len > sz)
                                len = sz;
                        if (len && rec[len - 1] == '\n')

I think I like option 2 best, as a nice compromise between stupidity and
actually working.  Opinions, anyone?

-- [mdw]
