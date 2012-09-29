From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 7/8] longest_ancestor_length(): resolve symlinks before
 comparing paths
Date: Sat, 29 Sep 2012 07:46:30 +0200
Message-ID: <50668B36.8020708@alum.mit.edu>
References: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu> <1348688090-13648-8-git-send-email-mhagger@alum.mit.edu> <7vipaznkom.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 07:46:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THpsz-0006jn-MS
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 07:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613Ab2I2Fqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 01:46:35 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:44597 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750792Ab2I2Fqe (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Sep 2012 01:46:34 -0400
X-AuditID: 12074414-b7f846d0000008b8-f9-50668b3943bb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id B4.E3.02232.93B86605; Sat, 29 Sep 2012 01:46:33 -0400 (EDT)
Received: from [192.168.69.140] (p57A246BE.dip.t-dialin.net [87.162.70.190])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8T5kV7V025153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 29 Sep 2012 01:46:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vipaznkom.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqGvZnRZgcH6fgEXXlW4mi4beK8wW
	R09ZWKx/d5XZgcVj56y77B4XLyl7fN4kF8AcxW2TlFhSFpyZnqdvl8CdsfmlS0GDZMWFi5cZ
	GxhninQxcnJICJhIrHz8ignCFpO4cG89WxcjF4eQwGVGiQl757NDOGeYJGbdewlWxSugLbFr
	6W8WEJtFQFWi5fhVNhCbTUBXYlFPM1iNqECIxIzLk5kh6gUlTs58AlYvIqAmMbHtEJjNLJAp
	0fLlHVivsECsxMWFl1ghli1nlJg+5wrQZg4OTgEziVOLZCHqdSTe9T1ghrDlJba/ncM8gVFg
	FpIVs5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRroVebmaJXmpK6SZGSAiL7GA8
	clLuEKMAB6MSD6/W8dQAIdbEsuLK3EOMkhxMSqK8fe1pAUJ8SfkplRmJxRnxRaU5qcWHGCU4
	mJVEeDOKgcp5UxIrq1KL8mFS0hwsSuK83xar+wkJpCeWpGanphakFsFkZTg4lCR453QBDRUs
	Sk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHRWp8MTBWQVI8QHsLQdp5iwsSc4GiEK2n
	GHU51t5d8IBRiCUvPy9VSpy3F6RIAKQoozQPbgUsYb1iFAf6WJi3HqSKB5js4Ca9AlrCBLRk
	6aYkkCUliQgpqQbGiBlnDkrqpIq0sxzOVVH7YZPOEHta+sYOj8ufWcMD6466VGlMEzuobXBW
	0+5Bv0gMW0acpumF/0u02h9neV37/VQtr/B5b4yEgvaqH3NXOxbsFWZYeF7Srn5V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206630>

On 09/28/2012 12:51 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> longest_ancestor_length() relies on a textual comparison of directory
>> parts to find the part of path that overlaps with one of the paths in
>> prefix_list.  But this doesn't work if any of the prefixes involves a
>> symbolic link, because the directories will look different even though
>> they might logically refer to the same directory.  So canonicalize the
>> paths listed in prefix_list using real_path_if_valid() before trying
>> to find matches.
>>
>> path is already in canonical form, so doesn't need to be canonicalized
>> again.
>>
>> This fixes some problems with using GIT_CEILING_DIRECTORIES that
>> contains paths involving symlinks, including t4035 if run with --root
>> set to a path involving symlinks.
>>
>> Remove a number of tests of longest_ancestor_length().  It is awkward
>> to test longest_ancestor_length() now, because its new path
>> normalization behavior depends on the contents of the whole
>> filesystem.  But we can live without the tests, because
>> longest_ancestor_length() is now built of reusable components that are
>> themselves tested separately: string_list_split(),
>> string_list_longest_prefix(), and real_path_if_valid().
> 
> Errr, components may be correct but the way to combine and construct
> could go faulty, so...

I don't see a realistic alternative.  Testing real_path() is itself is
already quite awkward (see t0060), so testing longest_ancestor_length()
would be even more so.  Of course, the GIT_CEILING_DIRECTORIES tests
indirectly test longest_ancestor_length(), though not systematically.

If you have a better suggestion, please let me know.

>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  path.c                | 17 ++++++++------
>>  t/t0060-path-utils.sh | 64 ---------------------------------------------------
>>  2 files changed, 10 insertions(+), 71 deletions(-)
>>
>> diff --git a/path.c b/path.c
>> index 5cace83..981bb06 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -570,22 +570,25 @@ int normalize_path_copy(char *dst, const char *src)
>>  
>>  static int normalize_path_callback(struct string_list_item *item, void *cb_data)
>>  {
>> -	char buf[PATH_MAX+2];
>> +	char *buf;
>>  	const char *ceil = item->string;
>> -	int len = strlen(ceil);
>> +	const char *realpath;
>> +	int len;
>>  
>> -	if (len == 0 || len > PATH_MAX || !is_absolute_path(ceil))
>> +	if (!*ceil || !is_absolute_path(ceil))
>>  		return 0;
>> -	memcpy(buf, ceil, len+1);
>> -	if (normalize_path_copy(buf, buf) < 0)
>> +	realpath = real_path_if_valid(ceil);
>> +	if (!realpath)
>>  		return 0;
>> -	len = strlen(buf);
>> +	len = strlen(realpath);
>> +	buf = xmalloc(len + 2); /* Leave space for possible trailing slash */
>> +	strcpy(buf, realpath);
>>  	if (len == 0 || buf[len-1] != '/') {
>>  		buf[len++] = '/';
>>  		buf[len++] = '\0';
>>  	}
> 
> Nice.

I just noticed that the second "len++" in the final "if" is misleading.
 I will fix that in v2.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
