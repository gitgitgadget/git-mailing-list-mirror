From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 37/44] refs: break out a ref conflict check
Date: Tue, 13 Oct 2015 14:46:31 -0400
Organization: Twitter
Message-ID: <1444761991.7234.8.camel@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
	 <1444686725-27660-39-git-send-email-dturner@twopensource.com>
	 <561CDC2E.8060804@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 13 20:46:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm4as-0006SJ-IP
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 20:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbbJMSqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 14:46:34 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33538 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbbJMSqd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 14:46:33 -0400
Received: by qkas79 with SMTP id s79so12626359qka.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 11:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=TQiuAvUbrFvGyUBiMnUA2CkbW1cL8xLiEYB6hsQd9oQ=;
        b=VhguK0VbbQLRsnmSmP5MyZw7AVGWZYajp2TsZw8ZDn8zoEVYU8RYkzPJk7Q65Q2N6a
         nZSOrBjnMoYfJqtcQ7jteJ1Zar7BXkDPWfOw/6GVqxlysab17LN9B6aYzzkhVt0s8CMP
         XL38C2daOodT92DGvlw2pGtZYU+osGz/NT81sYr0lp4pcchypVJYiOpbLxQq84uK0Foz
         7aUivn7b/J7nY7n8zK80AFtDD7+NmZM5q5ZJ/ryW3TwUmz/w0x1TShCU7hMaa844H3vF
         nx1vNRMWRr1uSw4q7gBnTJN30ZKciv5GWvo3ef2WT8cpJxwHv/MgQwAfDGjAr8T7eqbY
         cLBg==
X-Gm-Message-State: ALoCoQn9uQPmjZAEv3NYY8ES3Jbog8wZiww4UbNoOJHTFj9gfRMdG6QR3XL/dqJ0WUU7r++QE0MU
X-Received: by 10.55.215.18 with SMTP id m18mr39939901qki.49.1444761992923;
        Tue, 13 Oct 2015 11:46:32 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 105sm1733991qgl.13.2015.10.13.11.46.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2015 11:46:31 -0700 (PDT)
In-Reply-To: <561CDC2E.8060804@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279512>

On Tue, 2015-10-13 at 12:25 +0200, Michael Haggerty wrote:
> On 10/12/2015 11:51 PM, David Turner wrote:
> > Create new function verify_no_descendants, to hold one of the ref
> > conflict checks used in verify_refname_available.  Multiple backends
> > will need this function, so it goes in the common code.
> > 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  refs-be-files.c | 33 ++++++++-------------------------
> >  refs.c          | 22 ++++++++++++++++++++++
> >  refs.h          |  7 +++++++
> >  3 files changed, 37 insertions(+), 25 deletions(-)
> > 
> > [...]
> > diff --git a/refs.c b/refs.c
> > index 5a3125d..3ae0274 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1101,6 +1101,28 @@ enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
> >  	return PEEL_PEELED;
> >  }
> >  
> > +const char *find_descendant_ref(const char *refname,
> > +				const struct string_list *extras,
> > +				const struct string_list *skip)
> > +{
> > +	int pos;
> > +	if (!extras)
> > +		return NULL;
> > +
> > +	/* Look for the place where "$refname/" would be inserted in extras. */
> 
> The comment above is misleading. See my note at the bottom of this email
> for an explanation.
> 
> > +	for (pos = string_list_find_insert_index(extras, refname, 0);
> > +	     pos < extras->nr; pos++) {
> > +		const char *extra_refname = extras->items[pos].string;
> > +
> > +		if (!starts_with(extra_refname, refname))
> > +			break;
> > +
> > +		if (!skip || !string_list_has_string(skip, extra_refname))
> > +			return extra_refname;
> > +	}
> > +	return NULL;
> > +}
> > +
> >  /* backend functions */
> >  int refs_initdb(struct strbuf *err, int shared)
> >  {
> > diff --git a/refs.h b/refs.h
> > index 3aad3b8..f8becea 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -637,6 +637,13 @@ int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
> >  			const unsigned char *new_sha1, const char *msg,
> >  			int flags, struct strbuf *err);
> >  
> > +/*
> > + * Check for entries in extras that start with "$refname/", ignoring
> > + * those in skip. If there is such an entry, then we have a conflict.
> > + */
> > +const char *find_descendant_ref(const char *refname,
> > +				const struct string_list *extras,
> > +				const struct string_list *skip);
> 
> The documentation is is not correct. As written, the function needs not
> the refname as argument but the refname followed by '/'. Without the
> trailing slash, "refs/heads/foo" would be blocked by "refs/heads/foobar".
> 
> From the point of view of simplicity, it would be nice if this function
> could take a refname (without the trailing slash) as argument. But then
> it would basically be forced to allocate a new string, copy refname to
> it, append a '/', then free the string again when it's done.
> Alternatively, it could accept its refname argument in a strbuf and
> temporarily append the '/'.
> 
> But neither one of these alternatives is so elegant, so maybe it's OK if
> this function is documented to take a "directory name, including the
> trailing '/'" as argument and rename the argument (e.g., to "dirname").
> 
> Please also document that "skip" and "extras" can be NULL, but if not
> NULL they need to be sorted lists.

I think `extras` may not be NULL.  But I've otherwise fixed this.
Thanks.
