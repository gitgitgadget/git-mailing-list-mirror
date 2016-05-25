From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Wed, 25 May 2016 09:00:03 -0700
Message-ID: <xmqqshx6162k.fsf@gitster.mtv.corp.google.com>
References: <20160525020609.GA20123@zoidberg>
	<xmqqh9dm37xk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Edward Thomson <ethomson@edwardthomson.com>
X-From: git-owner@vger.kernel.org Wed May 25 18:00:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5bET-0003MS-DZ
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 18:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371AbcEYQAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 12:00:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53713 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754229AbcEYQAL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 12:00:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F13271D9C8;
	Wed, 25 May 2016 12:00:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MtnMgeCLNhAokpTdpyVDwjvfN5c=; b=fnfPBP
	WG8Qfyt8Yn8S0u35DykOJjt+yuls8nSgtNuVga2UDSovtnrVMVcgol8oukZ0YXem
	5BOmdqKmwwlu49XaTtOnZfID9mkMoq2kCXpmoaIAkFWabeQiWGZK6CIkSwKAhNZC
	B9Z2OC7rBiDfEg0Dacrd4/yAOF0T1sxDDKras=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mz1jp45mJPuzZ3BFtszBINP5uBGv3RDR
	wWPxaiey7MWJN74O7XQjoXDqoqf0zNjiEbY+pao6RoeSHX49B1H+rGUZYheDmteM
	PEKkRCWlqAiivHlEAJ4pQP4nmE+7tEPChwFWuWCr5hvYYcZV5sx1ImjPRTSxkKiZ
	HAk6eaVYNMg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E19731D9C6;
	Wed, 25 May 2016 12:00:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6AECB1D9C1;
	Wed, 25 May 2016 12:00:08 -0400 (EDT)
In-Reply-To: <xmqqh9dm37xk.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 25 May 2016 00:36:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C101F272-2291-11E6-BC29-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295576>

Junio C Hamano <gitster@pobox.com> writes:

>> @@ -661,6 +663,10 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>>  
>>  	if (trust_executable_bit && has_symlinks)
>>  		ce->ce_mode = create_ce_mode(st_mode);
>> +	else if (force_executable)
>> +		ce->ce_mode = create_ce_mode(0777);
>> +	else if (force_notexecutable)
>> +		ce->ce_mode = create_ce_mode(0666);
>
> This is an iffy design decision.
>
> Even when you are in core.filemode=true repository, if you
> explicitly said
>
> 	git add --chmod=+x READ.ME
>
> wouldn't you expect that the path would have executable bit in the
> index, whether it has it as executable in the filesystem?  The above
> if/else cascade, because trust-executable-bit is tested first, will
> ignore force_* flags altogether, won't it?  It also is strange that
> the decision to honor or ignore force_* flags is also tied to
> has_symlinks, which is a totally orthogonal concept.

Here is an additional patch to your tests.  It repeats one of the
tests you added, but runs in a repository with core.filemode and
core.symlinks both enabled.  The test fails to force executable bit
on platforms where it runs.

It passes with your patch if you drop core.symlinks, which is a good
demonstration why letting has_symlinks decide if force* is to be
honored is iffy.

 t/t3700-add.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index e551eaf..2afcb74 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -351,4 +351,15 @@ test_expect_success 'git add --chmod=-x stages an executable file with -x' '
 	esac
 '
 
+test_expect_success POSIXPERM,SYMLINKS 'git add --chmod=+x' '
+	git config core.filemode 1 &&
+	git config core.symlinks 1 &&
+	echo foo >foo2 &&
+	git add --chmod=+x foo2 &&
+	case "$(git ls-files --stage foo2)" in
+	100755" "*foo2) echo pass;;
+	*) echo fail; git ls-files --stage foo2; (exit 1);;
+	esac
+'
+
 test_done
