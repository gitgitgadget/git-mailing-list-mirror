From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] do not overwrite files in leading path
Date: Wed, 13 Oct 2010 14:57:59 -0700
Message-ID: <7v1v7tkb6g.fsf@alter.siamese.dyndns.org>
References: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
 <1286632380-7002-6-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Oct 13 23:58:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P69LG-0000NN-Vt
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 23:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023Ab0JMV6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 17:58:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53760 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab0JMV6H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 17:58:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AA68DEAC7;
	Wed, 13 Oct 2010 17:58:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/C74t8JhP3LgK5jNY88BGLg9jBY=; b=SvTsoo
	0Up2ZLFR4q375tW0QQQS/Zwcagarq5zyiW1fJ6UPmOiB4Xs7BXLMwBCTcEaxPUjt
	gRKsth9eKbEW1KpUNyAFP+hBFplO32+1N5v7Eril28RMML1bkbFp5PMD9DOGC1Wo
	vXtwZJ9ztc5ifUWybr57dQLKiEHWEbNH2rsWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oYtN6gNWDkCew/8xGeYtLC2BQn+5TR6h
	T2BfoedPkSZHfez771q3Q0hrNaGsyp53sklzMx64z/MRq3HtKigDpoEY2nF5eNpU
	+WG1XPZgN1Tciph9Mkj5NCFQgWkc6z0BM8RRkjTmywJqhAH7L1cgg+LC7EoILGN5
	6rpS6cM/hWw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 523BBDEAC6;
	Wed, 13 Oct 2010 17:58:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80404DEAC5; Wed, 13 Oct
 2010 17:58:01 -0400 (EDT)
In-Reply-To: <1286632380-7002-6-git-send-email-drizzd@aon.at> (Clemens
 Buchacher's message of "Sat\,  9 Oct 2010 15\:53\:00 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F4577116-D714-11DF-9639-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158985>

Clemens Buchacher <drizzd@aon.at> writes:

> If the work tree contains an untracked file x, and
> unpack-trees wants to checkout a path x/*, the
> file x is removed unconditionally.
>
> Instead, apply the same checks that are normally
> used for untracked files, and abort if the file
> cannot be removed.
>

Too short a line is also hard to read as too long a line.

> diff --git a/cache.h b/cache.h
> index 2ef2fa3..f65d6f9 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -852,7 +852,7 @@ struct cache_def {
>  
>  extern int has_symlink_leading_path(const char *name, int len);
>  extern int threaded_has_symlink_leading_path(struct cache_def *, const char *, int);
> -extern int has_symlink_or_noent_leading_path(const char *name, int len);
> +extern int check_leading_path(const char *name, int len);

This is an API regression.  "check" in function name "check-blah" does not
tell what you are checking (is it checking if the path is Ok?  is it
checking if the path has symlinked components?  is it checking if some
part of the path overlaps with tracked content?  is it checking if you
have already run lstat(2) on some of the leading path components?), nor
for what purpose the check can be used (it is Ok to overwrite it?, is it
Ok to create a directory there?  is it Ok to create a file there?).

At least the old name told us what it checked, didn't it?

The approach you took looks sound, though.  What did you feel was "not
exactly pretty" about it?

Thanks.
