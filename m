From: Jeff King <peff@peff.net>
Subject: Re: Redefine semantics of find_unique_abbrev()
Date: Sat, 1 Mar 2008 00:06:41 -0500
Message-ID: <20080301050641.GB8969@coredump.intra.peff.net>
References: <7vpruf9q5a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 06:07:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVJwO-0001RC-92
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 06:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbYCAFGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 00:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbYCAFGo
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 00:06:44 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1876 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbYCAFGn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 00:06:43 -0500
Received: (qmail 32644 invoked by uid 111); 1 Mar 2008 05:06:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 01 Mar 2008 00:06:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Mar 2008 00:06:41 -0500
Content-Disposition: inline
In-Reply-To: <7vpruf9q5a.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75611>

On Fri, Feb 29, 2008 at 05:41:53PM -0800, Junio C Hamano wrote:

> The function returned NULL when no object that matches the name
> was found, but that made the callers more complicated, as nobody
> used that NULL return as an indication that no object with such
> a name exists.  They (at least the careful ones) instead took
> the full 40-hexdigit and used in such a case, and the careless
> ones segfaulted.
> 
> With this "git rev-parse --short 5555555555555555555555555555555555555555"
> would stop segfaulting.

I have been meaning to clean up and submit a similar patch from the
1.5.4 freeze period. However, your patch will always print the
40-hexdigit version, which looks quite ugly in status output. Instead,
we can do much better by finding the longest subsequence we _do_ know
about, and adding one digit to it.

So you get:

  # this is the current master, abbreviated
  $ git rev-parse --short 97b97c58e609a1cd23b3c2514f41cdb0405870ee
  97b97c5

  # this is an object we don't have, but similar to that
  $ git rev-parse --short 97b97c58e609a1cd23b3c2514f41cdb0405870ff
  97b97c58e609a1cd23b3c2514f41cdb0405870f

  # and less similar means we can abbreviate more
  $ git rev-parse --short 97b97c58e609a1cd23b3c2514fffffffffffffff
  97b97c58e609a1cd23b3c2514ff

Implementation is below:

> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -202,16 +202,14 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
>  	while (len < 40) {
>  		unsigned char sha1_ret[20];
>  		status = get_short_sha1(hex, len, sha1_ret, 1);
> -		if (!status ||
> -		    (is_null && status != SHORT_NAME_AMBIGUOUS)) {
> +		if ((!is_null && !status) ||
> +		    (is_null && status == SHORT_NAME_NOT_FOUND)) {
>  			hex[len] = 0;
>  			return hex;
>  		}
> -		if (status != SHORT_NAME_AMBIGUOUS)
> -			return NULL;
>  		len++;
>  	}
> -	return NULL;
> +	return hex;
>  }

All we have to do is treat the "missing" case like we treat "is_null"
(and in fact, is_null is just a specialized case of something we don't
have). So replace this hunk with:

diff --git a/sha1_name.c b/sha1_name.c
index 05c2e7a..9c71d1b 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -192,18 +192,18 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 
 const char *find_unique_abbrev(const unsigned char *sha1, int len)
 {
-	int status, is_null;
+	int status, missing;
 	static char hex[41];
 
-	is_null = is_null_sha1(sha1);
+	missing = !has_sha1_file(sha1);
 	memcpy(hex, sha1_to_hex(sha1), 40);
 	if (len == 40 || !len)
 		return hex;
 	while (len < 40) {
 		unsigned char sha1_ret[20];
 		status = get_short_sha1(hex, len, sha1_ret, 1);
-		if ((!is_null && !status) ||
-		    (is_null && status == SHORT_NAME_NOT_FOUND)) {
+		if ((!missing && !status) ||
+		    (missing && status == SHORT_NAME_NOT_FOUND)) {
 			hex[len] = 0;
 			return hex;
 		}


-Peff
