From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Mon, 18 Apr 2016 18:15:56 -0700
Message-ID: <xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com>
References: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Jan Durovec <jan.durovec@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 03:16:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asKHE-0006iA-MQ
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 03:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbcDSBQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 21:16:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751728AbcDSBQA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 21:16:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A96A314F57;
	Mon, 18 Apr 2016 21:15:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AjEru3d+FHX0KW/fOV4CMwNuvnc=; b=H//45d
	AJ+xEPMkyb6p2bvxEx14GszrZVLlNrwewXwo1evQU0IOblypacGXd+veb2yHzGFC
	p2xdYQ3l3I/Aqdsxlyhsy9CErtfKphTHIqESj0+A/2JZXmab1+n6h7+CKPce5FXO
	X7CLLUvb/A74H+j4k81bPm1LU28mCz26yQ3ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u2oAK9PDDHkYFJ2wsErdNTERWwtj9jH8
	HQ7bJuam381EFgBNEfnLIdSW6Er1V/yGMtHgCTbOA4Pyy4hDYP4Te1HfPtW8o+mb
	BcYxfQTz8G9gfI2ZMJIfTVrbofgckMQKh3HY8CWEfqzxOaJn/yNhamvU9pJwPKxD
	H/fWlmtLHx0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A1C4014F56;
	Mon, 18 Apr 2016 21:15:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1942C14F55;
	Mon, 18 Apr 2016 21:15:58 -0400 (EDT)
In-Reply-To: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
	(Jan Durovec's message of "Sat, 16 Apr 2016 19:58:00 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 45A2E2DA-05CC-11E6-BC99-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291841>

Jan Durovec <jan.durovec@gmail.com> writes:

> When migrating from Perforce to git the information about P4 jobs
> associated with P4 changelists is lost.
>
> Having these jobs listed on messages of related git commits enables smooth
> migration for projects that take advantage of e.g. JIRA integration
> (which uses jobs on Perforce side and parses commit messages on git side).
>
> The jobs are added to the message in the same format as is expected when
> migrating in the reverse direction.
>
> Signed-off-by: Jan Durovec <jan.durovec@gmail.com>
> ---

Thanks for describing the change more throughly than the previous
round.

Luke, how does this one look?

>  git-p4.py              | 12 ++++++
>  t/lib-git-p4.sh        | 10 +++++
>  t/t9829-git-p4-jobs.sh | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+)
>  create mode 100755 t/t9829-git-p4-jobs.sh
>
> diff --git a/git-p4.py b/git-p4.py
> index 527d44b..8f869d7 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2320,6 +2320,15 @@ def extractFilesFromCommit(self, commit):
>              fnum = fnum + 1
>          return files
>  
> +    def extractJobsFromCommit(self, commit):
> +        jobs = []
> +        jnum = 0
> +        while commit.has_key("job%s" % jnum):
> +            job = commit["job%s" % jnum]
> +            jobs.append(job)
> +            jnum = jnum + 1

I am not familiar with "Perforce jobs", but I assume that they are
always named as "job" + small non-negative integer in a dense way
and it is OK for this loop to always begin at 0 and immediately stop
when job + num does not exist (i.e. if job7 is missing, it is
guaranteed that we will not see job8).

Shouldn't the formatting be "job%d" % jnum, though, as you are using
jnum as a number that begins at 0 and increments by 1?

> +        return jobs
> +
>      def stripRepoPath(self, path, prefixes):
>          """When streaming files, this is called to map a p4 depot path
>             to where it should go in git.  The prefixes are either
> @@ -2665,6 +2674,7 @@ def hasBranchPrefix(self, path):
>      def commit(self, details, files, branch, parent = ""):
>          epoch = details["time"]
>          author = details["user"]
> +        jobs = self.extractJobsFromCommit(details)
>  
>          if self.verbose:
>              print('commit into {0}'.format(branch))
> @@ -2692,6 +2702,8 @@ def commit(self, details, files, branch, parent = ""):
>  
>          self.gitStream.write("data <<EOT\n")
>          self.gitStream.write(details["desc"])
> +        if len(jobs) > 0:
> +            self.gitStream.write("\nJobs: %s" % (' '.join(jobs)))
>          self.gitStream.write("\n[git-p4: depot-paths = \"%s\": change = %s" %
>                               (','.join(self.branchPrefixes), details["change"]))
>          if len(details['options']) > 0:
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index f9ae1d7..3907560 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -160,6 +160,16 @@ p4_add_user() {
>  	EOF
>  }
>  
> +p4_add_job() {

Not a new problem in this script, but we'd prefer to spell this as

    p4_add_job () {

i.e. a space on both sides of ().

> +	name=$1 &&
> +	p4 job -f -i <<-EOF
> +	Job: $name
> +	Status: open
> +	User: dummy
> +	Description:
> +	EOF
> +}

It may be better without $name?

> +test_expect_success 'check log message of changelist with no jobs' '
> +	client_view "//depot/... //client/..." &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git p4 clone --use-client-spec --destination="$git" //depot@all &&
> +		cat >expect <<-\EOF &&
> +Add file 1
> +[git-p4: depot-paths = "//depot/": change = 1]
> +
> +		EOF

As you are using <<- to begin the here document, it is easier on the
eyes if you indented the text with HT, i.e.

		cat >expect <<-\EOF &&
		Add file 1
		[git-p4: depot-paths = "//depot/": change = 1]

		EOF

I won't repeat the same for other instances below.

Thanks.
