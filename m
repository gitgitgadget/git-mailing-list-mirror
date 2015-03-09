From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] log: decorate detached HEAD differently
Date: Mon, 09 Mar 2015 10:16:01 +0100
Message-ID: <54FD64D1.6080103@drmicha.warpmail.net>
References: <CAPc5daWz-Xa7q6f9RzgTP4has8DcCG4QgK7SMGNbH6KGnEyr2Q@mail.gmail.com>	<015d6992d2c2165045117f763d9ce3131979c2db.1425658434.git.git@drmicha.warpmail.net> <xmqq61aeymlv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Julien Cretel <j.cretel@umail.ucc.ie>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 10:16:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUtnG-00088P-NC
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 10:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbbCIJQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 05:16:07 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60112 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752998AbbCIJQE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2015 05:16:04 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 76754215AD
	for <git@vger.kernel.org>; Mon,  9 Mar 2015 05:16:01 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 09 Mar 2015 05:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=SVngbcjPLu3+WH1ixUjRhi
	azf/o=; b=GBQpZszojvkKY4unaxzL78YS0rYrSzQhYQyiUDCnj50k6sd0l4Kvia
	rsCvMBfEf69lyMjDSuNdjK8XTughjxkqNMWlKtsHh+DSI1PRASPPLBlNN6kt4cQu
	GONqZmcrEdFnxqT+c8O8cc78fyfaqJ9vKmo1K5+hz8KG/yh5SLvpY=
X-Sasl-enc: lOZoBW6zzJ7ZoVSoGK/q10A8kaQDa9eP04AWAPcdKM4a 1425892562
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 416E068024D;
	Mon,  9 Mar 2015 05:16:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqq61aeymlv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265138>

Junio C Hamano venit, vidit, dixit 06.03.2015 20:03:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> "git status" and "git branch" let the user know when the HEAD is
>> detached, as well as the current branch, while "git log --decorate" does not.
>>
>> Change the decoration by a non-detached HEAD pointing to branch foo to
>> "HEAD->foo". This can be seen as giving more information about the
>> decoration item itself in the same way as we prefix tags by "tag: ".
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>
>> Notes:
>>     v2 decorates the HEAD pointing to master as "HEAD->master", a detached
>>     HEAD just as "HEAD". The "->" hopefully conveys the symlink nature - a
>>     "=" would be confusing.
>>     
>>     Somehow I still prefer "detached HEAD", dunno. Maybe in addition?
>>     
>>     Note that now a checked branch is listed twice, once as target of the
>>     HEAD, once as branch: They are two different refs and colored differently.
> 
> The pointee of HEAD would always be branch and will always appear on
> the output when you show HEAD->$name_of_that_branch; is it feasible
> to drop the duplicate, I wonder?

It's doable but not nice, because we cannot take the order in which refs
are processed for granted.

I also think that we shouldn't simply check whether branch foo is
checked out (when decorating with foo) - we need to know whether HEAD is
among the refs which are eligible for decoration. That caveat is also
true for the "always" above. (I don't think we allow decorating by a
subset of all refs right now, but it would be useful, and easy given the
for-each-ref machinery.)

Also, HEAD and foo are two different refs, so even if HEAD has the value
"foo", I think we should really show them both anyways.

Alternatively, we could decorate by (HEAD, *foo, master, tag: release)
if foo is checked out, just like branch does.


>>  log-tree.c                             | 8 +++++++-
>>  t/t4013/diff.log_--decorate=full_--all | 2 +-
>>  t/t4013/diff.log_--decorate_--all      | 2 +-
>>  t/t4207-log-decoration-colors.sh       | 2 +-
>>  4 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/log-tree.c b/log-tree.c
>> index 7f0890e..38862bb 100644
>> --- a/log-tree.c
>> +++ b/log-tree.c
>> @@ -118,8 +118,11 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
>>  		type = DECORATION_REF_TAG;
>>  	else if (!strcmp(refname, "refs/stash"))
>>  		type = DECORATION_REF_STASH;
>> -	else if (!strcmp(refname, "HEAD"))
>> +	else if (!strcmp(refname, "HEAD")) {
>> +		unsigned char junk_sha1[20];
>>  		type = DECORATION_REF_HEAD;
>> +		refname = resolve_ref_unsafe("HEAD", 0, junk_sha1, NULL);
>> +	}
>>  
>>  	if (!cb_data || *(int *)cb_data == DECORATE_SHORT_REFS)
>>  		refname = prettify_refname(refname);
>> @@ -198,6 +201,9 @@ void format_decorations_extended(struct strbuf *sb,
>>  		strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
>>  		if (decoration->type == DECORATION_REF_TAG)
>>  			strbuf_addstr(sb, "tag: ");
>> +		else if (decoration->type == DECORATION_REF_HEAD &&
>> +			 strcmp(decoration->name, "HEAD"))
>> +			strbuf_addstr(sb, "HEAD->");
>>  		strbuf_addstr(sb, decoration->name);
>>  		strbuf_addstr(sb, color_reset);
>>  		prefix = separator;
>> diff --git a/t/t4013/diff.log_--decorate=full_--all b/t/t4013/diff.log_--decorate=full_--all
>> index 44d4525..3758ae9 100644
>> --- a/t/t4013/diff.log_--decorate=full_--all
>> +++ b/t/t4013/diff.log_--decorate=full_--all
>> @@ -5,7 +5,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
>>  
>>      Rearranged lines in dir/sub
>>  
>> -commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD, refs/heads/master)
>> +commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD->refs/heads/master, refs/heads/master)
>>  Merge: 9a6d494 c7a2ab9
>>  Author: A U Thor <author@example.com>
>>  Date:   Mon Jun 26 00:04:00 2006 +0000
>> diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
>> index 27d3eab..df702ae 100644
>> --- a/t/t4013/diff.log_--decorate_--all
>> +++ b/t/t4013/diff.log_--decorate_--all
>> @@ -5,7 +5,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
>>  
>>      Rearranged lines in dir/sub
>>  
>> -commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD, master)
>> +commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD->master, master)
>>  Merge: 9a6d494 c7a2ab9
>>  Author: A U Thor <author@example.com>
>>  Date:   Mon Jun 26 00:04:00 2006 +0000
>> diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
>> index 925f577..0437ff2 100755
>> --- a/t/t4207-log-decoration-colors.sh
>> +++ b/t/t4207-log-decoration-colors.sh
>> @@ -44,7 +44,7 @@ test_expect_success setup '
>>  '
>>  
>>  cat >expected <<EOF
>> -${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_HEAD}HEAD${c_reset}${c_commit},\
>> +${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_HEAD}HEAD->master${c_reset}${c_commit},\
>>   ${c_tag}tag: v1.0${c_reset}${c_commit},\
>>   ${c_tag}tag: B${c_reset}${c_commit},\
>>   ${c_branch}master${c_reset}${c_commit})${c_reset} B
