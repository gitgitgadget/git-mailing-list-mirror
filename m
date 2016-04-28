From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strangeness with git-add and nested repositories
Date: Thu, 28 Apr 2016 09:48:18 -0700
Message-ID: <xmqqtwil65nx.fsf@gitster.mtv.corp.google.com>
References: <CAH6n4TdG9LQOPaaw_H6vuCgia0-4JXhPsSiAJPa5GtjfduQoSw@mail.gmail.com>
	<CAGZ79kZhATfP1FpXnhivCa_Az-3KADSCReOo68E2Q3s29x5HNw@mail.gmail.com>
	<xmqq1t5p7kmp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andrew J <andj2223@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:48:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avp7K-0006Ef-Aq
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 18:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbcD1Qsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 12:48:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753384AbcD1QsW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 12:48:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DCF6C15B79;
	Thu, 28 Apr 2016 12:48:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XtUc4HoToZ9AAZfw0j+9I/mZ5Gw=; b=Vmr7TQ
	ZLLEhwStlMGDLAn2xsGUyU6cjXInBb+QSHMbWt7Jk2fK3qebrQnStctkpvd1Lsmj
	fCAGunq1w3napDRtub6erq6SQf3jIJPfRvIRyvRciFGnDblsJQypHTf7bfsak86r
	FFO0uPsydT7Ivo6k3hF3ssw5Sze5DRHAyof+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZGS48YCMPBz9n+Imb7G3FOv7F/zX/UgQ
	+CN1XJDSOQVtiH6uVf1tqXuPh0Nh1EBiPqJXxbI/EBq9DS8ErSmsFspl9vnXaB5l
	U+PbCQBG7PH0CjfW8wBCiyYUz4PJ+p7i90ZDYGmct+D002z4dK0RxR730GnryLax
	uNNc6BRgNmc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D4C3C15B78;
	Thu, 28 Apr 2016 12:48:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 373F815B77;
	Thu, 28 Apr 2016 12:48:20 -0400 (EDT)
In-Reply-To: <xmqq1t5p7kmp.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 28 Apr 2016 09:39:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 03757EC6-0D61-11E6-A3E9-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292918>

Junio C Hamano <gitster@pobox.com> writes:

>  * "git add -- path/to/subdir/file", when any of path/, path/to/,
>    path/to/subdir/ is a Git repository that is different from the
>    current Git repository, must fail.

If any of the leading directories in that long path is actually a
git repository that is different from the current one, it shouldn't
have added it.  IOW, adding the path is a bug.

"git add A/B/C" usually enforces this rule by

 - check A; if A is a separate repository (A/.git exists, etc.),
   do not add this path;

   - check A/B; if A/B is a separate repository, ignore;

     - check A/B/C; if A/B/C is a separate repository, ignore.
       otherwise add it.

When given multiple paths, e.g. "git add A/B/C A/D", it tries to
"optimize" things by first finding common leading directory (in this
case "A/") and doing something slightly different, and I think the
bug Andrew saw lies in that codepath.  It is likely that the code is
forgetting to make sure that there is no top of enclosed working
tree in the common leading directory part of the path.
