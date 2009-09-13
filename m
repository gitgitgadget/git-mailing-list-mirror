From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v4 1/2] gitweb: check given hash before trying to
 create snapshot
Date: Sat, 12 Sep 2009 22:42:31 -0700
Message-ID: <7vy6oj1jug.fsf@alter.siamese.dyndns.org>
References: <4AAC3833.8060905@mailservices.uwaterloo.ca>
 <7vmy4z4j35.fsf@alter.siamese.dyndns.org>
 <4AAC8521.1060005@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Sun Sep 13 07:42:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmhrU-0007pL-H8
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 07:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbZIMFmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 01:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752073AbZIMFms
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 01:42:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbZIMFmr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 01:42:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B97E4EE38;
	Sun, 13 Sep 2009 01:42:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GFcJfnGlN7sIUmF3WV8DUyHLVe0=; b=rPTOFD
	1AOV99r9IMUx8tX+8O0iZZDF7elei9IlyME8gJ9CUa3pB4yrO/LkhE1hzzhsghx2
	RQrEqddsRZf8ReUhNJ2P5+98hxIddSQa8cmPwutC7BHFkIwFfHAId77Z47LmwCsi
	9FHTIfA1k/A/xfEr9EpYQtxlp9b3xy5Jt9+3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dh00aFHjE6wd+Fb42zYXcxlLTX7yjJvm
	8yjSnvMu8RE4bnoKYZmu5gvTB6MkinOukKymF/nzlsrVo2pQLpT6Ba4eP98qMSE9
	VxK05kU3Pv5dO1mL9Yl2TYCnEmop3We2YgHwd8q6qcHd76YDdOss/+MJaKLGsd6u
	QpZJvUWDQnk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4D00D4EE37;
	Sun, 13 Sep 2009 01:42:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7851F4EE36; Sun, 13 Sep 2009
 01:42:33 -0400 (EDT)
In-Reply-To: <4AAC8521.1060005@mailservices.uwaterloo.ca> (Mark Rada's
 message of "Sun\, 13 Sep 2009 01\:37\:37 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 41E9C2FA-A028-11DE-9790-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128337>

Mark Rada <marada@uwaterloo.ca> writes:

> On 09-09-12 11:30 PM, Junio C Hamano wrote:
>>> @@ -5196,8 +5202,9 @@ sub git_snapshot {
>>>  		die_error(403, "Unsupported snapshot format");
>>>  	}
>>>  
>>> -	if (!defined $hash) {
>>> -		$hash = git_get_head_hash($project);
>>> +	my $full_hash = git_get_full_hash($project, $hash);
>>> +	if (!$full_hash) {
>>> +		die_error(404, 'Hash id was not valid');
>>>  	}
>> 
>> This is in the context of "snapshot", so obviously you care more about
>> just "such an object exists", don't you?  You also want it to be a
>> tree-ish.  Try giving it $hash = 'junio-gpg-pub' and see how it breaks.
>  
> You have confused me. How is using 'junio-gpg-pub' different from the 
> second test case that tries to use 'frizzumFrazzum'?

junio-gpg-pub tag exists in git.git but it tags a blob not a tree.

	$ git rev-parse junio-gpg-pub
        6019c27d966fe3ce8adcc0e9f12078eef96ca6ef
        $ git archive junio-gpg-pub
        fatal: not a tree object
