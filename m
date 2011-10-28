From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame.c: Properly initialize strbuf after calling,
 textconv_object()
Date: Fri, 28 Oct 2011 09:44:23 -0700
Message-ID: <7vhb2tt6ag.fsf@alter.siamese.dyndns.org>
References: <4EAACA1C.6020302@gmail.com>
 <7vlis5t8bf.fsf@alter.siamese.dyndns.org>
 <CAHGBnuPUGfOe1D_OZ0ga4s8EiS_=GZeBG7WLmyOHt7vNg+w3Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 18:44:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJpXk-00085J-Gt
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 18:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756076Ab1J1Qo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 12:44:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63226 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753832Ab1J1Qo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 12:44:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC2254C12;
	Fri, 28 Oct 2011 12:44:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qWF+IgERFH52Jx10Q27ehKBP1qk=; b=Nl3/kf
	zljVFjGbQeb/a83A5T2jswkwgxwD2KxBa+CONm280d5jZ05b5b8GVnlYfra8Uun9
	h6UlsRXdq4Qt5PKWPefm0URI7iq35Qi5hpXvN8t2skbQ6yxmUeHSnvny6rehyyNX
	OSGRNJKGif2ct77+FkscAD3nmIT9BdrL90Bc4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aqF54ZH/p7bJcfX1o1lYBW37st8mYkw8
	G2wLFSxEvvfs1GLpf9lwfmRbHrRHzfyr/sPIstMKBRKRKwvw4/mvx/cvLgwBCPOI
	y8ARbLrOz4hQ8yfz+mwNVeOQcW+Wlucws03DGozP1FCRVHJzyyjO/jkUOLyAqKo0
	xsvE+B9I92E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E33E14C11;
	Fri, 28 Oct 2011 12:44:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 459CC4C10; Fri, 28 Oct 2011
 12:44:25 -0400 (EDT)
In-Reply-To: <CAHGBnuPUGfOe1D_OZ0ga4s8EiS_=GZeBG7WLmyOHt7vNg+w3Fw@mail.gmail.com>
 (Sebastian Schuberth's message of "Fri, 28 Oct 2011 18:32:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 184F4892-0184-11E1-896E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184417>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Fri, Oct 28, 2011 at 18:00, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Thanks; do you have no addition to the test suite to demonstrate the
>> breakage?
>
> Not yet. I'll try to come up with something.

Let's do this.

diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index 32ec82a..4ee42f1 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -15,6 +15,7 @@ EOF
 chmod +x helper
 
 test_expect_success 'setup ' '
+	echo "bin: test number 0" >zero.bin &&
 	echo "bin: test 1" >one.bin &&
 	echo "bin: test number 2" >two.bin &&
 	if test_have_prereq SYMLINKS; then
@@ -43,6 +44,7 @@ test_expect_success 'no filter specified' '
 
 test_expect_success 'setup textconv filters' '
 	echo "*.bin diff=test" >.gitattributes &&
+	echo "zero.bin eol=crlf" >>.gitattributes &&
 	git config diff.test.textconv ./helper &&
 	git config diff.test.cachetextconv false
 '
@@ -74,6 +76,15 @@ test_expect_success 'blame --textconv going through revisions' '
 	test_cmp expected result
 '
 
+test_expect_success 'blame --textconv with local changes' '
+	test_when_finished "git checkout zero.bin" &&
+	printf "bin: updated number 0\015" >zero.bin &&
+	git blame --textconv zero.bin >blame &&
+	expect="(Not Committed Yet ....-..-.. ..:..:.. +0000 1)" &&
+	expect="$expect converted: updated number 0" &&
+	expr "$(find_blame <blame)" : "^$expect"
+'
+
 test_expect_success 'setup +cachetextconv' '
 	git config diff.test.cachetextconv true
 '
