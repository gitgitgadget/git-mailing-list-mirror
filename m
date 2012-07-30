From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] link_alt_odb_entry: fix read over array bounds reported
 by valgrind
Date: Sun, 29 Jul 2012 17:54:02 -0700
Message-ID: <7v4noqul05.fsf@alter.siamese.dyndns.org>
References: <20120728154635.GB98893@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Torsten =?utf-8?Q?B=C3=83=C2=B6gershausen?= <tboegi@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jul 30 02:54:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SveFR-00029Y-9d
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 02:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830Ab2G3AyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 20:54:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48397 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747Ab2G3AyG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 20:54:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08C4A9D21;
	Sun, 29 Jul 2012 20:54:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XwApUdkXRwLS+RhC2k8faC8gHlM=; b=KRhhSb
	ASB249dU/bBdFnqzKSStt8vG2jkFP274SPG5ZW8NYFRcXh73NYcTxwRvjg+siR4W
	/i2MJ5u6Xp1oM3sNOj0TKZkaTgqqVapgMyQBVUrRNFV63qPTMitjW1JeX5U8kA8d
	Qi8h7/bPaFuQl1L1dVyX4UrAKqVY04cD/VwoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WIFJtXUnuqU+qz6v4dEo4dgrM5hz+y5Y
	Q2SqN953x5hxUmIG3ThwrH5jCdoXzC6hpY/aUw2QWRR1CC60WfuCMBgJBV4Igbhc
	I03xMCT0Nhi6bU0RMLo4otVTVFiIiuaSmlz2pNPHvAeU7ocrz6mOV7luf8lTQnmc
	pQhyLQvHJhA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA46A9D20;
	Sun, 29 Jul 2012 20:54:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F29D9D1F; Sun, 29 Jul 2012
 20:54:04 -0400 (EDT)
In-Reply-To: <20120728154635.GB98893@book.hvoigt.net> (Heiko Voigt's message
 of "Sat, 28 Jul 2012 17:46:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F2D5A70-D9E1-11E1-8027-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202510>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> pfxlen can be longer than the path in objdir when relative_base contains
> the path to gits object directory.

s/gits/????/ perhaps "Git's", but I am not sure.

> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>  sha1_file.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 4ccaf7a..631d0dd 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -251,7 +251,7 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
>  	const char *objdir = get_object_directory();
>  	struct alternate_object_database *ent;
>  	struct alternate_object_database *alt;
> -	int pfxlen, entlen;
> +	int pfxlen, entlen, objdirlen;
>  	struct strbuf pathbuf = STRBUF_INIT;
>  
>  	if (!is_absolute_path(entry) && relative_base) {
> @@ -298,7 +298,8 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
>  			return -1;
>  		}
>  	}
> -	if (!memcmp(ent->base, objdir, pfxlen)) {
> +	objdirlen = strlen(objdir);
> +	if (!memcmp(ent->base, objdir, pfxlen > objdirlen ? objdirlen : pfxlen)) {

The new code tells us to compare up to the shorter length between
objdir (i.e. path/to/.git/objects) and the given alternate object
directory (i.e. alt/path/to/.git/objects), but is that really what
we want?  What happens if the given alternate object directory were
"path/to/.git/objects-not-quite", with objdir "path/to/.git/objects"?

They are not the same directory, and this check is about avoiding
"the common mistake of listing ... object directory itself", no?

>  		free(ent);
>  		return -1;
>  	}
