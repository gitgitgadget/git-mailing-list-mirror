From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 23/26] initdb: move safe_create_dir into common code
Date: Wed, 21 Oct 2015 12:38:48 -0700
Message-ID: <xmqq37x4vwon.fsf@gitster.mtv.corp.google.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
	<1444938410-2345-24-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 21:48:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZozNC-0001rA-Fs
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 21:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756050AbbJUTs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 15:48:27 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57214 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755316AbbJUTs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 15:48:26 -0400
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2015 15:48:25 EDT
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1DBB9232E9;
	Wed, 21 Oct 2015 15:38:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EisOqy7F5tVz6+sw6CNu6Xdpgp4=; b=DtOTeS
	6oZaQoCgPoaFqWd7dgBMRbnMPzN/KnWQtrjNUqtsBKrsOO1912OG5cxfdWFXR+q7
	BBV61wjkNmUcADPzy2FODuAqP7SEMxLJ/qrnbjcCit5KBgtHuy5Rea9DYTWDFISF
	bLz4Un2YFIlr5elKBWwm1fzP2CP9w3JWYGU84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DDbdqRQ0mBNZgoE5PTArPKPDrQZZHMRc
	aha2gDy5PqBea2puCjpTuvqiCD/LOrzm54E6vO7V0rW5CdoquhdsWWNskH+70GTm
	M7cYTHOVMeTYWcpFVLslrZow0QTLQt3k21oWHTdORDIYOFDPyOSgE/K7C+r/ugCY
	x8LfZji66HY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 14FE7232E8;
	Wed, 21 Oct 2015 15:38:50 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8EF6F232E7;
	Wed, 21 Oct 2015 15:38:49 -0400 (EDT)
In-Reply-To: <1444938410-2345-24-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Thu, 15 Oct 2015 15:46:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5A257C7E-782B-11E5-BC6A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280004>

David Turner <dturner@twopensource.com> writes:

> In a moment, we'll create initdb functions for ref backends, and code
> from initdb that calls this function needs to move into the files
> backend.  So this function needs to be public.

OK, but unlike the static function, being in public interface part
can invite mistakes of using this for things outside $GIT_DIR [*1*].
Let's have "Never use this for working tree directories" somewhere
in its docstring.

Other than that, this one, 24/26 and 25/26 looked fine to me.

Thanks.

[Footnote]

*1* Anything created by this function and everything underneath are
repository metadata and this function must not be used to do with
anything with the working tree, as it is clear with the use of
adjust_shared_perm().

> diff --git a/cache.h b/cache.h
> index 9a905a8..1d8a051 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1737,4 +1737,9 @@ void stat_validity_update(struct stat_validity *sv, int fd);
>  int versioncmp(const char *s1, const char *s2);
>  void sleep_millisec(int millisec);
>  
> +/*
> + * Create a directory and (if share is nonzero) adjust its permissions
> + * according to the shared_repository setting.
> + */
> +void safe_create_dir(const char *dir, int share);
>  #endif /* CACHE_H */
> diff --git a/path.c b/path.c
> index 212695a..9e0283c 100644
> --- a/path.c
> +++ b/path.c
> @@ -723,6 +723,18 @@ int adjust_shared_perm(const char *path)
>  	return 0;
>  }
>  
> +void safe_create_dir(const char *dir, int share)
> +{
> +	if (mkdir(dir, 0777) < 0) {
> +		if (errno != EEXIST) {
> +			perror(dir);
> +			exit(1);
> +		}
> +	}
> +	else if (share && adjust_shared_perm(dir))
> +		die(_("Could not make %s writable by group"), dir);
> +}
> +
>  static int have_same_root(const char *path1, const char *path2)
>  {
>  	int is_abs1, is_abs2;
