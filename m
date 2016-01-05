From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 11/16] refs: move duplicate check to common code
Date: Tue, 05 Jan 2016 11:42:09 -0500
Organization: Twitter
Message-ID: <1452012129.3892.32.camel@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	 <1449102921-7707-12-git-send-email-dturner@twopensource.com>
	 <567A3EB6.9000405@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 17:43:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGUhI-0002Ba-Np
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 17:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbcAEQmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 11:42:54 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36530 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbcAEQmM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 11:42:12 -0500
Received: by mail-qg0-f54.google.com with SMTP id e32so192034185qgf.3
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 08:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=R73GxXV68Uqou22wDA/aISqiQOx2e4VGGZciMVpg1EI=;
        b=o3zaChq6uPFRYpnaFxzPviY5z8tGUBvBaCjSHG5UCZG220IlkCvFz0HJ0AL6FZFT1W
         VfaLVN1VsvC/Hn0/SIQcqZRswasNvWV0znsF36K6Fi3AIrQba72G2ZTvPI44Q0CFvI9o
         T55Y0HYJ4+ukK19fODhZZ025cVOfN4pjO+M0KOMUlH4y0ftAXFfCsH3wDzmTAMHUzyG8
         +k90W1amX0mkkTt5d+RtLyqsINgEu/ECLdhuj8iUD40veofvI3RBSrlL8AL4voH5VmkG
         3TyXw4ixqQQXyPqmQJ4h5fEbbqrctza1zWh8KUcobqfoT5VD7QQTI/jp59VlqHCIGAxw
         l7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=R73GxXV68Uqou22wDA/aISqiQOx2e4VGGZciMVpg1EI=;
        b=Li+vu7SWuTsMlDQsPEIp3qDR/UseRWQhKhXGzBZDFKmbwTKJAU9VlwLOEU6E0afvTp
         tcy5bETLJWtWrEs+PLa4woRFPc4rq7KeVVw8XwrosGTXpODx+U0zNgtOlZ1fs4qYBkLR
         /DSLXBJ5gMdGQkv2nKqaCgyb4n/O4rhCRGPjR/Ywyk+WM4oZ0i9FrPIXQWbzpEKV+oDF
         UAC5VTz4lFzt4y6urex5J+tmjHW+qUqFRdikB+6D7FoO7ADp8VULqJZ2FDTbDsatqU3N
         TZ/1BNuu95lSTsGe8hJrftf79nGCvcY0Iu3hdkC9A4hWAUPzyPwOVv95uQCTZyme5JLa
         f0Lg==
X-Gm-Message-State: ALoCoQlebKw39eoaLBJ2c2qcheaBqrpTaakGu8BvpPG4Dei2Zozj9vAr2lel70gtfgNp4QQcelr7EC+IvDevm8M189nXCNJUJA==
X-Received: by 10.140.42.139 with SMTP id c11mr61577912qga.5.1452012131107;
        Tue, 05 Jan 2016 08:42:11 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f7sm42100092qhf.7.2016.01.05.08.42.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jan 2016 08:42:10 -0800 (PST)
In-Reply-To: <567A3EB6.9000405@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283385>

On Wed, 2015-12-23 at 07:27 +0100, Michael Haggerty wrote:
> > +static int ref_update_reject_duplicates(struct ref_transaction
> > *transaction,
> > +					struct string_list
> > *refnames,
> > +					struct strbuf *err)
> 
> I like that you extract this code into a function. Though it feels
> awkward to have a function called "ref_update_reject_duplicates()"
> that
> has a side effect of filling the names into a string list. I think it
> would feel more natural to call the function get_affected_refnames(),
> and treat the duplicate check as an extra bonus.


Renamed, thanks.

> >  int ref_transaction_commit(struct ref_transaction *transaction,
> >  			   struct strbuf *err)
> >  {
> > -	return the_refs_backend->transaction_commit(transaction,
> > err);
> > +	int ret = -1;
> > +	struct string_list affected_refnames =
> > STRING_LIST_INIT_NODUP;
> > +
> > +	assert(err);
> > +
> > +	if (transaction->state != REF_TRANSACTION_OPEN)
> > +		die("BUG: commit called for transaction that is
> > not open");
> > +
> > +	if (!transaction->nr) {
> > +		transaction->state = REF_TRANSACTION_CLOSED;
> > +		return 0;
> > +	}
> > +
> > +	if (ref_update_reject_duplicates(transaction,
> > &affected_refnames, err)) {
> > +		ret = TRANSACTION_GENERIC_ERROR;
> > +		goto done;
> > +	}
> > +
> > +	ret = the_refs_backend->transaction_commit(transaction,
> > +						  
> >  &affected_refnames, err);
> > +done:
> > +	string_list_clear(&affected_refnames, 0);
> > +	return ret;
> >  }
> 
> Here you are avoiding a small amount of code duplication by calling
> ref_update_reject_duplicates() here rather than in the backend
> -specific
> code. But you are doing so at the cost of having to compute
> affected_refnames here and pass it (redundantly) to the backend's
> transaction_commit function. This increases the coupling between
> these
> functions, which in my opinion is worse than the small amount of code
> duplication. But maybe it's just me.

Hm.  I'm trying to follow the principle that the backends should do as
little as possible (and that the common code should do as much as
possible).  This reduces the cognitive load when writing new backends -
- a new backend author need not know that the list of ref updates must
be unique.

What do others think? 
