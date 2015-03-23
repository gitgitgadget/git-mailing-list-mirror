From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] read-cache: fix memleak
Date: Mon, 23 Mar 2015 11:11:42 -0700
Message-ID: <xmqqlhina8ip.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kY=b3=ppmB+eJOAgcUec7hq+ycJiCvBzkTc7U78Mgog_g@mail.gmail.com>
	<1427133432-26703-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 19:11:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya6pJ-0008AZ-5S
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 19:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbbCWSLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 14:11:45 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752285AbbCWSLo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 14:11:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A15C042B34;
	Mon, 23 Mar 2015 14:11:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gdrF5T5mkZsVbxBaYCoqZLBeXws=; b=w3kGKt
	P+e16oyMhBSb1E/jx/9vXnU+0+qqlmsYR+GHqWUoKLrXy1Af0eFJ4jdLAwz0wecC
	SS34E5qgGknKDrzMXyldmppxt7vNTwOQsE4DTKYaKTwK4JDvOd1Gbc8jn+CQb65y
	NY5dYS1PhRHc0rQPi+bhGwZIAbZNPyW/IVAkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BeELJhAQ1aUCXlvidAwHxzZzEqnEwCyA
	v7XxBCJhLauP5fwwWWSMKGpcFeCGoQHd7cHrv6eP43NvglMY0UfNXoK7fuBa/YZc
	SXjr/X10jpIhsn9HNDpfZdUhlYaOEOd7u+13w+DVcwT3AXwSgBQRt4HLaQiFHa/U
	d69MQTvIRfo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AE7C42B31;
	Mon, 23 Mar 2015 14:11:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 24A2E42B30;
	Mon, 23 Mar 2015 14:11:43 -0400 (EDT)
In-Reply-To: <1427133432-26703-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 23 Mar 2015 10:57:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0F5F5E2A-D188-11E4-816C-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266155>

Stefan Beller <sbeller@google.com> writes:

> `ce` is allocated in make_cache_entry and should be freed if it is not
> used any more. refresh_cache_entry as a wrapper around refresh_cache_ent
> will either return `ce` or a new updated cache entry which is allocated
> to new memory. In that case we need to free `ce` ourselfs.

Thanks.  I started "commit --amend" to do s/ourselfs/ourselves/, but
ended up tweaking the description a bit more.

-- .8 --
From: Stefan Beller <sbeller@google.com>
Date: Mon, 23 Mar 2015 10:57:11 -0700
Subject: [PATCH] read-cache: fix memleak

`ce` is allocated in make_cache_entry and should be freed if it is not
used any more. refresh_cache_entry as a wrapper around refresh_cache_ent
will either return

 - the `ce` given as the parameter, when it was up-to-date;
 - a new updated cache entry which is allocated to new memory; or
 - a NULL when refreshing failed.

In the latter two cases, the original cache-entry `ce` is not used
and needs to be freed.  The rule can be expressed as "if the return
value from refresh is different from the original ce, ce is no
longer used."

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 5b922fd5..0052b72 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -748,12 +748,9 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 	ce->ce_mode = create_ce_mode(mode);
 
 	ret = refresh_cache_entry(ce, refresh_options);
-	if (!ret) {
+	if (ret != ce)
 		free(ce);
-		return NULL;
-	} else {
-		return ret;
-	}
+	return ret;
 }
 
 int ce_same_name(const struct cache_entry *a, const struct cache_entry *b)
-- 
2.3.3-454-g85aa98f
