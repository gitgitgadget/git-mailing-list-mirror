From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use FIX_UTF8_MAC to enable conversion from UTF8-MAC to UTF8
Date: Mon, 21 Jan 2008 02:15:02 -0800
Message-ID: <7vve5nzdqx.fsf@gitster.siamese.dyndns.org>
References: <fn1nl6$ek5$1@ger.gmane.org> <fn1pj9$kkg$1@ger.gmane.org>
	<fn1ptk$ljj$1@ger.gmane.org> <fn1q6b$ljj$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Junker <mjscod@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 21 11:17:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGtiE-0001v3-NO
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 11:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763346AbYAUKPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 05:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762581AbYAUKPM
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 05:15:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763983AbYAUKPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 05:15:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AC2E3EED;
	Mon, 21 Jan 2008 05:15:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A81A73EEC;
	Mon, 21 Jan 2008 05:15:04 -0500 (EST)
In-Reply-To: <fn1q6b$ljj$2@ger.gmane.org> (Mark Junker's message of "Mon, 21
	Jan 2008 10:55:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71252>

Mark Junker <mjscod@web.de> writes:

> diff --git a/compat/readdir.c b/compat/readdir.c
> new file mode 100644
> index 0000000..045cfef
> --- /dev/null
> +++ b/compat/readdir.c
> @@ -0,0 +1,26 @@
> +#include "../git-compat-util.h"
> +#include "../utf8.h"
> +
> +#undef readdir
> +
> +static struct dirent temp;
> +
> +struct dirent *gitreaddir(DIR *dirp)
> +{
> +	size_t utf8_len;
> +	char *utf8;
> +	struct dirent *result;
> +	result = readdir(dirp);
> +	if (result != NULL) {
> +		memcpy(&temp, result, sizeof(struct dirent));
> +		utf8 = reencode_string(temp.d_name, "UTF8", "UTF8-MAC");
> +		if (utf8 != NULL) {
> +			utf8_len = strlen(utf8);
> +			temp.d_namlen = (u_int8_t) utf8_len;
> +			memcpy(temp.d_name, utf8, utf8_len + 1);
> +			free(utf8);

I do not know how Macintosh libc implements "struc dirent", but
this approach does not work in general.  For example, on Linux
boxes with glibc, "struct dirent" is defined like this (pardon
the funny indentation --- that is from the original):

        struct dirent
          {
        #ifndef __USE_FILE_OFFSET64
            __ino_t d_ino;
            __off_t d_off;
        #else
            __ino64_t d_ino;
            __off64_t d_off;
        #endif
            unsigned short int d_reclen;
            unsigned char d_type;
            char d_name[256];		/* We must not include limits.h! */
          };

yet you can obtain a path component longer than 256 bytes.
Apparently the library allocates longer d_name[] field than what
is shown to the user.
