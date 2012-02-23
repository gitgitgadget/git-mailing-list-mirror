From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: use editor by default in interactive sessions
Date: Thu, 23 Feb 2012 11:23:37 -0800
Message-ID: <7vd3954ame.fsf@alter.siamese.dyndns.org>
References: <7vipk26p1b.fsf@alter.siamese.dyndns.org>
 <CABPQNSZVOjOKpqv4s1ZCEQRd_yT3us3mqC9aN-KK5PHqztYQQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 23 20:23:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0eGX-0007ka-BV
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 20:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974Ab2BWTXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 14:23:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50963 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754687Ab2BWTXj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 14:23:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DB78702E;
	Thu, 23 Feb 2012 14:23:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W1E4O9TqFuIMpsg2heodfE2o6dQ=; b=VfGDih
	9riaujm1Ep1FhNFkdqjdsyJpwiKM2aIffCXZ3ziKN9V6fXamvu4TPEY7W/XqM4U/
	BUidDdroSmdvNVx6R9PciLPcBykuGviOzJdaQsIR5fDBCxir3KnSwiHIjzkp8aIp
	bUvjhO82GTOTQgZDLb0WGQhhaEVcYBXI9Prm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B0E3Xq6jZ4O8P3UgqXHoN7TjYmHYQt9B
	vmJuFdbZRpRUNVMnSrkSB807BaQ1AUu6xXiOr8Ig7ScWv98z1UEqRU7EKHvZPTa3
	c9beAMO2DYb2l0+uPvamCX739YzOR0yoOLuhV/9yG7+gPlyZD7biPkqCSBCa6vOu
	F0Duz5Ks77I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64C65702D;
	Thu, 23 Feb 2012 14:23:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC86B702C; Thu, 23 Feb 2012
 14:23:38 -0500 (EST)
In-Reply-To: <CABPQNSZVOjOKpqv4s1ZCEQRd_yT3us3mqC9aN-KK5PHqztYQQg@mail.gmail.com> (Erik
 Faye-Lund's message of "Thu, 23 Feb 2012 13:43:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E37DBDE2-5E53-11E1-BE22-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191387>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>> +       /* Use editor if stdin and stdout are the same and is a tty */
>> +       return (!fstat(0, &st_stdin) &&
>> +               !fstat(1, &st_stdout) &&
>> +               isatty(0) &&
>> +               st_stdin.st_dev == st_stdout.st_dev &&
>> +               st_stdin.st_ino == st_stdout.st_ino &&
>> +               st_stdin.st_mode == st_stdout.st_mode);
>
> I just stumbled over this code, and I got a bit worried; the
> stat-implementation we use on Windows sets st_ino to 0, so
> "st_stdin.st_ino == st_stdout.st_ino" will always evaluate to true.
>
> Perhaps we should add a check for isatty(1) here as well? ...
> Or is there something I'm missing here?

No, the intention was not "we do this whether standard output is tty or
not", but was "we check that fd#0 and fd#1 are connected to the same
device by trusting stat() to do the right thing, so checking isatty(0)
is sufficient".  As that "trusting stat()" assumption does not hold for
your platform, we would need to add isatty(1) to accomodate it.

Thanks for a set of sharp eyes.
