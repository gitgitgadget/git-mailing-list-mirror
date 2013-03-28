From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Thu, 28 Mar 2013 11:50:08 -0700
Message-ID: <7vr4iztl3z.fsf@alter.siamese.dyndns.org>
References: <20130327122216.5de0c336@hoelz.ro>
 <20130327182345.GD28148@google.com> <20130327211554.GH28148@google.com>
 <7vsj3gjy3t.fsf@alter.siamese.dyndns.org> <20130327174845.5e3081d1@hoelz.ro>
 <20130327230943.GA5204@jtriplet-mobl1>
 <7vfvzfwn55.fsf@alter.siamese.dyndns.org> <20130328160937.GD16034@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rob Hoelz <rob@hoelz.ro>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 19:50:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULHuQ-0005f8-5J
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 19:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716Ab3C1SuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 14:50:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61054 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718Ab3C1SuN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 14:50:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7396E69F;
	Thu, 28 Mar 2013 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u/fiuXj8LN/fTBvveUUcaYvptAI=; b=RuNkRH
	r74WgXwtZoiDEmotWvqvyfikgOpR+X6+gRpCpRwXDF325kp09FOyKrVMKygP9kBX
	Gc2CxxUccSGPo6n6zy/3POnX24rP/oWuBbeafcWXeIuJv6TJxtYITkd3B6eUFUYn
	HuP4MpnNgtv/k7YXCqtzs1Exesd/zfErIhAWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dlsisWlr77t/wP+bXqtP6WPffaPNkGv5
	vR56LQNCPsjpITw8kEdvGY1KmmRqDCaXa3V+MW3FlhWM5oD/ZfEPg6L8GcxodNie
	B29uhuSsBSclDlQbxhEUtyUVxC3JL4MBexBoAUWpTeDv6s1c0tsvMEs/AGUUKEgQ
	v8QOjwkU74c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EE81E69E;
	Thu, 28 Mar 2013 18:50:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D4EEE69B; Thu, 28 Mar 2013
 18:50:09 +0000 (UTC)
In-Reply-To: <20130328160937.GD16034@leaf> (Josh Triplett's message of "Thu,
 28 Mar 2013 09:09:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50E815DA-97D8-11E2-9AAD-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219442>

Josh Triplett <josh@joshtriplett.org> writes:

(on url.$base.pushInsteadOf)
>> If a remote has an explicit pushurl, git will ignore this setting for
>> that remote.
> That really meant what I just said above: git will prefer an explicit
> pushurl over the pushInsteadOf rewrite of url.

Very correct.

> It says nothing about
> applying pushInsteadOf to rewrite pushurl.

Incorrect, I think.  If you have pushURL, pushInsteadOf is *ignored*.
Of course, if you have both URL and pushURL, the ignored pushInsteadOf
will not apply to _anything_.  It will not apply to URL, and it will
certainly not apply to pushURL.

You are correct to point out that with the test we would want to
make sure that for a remote with pushURL and URL, a push goes

 - to pushURL;
 - not to URL;
 - not to insteadOf(URL);
 - not to pushInsteadOf(URL);
 - not to insteadOf(pushURL); and
 - not to pushInsteadOf(pushURL).

I do not think it is worth checking all of them, but I agree we
should make sure it does not go to pushInsteadOf(URL) which you
originally meant to check, and we should also make sure it does not
go to pushInsteadOf(pushURL).

>>  test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf should not rewrite)' '
>>  	mk_empty &&
>> -	TRASH="$(pwd)/" &&
>> -	git config "url.trash2/.pushInsteadOf" trash/ &&
>> +	git config "url.trash2/.pushInsteadOf" testrepo/ &&

Adding

	git config "url.trash3/.pusnInsteadOf" trash/wrong &&

here should be sufficient for that, no?  If we mistakenly used URL
(i.e. trash/wrong) the push would fail.  If we mistakenly used
pushInsteadOf(URL), that is rewritten to trash3/ and again the push
would fail.  pushInsteadOf(pushURL) would go to trash2/ and that
would also fail.

We aren't checking insteadOf(URL) and insteadOf(pushURL) but
everything else is checked, I think, so we can do without replacing
anything.  We can just extend it, no?

>>  	git config remote.r.url trash/wrong &&
>> -	git config remote.r.pushurl "$TRASH/testrepo" &&
>> +	git config remote.r.pushurl "testrepo/" &&
>>  	git push r refs/heads/master:refs/remotes/origin/master &&
>>  	(
>>  		cd testrepo &&
>
> ...the test you describe should appear in *addition* to this test, not
> replacing it, because as described above this test does test one
> critical bit of behavior, namely prefering pushurl over the
> pushInsteadOf rewrite of url.
>
> - Josh Triplett
