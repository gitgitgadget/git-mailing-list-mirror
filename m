From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2] merge: fix cache_entry use-after-free
Date: Wed, 14 Oct 2015 18:00:42 -0400
Organization: Twitter
Message-ID: <1444860042.18742.13.camel@twopensource.com>
References: <1444687413-928-1-git-send-email-dturner@twitter.com>
	 <xmqqk2qp6tg1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Keith McGuigan <kmcguigan@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 00:00:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmU6M-0007z1-4H
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 00:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbbJNWAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 18:00:45 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35052 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453AbbJNWAp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 18:00:45 -0400
Received: by qgt47 with SMTP id 47so55840593qgt.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 15:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=j6RXLxIcCVut2zUUlrjRK6bVv22CyeVLZ275cPMwSNI=;
        b=KQYAxdQntznIz14/B3rxPo2nu+TkWyPRpvY051H/Dp3znatcA8cdXGQSWDWixOuaNm
         pudY2Rk+pVY2fEQnrzK2CcGw+VGBCKwXJYsz9WYXaBUygSRRzpDYw9uUjzbuDK9JXLFM
         E5k6p9au6wngcvr9EcK2dpLDy/87dUT3fb7PfK0yJuobMuvoYFsodtMt2z1h4NbOpQgt
         jOCWX20JJsHRicu96pUjavuCowKdzw8zLAuB2WtWzddbzOzlTKIm92DT8FWJn01IxA9c
         OutHMQqthBEy8h22cSRFxAwY8wORVb0FPtLVHKIDazxwqGO/tdafJzyVQLc4PBqJGMc9
         8ffA==
X-Gm-Message-State: ALoCoQnhfPc+iIMhAgdukNlAcwzPYLYhLlKCxbN28O+EQg9x9ibOM4HIfWa/8dYj8TZif6Jj2kfI
X-Received: by 10.140.41.240 with SMTP id z103mr7139615qgz.7.1444860044446;
        Wed, 14 Oct 2015 15:00:44 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b83sm4169491qkj.43.2015.10.14.15.00.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2015 15:00:43 -0700 (PDT)
In-Reply-To: <xmqqk2qp6tg1.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279633>

On Wed, 2015-10-14 at 14:17 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > +	unsigned int ref_count; /* count the number of refs to this in dir_hash */
> 
> Me makes a mental note of the type used...
> 
> > @@ -213,6 +214,32 @@ struct cache_entry {
> >  struct pathspec;
> >  
> >  /*
> > + * Increment the cache_entry reference count.  Should be called
> > + * whenever a pointer to a cache_entry is retained in a data structure,
> > + * thus marking it as alive.
> > + */
> > +static inline void add_ce_ref(struct cache_entry *ce)
> > +{
> > +	assert(ce != NULL && ce->ref_count >= 0);
> 
> ... and notices that ce->ref_count will always be non-negative here
> 
> 
> > +	ce->ref_count++;
> > +}
> > +
> > +/*
> > + * Decrement the cache_entry reference count.  Should be called whenever
> > + * a pointer to a cache_entry is dropped.  Once the counter drops to 0
> > + * the cache_entry memory will be safely freed.
> > + */
> > +static inline void drop_ce_ref(struct cache_entry *ce)
> > +{
> > +	if (ce != NULL) {
> > +		assert(ce->ref_count >= 0);
> 
> ... and here.
> 
> By not checking integer overflow/wraparound, the code is assuming
> that a ce entry will never referenced more than 4 billion times on
> 32-bit platform.  And that is a sensible assumption as there aren't
> that many pointers in the address space to make that many reference
> anyway.
> 
> Perhaps the code can assume the number won't be more than 2 billion
> and use a signed type instead for the reference counting?

Will do.
