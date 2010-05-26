From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] checkout --orphan: respect -l option always
Date: Tue, 25 May 2010 22:07:08 -0700
Message-ID: <7vzkznqmir.fsf@alter.siamese.dyndns.org>
References: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com>
 <1274488119-6989-4-git-send-email-erick.mattos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 26 07:07:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH8px-0005Io-6m
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 07:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086Ab0EZFHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 01:07:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab0EZFHP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 01:07:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C454B67A4;
	Wed, 26 May 2010 01:07:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=p5AVdtEOhmGEXzkj3pH/vlh1Ehk=; b=CXxGVB5pksKTSNpvPqjnq9k
	uwb6MyafWefpNlMdKltihw5Ro5fn984RtNeuBtPmNfCOTHZW5KTlPNhKKXHn7n9T
	F9ojHX96LsLZWPXt7iNRNlB7QCIOxR583AK2YmXD7/PbmSPkDvHt1X9swql6prQf
	LBWtMPuBsN2hMLv3etPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=r68wlp4ccVokQ+at5sIHTe/taM8EnENvpnRhn572Xcn7pJCq2
	jki8QQYakkE4f2IWRmlLqjTtE8vYZTqg+2kQMuRkwegjT3P4u9PmKRcDr2nMB1BH
	5xhWI0c+ehwWZOqHh+uxioIpjM1GVnD/oV+3/7ZhRxU4osGCY28lF48ISg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DB772B67A1;
	Wed, 26 May 2010 01:07:12 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27783B679B; Wed, 26 May
 2010 01:07:10 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8B6F0B0E-6884-11DF-B453-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147735>

Erick Mattos <erick.mattos@gmail.com> writes:

> +			git_snpath(ref_file, sizeof(ref_file), "%s", old->path);

???

> @@ -684,8 +709,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  	if (opts.new_orphan_branch) {
>  		if (opts.new_branch)
>  			die("--orphan and -b are mutually exclusive");
> -		if (opts.track > 0 || opts.new_branch_log)
> -			die("--orphan cannot be used with -t or -l");
> +		if (opts.track > 0)
> +			die("--orphan should not be used with -t");

Why s/cannot/should not/?  Just being curious.

> +test_expect_success 'giving up --orphan not committed when -l and core.logAllRefUpdates = false deletes reflog' '
> +	git checkout master &&
> +	git checkout -l --orphan eta &&
> +	test -f .git/logs/refs/heads/eta &&
> +	test_must_fail PAGER= git reflog show eta &&
> +	git checkout master &&
> +	! test -f .git/logs/refs/heads/eta &&
> +	test_must_fail PAGER= git reflog show eta
> +'

I don't quite understand the title of this test, nor am I convinced that
testing for .git/logs/refs/heads/eta is necessarily a good thing to do
here.  "eta" branch is first prepared in an unborn state with the working
tree and the index prepared to commit what is in 'master', and the first
"git reflog" would fail because there is no eta branch at that point yet.
Moving to 'master' from that state would still leave "eta" branch unborn
and we will not see "git reflog" for that branch (we will fail "git log
eta" too for that matter).  Perhaps two "test -f .git/logs/refs/heads/eta"
shouldn't be there?  It feels that it is testing a bit too low level an
implementation detail.
