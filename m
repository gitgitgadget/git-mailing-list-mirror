From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] rerere forget path: forget recorded resolution
Date: Wed, 06 Jan 2010 08:58:42 -0800
Message-ID: <7vr5q31871.fsf@alter.siamese.dyndns.org>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com>
 <1262122958-9378-10-git-send-email-gitster@pobox.com>
 <4B43AE38.9070800@kdbg.org> <7v4on0oxcs.fsf@alter.siamese.dyndns.org>
 <4B444FF9.1000004@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jan 06 17:59:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSZDl-0005HY-Bq
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 17:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317Ab0AFQ6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 11:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247Ab0AFQ6v
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 11:58:51 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39227 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243Ab0AFQ6u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 11:58:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BABC8E770;
	Wed,  6 Jan 2010 11:58:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RxM0bzOxKdcCrYH5Rq+lTNYGKOg=; b=GzsGH6
	kAaMFkZog49qrW+sCpmmlsrDSAHnnZPBabKrAgLw0AwoxgvlG0KmrrSZiDhvVVQK
	KfK5SqOTiFUDyc7mjY+qIpujQHdl6nJlJzd1oLPAWIoKSrVRVhj0q9vCw6CpbnvQ
	vvCbBt+JRuLSZV6pQSvTF1EX3OgbhrDc3aUVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EerPslDTV7CuoiE2fVvWEG4Hvz5c56ao
	HL2oWhBIOHP0etRiaKbgh/dh/avN7I6khHjM07hMmOWwmFjEFrSIwheGjL2R3Q3u
	WKy1OyucsPxgJNqBDgCa0Cqx6vQv1vm1CTU6wZD0yLhceiJAkPILO55/DgG6SfMd
	VlRyvU2vJSY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 317608E769;
	Wed,  6 Jan 2010 11:58:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 790928E768; Wed,  6 Jan
 2010 11:58:44 -0500 (EST)
In-Reply-To: <4B444FF9.1000004@kdbg.org> (Johannes Sixt's message of "Wed\,
 06 Jan 2010 09\:55\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C162B098-FAE4-11DE-B25A-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136269>

Johannes Sixt <j6t@kdbg.org> writes:

>> Doesn't "checkout --conflict=merge" use the same ll_merge() machinery?
>
> It does, without setting up .gitattributes, either (IIUC), which is a bug IMO.

I don't think there is any bug there; git_checkattr() that is used by
git_path_check_merge() autoinitializes the attribute machinery.

However, I think you need this fix for "checkout -m" to work as intended,
if your custom merge driver has recursive attribute set to 'binary' or
something:

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 64f3a11..50f5079 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -167,7 +167,7 @@ static int checkout_merged(int pos, struct checkout *state)
 	fill_mm(active_cache[pos+2]->sha1, &theirs);
 
 	status = ll_merge(&result_buf, path, &ancestor,
-			  &ours, "ours", &theirs, "theirs", 1);
+			  &ours, "ours", &theirs, "theirs", 0);
 	free(ancestor.ptr);
 	free(ours.ptr);
 	free(theirs.ptr);

I don't know why I decided to pass "1" to ll_merge() there; it doesn't
make any sense and looks like an untested bug to me.

The ll_merge() call jc/cache-unmerge topic adds for "rerere forget"
doesn't share this problem.
