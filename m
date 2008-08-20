From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] * remote.c (valid_fetch_refspec): remove useless if-before-free
 test
Date: Wed, 20 Aug 2008 18:38:44 -0500
Message-ID: <pI8EXbuWhkm4pM0AaaTAPQQYBeFSffOSzCiM4NfNHKomivEcfUfShA@cipher.nrlssc.navy.mil>
References: <87k5ecx2pl.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jim Meyering <meyering@redhat.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 01:40:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVxHf-0003bX-Rb
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 01:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128AbYHTXjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 19:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756121AbYHTXjF
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 19:39:05 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56450 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756111AbYHTXjE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 19:39:04 -0400
Received: by mail.nrlssc.navy.mil id m7KNcjv4022611; Wed, 20 Aug 2008 18:38:45 -0500
In-Reply-To: <87k5ecx2pl.fsf@rho.meyering.net>
X-OriginalArrivalTime: 20 Aug 2008 23:38:45.0010 (UTC) FILETIME=[E2C27720:01C9031D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93073>

Jim Meyering wrote:
> We removed a handful of these useless if-before-free tests
> several months ago.  This change removes a new one that snuck back in.

> diff --git a/remote.c b/remote.c
> index f61a3ab..105668f 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -579,8 +579,7 @@ int valid_fetch_refspec(const char *fetch_refspec_str)
>  	struct refspec *refspec;
> 
>  	refspec = parse_refspec_internal(1, fetch_refspec, 1, 1);
> -	if (refspec)
> -		free(refspec);
> +	free(refspec);
>  	return !!refspec;
>  }

Maybe we should also begin the process of not leaking memory here...

diff --git a/remote.c b/remote.c
index 7f2897b..984ad1b 100644
--- a/remote.c
+++ b/remote.c
@@ -449,6 +449,20 @@ static int verify_refname(char *name, int is_glob)
	return result;
 }
 
+void free_refspecs(struct refspec *refspec, int nr_refspec)
+{
+	int i;
+
+	if (!refspec)
+		return;
+
+	for (i = 0; i < nr_refspec; i++) {
+		free(refspec[i].src);
+		free(refspec[i].dst);
+	}
+	free(refspec);
+}
+
 static struct refspec *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch, int verify)
 {
 	int i;
@@ -567,7 +581,12 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 
  invalid:
 	if (verify) {
-		free(rs);
+		/*
+		 * nr_refspec must be greater than zero and i must be valid
+		 * since it is only possible to reach this point from within
+		 * the for loop above.
+		 */
+		free_refspecs(rs, i+1);
 		return NULL;
 	}
 	die("Invalid refspec '%s'", refspec[i]);
@@ -579,8 +598,7 @@ int valid_fetch_refspec(const char *fetch_refspec_str)
 	struct refspec *refspec;
 
 	refspec = parse_refspec_internal(1, fetch_refspec, 1, 1);
-	if (refspec)
-		free(refspec);
+	free_refspecs(refspec, 1);
 	return !!refspec;
 }
 
diff --git a/remote.h b/remote.h
index 091b1d0..2601f6e 100644
--- a/remote.h
+++ b/remote.h
@@ -78,6 +78,7 @@ void ref_remove_duplicates(struct ref *ref_map);
 int valid_fetch_refspec(const char *refspec);
 struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
 struct refspec *parse_push_refspec(int nr_refspec, const char **refspec);
+void free_refspecs(struct refspec *refspec, int nr_refspec);
 
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	       int nr_refspec, const char **refspec, int all);
