From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 19/44] refs-be-files.c: add a backend method
 structure with transaction functions
Date: Tue, 13 Oct 2015 14:28:31 -0400
Organization: Twitter
Message-ID: <1444760911.7234.6.camel@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
	 <1444686725-27660-21-git-send-email-dturner@twopensource.com>
	 <561CB919.8000801@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 13 20:28:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm4JS-0005Hh-MG
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 20:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbbJMS2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 14:28:34 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36069 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbbJMS2d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 14:28:33 -0400
Received: by qgx61 with SMTP id 61so22434048qgx.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 11:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=xlX6pHX2kgaXpinLipKY6nuERzD8o5YV6CZLzwEiGw4=;
        b=GLqwUZejmGzKtQvkNOzPMpJhXkWFDlZgo0hr2dvbwpxISIni1JC5f/uMISwhrU2OPR
         Fdl+ulMo16WEc0yt6ez+NasubyNPC6Pq6sfRdB3mo2VyDhX7icALND6ZBWnuJn+gtsST
         3KSnl9r6V+RSVNtvP8CiiYlxpQVRsF8Ad/IFOpTkAmGrS5Hn0VehcVZ0MA222a+4CIad
         ZFxFxUQamGdPpWaqEDxIg8BwodYUOzHGaClO+oTHMG2MyFMMSzHvwDIdVzQqvuJIJY6j
         130s94kZSJ0ZHv7iV0tUf+t+3fyVcSLbadQCn+fEHtm7ZrbkePLkJrwTdLfRGDfc1XLe
         yXng==
X-Gm-Message-State: ALoCoQnXaSWr1ABtunfxvI9kODeauQWYh7OfMUNpLcaecHuKO3X2rai1swZycUrDkX1BqzeWjyBG
X-Received: by 10.140.40.139 with SMTP id x11mr41403359qgx.41.1444760913033;
        Tue, 13 Oct 2015 11:28:33 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id o39sm1680681qgd.48.2015.10.13.11.28.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2015 11:28:31 -0700 (PDT)
In-Reply-To: <561CB919.8000801@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279510>

On Tue, 2015-10-13 at 09:56 +0200, Michael Haggerty wrote:
> On 10/12/2015 11:51 PM, David Turner wrote:
> > From: Ronnie Sahlberg <sahlberg@google.com>
> > 
> > Add a ref structure for backend methods. Start by adding a method pointer
> > for the transaction commit function.
> > 
> > Add a function set_refs_backend to switch between backends. The files
> > based backend is the default.
> > 
> > Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  refs-be-files.c | 10 ++++++++--
> >  refs.c          | 30 ++++++++++++++++++++++++++++++
> >  refs.h          | 15 +++++++++++++++
> >  3 files changed, 53 insertions(+), 2 deletions(-)
> > 
> > [...]
> > diff --git a/refs.h b/refs.h
> > index 4940ae9..419abf4 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -619,4 +619,19 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
> >  			 reflog_expiry_cleanup_fn cleanup_fn,
> >  			 void *policy_cb_data);
> >  
> > +/* refs backends */
> > +typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
> > +				      struct strbuf *err);
> > +typedef void ref_transaction_free_fn(struct ref_transaction *transaction);
> 
> The ref_transaction_free_fn typedef isn't used anywhere.

Will fix, thanks.

> > +struct ref_be {
> > +	struct ref_be *next;
> > +	const char *name;
> > +	ref_transaction_commit_fn *transaction_commit;
> > +};
> > +
> > +
> > +extern struct ref_be refs_be_files;
> 
> I don't think that refs_be_files is needed in the public interface.

We use refs_be_lmdb in a few other places to set up the lmdb backend, so
I thought I would put refs_be_files in refs.h too.  But I can remove
refs_be_files and just stick it in the places it's needed.
