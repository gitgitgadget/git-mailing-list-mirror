From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] absolute_path(): reject the empty string
Date: Thu, 06 Sep 2012 16:09:09 -0700
Message-ID: <7vy5kmzr3e.fsf@alter.siamese.dyndns.org>
References: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
 <1346971264-23744-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Orgad and Raizel Shaneh <orgads@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 07 01:09:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9lCK-0004tG-9l
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 01:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594Ab2IFXJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 19:09:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33844 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557Ab2IFXJM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 19:09:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC9179898;
	Thu,  6 Sep 2012 19:09:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Wt3cN9YoYdKFeJBcc0TXsWKqCfE=; b=XdZ7g+DJzrgMQObcBwy7
	gsVHY+IYqbIOteAkWWE0J/zpEll8M7eJu9gNMJ678UkOLPos0JPTvvRtmFfQjpxo
	HL44iX1+LqAEwZZzUVtcPTTGujEadD0MWTcmNhb0qKJYbYB7n8zGh3aMlBS/HdnN
	QO7Ex0KFuLKoA4oGfSRMlKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=L2bvI44pRZkyP72s3Oj2s/nYQPOTCxjup+yEpV6oKsSJvf
	4V8ryK3IMUMqfdADL6fWRAMs6YaQAxj8V1rgiYacLSV5Ag8dXCGOiPjaSj84mGzv
	YwU15vnzsO640QNjudwceaHih1XLqk+HiCtTBuWvrxLvGHAVsVL5IHqzc+uGA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA1C99897;
	Thu,  6 Sep 2012 19:09:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41BB59896; Thu,  6 Sep 2012
 19:09:11 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE559236-F877-11E1-88EA-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204940>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

I think I asked why this matters (iow, why it is the right thing to
do to reject an empty string, instead of treating it as "the current
directory") in the previous round.  I would have expected to find
the answer be above the S-o-b line here.

The same comment applies to the other patch for real_path().

>  abspath.c             | 4 +++-
>  t/t0060-path-utils.sh | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/abspath.c b/abspath.c
> index f04ac18..5d62430 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -123,7 +123,9 @@ const char *absolute_path(const char *path)
>  {
>  	static char buf[PATH_MAX + 1];
>  
> -	if (is_absolute_path(path)) {
> +	if (!*path) {
> +		die("The empty string is not a valid path");
> +	} else if (is_absolute_path(path)) {

>  		if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
>  			die("Too long path: %.*s", 60, path);
>  	} else {
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index d91e516..924aa60 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -140,7 +140,7 @@ test_expect_success 'strip_path_suffix' '
>  		c:/msysgit/libexec//git-core libexec/git-core)
>  '
>  
> -test_expect_failure 'absolute path rejects the empty string' '
> +test_expect_success 'absolute path rejects the empty string' '
>  	test_must_fail test-path-utils absolute_path ""
>  '
