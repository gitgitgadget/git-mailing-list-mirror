From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] git-p4: Add test case for complex branch import
Date: Fri, 20 Jan 2012 20:54:42 -0800
Message-ID: <7vehutd59p.fsf@alter.siamese.dyndns.org>
References: <1327105292-30092-1-git-send-email-vitor.hda@gmail.com>
 <1327105292-30092-4-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Luke Diamand <luke@diamand.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 21 05:55:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoSyl-000115-7W
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 05:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756801Ab2AUEyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 23:54:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40262 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756561Ab2AUEyp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 23:54:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE3626697;
	Fri, 20 Jan 2012 23:54:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jFFOi+bXvncXBDx12moE1wzAVZ0=; b=ZgJoKm
	hJOlva47fS4AA8F0/kwnQMFeMmMvTcBibHTsGGhuKygQepgyNB93Km+jF+NwyTfw
	OpqNJWG92y72Z1fn+WTEAbpoijsPhtxp8kv+pIfN3MemxrO6j4eqg4uDHiZBBzqT
	N528WoxDxgs3tkI9Bf1R64IgtKp/xjbbCF+MU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mzvks4yVlP+athpebKGXyT8uqsECRPBI
	MmCt3uO3SZ9A7GIAIw/37EyeMSaqE4CcOUHNOdO5DgDfKSqAzyK+46OHsht7QKWy
	zkdA+CMhGBWIKUa8rTHaDYMF5VjUqJ4MTp1OSYUGd+gvCiFw3UPrJJ6xxffP+BsJ
	5lwyR2ukZWg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A63F76695;
	Fri, 20 Jan 2012 23:54:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D6536694; Fri, 20 Jan 2012
 23:54:44 -0500 (EST)
In-Reply-To: <1327105292-30092-4-git-send-email-vitor.hda@gmail.com> (Vitor
 Antunes's message of "Sat, 21 Jan 2012 00:21:32 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 091BA640-43EC-11E1-8B27-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188917>

Vitor Antunes <vitor.hda@gmail.com> writes:

> +test_expect_success 'git-p4 add complex branches' '
> +	test_when_finished cleanup_git &&
> +	test_create_repo "$git" &&
> +	(
> +		cd "$cli" &&
> +		changelist=$(p4 changes -m1 //depot/... | cut -d" " -f2) &&
> +		changelist=$(($changelist - 5)) &&
> +		p4 integrate //depot/branch1/...@$changelist //depot/branch4/... &&
> +		p4 submit -d "branch4" &&
> +		changelist=$(($changelist + 2)) &&
> +		p4 integrate //depot/branch1/...@$changelist //depot/branch5/... &&
> +		p4 submit -d "branch5"

That's a strange quoting convention. Why are "branch4" and "branch5"
enclosed in double quotes while "integrate" and "submit" aren't?
(rhetorical: do not quote these branch names without a good reason).

> +# Configure branches through git-config and clone them. git-p4 will only be able
> +# to clone the original structure if it is able to detect the origin changelist
> +# of each branch.
> +test_expect_success 'git-p4 clone complex branches' '
> +	test_when_finished cleanup_git &&
> +	test_create_repo "$git" &&
> +	(
> +		cd "$git" &&
> +		git config git-p4.branchList branch1:branch2 &&
> +		git config --add git-p4.branchList branch1:branch3 &&
> +		git config --add git-p4.branchList branch1:branch4 &&
> +		git config --add git-p4.branchList branch1:branch5 &&
> +		"$GITP4" clone --dest=. --detect-branches //depot@all &&
> +		git log --all --graph --decorate --stat &&
> +		git reset --hard p4/depot/branch1 &&
> +		test_path_is_file file1 &&
> +		test_path_is_file file2 &&
> +		test_path_is_file file3 &&
> +		grep -q update file2 &&

Do you really need to use "-q" here?  Wouldn't it help if you wrote it
without it while debugging tests with "sh ./t9801-*.sh -v"?

Also how does this series interact with the series Luke posted earlier on
branches and labels?

Thanks.
