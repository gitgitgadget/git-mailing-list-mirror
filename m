From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] update-server-info: create info/* with mode 0666
Date: Tue, 06 Jan 2015 13:43:33 -0800
Message-ID: <xmqqegr7oa9m.fsf@gitster.dls.corp.google.com>
References: <20150106034702.GA11503@peff.net>
	<20150106035048.GB20087@peff.net>
	<xmqqh9w3px0a.fsf@gitster.dls.corp.google.com>
	<20150106193950.GB28440@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Sokolovsky <paul.sokolovsky@linaro.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 06 22:44:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8buf-0005Vv-7K
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 22:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932856AbbAFVnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 16:43:37 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60075 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932536AbbAFVng (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 16:43:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 26AD92DCBD;
	Tue,  6 Jan 2015 16:43:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6TEFm0aQE9QQgy1CJGB3b9lOPmQ=; b=Vzt/ax
	r4PXvXv6+VU7OAPT+Oq24CyrmM5vGSmnatj3l9cggMuzRrKJEoPd55E2EglByjV0
	+PQvGcRz97n/TFGKjBvpwLeBl1oOg8ru1iwuTMHI1cNML9c8L3ZF/MVlRT8NiEzK
	E0mnPIXOI2FdMEcyh6mJDlbOwvvsZmiFgBHZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ag/BUyH95KENOifOoGv+MdTv+HBG0F8W
	OpaFJsTEt3cnPeWVH1kCPLy9QKQR8MnwYe62usKaSqCWLCFDwNzf90kHCRECvLCy
	U75jYrrXDyqi+tjdEafYwUreBVYGDrKbdB3b/gzPo4iXYzLw2vnSafJ3JBcB9m6d
	iyilQH+Gmv4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B5502DCBC;
	Tue,  6 Jan 2015 16:43:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 952332DCBB;
	Tue,  6 Jan 2015 16:43:34 -0500 (EST)
In-Reply-To: <20150106193950.GB28440@peff.net> (Jeff King's message of "Tue, 6
	Jan 2015 14:39:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1098D4B4-95ED-11E4-A773-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262102>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 06, 2015 at 10:47:01AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > +test_expect_success POSIXPERM 'info/refs is readable in unshared repo' '
>> > +	rm -f .git/info/refs &&
>> > +	test_unconfig core.sharedrepository &&
>> > +	umask 002 &&
>> > +	git update-server-info &&
>> > +	echo "-rw-rw-r--" >expect &&
>> > +	modebits .git/info/refs >actual &&
>> > +	test_cmp expect actual
>> > +'
>> 
>> Hmm, the label and the test look somewhat out-of-sync.  "readable as
>> long as umask allows it" would be more in line with what the fix is
>> about (i.e. I would expect a test with that title to pass even if I
>> changed 'umask 002' to 'umask 007', but that is not what we want in
>> this series).
>
> That is definitely not what the series means to accomplish. I think
> naming the test "info/refs respects umask in unshared repo" is probably
> a better title for the test.

Thanks for sanity-checking me (I am still somewhat feverish and not
performing at 100% level).  Here is what I have locally (but haven't
got around to today's integration cycle yet) on top.

Subject: [PATCH] SQUASH???

---
 t/t1301-shared-repo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index feff55e..d5eacb0 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -111,7 +111,7 @@ do
 
 done
 
-test_expect_success POSIXPERM 'info/refs is readable in unshared repo' '
+test_expect_success POSIXPERM 'info/refs is created honoring the umask' '
 	rm -f .git/info/refs &&
 	test_unconfig core.sharedrepository &&
 	umask 002 &&
-- 
2.2.1-349-g24d7964
