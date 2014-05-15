From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 02/44] refs.c: allow passing NULL to
 ref_transaction_free
Date: Thu, 15 May 2014 11:15:12 -0700
Message-ID: <20140515181512.GC26471@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-3-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 20:15:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl0Bf-0005FD-8g
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 20:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678AbaEOSPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 14:15:16 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:44658 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480AbaEOSPP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 14:15:15 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so1414922pbb.22
        for <git@vger.kernel.org>; Thu, 15 May 2014 11:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Jtmx3zZ+5VjnOsP5ixBf59lbFFk0Fa8IvtIMWyGzdog=;
        b=y6s8sMjSoa4PaoI/RNmINEprbtRZDChdc4B9jhZvNxiHm39QaXDbYyI+JxqQO6e1ie
         cOz4K/JPq9Yt4xR6onNOqTBD+jXDXg0IZAj2oN0xl/ppL8MMz/ZOYkthI4ri45jK9YOH
         mNqHw2nwQMEV7gpm1zbUmjS5hxizf8VbbpMPLloio6PEBX9BWEPYmrwexRvamHW8rt3V
         9p+AgwVU5DRVXs800/nAfwuD1eeC7gnTzCGxPKZjLztP2GWD8HhDhWmASVLZkfI6XALD
         MurwlcogmWmDx+VuBBZTINLWIni7Xlh83/tdDh+KUMcc6JV83XEbBxdAlqiaghRozwG5
         +GCg==
X-Received: by 10.66.254.198 with SMTP id ak6mr4990987pad.156.1400177714684;
        Thu, 15 May 2014 11:15:14 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ir10sm10261843pbc.59.2014.05.15.11.15.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 11:15:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-3-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249175>

Ronnie Sahlberg wrote:

> Allow ref_transaction_free to be called with NULL and as a result allow
> ref_transaction_rollback to be called for a NULL transaction.
>
> This allows us to write code that will
>   if ( (!transaction ||
>         ref_transaction_update(...))  ||
>       (ref_transaction_commit(...) && !(transaction = NULL)) {
>           ref_transaction_rollback(transaction);
>           ...
>   }
>
> In this case transaction is reset to NULL IFF ref_transaction_commit() was
> invoked and thus the rollback becomes ref_transaction_rollback(NULL) which
> is safe. IF the conditional triggered prior to ref_transaction_commit()
> then transaction is untouched and then ref_transaction_rollback(transaction)
> will rollback the failed transaction.

I still think these last two paragraphs confuse more than enlighten
here.  There's plenty of time to explain them in the patch that uses
that code.

I'd just say something like

	Allow ref_transaction_free(NULL) and hence ref_transaction_rollback(NULL)
	as no-ops.

	This makes ref_transaction_rollback easier to use and more similar to
	plain 'free'.

And maybe:

	In particular, it lets us rollback unconditionally as part of cleanup
	code after setting 'transaction = NULL' if a transaction has been
	committed or rolled back already.

Thanks,
Jonathan
