From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 00/44] Use ref transactions for all ref updates
Date: Thu, 22 May 2014 16:08:02 -0700
Message-ID: <20140522230802.GZ12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 23 01:13:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WncBK-000351-LX
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 01:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178AbaEVXIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 19:08:07 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:57748 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbaEVXIF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 19:08:05 -0400
Received: by mail-pa0-f48.google.com with SMTP id rd3so3141085pab.7
        for <git@vger.kernel.org>; Thu, 22 May 2014 16:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IdFsQD8RS4hXr0Ng/tGu5aK2ksw6aLMaz8w3t+JHYGQ=;
        b=KIEYVDEfUPFNavx32Jdr8+mP+9CyZN2LdaqJdw6/ckWOctOoJI9E+OE+AWudbaiKUg
         fODomraMFe9X47o3Qlx6RtUb9QCrFvIAvKp5DPnpeJ+wJz3cw3tpYudZbIQqTPsuH7MG
         3MKh5N/AvJXP6v7GeBeLjtji5y5Z/GusuSbK5Qrr5y6oiYA88760O1vh6k1XgeHX0/84
         4ZqeOmcSX3m/Dq4QE0kQWZkIligG/c0iF60b+5yAPM9Ofy/mLKRdGEVYyy0gSQxsr7DN
         As4TIn+Xc2ieQ4SyZPfN6xIPXtax2V2QsyXmSUi58a13CsiH5+neOuhwXX18UKKSh0NG
         jTQQ==
X-Received: by 10.68.220.137 with SMTP id pw9mr1129888pbc.24.1400800085037;
        Thu, 22 May 2014 16:08:05 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id g6sm5075014pat.2.2014.05.22.16.08.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 16:08:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249959>

Ronnie Sahlberg wrote:

> This patch series can also be found at
> https://github.com/rsahlberg/git/tree/ref-transactions

Continuing with the review of 65a1cb7b (2014-05-22 12:08):

 11/40 change ref_transaction_update() to do error checking and return status
 The "there will be in the future" sounds ominous.  Do you have an
 example in mind?  E.g., I suppose it would be nice if _update could
 notice D/F conflicts or connection to a database server closing early,
 but it's not clear to me whether the kind of errors you're talking
 about are that or something else.

 With or without such a clarification,
 Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

 12/40 change ref_transaction_create to do error checking and return status
 What does "On failure the err buffer will be updated" mean?  Will
 it clear err and replace it with a message, append to err, or
 something else?  Does the message explain the context or is the
 caller responsible for adding to it?  Does the message end with a
 newline or is the caller responsible for adding one when printing it
 out?

 For cases like this where lots of functions have a similar API,
 API comments start to become potentially repetitive.  It might be
 better to explain conventions at the top of the file or in
 Documentation/technical/api-refs.txt and say "See the top of the
 file for error handling conventions" or "Returns non-zero and
 appends a message to err on error.  See
 Documentation/technical/api-refs.txt for more details on error
 handling".

 13/40 ref_transaction_delete to check for error and return status
 Each successive commit dropped something from its subject. :)
 (First the (), then the verb.)

 Same comments as before about an example being useful for the
 log message and the API documentation on error handling being a
 bit vague.

 14/40 make ref_transaction_begin take an err argument
 I found the "failed to connect to mysql" example instructive while
 doing reviews.  Perhaps it would be worth mentioning in the commit
 message.

 Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

 15/40 add transaction.status and track OPEN/CLOSED/ERROR
 It says an ERRORed transaction cannot be committed and can be rolled
 back by calling _free.  Can a CLOSED transaction be committed or
 _freed?

 What does "faild" mean in the documentation comments?  (Maybe
 "non-OPEN"?)

 In the previous version of this patch passing a non-OPEN transaction
 would die("BUG: "...) to diagnose the caller's mistake.  Now I'm
 confused about the API: it seems you're allowed to pass a non-OPEN
 transaction but it doesn't append a message to 'err' in that case.
 Is this meant as a way to save the caller some typing, like
 fwrite/fclose do?  (I've found people often make mistakes with the
 fwrite API fwiw but can understand the appeal of it.)

 Maybe with more context I'd like this.  As is, it feels like a step
 in the wrong direction.

 16/40 tag: use ref transactions when doing updates
 Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

 17/40 replace: use ref transactions when doing updates
 Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

 18/40 commit: use ref transactions for updates
 Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
 
 19/40 sequencer: use ref transactions for all ref updates
 This would be a lot simpler if the "ref_transaction_commit should not
 free the transaction" patch came before it (yes, sorry, killing the
 fun).  I can push the result of a rebase doing that somewhere if you
 like.

 20/40 fast-import: change update_branch to use ref transactions
 Likewise.
