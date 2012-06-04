From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not
 break ACLs with restrictive umask
Date: Mon, 04 Jun 2012 15:19:47 -0700
Message-ID: <7vy5o2ra7w.fsf@alter.siamese.dyndns.org>
References: <CALbm-Ea5ZkAGFyB2OETqe7vK7LE+yO0zSaa_+kFMXOhO-nMwMQ@mail.gmail.com>
 <7vhauqsue3.fsf@alter.siamese.dyndns.org>
 <CALbm-EatNCPjFRO4NyGfZuSa72-FXwZcd_7cFe-f_iMOdGL4MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 00:20:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbfcw-0001KC-QT
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 00:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761059Ab2FDWTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 18:19:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54461 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754512Ab2FDWTt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 18:19:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FA378C38;
	Mon,  4 Jun 2012 18:19:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ErrlYYJAUyb6Jq1TKGUua270lH4=; b=b6sYNl
	CrcGN6fYzscZ+0S3azOoQ8Dv94APF5LRysCNzbyS+Own41DCAtjtW6y8hftIZT52
	fq0V1kc6a/+EZIVabzklMp4KjlScszDHggezwlEdG+V+uE1tNj2GgISx/IWDbeDa
	Ra8hkT+iW+nJv1YjNU9l9A2Hzn+Bjj80uuMBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VSVJOv5m8g3TpMRaDdxyiWilhakl/paN
	zpectYGUyuh2xlFJ99B6JR/wv58Yf4KF64dBKW24A1BKUOIs1U+RZMGf8M1H7XqK
	wyLC3PCtZA2KCycZ/SlnrG7HG8I1rbzOKnx0xQ383q74Y5HM0axssVTdCNOkFopJ
	RbN9wMlFu4s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 666CF8C37;
	Mon,  4 Jun 2012 18:19:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC8B78C35; Mon,  4 Jun 2012
 18:19:48 -0400 (EDT)
In-Reply-To: <CALbm-EatNCPjFRO4NyGfZuSa72-FXwZcd_7cFe-f_iMOdGL4MQ@mail.gmail.com> (Stefan
 Beller's message of "Mon, 4 Jun 2012 22:48:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 65D65AEE-AE93-11E1-A15C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199193>

Stefan Beller <stefanbeller@googlemail.com> writes:

> I tried debugging into it:
> In git/t/t1304-default-acl.sh there is:
> check_perms_and_acl () {
>     test -r "$1" &&
>     getfacl "$1" > actual &&
>     grep -q "user:root:rwx" actual &&
>     grep -q "user:${LOGNAME}:rwx" actual &&
>     egrep "mask::?r--" actual > /dev/null 2>&1 &&
>     grep -q "group::---" actual || false
> }
>
> but when I do all the commands as in the test2:
> test_expect_success SETFACL 'Objects creation does not break ACLs with
> restrictive umask' '
>     # SHA1 for empty blob
>     check_perms_and_acl .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
> '
> Now I run the second line in check_perms_and_acl ()  with
> .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
> there is
>
> getfacl .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
> # file: .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
> # owner: sb
> # group: sb
> user::r--
> user:root:rwx			#effective:---
> user:sb:rwx			#effective:---
> group::---
> mask::---
> other::---
>
> This command seem to fail 'egrep "mask::?r--" actual' as there is
> mask::---
> but expected is
> mask::r--
>
> That's my understanding of the test case so far.

Hmph.  Running the test manually does not seem to fail for me and
gives the "r--" mask.

I am lost.  Matthieu, you introduced this as a failing test with
7aba618 (Add a testcase for ACL with restrictive umask.,
2010-02-22), as part of the series leading to 5256b00 (Use
git_mkstemp_mode instead of plain mkstemp to create object files,
2010-02-22).  Any ideas (other than "Your filesystem is broken",
that is)?  As far as I can tell, with 'mask::---', these specific
users who are given permissions to read from the objects wouldn't be
able to read from them, so...
