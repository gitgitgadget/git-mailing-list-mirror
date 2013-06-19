From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH] peel_onion(): add support for <rev>^{tag}
Date: Wed, 19 Jun 2013 16:08:49 -0400
Message-ID: <51C20FD1.4090203@bbn.com>
References: <1371605946-32565-1-git-send-email-rhansen@bbn.com> <7vvc5aymhd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 22:09:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpOgc-0005Ux-7J
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 22:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935108Ab3FSUIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 16:08:54 -0400
Received: from smtp.bbn.com ([128.33.1.81]:62925 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934978Ab3FSUIx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 16:08:53 -0400
Received: from socket.bbn.com ([192.1.120.102]:39126)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1UpOgU-000Pzz-46; Wed, 19 Jun 2013 16:08:50 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id DCAA940665
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7vvc5aymhd.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228421>

On 2013-06-19 14:38, Junio C Hamano wrote:
> Richard Hansen <rhansen@bbn.com> writes:
> 
>> gitrevisions(7) implies that <rev>^{tag} should work,...
> 
> Does it?  Is it possible that that should be fixed?

Depends on whether you think ^{tag} is a useful feature or not; see below.

> 
> What does it even _mean_ to peel something to a TAG?

It's the same as peeling something to any other object type:  If the
object is that type, done.  Otherwise dereference and try again.  If it
can't be dereferenced, barf.

> 
> A commit, a tree or a blob cannot be peeled to a tag---none of them
> can contain a tag.

Right, so all of those would barf.

> 
> When you have a tag that points at something else, what you have is
> already a tag, so <that-tag>^{tag} would be <that-tag> itself.

Exactly, just like <object>^{object} is <object> itself.

> 
> Even more confusingly, when you have a tag that points at another
> tag, what does <that-outer-tag>^{tag} mean?  The outer tag itself,
> or do you need to peel at least once to reveal the inner-tag?  What
> if that inner-tag points at yet another tag?
> 
> The patch does not touch peel_to_type(), so your answer to the above
> question seems to be "if T is already a tag, T^{tag} is T itself",
> but then that operation does not look all that useful.

Barfing on non-tags is the feature this adds.  It's otherwise useless,
just like <object>^{object} is useless except to barf when <object>
doesn't exist.

It's a sometimes-convenient way to assert that an object specifier
refers to a tag object and not something else.  For example, instead of:

   fatal() { printf %s\\n "ERROR: $*" >&2; exit 1; }

   type=$(git cat-file -t "$1") || fatal "$1 is not a valid object"
   [ "${type}" = tag ] || fatal "$1 is not a tag object"
   use "$1" here

you can do:

   use "$1"^{tag} here

-Richard


> 
> Confused...
> 
>> diff --git a/sha1_name.c b/sha1_name.c
>> index 90419ef..68fd0e4 100644
>> --- a/sha1_name.c
>> +++ b/sha1_name.c
>> @@ -677,6 +677,8 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
>>  	sp++; /* beginning of type name, or closing brace for empty */
>>  	if (!strncmp(commit_type, sp, 6) && sp[6] == '}')
>>  		expected_type = OBJ_COMMIT;
>> +	else if (!strncmp(tag_type, sp, 3) && sp[3] == '}')
>> +		expected_type = OBJ_TAG;
>>  	else if (!strncmp(tree_type, sp, 4) && sp[4] == '}')
>>  		expected_type = OBJ_TREE;
>>  	else if (!strncmp(blob_type, sp, 4) && sp[4] == '}')
> 
