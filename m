From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] don't write to git_log_output_encoding outside
 git_config()
Date: Thu, 02 Sep 2010 08:49:48 -0700
Message-ID: <7veidc2lib.fsf@alter.siamese.dyndns.org>
References: <vpqhbibbthi.fsf@bauges.imag.fr>
 <1283210123-19752-2-git-send-email-Matthieu.Moy@imag.fr>
 <vpq7hj4h6ba.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 02 17:52:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrC5A-000575-LV
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 17:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560Ab0IBPt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 11:49:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873Ab0IBPt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 11:49:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E4250D295D;
	Thu,  2 Sep 2010 11:49:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fcAdgj3i3P2kmGh/AreSB6nk/No=; b=iiJ8zj
	meBJRTcwzNodQ/qg42MTN3KsDJmcnMNLP3EVwMb0bYOlRNEYz/wTvI+WvQpFb91o
	LLPDdRntRbfnaZp4DBhjUdR9Nzt341dmK8nPgu2auRFBFufiSZAU20eB9WY1ETIj
	T0YBadNSQKJibd9vxWaJOo8pIgTjpnT3HdM0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KAP1fV/qrYHKaGt9aYl7fDIBtmqmcqhB
	EMUXyoLvoe5K1NLpwDPBlu6Jc3Cftf6GSg3hz/GMEQo64JK/rTmbw3MwUn5MpD/v
	tNRjlKM4kfpLYmnlcEAbFmoTtA5ZkjhCNU41ieh2AiaQ3BpGyAWu84dM8sDwHvUs
	pzrtFuo6PZE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C11A8D295B;
	Thu,  2 Sep 2010 11:49:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD3A4D295A; Thu,  2 Sep
 2010 11:49:50 -0400 (EDT)
In-Reply-To: <vpq7hj4h6ba.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Thu\, 02 Sep 2010 10\:56\:41 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BA69F004-B6A9-11DF-9D32-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155137>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I'm just raising attention on this patch. It didn't receive any
> comment and didn't find its way to pu.
>
> I think it makes the code more robust, and would prevent accidental
> bugs like the one I introduced patching the gitattributes patch, but
> it's not critical.

If we didn't have the fix to po/etc-gitattributes topic, the patch is
absolutely necessary as it stops bleeding.

Two points and a bit of discussion.

(1) The patch claims that the existing "have a variable in environment.c,
    with possibly hardcoded default, update that variable by reading
    config file at the startup, further override the same variable by
    reading the command line, and use the final result from the variable"
    pattern is fragile, _if_ configuration files can be re-read at random
    places outside the control of the main program.

    The above claim _is_ correct, but is it the existing pattern that is
    broken, or the uncontrolled reading of configuration file, that is the
    real culprit (iow, you said "X if Y" but if Y is false then what X
    claims does not matter)?

    I don't think we have a satisfactory answer to that question yet.

(2) If the answer to the question (1) is that the existing pattern is bad,
    I agree that a mechanism to protect the value that the main program
    decided to use (after taking environment.c default, config and its
    command line processing) _is_ necessary, and the patch shows one
    possible way to do so by replacing a single environment.c variable
    with a pair of variables and an accessor macro.

    (a) Is that the best solution to the problem, though?

    (b) Does the solution show us a pattern that is easy to follow to
        avoid the same problem with other environment.c variables?

One minor potential flaw I see is that while this solution can be applied
to a variable of a type with an obvious "unset" value (e.g. pointer with
NULL), we cannot use it for a variable of type "int" if it can truly take
any value, because get_git_frotz() macro needs to be able to check if
git_fortz_cli has that "unset" value in order to decide which one of the
variables to use.  My gut feeling is that it wouldn't matter in real-life
(most int-type knobs actually take uint values), but I didn't check.

I care about (2-b) more than anything else.  For example, we see
"git_commit_encoding" variable in cache.h in the context of your patch.
This particular patch does not have to (and I do not want it to) fix
potential problems with that or any other variable, but it would be nice
if the patch shows us an obvious and uniform way to apply the same fix
when/if it becomes necessary.  IOW, we would want to make sure that this
is a generic enough solution, not an ad-hoc workaround.

Is there something we can do to make it easier to apply to other cases?
Perhaps something along the lines of...

    #define git_declare_var_pair(type, name, unset) \
    extern type name; \
    extern type name ## _cli; \
    static inline type get_ ## name (void) { \
    	return (name ## _cli != (unset)) \
        	? name ## _cli \
                : name; \
    }

    git_declare_var_pair(const char *, git_log_output_encoding, NULL)

Or is it a way-premature generalization?

By the way, do we have a case where the main codepath reads an environment
variable and updates a variable in environment.c to be used with that
value?  Then the existing "fragile" pattern for that case may look like:

    - there is a variable with default value in environment.c;
    - it is overwritten by reading configuration file;
    - it is further overwritten by reading environ[];
    - it is further overwritten by reading argv[];
    - and then it is used.

Does the solution presented by this patch show us a pattern that is
applicable to such a case as well?

>> diff --git a/cache.h b/cache.h
>> index eb77e1d..7e10a39 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1005,7 +1005,25 @@ extern int user_ident_explicitly_given;
>>  extern int user_ident_sufficiently_given(void);
>>  
>>  extern const char *git_commit_encoding;
>> +
>> +/* Value found in config file */
>>  extern const char *git_log_output_encoding;
>> +
>> +/* Value given in command line with --encoding */
>> +extern const char *git_log_output_encoding_cli;
>> +
>> +/* 
>> + * Prioritize the value given by the command-line over the value found
>> + * in the config file.
>> + */
>> +static inline
>> +const char *get_git_log_output_encoding()
>> +{
>> +	return git_log_output_encoding_cli ?
>> +		git_log_output_encoding_cli :
>> +		git_log_output_encoding;
>> +}
>> +
>>  extern const char *git_mailmap_file;
