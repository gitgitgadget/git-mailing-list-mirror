From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH/RFC] branch.c: Replace `git_config` with `git_config_get_string`
Date: Mon, 16 Jun 2014 10:49:19 -0700
Message-ID: <539F2E1F.7010604@gmail.com>
References: <1402908750-24851-1-git-send-email-tanayabh@gmail.com> <vpqfvj4226o.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 16 19:49:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwb2E-0002Kt-EF
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 19:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbaFPRt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 13:49:26 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:37967 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbaFPRtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 13:49:25 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so4733561pab.36
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 10:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KRWLOLe42Idj42pB+OkQRXB50axQDwR7Jb9s8a5jOpk=;
        b=gebjbf0FuFHOoCXHw4OiL5b5tyHdcwPsogD+crCaHqpSXoYEKykZ5UWf8ggs3zqd21
         Z3R3p45/KJY+kCfZFGINUrnE+4GeN8A5YjKRKYefDW6LI9vLk6J8o6irjNG6/QdvAuQR
         Ei/ubvMexZf0lslU7nnUpWXqdcvoSEjvuA47Z1IoS22EDFuMg76Kai0BU11DvblZIG2v
         IR0sTEo2WnaBQNCXBWopU8tZmWpRSsomyYZ5/HL6O8wEvjgU3aJVv/o/+mvOh1dlL6eX
         bLYsm2KS0aK8ppRJBapNf15o0VAtppnizXM3eIbJj+UXxIfOvSlp0Z487xnqDLOrms5t
         HUKQ==
X-Received: by 10.68.192.106 with SMTP id hf10mr26119542pbc.30.1402940964539;
        Mon, 16 Jun 2014 10:49:24 -0700 (PDT)
Received: from [192.168.52.163] ([117.254.222.96])
        by mx.google.com with ESMTPSA id be7sm72000004pad.9.2014.06.16.10.49.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 16 Jun 2014 10:49:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <vpqfvj4226o.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251740>

On 06/16/2014 10:29 AM, Matthieu Moy wrote:
>> Subject: Re: [PATCH/RFC] branch.c: Replace `git_config` with `git_config_get_string`
> 
> Here and elsewhere: usually, no capital after :.
> 

Noted.

> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> Original implementation uses a callback based approach which has some
>> deficiencies like a convoluted control flow and redundant variables.
> 
> "deficiencies" might be a bit strong (the code did work).
> 

Hehe, I did spell out what the "deficiencies" were, nevertheless will revise it in
next iteration.

>> There are total 111 calls in total in all of git codebase. How should I send
>> the patches, alphabetically or otherwise?
> 
> My advice would be: try as much as possible to split according to the
> complexity of the patch.
> 
> As a reviewer, I find it rather easy to review a large number of trivial
> and similar changes, but I hate having to switch back to "wow, the
> author did something tricky, let's try to understand this" in the middle
> of a trivial series.
> 
> (we had this discussion about `...` Vs $(...) and test -a Vs test ... &&
> series, which were essentially very trivial changes, but with subtle
> bugs introduced and hidden by the volume of trivial changes).
> 

Noted.

>>  branch.c | 25 +++++++++----------------
>>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> Removing more lines than it adds. I like the patch already ;-).
> 
>> diff --git a/branch.c b/branch.c
>> index 660097b..257b1bf 100644
>> --- a/branch.c
>> +++ b/branch.c
> [...]
>>  int read_branch_desc(struct strbuf *buf, const char *branch_name)
>>  {
>> -	struct branch_desc_cb cb;
>> +	const char *value;
>> +	struct branch_desc desc;
>>  	struct strbuf name = STRBUF_INIT;
>>  	strbuf_addf(&name, "branch.%s.description", branch_name);
>> -	cb.config_name = name.buf;
>> -	cb.value = NULL;
>> -	if (git_config(read_branch_desc_cb, &cb) < 0) {
>> +	desc.config_name = name.buf;
>> +	desc.value = NULL;
>> +	value = git_config_get_string(desc.config_name);
>> +	git_config_string(&desc.value, desc.config_name, value);
> 
> You're ignoring the return value of git_config_string, which is an error
> code. It shouldn't harm, because the code is non-zero iff desc.value is
> set to non-NULL, but you may want to write the code as
> 
> if (git_config_string(...)) {
> 	strbuf_release(...);
> 	return -1;
> }
> 
> In any case, the patch sounds good to me.
> 

Yes, for clarity sake, will rewrite the section like that.
Thanks for the review.
