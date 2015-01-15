From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5539 broken under Mac OS X
Date: Thu, 15 Jan 2015 14:39:56 -0800
Message-ID: <xmqqa91j6537.fsf@gitster.dls.corp.google.com>
References: <54B68D99.2040906@web.de>
	<xmqqmw5l9pje.fsf@gitster.dls.corp.google.com>
	<54B6C897.5030405@web.de> <20150114211712.GE1155@peff.net>
	<064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>
	<xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
	<20150115222719.GA19021@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershau?= =?utf-8?Q?sen?= 
	<tboegi@web.de>, Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 23:40:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBt5A-0000BP-03
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 23:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbbAOWkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 17:40:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753086AbbAOWj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 17:39:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 647082FABE;
	Thu, 15 Jan 2015 17:39:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KvmsFkx3kFsI5AbqroWUG+OV7Ow=; b=idY76a
	R9rE4bbFZPW50yWAwMKbG4dLe5hOyOa1Yv8MmfOTzTbJHFvPQkG9/3vidcSvdnfy
	sPuan/ZEzZ7WSJCMA+1/7MmRGcjUh5DntBdEmayitfZ2U/GPt0pfziVfgPdrObzy
	FCSwwbQ+2RqPFF7/FW1D3phVLdVFDAtYhBhwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ieiLJ5b7YQSgAe5+2BT701ROfJxxdRqu
	qf8UNO6l6AgDBOTkrWCmGuvyTWkfBXFX8/lcKs7aKhNIurt/TJIrFR94OPJX6WG0
	ffxc7ekPUUTOh+m1bfYsHTV2rGSmbTIOQtqiNWAZk3kY9TyHhuullj2Hzk1wvEX0
	Agd6VWw18Xo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5AA892FABB;
	Thu, 15 Jan 2015 17:39:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF9F42FABA;
	Thu, 15 Jan 2015 17:39:57 -0500 (EST)
In-Reply-To: <20150115222719.GA19021@peff.net> (Jeff King's message of "Thu,
	15 Jan 2015 17:27:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6ED81956-9D07-11E4-9839-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262517>

Jeff King <peff@peff.net> writes:

> The current scheme does not require POSIXPERM. Would this mean that
> some platforms no longer runs SANITY tests (e.g., Windows)?
>
> Many of the SANITY-marked tests already require both, but not all.

Before writing that patchlet, I briefly looked at grep output and
thought that many that are protected only by SANITY lacked POSIXPERM
by mistake:

 t/t1004-read-tree-m-u-wf.sh:test_expect_success SANITY 'funny symlink in...
 t/t3600-rm.sh 'Test that "git rm -f" fails if its rm fails'
 t/t7300-clean.sh:test_expect_success SANITY 'removal failure' '
 t/t7300-clean.sh:test_expect_success SANITY 'git clean -d with an...

All of the above relies on a working chmod as far as I can tell, so
they should require POSIXPERM,SANITY, not just SANITY.

> And
> certainly lib-httpd actually cares whether you are _truly_ root, not
> about weird filesystem permissions. Should lib-httpd literally be
> checking the output of `id` (though I can imagine that is anything but
> portable)?

Even though t/README describes SANITY to require:

  Test is not run by root user, and an attempt to write to an
  unwritable file is expected to fail correctly.

and it has been that way from day one, c91cfd19 (tests: A SANITY
test prereq for testing if we're root, 2010-08-06) is clear that
this is about "'chmod -w' is a good way to test unwritable files"

lib-httpd should, if it cares about the root-ness, be checking that
in a more direct way, "test_have_prereq RUNNING_AS_ROOT".  Making
the implementation of that portable is another matter, though.
