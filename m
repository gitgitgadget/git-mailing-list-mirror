From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 21/44] refs.c: ref_transaction_commit should not free
 the transaction
Date: Fri, 16 May 2014 08:02:23 -0700
Message-ID: <CAL=YDWkdjjMmVNcXHYr2CGsR4-eU0aHHR5Ek6JipL-Xhi=p7-w@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-22-git-send-email-sahlberg@google.com>
	<20140516002029.GB11011@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 17:02:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJeb-0001l5-7H
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 17:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbaEPPC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 11:02:28 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:62111 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756380AbaEPPCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 11:02:25 -0400
Received: by mail-vc0-f176.google.com with SMTP id lg15so6295030vcb.21
        for <git@vger.kernel.org>; Fri, 16 May 2014 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kaa9gHLyOadZ9UsrV9ANOstk0SDxrDIBi2R2D9jcuxU=;
        b=i6n26W2P7vZnzkQlQ2SVs7J0wSo/InCtNAROtDxeTKsMu5zW66RSA6eRCdetnhWkYH
         TLLaXwxxmAQ64uZWfcD/pdyZjOeyGi+/6peMkS2Bc+WmxP+pAtC2b3rnYGGm+ZdC71GS
         4Nl+xrLloJuZpoFfTOy/BpRpi3Ll7YA8WI81VvrGxyYIiw6LZ5dEHKLpRtScBE194nKV
         QlIExR4O8uXXj4EQPwDjfSu72J9OmQBWRwloDprc9+Ew5MAUDBRdXJrHigoIhB0ZeB70
         8J54LFCyrOUm1bKZg6x9BEI8G+3urTJy77XM/QoJp1mK+ndxH0nm4lr/soKucX35gDAD
         l2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=kaa9gHLyOadZ9UsrV9ANOstk0SDxrDIBi2R2D9jcuxU=;
        b=OdrEFuxaXCZwedO/8S7E74fGzig6sfvwrIxFETMmd1g4AW9FwEYNi8D7uOaE4RjFBH
         6LZnJ2IitUWK6RbgpDIZNQKx3t9mfC/OfRcbzJuyEb4K9bM5rpNkyvG2WEaZ75rB1/nr
         +zzlffwJgWApJa9rPFX3u0aOU3MprivfPhPVzOWOKA9XSkaMWojrDJbHw6Rl2YCNuuba
         /uxlOyAhDvfhsbJwkev+gQYjNa1aoW3sA9g8zeyhk2cw7UEZHcs0CfTGCSU+7lN4rAM5
         iqmeYSpFfhRKcf2iZ6khXTD+4Xq1te0aguuMM2kPeZ+sie8wzg0cIdDqJWWz5EVYGd+f
         QLHw==
X-Gm-Message-State: ALoCoQkMFR16Dh2j2c4EGpbJgUpf6NdcbaQGLPeOxCjTZGLR7KGcKKi0Ooh62WXZU9j2nMfs+xc/
X-Received: by 10.58.48.201 with SMTP id o9mr14308396ven.5.1400252543815; Fri,
 16 May 2014 08:02:23 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Fri, 16 May 2014 08:02:23 -0700 (PDT)
In-Reply-To: <20140516002029.GB11011@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249343>

On Thu, May 15, 2014 at 5:20 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Change ref_transaction_commit so that it does not free the transaction.
>> Instead require that a caller will end a transaction by either calling
>> ref_transaction_rollback or ref_transaction_free.
>
> Can I always use ref_transaction_rollback instead of ref_transaction_free?
> It would be convenient if my cleanup code could always call _rollback
> instead of having to do something different for success and errors.

Currently, yes.

But it might make sense to change these so rollback only clears the
updates that are in flight from the transaction and
free only frees the transaction itself iff there are no updates in flight.

I.e. the success and error would then differ like this :
...
   if (transaction_commit()) {
       transaction_rollback()
       transaction_free()
       return error("some error")
   }
   transaction_free()



>
> Another way to ask the question: what is it valid to do with a
> transaction after commiting?

Right now the only valid thing to do is either rollback or free. But
we could allow other things too :


re-usable transactions.
---------------------------------
I don't know if this is a good reason or not, but one reason we might
want to keep
two different names could be if we want to start allowing to re-use
transactions.
For example for cases/backends where transaction_begin() might be very
expensive.

For that case I would imagine we could allow to do things such as

t = transaction_begin()
...
/* first transaction */
transaction_update(...)
transaction_commit(...)
     if transaction failed   transaction_rollback(...)

/* second transaction,  first transaction cleared all updates in
flight either through commit or through rollback */
transaction_update()
transaction_commit()
     if transaction failed   transaction_rollback(...)
...
transaction_free()


(In order to do something like this we would still need to do some
changes so that rollback will only free the updates that were in
flight but not free the transaction itself.)


>
> Thanks,
> Jonathan
