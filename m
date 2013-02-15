From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/5] gpg-interface: check good signature in a reliable
 way
Date: Fri, 15 Feb 2013 09:27:32 +0100
Message-ID: <511DF174.4090301@drmicha.warpmail.net>
References: <CAJ9Ak2pLqUesOWKNtjwG7P_BW7-EqJP4Kaj0FF_+72Wn=oGoew@mail.gmail.com> <e0f3c48e474c64e33c67c772468bbf7bba0169af.1360857415.git.git@drmicha.warpmail.net> <7vzjz624kj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Mariusz Gronczewski <xani666@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 09:27:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6GeB-0002GD-4y
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 09:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894Ab3BOI1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 03:27:32 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58883 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752463Ab3BOI1b (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Feb 2013 03:27:31 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id DDD28208DB;
	Fri, 15 Feb 2013 03:27:30 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 15 Feb 2013 03:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=FWJEqqroYS60Z5Wo/7wFcS
	sNua8=; b=btjJiLpUwkm49+1tORTjgFyZhch3oJ4CMU0S/vEoFF5+T1c4Tl9Gnz
	hL+NLb9VBhx8/zdZceAicsLjPsDHuBUceDx14FcpC4/EOOmKvOVCtNTfppbBJ3Z4
	Rz6Co0S9r+YL9Jylg7CStKscBdEMdKWz4j2Fk95+ev2osUJi8XWdI=
X-Sasl-enc: kir2AQg8sQKA6Brbm13Z0Zj+bA0jMbrhMFQYLrUePuar 1360916850
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 471914825FD;
	Fri, 15 Feb 2013 03:27:30 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <7vzjz624kj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216343>

Junio C Hamano venit, vidit, dixit 14.02.2013 18:22:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Currently, verify_signed_buffer() only checks the return code of gpg,
>> and some callers implement additional unreliable checks for "Good
>> signature" in the gpg output meant for the user.
>>
>> Use the status output instead and parse for a line beinning with
>> "[GNUPG:] GOODSIG ". This is the only reliable way of checking for a
>> good gpg signature.
>>
>> If needed we can change this easily to "[GNUPG:] VALIDSIG " if we want
>> to take into account the trust model.
> 
> Thanks.  I didn't look beyond "man gpg" nor bother looking at
> DETAILS file in its source, which the manpage refers to.
> 
> I think GOODSIG is a good starting point.  Depending on the context
> (e.g. "%G?") we may also want to consider EXPSIG (but not EXPKEYSIG
> or REVKEYSIG) acceptable, while reading "log --show-signature" on
> ancient part of the history, no?

Yes, we could certainly return a more detailed status to the callers.
Currently, "0" is OK (GOODSIG) and everything else is a fail. We would
need to change the callers to allow more details on the "fail" as well
as the "OK" so that they can decide what is good enough, say:

-1: fail for technical reasons (no sig, can't run gpg etc.)
0: sig present bad (cryptographically) BAD
1: REVKEYSIG
2: EXPKEYSIG
3: EXPSIG
4: GOODSIG
5: VALIDSIG

I'd have to recheck whether a bitmask or ordered values make more sense.

>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  gpg-interface.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/gpg-interface.c b/gpg-interface.c
>> index 4559033..c582b2e 100644
>> --- a/gpg-interface.c
>> +++ b/gpg-interface.c
>> @@ -96,15 +96,17 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
>>  /*
>>   * Run "gpg" to see if the payload matches the detached signature.
>>   * gpg_output, when set, receives the diagnostic output from GPG.
>> + * gpg_status, when set, receives the status output from GPG.
>>   */
>>  int verify_signed_buffer(const char *payload, size_t payload_size,
>>  			 const char *signature, size_t signature_size,
>>  			 struct strbuf *gpg_output)
>>  {
>>  	struct child_process gpg;
>> -	const char *args_gpg[] = {NULL, "--verify", "FILE", "-", NULL};
>> +	const char *args_gpg[] = {NULL, "--status-fd=1", "--verify", "FILE", "-", NULL};
>>  	char path[PATH_MAX];
>>  	int fd, ret;
>> +	struct strbuf buf = STRBUF_INIT;
>>  
>>  	args_gpg[0] = gpg_program;
>>  	fd = git_mkstemp(path, PATH_MAX, ".git_vtag_tmpXXXXXX");
>> @@ -119,9 +121,10 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
>>  	memset(&gpg, 0, sizeof(gpg));
>>  	gpg.argv = args_gpg;
>>  	gpg.in = -1;
>> +	gpg.out = -1;
>>  	if (gpg_output)
>>  		gpg.err = -1;
>> -	args_gpg[2] = path;
>> +	args_gpg[3] = path;
>>  	if (start_command(&gpg)) {
>>  		unlink(path);
>>  		return error(_("could not run gpg."));
>> @@ -134,9 +137,15 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
>>  		strbuf_read(gpg_output, gpg.err, 0);
>>  		close(gpg.err);
>>  	}
>> +	strbuf_read(&buf, gpg.out, 0);
>> +	close(gpg.out);
>> +
>>  	ret = finish_command(&gpg);
>>  
>>  	unlink_or_warn(path);
>>  
>> +	ret |= !strstr(buf.buf, "\n[GNUPG:] GOODSIG ");
>> +	strbuf_release(&buf);
>> +
>>  	return ret;
>>  }
