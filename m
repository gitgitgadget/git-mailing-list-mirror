From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] checkout -m: attempt merge when deletion of path was staged
Date: Wed, 13 Aug 2014 11:59:18 -0700
Message-ID: <xmqqvbpw2p2x.fsf@gitster.dls.corp.google.com>
References: <xmqqha1h60fy.fsf@gitster.dls.corp.google.com>
	<1407878107-22850-1-git-send-email-stefanbeller@gmail.com>
	<20140812235731.GD24621@google.com>
	<20140813000317.GG24621@google.com>
	<xmqqzjf82sc7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@gmail.com>, Johannes.Schindelin@gmx.de,
	barkalow@iabervon.org, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 20:59:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHdlq-00083w-BI
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 20:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbaHMS7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 14:59:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52042 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbaHMS7d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 14:59:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4734630E32;
	Wed, 13 Aug 2014 14:59:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y0w7JG+6toqbBli3LhCWC+bmD3A=; b=U4kT2R
	WNZIkbS+zuR1R5H7i8Cna90b7nKvrtm7HmqaozCtFfWkcGU1UDJULBw2g380S/pn
	BnboFBCm+iAjye3Gof1CfTkZ6AmKLn1iXg76O3hC8zv+CgP8DEFdNiTyWKKe9yhc
	f1Oe7GW+6vs39O1xqDWfNMe7IINE0gLupcfy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ckRqx5n7xqjptVOPSDS8X5js4Tu5quSN
	VKMN+LAL+kpNhmC1o60M+BDdsEZC65TsUwYvpIq3Cud3jCDwlK5hES+CzUbrmpU0
	hRgeV9sVWjsPKpCrGNHsMxSgvEa7IlTbFMU+wG2RjXs9Gm+H99IGmfsJ7wWtMI5V
	aq6ESkz17Hk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3DA5C30E2F;
	Wed, 13 Aug 2014 14:59:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2C5B630E12;
	Wed, 13 Aug 2014 14:59:20 -0400 (EDT)
In-Reply-To: <xmqqzjf82sc7.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 13 Aug 2014 10:48:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EE974F88-231B-11E4-A4B0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255223>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> twoway_merge() is missing an o->gently check in the case where a file
>> that needs to be modified is missing from the index but present in the
>> old and new trees.  As a result, in this case 'git checkout -m' errors
>> out instead of trying to perform a merge.
>
> I see two hunks in threeway_merge(), so two existing callers there
> will not change their behaviour.  Two hunks in twoway_merge() means
> that among three existing callers in that function, this one at the
> end (not shown in your patch) changes its behaviour:
>
> 	else if (newtree) {
> 		if (oldtree && !o->initial_checkout) {
> 			/*
> 			 * deletion of the path was staged;
> 			 */
> 			if (same(oldtree, newtree))
> 				return 1;
> 			return reject_merge(oldtree, o);
> 		}
> 		return merged_entry(newtree, current, o);
> 	}
> 	return deleted_entry(oldtree, current, o);
>
>> This is the most iffy of the three patches, mostly because I was too
>> lazy to write a test.
>
> You would trigger this codepath by jumping from an old revision to a
> new revision after "git rm $path" any path that has been modified
> between the two.  The only behaviour difference is that it will stop
> issuing an error message---the "checkout -m" will successfully switch
> between the revs and leave the index in a "we modified, they removed"
> conflicting state with or without your patch.

IOW, something like this perhaps?

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 0c9ec0a..cedbb6a 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -223,6 +223,23 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
 	test_cmp two expect
 '
 
+test_expect_success 'switch to another branch while carrying a deletion' '
+
+	git checkout -f master && git reset --hard && git clean -f &&
+	git rm two &&
+
+	test_must_fail git checkout simple 2>errs &&
+	test_i18ngrep overwritten errs &&
+
+	git checkout --merge simple 2>errs &&
+	! test_i18ngrep overwritten errs &&
+	git ls-files -u &&
+	test_must_fail git cat-file -t :0:two &&
+	test "$(git cat-file -t :1:two)" = blob &&
+	test "$(git cat-file -t :2:two)" = blob &&
+	test_must_fail git cat-file -t :3:two
+'
+
 test_expect_success 'checkout to detach HEAD (with advice declined)' '
 
 	git config advice.detachedHead false &&
