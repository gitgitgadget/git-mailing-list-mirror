From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] blame.c: Properly initialize strbuf after calling, textconv_object()
Date: Fri, 28 Oct 2011 20:36:45 +0200
Message-ID: <4EAAF63D.7050401@gmail.com>
References: <4EAACA1C.6020302@gmail.com> <7vlis5t8bf.fsf@alter.siamese.dyndns.org> <CAHGBnuPUGfOe1D_OZ0ga4s8EiS_=GZeBG7WLmyOHt7vNg+w3Fw@mail.gmail.com> <7vhb2tt6ag.fsf@alter.siamese.dyndns.org> <CAHGBnuNpwZCpQxZQNRZ-pYpLMHMi1O4d0hsR9MKM3=7Hw5A=zw@mail.gmail.com> <7vd3dht4ms.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 20:37:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJrIb-0001AI-3n
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 20:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507Ab1J1Sgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 14:36:55 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32824 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077Ab1J1Sgx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 14:36:53 -0400
Received: by faan17 with SMTP id n17so3878291faa.19
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=B+X/BL1oYIZ3T4mkTfClYkSNBv79IKZDy7BYZWx3sO8=;
        b=U0XLTgLuXtyK7I4FUJce3LjKw890LKzYeoAdKTIuIeLUQ0KnjtdD4bBZANpzmdtHVA
         bQejh9iJWo8u+ht4n3BH7rihbLNHJKYZU2gWCj0jAmIVLJZF7ldnTtA30QQuqXlrWXOe
         UlbUc4fk8HKWD8109iQGqR0yIEbtT54VCw7WI=
Received: by 10.223.5.66 with SMTP id 2mr7602437fau.26.1319827012554;
        Fri, 28 Oct 2011 11:36:52 -0700 (PDT)
Received: from [192.168.178.22] (p5DDB0F41.dip0.t-ipconnect.de. [93.219.15.65])
        by mx.google.com with ESMTPS id x19sm11125027fag.5.2011.10.28.11.36.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Oct 2011 11:36:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git,gmane.comp.version-control.msysgit
In-Reply-To: <7vd3dht4ms.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184425>

On 28.10.2011 19:20, Junio C Hamano wrote:

>>>>> Thanks; do you have no addition to the test suite to demonstrate the
>>>>> breakage?
>>>>
>>>> Not yet. I'll try to come up with something.
>>>
>>> Let's do this.
>>
>> Thanks, but that does not seem to work for me. The test breaks both
>> without and with my patch. I'll look into it.
> 
> Thanks. I suspect the difference is because you are on a crlf-native
> platform while I am not...

I also didn't have any luck. I've created a test that should fail without my patch, but it succeeds when running the test script. However, if I copy and paste the lines from the test to the command line, the test fails as expected ("blame" is empty). I'm out of ideas right now.

diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index 32ec82a..4fee5aa 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -14,6 +14,13 @@ sed 's/^bin: /converted: /' "$1"
 EOF
 chmod +x helper
 
+cat >helper-dos-line-endings <<'EOF'
+#!/bin/sh
+grep -q '^bin: ' "$1" || { echo "E: $1 is not \"binary\" file" 1>&2; exit 1; }
+sed 's/^bin: \(.*\)$/converted: \1\r/' "$1"
+EOF
+chmod +x helper-dos-line-endings
+
 test_expect_success 'setup ' '
 	echo "bin: test 1" >one.bin &&
 	echo "bin: test number 2" >two.bin &&
@@ -74,6 +81,14 @@ test_expect_success 'blame --textconv going through revisions' '
 	test_cmp expected result
 '
 
+test_expect_success 'blame --textconv with DOS line endings' '
+	git config diff.test.textconv ./helper-dos-line-endings &&
+	git blame --textconv two.bin >blame &&
+	git config diff.test.textconv ./helper &&
+	find_blame <blame >result &&
+	test_cmp expected result
+'
+
 test_expect_success 'setup +cachetextconv' '
 	git config diff.test.cachetextconv true
 '

-- 
Sebastian Schuberth
