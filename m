From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] combine-diff: handle binary files as binary
Date: Tue, 31 May 2011 15:42:47 -0700
Message-ID: <7vlixmija0.fsf@alter.siamese.dyndns.org>
References: <20110523201529.GA6281@sigill.intra.peff.net>
 <20110523202734.GC6298@sigill.intra.peff.net>
 <7vpqn0ofy5.fsf@alter.siamese.dyndns.org>
 <20110530143627.GC31490@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 00:43:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRXeg-00017E-2r
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 00:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827Ab1EaWnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 18:43:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38976 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932786Ab1EaWnA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 18:43:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 40BAA5E5F;
	Tue, 31 May 2011 18:45:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TTQXngEqLyIKhqCZfqGgrYVe8/A=; b=gzckd4
	20C5WERqJnoHrx5Wguptp3UBWKNw+bN8sMkkaIp218iiuW0rPik771/8ionEboi8
	Mh5dx2qhLc7eS2AF9DfARU3EE7c1vS2hHYbH4UwqkPRmJeuLESEOHj527uMxjDec
	PiyPIj9bpusVEZgkXu4hCspregq3tWOQuACns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ubTPdBIuYcAdtxtbLCMEtkTvkJjaA4Ss
	13P+UNvoowTpnXSlDHCwxe5t20I2y7xwnaO2vViMQ1KvkMqjesY8IdhVxuW3PaWd
	GQBdSTZGwvLtVqtNe574q4LlnkdLScN5mJQM1D3seDFmuFjuMv7hNlSFEbDBBOCR
	dXEBYwsKH34=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EAC6E5E5D;
	Tue, 31 May 2011 18:45:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 73F605E59; Tue, 31 May 2011
 18:44:58 -0400 (EDT)
In-Reply-To: <20110530143627.GC31490@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 30 May 2011 10:36:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9FF122CA-8BD7-11E0-9E6F-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174836>

Jeff King <peff@peff.net> writes:

> ... speaking of
> which, I need to polish that now that the streaming series seems to have
> settled...

I merely put it on the back burner, not necessarily declaring it as
"settled".

I just created a pair of test repository with a single 800M binary junk
file. One repository has it as a single loose object file, and the other
repository has it in a packfile.  The path is not explicitly marked with
any attributes, but I have no CRLF funniness configured, so streaming
would be used but there won't be any filtering involved.

Removing the file from the working tree and then checking it out of the
index gave me a pleasant surprise. I originally did this only to help
smaller machines that cannot comfortably fit inflated blob data in core,
but it turns out that streaming write seems to perform better.

These are the typical /usr/bin/time output:

  $ /usr/bin/time git checkout a ;# w/o streaming
  1.39user 2.23system 0:03.62elapsed 99%CPU (0avgtext+0avgdata 6297056maxresident)k
  0inputs+1572872outputs (0major+399828minor)pagefaults 0swaps

  $ /usr/bin/time git checkout a ;# w/ streaming
  1.35user 1.22system 0:02.52elapsed 101%CPU (0avgtext+0avgdata 3151536maxresident)k
  0inputs+1572872outputs (0major+203226minor)pagefaults 0swaps

So now I can say I am reasonably happy with the series, but I haven't
really exercised the code heavily, so there may still be bugs lurking ;-).
