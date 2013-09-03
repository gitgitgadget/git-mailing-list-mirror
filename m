From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/2] Add new @ shortcut for HEAD
Date: Tue, 03 Sep 2013 11:50:49 -0700
Message-ID: <xmqqd2opsprq.fsf@gitster.dls.corp.google.com>
References: <1378103670-3394-1-git-send-email-felipe.contreras@gmail.com>
	<1378103670-3394-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 20:51:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGvh5-0005T5-5M
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 20:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760415Ab3ICSvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 14:51:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47421 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760379Ab3ICSvA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 14:51:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F0D43E0BC;
	Tue,  3 Sep 2013 18:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I633JE6LUFYh5AQsByt3ptzGA9c=; b=BHbAP+
	kBsS89WtfVSQ/QCGrSTqGFUw65nXhPgA71OSjZ1/1DSmVhsmcQ1muR7mtZIiSE7/
	LbYL+o6rsP4npa7AZWoM6DVQx90AdqT0R/q0UPycS4r0WCC6xSRYzKFfqU4VYGRw
	ZrDRiQ0ffz97UBAuYZCsa7E84Noq8ygn7yR6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XoC2LOT8cgdq0UMuk2BaxCEPp6z5WApd
	xIzzI8cg6HFjhOouHD8o0h1hvOOBglLhJu57y10YZ0+njQSzmM9wK9LwYTy6DCa+
	3vaH2OGwfR6LVpjADLBPGRQAHUVH+mD2FNM2cYoUhDeZ2xqCp43nUy9k/LXpTn68
	+KL4NrApvz0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 279633E0B2;
	Tue,  3 Sep 2013 18:50:56 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D85C73E097;
	Tue,  3 Sep 2013 18:50:53 +0000 (UTC)
In-Reply-To: <1378103670-3394-3-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 2 Sep 2013 01:34:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C310BEC8-14C9-11E3-9A8B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233758>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> diff --git a/sha1_name.c b/sha1_name.c
> index 93197b9..b8ece6e 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1004,6 +1004,26 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
>  	return st;
>  }
>  
> +/* parse @something syntax, when 'something' is not {.*} */
> +static int interpret_empty_at(const char *name, int namelen, int len, struct strbuf *buf)
> +{
> +	const char *next;
> +
> +	if (len || name[1] == '{')
> +		return -1;
> +
> +	/* make sure it's a single @, or @@{.*}, not @foo */
> +	next = strchr(name + len + 1, '@');
> +	if (!next)
> +		next = name + namelen;
> +	if (next != name + 1)
> +		return -1;
> +
> +	strbuf_reset(buf);
> +	strbuf_add(buf, "HEAD", 4);
> +	return 1;
> +}

Hmph, is the above sufficient?  I added a case that mimics Stefano's
original regression report (which is handled) and another that uses
doubled "@" for the same purpose of introducing a "funny" hierarchy,
and it appears that "checkout -b" chokes on it.

 t/t1508-at-combinations.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 3a52375..ceb8449 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -32,6 +32,8 @@ test_expect_success 'setup' '
 	git checkout -b upstream-branch &&
 	test_commit upstream-one &&
 	test_commit upstream-two &&
+	git checkout -b @/at-test &&
+	git checkout -b @@/at-test &&
 	git checkout -b @at-test &&
 	git checkout -b old-branch &&
 	test_commit old-one &&
@@ -58,6 +60,8 @@ check "@{-1}@{u}" ref refs/heads/master
 check "@{-1}@{u}@{1}" commit master-one
 check "@" commit new-two
 check "@@{u}" ref refs/heads/upstream-branch
+check "@@/at-test" ref refs/heads/@@/at-test
+check "@/at-test" ref refs/heads/@/at-test
 check "@at-test" ref refs/heads/@at-test
 nonsense "@{u}@{-1}"
 nonsense "@{0}@{0}"
