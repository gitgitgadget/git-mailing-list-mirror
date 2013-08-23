From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t3103: demonstrate dir.c:treat_one_path() core.ignorecase failure
Date: Fri, 23 Aug 2013 10:21:38 -0700
Message-ID: <xmqqfvu0pbkt.fsf@gitster.dls.corp.google.com>
References: <1377232155-7300-1-git-send-email-sunshine@sunshineco.com>
	<1377232155-7300-2-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Joshua Jensen <jjensen@workspacewhiz.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 19:21:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCv3T-0004nX-MY
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 19:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755765Ab3HWRVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 13:21:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40779 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755588Ab3HWRVm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 13:21:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1421F3BA25;
	Fri, 23 Aug 2013 17:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pFPaIbuCNrOU7bFYtn3//DnP7Ec=; b=fQOx3l
	CUd2gQCekelF9xoFbS5s/Q5D7iYETu+/OfjYaqYWpz9ohguNJKFSMwvommGvO/pZ
	ZdqQH+Xy0Ye36ixYWauQdsYKA8bHpX3rz1sfo7xHuaIAToO2Mt4RKQ3H5D0wxWMb
	oDxAe8FcZR5YHrVTRAU1SeaUKBTaJAadmLKSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mpsn1YmkT1YG/LOHcLS/lZJjFsTKkZgo
	2dQjYHNEstU5dG8eoum7clnG/QwofvE50JerlnT6x4ABMi0Cyo1OB8LcKmIB0tRH
	DAVrL26R+MFVJXkEQ4nho71CobDbmCxiYe+3106fAPFut3pn/9kcUhUaarYDsrVd
	xx4qUQmqYDk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 082973BA23;
	Fri, 23 Aug 2013 17:21:42 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6488D3BA22;
	Fri, 23 Aug 2013 17:21:41 +0000 (UTC)
In-Reply-To: <1377232155-7300-2-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Fri, 23 Aug 2013 00:29:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 79D862BA-0C18-11E3-9BB5-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232814>

Eric Sunshine <sunshine@sunshineco.com> writes:

> @@ -21,4 +22,18 @@ test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
>  	test_must_fail git ls-tree -r HEAD
>  '
>  
> +test_expect_failure 'ls-tree directory core.ignorecase' '
> +	cat >expect <<-\EOF &&
> +	d/e/f
> +	EOF
> +	mkdir d &&
> +	>d/e &&
> +	git update-index --add -- d/e &&
> +	rm d/e &&
> +	mkdir d/e &&
> +	>d/e/f &&
> +	git -c core.ignorecase=true ls-files -k >actual &&
> +	test_cmp expect actual
> +'

Hmm. Wouldn't it be a clearer demonstration to add to t3010 another
invocation of "ls-files -k" that was added by 3c568751 (t3010:
update to demonstrate "ls-files -k" optimization pitfalls,
2013-08-15) but with core.ignorecase=true? Something like...

 t/t3010-ls-files-killed-modified.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index 6ea7ca8..f4783ed 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -90,6 +90,17 @@ pathx/ju/nk
 EOF
 
 test_expect_success \
+    'git ls-files -k to show killed files (with icase)' \
+    'git -c core.ignorecase=true ls-files -k >.output'
+cat >.expected <<EOF
+path0/file0
+path1/file1
+path2
+path3
+pathx/ju/nk
+EOF
+
+test_expect_success \
     'validate git ls-files -k output.' \
     'test_cmp .expected .output'
 
