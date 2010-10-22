From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix git-apply with -p greater than 1
Date: Fri, 22 Oct 2010 11:40:41 -0700
Message-ID: <7vd3r2m5p2.fsf@alter.siamese.dyndns.org>
References: <1287699122-26702-1-git-send-email-fedux@lugmen.org.ar>
 <7viq0urfbz.fsf@alter.siamese.dyndns.org> <20101022053140.GB786@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Federico Cuello <fedux@lugmen.org.ar>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 20:42:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9MZ6-0001pY-Fg
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 20:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758693Ab0JVSky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 14:40:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50781 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758653Ab0JVSkv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 14:40:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 99974E1304;
	Fri, 22 Oct 2010 14:40:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=cHHw9xE3BUNZ0vKMkI7ZMb0gkNg=; b=sAo/TY
	XkftdiP5YxJUFZH9HzhlAhvX/0WDk0CmLesdjNnnKlCfcMY/4b+mtuog7EtEcIWy
	gcMynBS+sI9Kq/VZJDbfnJpSGLOLPZxRl27QAKrCLL0IJjLlvOuKuFedF+MWX6AQ
	USTynYTNS+Njgx4Q5I2MVdHzsEM3W7CwOre2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iJl2Cp34rTeywJJoH4oJhx3/Af6849Z0
	TNNMDeHxY8PM8g6Cq+CZPXdEOMFL4xMzEkOKff1ZLE/OmvQ1nEIDr9a2UmeF/THM
	UkcIdl6JGv2l3/Wgh4lsakKEzr9dd0m6ohSKMK/vLcv0JAQqucnVxw6Yk5yPm4Fn
	bzRT6UjEztk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 448CDE1300;
	Fri, 22 Oct 2010 14:40:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 26B26E12F9; Fri, 22 Oct
 2010 14:40:42 -0400 (EDT)
In-Reply-To: <20101022053140.GB786@burratino> (Jonathan Nieder's message of
 "Fri\, 22 Oct 2010 00\:31\:40 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E2939164-DE0B-11DF-A7F3-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159728>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> +test_expect_success 'apply (-p2) diff, mode change only' '
>> +	cat >patch.chmod <<-\EOF &&
>> +	diff --git a/sub/file1 b/sub/file1
>> +	old mode 100644
>> +	new mode 100755
>> +	EOF
>> +	chmod 644 file1 &&
>> +	git apply -p2 patch.chmod &&
>> +	test -x file1
>
> I had thought -p was only supposed to apply to traditional patches.

You are correct that historically it was invented for use with non-git
patches, but I didn't think of a good reason why we should forbid it
offhand.

> Maybe a documentation update would avoid confusion?
>
> 	-p<n>
> 	   Remove <n> leading slashes from traditional diff paths.
> 	   The default is 1.

If we have a good reason to forbid this option on git generated patches,
perhaps yes, and with either error/warning codepath, but first lets find
out a good reason why we should forbid it.  There may indeed be some.
