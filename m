From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] silence git gc --auto --quiet output
Date: Mon, 24 Sep 2012 15:53:55 -0700
Message-ID: <7vy5jzvxq4.fsf@alter.siamese.dyndns.org>
References: <20120924024024.GA12700@tin.tmux.org>
 <7v3927xcu1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tobias Ulmer <tobiasu@tmux.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 00:54:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGHXU-0003m1-Ox
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 00:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839Ab2IXWx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 18:53:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65066 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706Ab2IXWx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 18:53:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8D9389F4;
	Mon, 24 Sep 2012 18:53:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W6vKcXHfkaOiewBYI/1yML5DNi8=; b=E+z3+i
	2mUGmBUjjKcEpLuVCWKQvYt7ySwF1Pq1h/qnQMVorTxW+lPS34JEh94U7JqDfNre
	u/c9Ze/mkg2BPbY93e7mXPTWN19TJqYT/+2+SczSU+iNxKkbivV9A7tCdTHeHoM4
	aLrigs5irTkYxtqewM2ZNRh7ifwA3JkYT8kQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mGYP5idrK1ckPACxVN1nWWhPOHEGQbmo
	uwfnvs5SaJjhL3Y75/uNZqRJyWHeUnyR2JVMcmI9Ivaw/2AZ2OEuj8TSThDDUtKa
	GGHXfd3Y0eGQAC918Z0hKFh6WHSl1rGhTEDRuc6JhLLFE521xXoZSYZ6m1g+Csqg
	AqyQw4tlZ80=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B645989F3;
	Mon, 24 Sep 2012 18:53:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D0EA89F2; Mon, 24 Sep 2012
 18:53:57 -0400 (EDT)
In-Reply-To: <7v3927xcu1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 24 Sep 2012 15:42:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8E4BDF2-069A-11E2-8AC9-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206333>

Junio C Hamano <gitster@pobox.com> writes:

> Tobias Ulmer <tobiasu@tmux.org> writes:
>
>> When --quiet is requested, gc --auto should not display messages unless
>> there is an error.
>>
>> Signed-off-by: Tobias Ulmer <tobiasu@tmux.org>
>> ---
>>  builtin/gc.c |    4 +---
>>  1 files changed, 1 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index 6d46608..6be6c8d 100644
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -217,9 +217,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>>  		 */
>>  		if (!need_to_gc())
>>  			return 0;
>> -		if (quiet)
>> -			fprintf(stderr, _("Auto packing the repository for optimum performance.\n"));
>> -		else
>> +		if (!quiet)
>>  			fprintf(stderr,
>>  					_("Auto packing the repository for optimum performance. You may also\n"
>>  					"run \"git gc\" manually. See "
>
> This patch will break t5400; the test needs to be updated in the
> same patch to check auto-gc kicks in when it should in some other
> way.  The test currently _relies_ on this message to see the gc is
> triggered.

I suspect that the following may be sufficient.  The test prepares a
stale garbage file in the repository an auto-gc is expected to
happen, and makes sure the garbage file is removed after the
operation that expects to trigger an auto-gc.  The detection of the
message is more or less superfluous.

 t/t5400-send-pack.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git i/t/t5400-send-pack.sh w/t/t5400-send-pack.sh
index 250c720..78ab177 100755
--- i/t/t5400-send-pack.sh
+++ w/t/t5400-send-pack.sh
@@ -174,8 +174,7 @@ test_expect_success 'receive-pack runs auto-gc in remote repo' '
 	    cd parent &&
 	    echo "Even more text" >>file.txt &&
 	    git commit -a -m "Third commit" &&
-	    git send-pack ../child HEAD:refs/heads/test_auto_gc >output 2>&1 &&
-	    grep "Auto packing the repository for optimum performance." output
+	    git send-pack ../child HEAD:refs/heads/test_auto_gc
 	) &&
 	test ! -e child/.git/objects/tmp_test_object
 '
