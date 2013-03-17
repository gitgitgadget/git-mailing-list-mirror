From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] safe_create_leading_directories: fix race that could
 give a false negative
Date: Sun, 17 Mar 2013 12:45:45 -0700
Message-ID: <7vppyxres6.fsf@alter.siamese.dyndns.org>
References: <7v7gl6sfsg.fsf@alter.siamese.dyndns.org>
 <1363529367-5919-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 20:46:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHJX7-0002a0-5x
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 20:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756500Ab3CQTpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 15:45:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43718 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756411Ab3CQTps (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 15:45:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05D5DB62A;
	Sun, 17 Mar 2013 15:45:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fZmRaatruyc1dxyD0yMQTrLWdQQ=; b=t4KWz4
	0BFBxdPSG4lxiywAn+5WHV6S5mEgftnJIkJaOouFkB1YMLmb0n2AZsuW6zqm1BR0
	3zJD8s07MAeRioDA/fPe02+WeuAZLJDW3X84RlB+cVekmET8adMhbB7lk4caUCG1
	rKXoFaN+USC9PtERmhKH85Uw6F9HKIJHZxko0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rh1jxdGcEPhVBrUyt3a1F66om4sIofsC
	jK/dGiOeTOEZS2ZKl28KHeOC6Sr7aU5VF9oXG6c0HEbGpOzGZhfy9rmlDWOpPbeQ
	p45SVoxKP1EvgU5k8S5iSXtC2YuYOZaQ33JNpSd88ftWQuif5HCRIljnpJ/JINii
	Dn0Jv5TFleM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF5D7B629;
	Sun, 17 Mar 2013 15:45:47 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46491B627; Sun, 17 Mar 2013
 15:45:47 -0400 (EDT)
In-Reply-To: <1363529367-5919-1-git-send-email-stevenrwalter@gmail.com>
 (Steven Walter's message of "Sun, 17 Mar 2013 10:09:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4381CE7C-8F3B-11E2-9E40-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218368>

Steven Walter <stevenrwalter@gmail.com> writes:

> If two processes are racing to create the same directory tree, they will
> both see that the directory doesn't exist, both try to mkdir(), and one
> of them will fail.  This is okay, as we only care that the directory
> gets created.  So, we add a check for EEXIST from mkdir, and continue if
> the directory now exists.
>
> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
> ---
>  sha1_file.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 40b2329..5668ecc 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -123,6 +123,15 @@ int safe_create_leading_directories(char *path)
>  			}
>  		}
>  		else if (mkdir(path, 0777)) {
> +			if (errno == EEXIST) {
> +				/*
> +				 * We could be racing with another process to
> +				 * create the directory.  As long as the
> +				 * directory gets created, we don't care.
> +				 */
> +				if (stat(path, &st) && S_ISDIR(st.st_mode))
> +					continue;

You probably meant !stat() here, "we can successfully stat() and it
turns out that we already have a directory there, so let's not do
the error thing".

Don't you need to restore (*pos = '/') before doing anything else,
like "continue", by the way?  We were given "a/b/c", and in order to
make sure "a" exists, we made it to "a\0b/c", did a stat() and found
it was missing, did a mkdir() and now we got EEXIST.  pos points at
that NUL, so I would imagine that in order to continue you need to

 * restore the string to be "a/b/c"; and
 * make pos to point at "b" in the string.

Perhaps something like this instead?

 sha1_file.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 9152974..964c4d4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -122,8 +122,13 @@ int safe_create_leading_directories(char *path)
 			}
 		}
 		else if (mkdir(path, 0777)) {
-			*pos = '/';
-			return -1;
+			if (errno == EEXIST &&
+			    !stat(path, &st) && S_ISDIR(st.st_mode)) {
+				; /* somebody created it since we checked */
+			} else {
+				*pos = '/';
+				return -1;
+			}
 		}
 		else if (adjust_shared_perm(path)) {
 			*pos = '/';
