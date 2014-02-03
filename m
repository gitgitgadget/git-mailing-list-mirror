From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] combine-diff: Fast changed-to-all-parents paths scanning
Date: Mon, 03 Feb 2014 15:39:02 -0800
Message-ID: <xmqqeh3jbwbt.fsf@gitster.dls.corp.google.com>
References: <cover.1391430523.git.kirr@mns.spb.ru>
	<c0ad49d850377aedffa0a593fef8738112019b01.1391430523.git.kirr@mns.spb.ru>
	<xmqqk3dbbwwf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Tue Feb 04 00:39:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAT6i-0000AA-0O
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 00:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbaBCXjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 18:39:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41870 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753958AbaBCXjF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 18:39:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2BBA69287;
	Mon,  3 Feb 2014 18:39:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6vcYnZ3+ceuPpybAYxQjq6Z6Qsc=; b=WdLhcv
	f2uVt87H4Go+Qjr3OzA2bA74lyh9rYvLJIutXyd7k2SdYWYIFhJaLKETmnZgGY/5
	5RcHipzr41LfL3UOYKIfiy7HPTQGRUTDiTsjGB66/AOStiy0FOQwcomcT14Dv2+T
	L6ssu7ITKERxD/cNvMZ2/T5xm1W8bd8LBbNlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qRgqBWyD+seVk5plyFZpH/34MyJnVktl
	a7zigJ8HcFX+L+hb6aYuvP6rRKhdj5jpguaX6Py7jsABgrrxF3KWubhS/uRVdt/c
	IH926bctwSXc0KlBPUlV8g4YEACY9gGXOeT6ZxIpM5mwUy95gQRjCZ5SFrPiskjZ
	t9EGkk/b3FY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0F2869286;
	Mon,  3 Feb 2014 18:39:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13AFE69285;
	Mon,  3 Feb 2014 18:39:03 -0500 (EST)
In-Reply-To: <xmqqk3dbbwwf.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 03 Feb 2014 15:26:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5DABFF94-8D2C-11E3-9DFF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241496>

Junio C Hamano <gitster@pobox.com> writes:

> Kirill Smelkov <kirr@mns.spb.ru> writes:
>
>> As was recently shown (c839f1bd "combine-diff: optimize
>> combine_diff_path sets intersection"), combine-diff runs very slowly. In
>> that commit we optimized paths sets intersection, but that accounted
>> only for ~ 25% of the slowness, and as my tracing showed, for linux.git
>> v3.10..v3.11, for merges a lot of time is spent computing
>> diff(commit,commit^2) just to only then intersect that huge diff to
>> almost small set of files from diff(commit,commit^1).
>>
>> That's because at present, to compute combine-diff, for first finding
>> paths, that "every parent touches", we use the following combine-diff
>> property/definition:
>>
>>     D(A,P1...Pn) = D(A,P1) ^ ... ^ D(A,Pn)      (w.r.t. paths)
>>
>> where
>>
>>     D(A,P1...Pn) is combined diff between commit A, and parents Pi
>>
>> and
>>
>>     D(A,Pi) is usual two-tree diff Pi..A
>
> and A ^ B means what???

Silly me; obviously it is the "set intersection" operator.

We probably could instead use the "current" set of paths as literal
pathspec to compute subsequent paths, i.e.

	D(A,Pi,PS) is two tree diff P1..A limited to paths PS

	D(A,P1...Pn) = D(A,P1,[]) ^
        	       D(A,P2,D(A,P1,[])) ^
                       ...
        	       D(A,Pn,D(A,P1...Pn-1))

if we did not want to reinvent the whole tree walking thing, which
would add risks for new bugs and burden to maintain this and the
usual two-tree diff tree walking in sync.
