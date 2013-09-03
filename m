From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH v2] peel_onion(): add support for <rev>^{tag}
Date: Tue, 03 Sep 2013 14:36:39 -0400
Message-ID: <52262C37.3030406@bbn.com>
References: <1378100551-892-1-git-send-email-rhansen@bbn.com> <20130903070546.GC3608@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 03 20:36:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGvT6-00089q-Sp
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 20:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076Ab3ICSgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 14:36:45 -0400
Received: from smtp.bbn.com ([128.33.0.80]:58206 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755725Ab3ICSgo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 14:36:44 -0400
Received: from socket.bbn.com ([192.1.120.102]:55386)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VGvSy-000G88-1J; Tue, 03 Sep 2013 14:36:40 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id BB7803FFDB
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <20130903070546.GC3608@sigill.intra.peff.net>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233756>

On 2013-09-03 03:05, Jeff King wrote:
> FWIW, this makes sense to me.

Thank you for the feedback.  I posted a reroll of the patch that you've
already replied to, but for the benefit of others searching the mailing
list archive, v3 can be found at
<http://thread.gmane.org/gmane.comp.version-control.git/233752>.

I have a patch submission question:  Is it OK that I didn't use the
'--in-reply-to' argument to 'git send-email' when I sent the v3 reroll?
 Should I have marked it as a reply to the v2 email?  Or should I have
marked it as a reply to your review of the v2 email?

> You can already accomplish the same thing
> by checking the output of $(git cat-file -t $name), but this is a
> natural extension of the other ^{} rules, and I can see making some
> callers more natural.

Exactly.  I updated the commit message to explain this so that other
people know why it might be a good feature to have.

> Can you please add a test (probably in t1511) that checks the behavior,
> similar to what you wrote in the commit message?

Done.  I see by your reply that my fear of going a bit overboard in the
test was justified.  :)  I don't mind rerolling if you'd prefer a
simpler test.

For future reference, is there a preference for putting tests of a new
feature in a separate commit?  In the same commit?  Doesn't really matter?

>> diff --git a/sha1_name.c b/sha1_name.c
>> index 65ad066..6dc496d 100644
>> --- a/sha1_name.c
>> +++ b/sha1_name.c
>> @@ -679,6 +679,8 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
>>  	sp++; /* beginning of type name, or closing brace for empty */
>>  	if (!strncmp(commit_type, sp, 6) && sp[6] == '}')
>>  		expected_type = OBJ_COMMIT;
>> +	else if (!strncmp(tag_type, sp, 3) && sp[3] == '}')
>> +		expected_type = OBJ_TAG;
> 
> This is not a problem you are introducing to this code, but the use of
> opaque constants like commit_type along with the magic number "6"
> assuming that it contains "commit" seems like a maintenance nightmare
> (the only thing saving us is that it will almost certainly never change
> from "commit"; but then why do we have the opaque type in the first
> place?).

I agree.  I didn't address this in the reroll.

> 
> I wonder if we could do better with:
> 
>   #define COMMIT_TYPE "commit"
>   ...
>   if (!strncmp(COMMIT_TYPE, sp, strlen(COMMIT_TYPE))
>       && sp[strlen(COMMIT_TYPE)] == '}')
> 
> Any compiler worth its salt will optimize the strlen on a string
> constant into a constant itself. The length makes it a bit less
> readable, though.

True, and I'm not a huge fan of macros.

> 
> I wonder if we could do even better with:
> 
>   const char *x;
>   ...
>   if ((x = skip_prefix(sp, commit_type)) && *x == '}')
> 
> which avoids the magic lengths altogether

Not bad, especially since skip_prefix() already exists.

> (though the compiler cannot
> optimize out the strlen call inside skip_prefix, because we declare
> commit_type and friends as an extern.  It probably doesn't matter in
> peel_onion, though, which should not generally be performance critical
> anyway).

Yeah, I can't see performance being a problem there.

There's also this awkward approach, which would avoid strlen() altogether:

commit.h:

    extern const char *commit_type;
    extern const size_t commit_type_len;

commit.c:

    const char commit_type_array[] = "commit";
    const char *commit_type = &commit_type_array[0];
    const size_t commit_type_len = sizeof(commit_type_array) - 1;

sha1_name.c peel_onion():

    if (!strncmp(commit_type, sp, commit_type_len)
        && sp[commit_type_len] == '}')

but I prefer your skip_prefix() suggestion.

-Richard
