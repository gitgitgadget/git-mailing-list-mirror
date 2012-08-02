From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [RFC/PATCH] apply: parse and act on --irreversible-delete output
Date: Thu, 2 Aug 2012 18:23:57 -0400
Message-ID: <501AFDFD.3010900@windriver.com>
References: <1343939748-12256-1-git-send-email-paul.gortmaker@windriver.com> <7vr4rpc7nz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:24:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx3oO-0002Hx-5G
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 00:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583Ab2HBWYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 18:24:04 -0400
Received: from mail.windriver.com ([147.11.1.11]:61122 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab2HBWYB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 18:24:01 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q72MNxCN016531
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 2 Aug 2012 15:23:59 -0700 (PDT)
Received: from [128.224.146.65] (128.224.146.65) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.2.309.2; Thu, 2 Aug 2012
 15:23:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <7vr4rpc7nz.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [128.224.146.65]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202806>

On 12-08-02 05:20 PM, Junio C Hamano wrote:
> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
> 
>> The '-D' or '--irreversible-delete' option of format-patch is
>> great for sending out patches to mailing lists, where there
>> is little value in seeing thousands of lines of deleted code.
>> Attention can then be focused on the changes relating to
>> the binding of the deleted code (Makefiles, etc).
>>
>> However the original intent of commit 467ddc14f ("git diff -D: omit
>> the preimage of deletes") was as follows:
>>
>>     To prevent such a patch from being applied by mistake, the
>>     output is designed not to be usable by "git apply" (or GNU "patch");
>>     it is strictly for human consumption.
>>
>> The downside of this, is that patches to mailing lists which are
>> then either managed with patchworks, or dealt with directly by
>> maintainers, will need manual intervention if they are to be used.
>>
>> But with the index lines, there is no reason why we can't act
>> intelligently and automatically on these with "git apply".
>> If we can unambiguously map what was recorded as the deleted
>> SHA prefix to the SHA of the matching blob filename in our tree,
>> then we set the image len to zero which facilitates the delete.
>>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> ---
>>
>> For a recent use case example, see:
>> 	http://www.spinics.net/lists/netdev/msg206519.html
>>
>> Could be wrapped in an "am.applyirreversible" if for some reason
>> global deployment was considered unwise?
>>
>>  Documentation/diff-options.txt |  5 +++--
>>  builtin/apply.c                | 30 ++++++++++++++++++++++++++++++
>>  2 files changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>> index cf4b216..efaaf1c 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -328,8 +328,9 @@ endif::git-log[]
>>  --irreversible-delete::
>>  	Omit the preimage for deletes, i.e. print only the header but not
>>  	the diff between the preimage and `/dev/null`. The resulting patch
>> -	is not meant to be applied with `patch` nor `git apply`; this is
>> -	solely for people who want to just concentrate on reviewing the
>> +	is not meant to be applied with `patch` (but can be with `git apply`).
> 
> ... but only when you are applying to the exact version the patch
> was created from, no?

True, I can add that extra detail/limitation to the docs.

> 
>> +	This is for people who want to avoid seeing/mailing all the deleted
>> +	file content, and instead just concentrate on reviewing the
>>  	text after the change. In addition, the output obviously lack
>>  	enough information to apply such a patch in reverse, even manually,
>>  	hence the name of the option.
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> index d453c83..363da63 100644
>> --- a/builtin/apply.c
>> +++ b/builtin/apply.c
>> @@ -2933,6 +2933,36 @@ static int apply_fragments(struct image *img, struct patch *patch)
>>  	if (patch->is_binary)
>>  		return apply_binary(img, patch);
>>  
>> +	/* output from --irreversible-delete (looks like empty file delete) */
>> +	if (patch->is_delete > 0 && !frag && img->len > 0) {
> 
> What is (img->len > 0) part trying to ensure?
> 
> If somebody gives you an irreversible deletion of an empty file,
> shouldn't this codepath handle it the same way?

The format-patch output of the deletion of an empty file is
identical with or without the switch, so I didn't want to
accidentally limit people from normal empty file deletions
by invoking special checks on them that did not exist before.

> 
>> +		unsigned char file_sha1[20], patch_sha1[20];
>> +		struct object_context oc;
>> +
>> +		if (apply_in_reverse) {
>> +			error(_("can not reverse an irreversible-delete patch"
>> +			      "on file '%s'."), name);
>> +			return -1;
>> +		}
> 
> The return value of error() is already -1, so you can just return
> it without { stmt; return -1; }.

OK, will update.  I'd inadvertently got the separate statements
by copying the code below it, which did a conditional return based
on what apply_with_reject was set to, but I'm not sure any special
reject behaviour for an irreversible delete fail makes sense.

> 
>> +
>> +		strcpy(oc.path, name);
>> +		if (get_sha1_with_context(patch->old_sha1_prefix,
>> +		    GET_SHA1_BLOB | GET_SHA1_QUIETLY, patch_sha1, &oc)) {
>> +			error(_("the deleted SHA prefix of file '%s' (%s), does"
>> +			      " not seem to exist in this repository."), name,
>> +			      patch->old_sha1_prefix);
>> +			return -1;
>> +		}
> 
> This is not sufficient to make sure patch_sha1 exists in your
> repository and is indeed a blob object.  GET_SHA1_BLOB is a hint to
> say "if there are more than one that shares this prefix, ignore ones
> that are not blob---if there is only one remains, then even though
> the prefix is ambiguous in this repository, we will take it".  If
> you only have a commit or a tree that has the prefix but not the
> blob object the patch wants to touch, you will get the object name
> of that commit or tree you have in your repository.
> 
> Also oc is an output parameter; it is not about "I want to make sure
> the found object is at this pathname"---that is an impossible request

Thanks for the clarification.  I didn't realize that.

> to begin with.  I think something like this, without oc, would be
> what you want:
> 
> 	if (get_sha1_with_context(patch->old_sha1_prefix,
>         		GET_SHA1_BLOB | GET_SHA1_QUIETLY,
>         		patch_sha1, NULL) ||
> 	    sha1_object_info(patch_sha1, NULL) != OBJ_BLOB)
> 		return error(...);
> 
> But I think the test itself (not the way you tested, but what you
> are trying to test---the uniqueness of abbrevited object name) is
> pointless.  The submitter of the patch may have far fewer objects
> than you do, and it is perfectly normal if the old_sha1_prefix that
> was sufficiently long to identify the blob for the submitter is not
> unambiguous enough to identify the blob uniquely for you when you
> try to apply the patch.  You may have other unrelated blobs that
> happen to share the prefix in your repository.
> 
> Hashing img->buf and making sure it matches old_sha1_prefix is the
> best you can do.  If the extra ambiguity coming from that approach
> bothers you, then the entire "force apply an --irreversible-delete
> patch" idea also should.

That makes sense to me.  So then it would look something like:

   hash_sha1_file(img->buf, img->len, blob_type, sha1);
   if (strncmp(sha1_to_hex(sha1), patch->old_sha1_prefix, strlen(patch->old_sha1_prefix))
	 return error(...)

if I understand you correctly?

Thanks for the prompt review.

Paul.
--

> 
>> +		hash_sha1_file(img->buf, img->len, blob_type, file_sha1);
>> +		if (memcmp(file_sha1, patch_sha1, 20)) {
>> +			error(_("the delete requested of '%s' (%s), does not"
>> +			      " match the current file contents."), name,
>> +			      sha1_to_hex(patch_sha1));
>> +			return -1;
> 
> return error(...);
> 
