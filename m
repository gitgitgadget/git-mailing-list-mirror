From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix safe_create_leading_directories() for Windows
Date: Thu, 02 Jan 2014 13:24:27 -0800
Message-ID: <xmqq8uuyoz5g.fsf@gitster.dls.corp.google.com>
References: <52C5A039.6030408@gmail.com>
	<alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info>
	<xmqqtxdmp39a.fsf@gitster.dls.corp.google.com>
	<52C5D0AB.7050309@gmail.com> <52C5D201.5070008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 22:24:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vypkp-0004A5-Tn
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 22:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbaABVYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 16:24:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60766 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbaABVYb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 16:24:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2D755E309;
	Thu,  2 Jan 2014 16:24:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dePLoYT4ZirpfrCVpVFxj/l6mn4=; b=qTWErc
	34cSpBbyQaB5kcJuMdSEf26+gAcyGn46oS1v26u3BArRNFL27h6Bo7EmVyJ5vowH
	6FRzAZReV4yNxcXmg5M9ff+ceCdIEFXTsWO8+pQIZlCINq8uCgp4HbnPwRsxBRip
	yB+P1tjRSelgQD+GiSSDVYObIaEXRa7crSPb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y5JocESpdApdXNZcVTuyELd7THI+qELY
	trM92uQRjxg+13HVkusTxZZ9FxOW42qYwD3deIU6No5WoMTlv9wTfyllcIGL2LjJ
	dvPMBx5pkT6pprkGKDpSYcxU+bklWTYtIzVukPZevC7kpVHHRj56Bqkb2Abcsshr
	IomPbKLg5EM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDC3A5E308;
	Thu,  2 Jan 2014 16:24:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A6E25E307;
	Thu,  2 Jan 2014 16:24:30 -0500 (EST)
In-Reply-To: <52C5D201.5070008@gmail.com> (Sebastian Schuberth's message of
	"Thu, 02 Jan 2014 21:54:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4407F6B6-73F4-11E3-A3DE-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239886>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> When cloning to a directory "C:\foo\bar" from Windows' cmd.exe where "foo"
> does not exist yet, Git would throw an error like
>
> fatal: could not create work tree dir 'c:\foo\bar'.: No such file or directory
>
> Fix this by not hard-coding a platform specific directory separator into
> safe_create_leading_directories().
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  sha1_file.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 760dd60..2114c58 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -110,12 +110,15 @@ int safe_create_leading_directories(char *path)
>  	char *pos = path + offset_1st_component(path);
>  	struct stat st;
>  
> -	while (pos) {
> -		pos = strchr(pos, '/');
> -		if (!pos)
> -			break;
> -		while (*++pos == '/')
> -			;
> +	while (*pos) {
> +		while (!is_dir_sep(*pos)) {
> +			++pos;
> +			if (!*pos)
> +				break;
> +		}
> +		/* skip consecutive directory separators */
> +		while (is_dir_sep(*pos))
> +			++pos;
>  		if (!*pos)
>  			break;
>  		*--pos = '\0';

This has a bit of conflict with another topic in flight; I think I
resolved it correctly, but please double check.  The following is
how it would apply on top of 'pu'.

 sha1_file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 131ca97..9e686eb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -113,11 +113,12 @@ int safe_create_leading_directories(char *path)
 
 	while (!retval && next_component) {
 		struct stat st;
-		char *slash = strchr(next_component, '/');
-
-		if (!slash)
+		char *slash = next_component;
+		while (!is_dir_sep(*slash))
+			++slash;
+		if (!*slash)
 			return 0;
-		while (*(slash + 1) == '/')
+		while (is_dir_sep(*(slash + 1)))
 			slash++;
 		next_component = slash + 1;
 		if (!*next_component)
