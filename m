From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Remove duplicate pathspecs from ls-files command line
Date: Wed, 29 Aug 2007 21:44:10 +0200
Message-ID: <20070829194410.GA11824@steel.home>
References: <20070829081122.GA604@piper.oerlikon.madduck.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>,
	439992-quiet@bugs.debian.org, Junio C Hamano <junkio@cox.net>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Aug 29 21:44:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQTSf-0004EB-4U
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 21:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985AbXH2ToO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 15:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754260AbXH2ToO
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 15:44:14 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:58752 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721AbXH2ToN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 15:44:13 -0400
Received: from tigra.home (Fc9fa.f.strato-dslnet.de [195.4.201.250])
	by post.webmailer.de (klopstock mo64) (RZmta 12.1)
	with ESMTP id t03533j7TFg8V1 ; Wed, 29 Aug 2007 21:44:10 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 868A7277BD;
	Wed, 29 Aug 2007 21:44:10 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 45021BE06; Wed, 29 Aug 2007 21:44:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070829081122.GA604@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAciAx4=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56973>

The first entry wins, all the subsequent entries will be discarded.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

martin f krafft, Wed, Aug 29, 2007 10:11:22 +0200:
> when using git-add from a script, the following fails:
> 
>   $ git commit -m. foo foo
>   error: pathspec 'foo' did not match any file(s) known to git.
>   Did you forget to 'git add'?
> 
> I am bringing this up in the context of
> http://bugs.debian.org/439992, where debcommit.pl would duplicate
> a file argument under certain conditions. It's since been fixed, but
> I wonder whether git-commit could be made more robust in the
> presence of duplicate arguments? Or is this behaviour by choice?
> 

Don't think so. Looks like accident. The patch below fixes it,
by introducing a costly argument duplication check. Shouldn't
be a problem for a normal use (git-ls-files expects globs, not
pathnames).

 setup.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 06004f1..b13b628 100644
--- a/setup.c
+++ b/setup.c
@@ -111,10 +111,19 @@ void verify_non_filename(const char *prefix, const char *arg)
 		die("'%s': %s", arg, strerror(errno));
 }
 
+static const char **has_pathspec(const char **start, const char **end, const char *spec)
+{
+	const char **p;
+	for (p = start; p != end; ++p)
+		if (!strcmp(*p, spec))
+			return p;
+	return NULL;
+}
+
 const char **get_pathspec(const char *prefix, const char **pathspec)
 {
 	const char *entry = *pathspec;
-	const char **p;
+	const char **in, **out;
 	int prefixlen;
 
 	if (!prefix && !entry)
@@ -128,11 +137,15 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 	}
 
 	/* Otherwise we have to re-write the entries.. */
-	p = pathspec;
+	in = out = pathspec;
 	prefixlen = prefix ? strlen(prefix) : 0;
 	do {
-		*p = prefix_path(prefix, prefixlen, entry);
-	} while ((entry = *++p) != NULL);
+		const char *spec = prefix_path(prefix, prefixlen, entry);
+		if (!has_pathspec(pathspec, out, spec))
+			*out++ = spec;
+	} while ((entry = *++in) != NULL);
+	if (in != out)
+		*out = NULL;
 	return (const char **) pathspec;
 }
 
-- 
1.5.3.rc7.24.g0e57
