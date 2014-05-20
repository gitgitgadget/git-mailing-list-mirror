From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 25/44] receive-pack.c: use a reference transaction for
 updating the refs
Date: Tue, 20 May 2014 12:42:46 -0700
Message-ID: <20140520194246.GR12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-26-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue May 20 21:42:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmpw6-0007Wg-QI
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 21:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbaETTmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 15:42:50 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:57209 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbaETTmu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 15:42:50 -0400
Received: by mail-pa0-f42.google.com with SMTP id rd3so626008pab.29
        for <git@vger.kernel.org>; Tue, 20 May 2014 12:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mVCsbtHAoUJLHHzDhmbn74XWnVQD/QkPCfmbgSuAirg=;
        b=ewdI9lSxkezODTkTNSImlKNNxj+qSDOT/Xn59z77noAgXmXWxjePNBGsStFKvlP7mY
         bITRYE9Vs2jyG2OWzrd8cUcc+vAZyGWUreb87+emj55z1Svtfy/SUZ65mliX2v69kHSi
         a428BSr82dpnjuh7oUw7+Xz1zPQsKQwxAQ8m5ey6Xz0Hg5geexqqT6yJ9cPCI0vk3JZe
         hsR69S7Aya+iXwTndgpnpKbfPhiVZvkeiTY1SJEPzRN5Kn9zMVeMSF1MLk2AQBKloL/H
         UsIYSHKGPfEfoDNl1und9+kHyTGQukqZdjcrSZrstdccQDLjUqOm2TENiM0nAVoTvOEK
         M3Cw==
X-Received: by 10.66.66.135 with SMTP id f7mr53524185pat.22.1400614969604;
        Tue, 20 May 2014 12:42:49 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id iv2sm4477622pbc.19.2014.05.20.12.42.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 12:42:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-26-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249737>

Ronnie Sahlberg wrote:

> Wrap all the ref updates inside a transaction to make the update atomic.

Interesting.

[...]
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -46,6 +46,8 @@ static void *head_name_to_free;
>  static int sent_capabilities;
>  static int shallow_update;
>  static const char *alt_shallow_file;
> +static struct strbuf err = STRBUF_INIT;

I think it would be cleaner for err to be local.  It isn't used for
communication between functions.

[...]
> @@ -580,15 +581,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>  		    update_shallow_ref(cmd, si))
>  			return "shallow error";
>  
> -		lock = lock_any_ref_for_update(namespaced_name, old_sha1,
> -					       0, NULL);
> -		if (!lock) {
> -			rp_error("failed to lock %s", name);
> -			return "failed to lock";
> -		}
> -		if (write_ref_sha1(lock, new_sha1, "push")) {
> -			return "failed to write"; /* error() already called */
> -		}
> +		if (ref_transaction_update(transaction, namespaced_name,
> +					   new_sha1, old_sha1, 0, 1, &err))
> +			return "failed to update";

The original used rp_error to send an error message immediately via
sideband.  This drops that --- intended?

The old error string shown on the push status line was was "failed to
lock" or "failed to write" which makes it clear that the cause is
contention or database problems or filesystem problems, respectively.
After this change it would say "failed to update" which is about as
clear as "failed".

Would it be safe to send err.buf as-is over the wire, or does it
contain information or formatting that wouldn't be suitable for the
client?  (I haven't thought this through completely yet.)  Is there
some easy way to distinguish between failure to lock and failure to
write?  Or is there some one-size-fits-all error for this case?

When the transaction fails, we need to make sure that all ref updates
emit 'ng' and not 'ok' in receive-pack.c::report (see the example at
the end of Documentation/technical/pack-protocol.txt for what this
means).  What error string should they use?  Is there some way to make
it clear to the user which ref was the culprit?

What should happen when checks outside the ref transaction system
cause a ref update to fail?  I'm thinking of

 * per-ref 'update' hook (see githooks(5))
 * fast-forward check
 * ref creation/deletion checks
 * attempt to push to the currently checked out branch

I think the natural thing to do would be to put each ref update in its
own transaction to start so the semantics do not change right away.
If there are obvious answers to all these questions, then a separate
patch could combine all these into a single transaction; or if there
are no obvious answers, we could make the single-transaction-per-push
semantics optional (using a configuration variable or protocol
capability or something) to make it possible to experiment.

Hope that helps,
Jonathan
