From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH 2/2] prepare_revision_walk: Check for return value in
 all places
Date: Mon, 11 Aug 2014 21:23:54 +0200
Message-ID: <53E9184A.8030504@gmail.com>
References: <1407706406-30455-1-git-send-email-stefanbeller@gmail.com>	<1407706406-30455-2-git-send-email-stefanbeller@gmail.com> <xmqq1tsm7si5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 21:24:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGvCL-00078Y-6F
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 21:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754AbaHKTX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 15:23:57 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:52735 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbaHKTX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 15:23:57 -0400
Received: by mail-we0-f178.google.com with SMTP id w61so8927024wes.23
        for <git@vger.kernel.org>; Mon, 11 Aug 2014 12:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=HRgl182LQe93gRd6ELzo/MHK69WOCMgSKOOskE+USUk=;
        b=ZwA9XpX5GmsV+0+jn/f4q7hoQ4hZCkbCYINGczxrCYw8mPjbFL8D8Nqx0EGrLGd/ql
         aAUfscVuc4tjibRALqD5ufpv/WA//JB4bc9+IQFoBWmywFdE8BU1fg8GTkzlYtkkZuGy
         J7cqC5aChsYJrmg55qki/ibkwOiFECaRD+qNANun7JxmF/b89IpgrCT2o9qaGQIcoXM0
         gypxg2zjrFDW2n6piwFTKuEj4UjVVC64U+D1jDe93OK3sWGfw0qM0uDFKSTe7KdsFM7b
         K8CKKfl2faCR5UTCSI+rWBjd++wHpzEHYNv8Q7X1DjFFe4UqhnEOu2lEiUdn1cAfq7vq
         ELvA==
X-Received: by 10.180.211.233 with SMTP id nf9mr27021121wic.33.1407785035901;
        Mon, 11 Aug 2014 12:23:55 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id co6sm3696698wjb.31.2014.08.11.12.23.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Aug 2014 12:23:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqq1tsm7si5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255133>

On 11.08.2014 21:09, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@gmail.com> writes:
> 
>> Even the documentation tells us:
>> 	You should check if it
>> 	returns any error (non-zero return code) and if it does not, you can
>> 	start using get_revision() to do the iteration.
>>
>> In preparation for this commit, I grepped all occurrences of
>> prepare_revision_walk and added error messages, when there were none.
> 
> Thanks.  One niggling thing is that I do not seem to find a way for
> the function to actually return an error without dying in it, but
> these are independently good changes.
> 
>>
>> Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
>> ---
>>  builtin/branch.c | 4 +++-
>>  builtin/commit.c | 3 ++-
>>  remote.c         | 3 ++-
>>  3 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index 0591b22..ced422b 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -653,7 +653,9 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
>>  		add_pending_object(&ref_list.revs,
>>  				   (struct object *) filter, "");
>>  		ref_list.revs.limited = 1;
>> -		prepare_revision_walk(&ref_list.revs);
>> +
>> +		if (prepare_revision_walk(&ref_list.revs))
>> +			die(_("revision walk setup failed"));
>>  		if (verbose)
>>  			ref_list.maxwidth = calc_maxwidth(&ref_list);
>>  	}
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 7867768..bb84e1d 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1055,7 +1055,8 @@ static const char *find_author_by_nickname(const char *name)
>>  	revs.mailmap = &mailmap;
>>  	read_mailmap(revs.mailmap, NULL);
>>  
>> -	prepare_revision_walk(&revs);
>> +	if (prepare_revision_walk(&revs))
>> +		die("revision walk setup failed");

Just reviewed the patch myself and here in commit.c we should have a
localized version, right?
Should I resend the patch with the localisation or could you just amend
that?

>>  	commit = get_revision(&revs);
>>  	if (commit) {
>>  		struct pretty_print_context ctx = {0};
>> diff --git a/remote.c b/remote.c
>> index 894db09..112e4d5 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -1893,7 +1893,8 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
>>  
>>  	init_revisions(&revs, NULL);
>>  	setup_revisions(rev_argc, rev_argv, &revs, NULL);
>> -	prepare_revision_walk(&revs);
>> +	if (prepare_revision_walk(&revs))
>> +		die("revision walk setup failed");
>>  
>>  	/* ... and count the commits on each side. */
>>  	*num_ours = 0;
