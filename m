From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 2/3] pretty: add infrastructure to allow format
 aliases
Date: Sun, 2 May 2010 06:55:11 -0500
Message-ID: <20100502115511.GA13419@progeny.tock>
References: <1272798044-10487-1-git-send-email-wmpalmer@gmail.com>
 <1272798044-10487-3-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 13:55:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Xlc-0005kX-D4
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 13:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756533Ab0EBLzT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 May 2010 07:55:19 -0400
Received: from mail-iw0-f182.google.com ([209.85.223.182]:62422 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756428Ab0EBLzR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 07:55:17 -0400
Received: by iwn12 with SMTP id 12so2084088iwn.15
        for <git@vger.kernel.org>; Sun, 02 May 2010 04:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=24VIkHjOGQngFKybQhC3b6ys4UcqE04M2vniu+op0Hc=;
        b=Sbn9ZBNHcdWI0N4A5FAeg1g3915B3umvfQ9Y+a9kyMpfWfZR9VhLib+mX/LptJqV3w
         W9VWmI4Slhuyi/ES6Xtdbl6YCE+511Z4Bp8HTL3HRTMg4+r/Lq1iccIehpWK6TGhtRMH
         5yP36uZT0TKCrFephSAIeQbjVR71IFTlsA6Ik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=rjHqf/057qpmGhfBbY/o7BXrfCOabf0+uXzo+JO2sZQ9FHeiRdVHq9wiiUA7yQNjU3
         dLaWuP7GBUC59OfoRYv7/NtPPp39Ayq1U5KXxv41GWkSXn6i96VoOPouP+iGOYTasKNw
         zLg+uVNFy3B4O08a+vWhNOxuYZLKxiIBjMfKc=
Received: by 10.231.79.196 with SMTP id q4mr2540310ibk.69.1272801315530;
        Sun, 02 May 2010 04:55:15 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm3387763iwn.10.2010.05.02.04.55.13
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 04:55:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1272798044-10487-3-git-send-email-wmpalmer@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146166>

Will Palmer wrote:

> here we modify the find_commit_format function to make it recursively
> dereference aliases when they are specified. At this point, there are
> no aliases specified and there is no way to specify an alias, but the
> support is there for any which are added.

Style.  Maybe:

	Subject: pretty: add infrastructure for commit format aliases

	Allow named commit formats to alias one another;
	find_commit_format() will recursively dereference aliases when
	they are specified.  At this point, there are no aliases
	specified and there is no way to specify an alias, but the
	support is there for any which are added.

	If an alias loop is detected, the function die()s.

[...]
> -static struct cmt_fmt_map *find_commit_format(const char *sought)
> +static struct cmt_fmt_map *find_commit_format_recursive(const char *=
sought,
> +							const char *original,
> +							int num_redirections)
>  {
>  	struct cmt_fmt_map *found =3D NULL;
>  	size_t found_match_len;
>  	int i;
> =20
> -	if (!commit_formats)
> -		setup_commit_formats();
> +	if (num_redirections >=3D commit_formats_len) {
> +		die("invalid --pretty format: '%s' references an alias which "
> +		    "points to itself", original);
> +		return NULL;

nitpicks:

 1. If the caller might like the chance to add more information or
    recover (as in code used by git daemon or that might become part of
    libgit2), you can error() and return NULL.  This would print an
    "error: " message and let the caller take care of exiting.

    Otherwise, this should probably die() (which prints a "fatal: "
    message) without returning anything.

    Not important, of course; just something to avoid confusion for
    the reader and static analyzers.

 2. It might be helpful to wrap differently in case someone tries to
    grep for "alias which points to itself" after encountering the
    error message.

With or without the changes mentioned above:

  Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Nice, thanks.  I hope GCC notices the tail recursion (though since
this is not so performance critical for git afaict, if it doesn=E2=80=99=
t, it
is probably better to fix that in GCC than make the git code uglier).

diff --git a/pretty.c b/pretty.c
index 02665d0..0ba056a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -56,11 +56,10 @@ static struct cmt_fmt_map *find_commit_format_recur=
sive(const char *sought,
 	size_t found_match_len;
 	int i;
=20
-	if (num_redirections >=3D commit_formats_len) {
-		die("invalid --pretty format: '%s' references an alias which "
-		    "points to itself", original);
-		return NULL;
-	}
+	if (num_redirections >=3D commit_formats_len)
+		die("invalid --pretty format: "
+		    "'%s' references an alias which points to itself",
+		    original);
=20
 	for (i =3D 0; i < commit_formats_len; i++) {
 		size_t match_len;
--=20
