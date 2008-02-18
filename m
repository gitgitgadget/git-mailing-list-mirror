From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Add platform-independent .git "symlink"
Date: Sun, 17 Feb 2008 21:43:34 -0800
Message-ID: <7v7ih2u8e1.fsf@gitster.siamese.dyndns.org>
References: <1203286456-26033-1-git-send-email-hjemli@gmail.com>
 <1203286456-26033-2-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 06:44:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQyoE-0004M8-Ej
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 06:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbYBRFoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 00:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbYBRFoK
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 00:44:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35101 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbYBRFoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 00:44:09 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A22BF36C6;
	Mon, 18 Feb 2008 00:44:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 1088336C4; Mon, 18 Feb 2008 00:44:03 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74231>

Lars Hjemli <hjemli@gmail.com> writes:

> This patch allows .git to be a regular textfile containing the path of
> the real git directory (formatted like "gitdir: <path>\n"), which is
> useful on platforms lacking support for real symlinks.

Hmmmm.  I have suspected all along that these "platforms lacking
support for real symlinks" are the ones whose native line
termination convention is CRLF.  How do you envision this file
is initialized?  By users editing the file by hand?  Or some git
specific tool?  If the former, it might make sense to define the
format as "a single line, terminated with platform line
terminator" and open and read it in text mode.  If the latter,
we do not have to care, and "terminated with LF" is good enough.

I think a sane simplification is to allow the file to have
any number of optional \r or \n at the end.  We may care about
allowing arbitrary and possibly crazy filenames in the tracked
contents, but we can say "Sorry, you cannot create a directory
'ab\nc\r' and use it as the .git directory substitute."

> +const char *read_gitfile_gently(const char *path)
> +{
> +	static char buf[PATH_MAX + 9];  /* "gitdir: " + "\n" */
> +	struct stat st;
> +	int fd;
> +	size_t len;
> +
> +	if (stat(path, &st))
> +		return NULL;
> +	if (!S_ISREG(st.st_mode) || st.st_size >= sizeof(buf))
> +		return NULL;
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0)
> +		return NULL;

Up to this point it is fine "gently" semantics.

> +	len = read_in_full(fd, buf, sizeof(buf));
> +	close(fd);
> +	if (len != st.st_size)
> +		return NULL;
> +	if (!len || buf[len - 1] != '\n')
> +		return NULL;
> +	buf[len - 1] = '\0';
> +	if (prefixcmp(buf, "gitdir: "))
> +		return NULL;

But I am not sure about this part.  We found what claims to be
the ".git" fake symlink but it is ill-formed.  Don't we want to
diagnose the possible breakage for the user?

> +/*
> +	if (!is_git_directory(buf + 8))
> +		return NULL;
> +*/

Likewise.
