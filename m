From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 6/9] pseudorefs: create and use pseudoref update and
 delete functions
Date: Fri, 24 Jul 2015 16:17:15 -0400
Organization: Twitter
Message-ID: <1437769035.1141.16.camel@twopensource.com>
References: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
	 <1437713129-19373-7-git-send-email-dturner@twopensource.com>
	 <xmqqbnf1mk72.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 22:17:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIjPH-0003JS-KV
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 22:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595AbbGXURT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 16:17:19 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:34284 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527AbbGXURS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 16:17:18 -0400
Received: by qgeu79 with SMTP id u79so15964721qge.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 13:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=U+Qx9hZ+JTbkFA1qsK3XpNOU83hFzVmI1pY7fTbXHSE=;
        b=OsD/fprUN778gqNL3tK9naxnBvODO0d45rrKhfTuYQ3Gp56VQcKHl+O/olUPwuc2Ol
         E23NrXr2rP554TtSlb/zIu/+k07/D61vYmjdtH+8Sw3Bw192FrsZ3jVRDi63FiMYtXvH
         HU/VenFreWCA+eYVC+Vjfg0N2WhpCA7oHMSgmFfrnoBnBt0WmybZxmzAV4mGc5x3jxPM
         QvytI1q7eT7lcZ1zS9WpNZ1rEZYu0dNhEpOtzxNEF/6uhmT/IORrBTvUTt5ot/0/NH5A
         /g4Hlm4etDcY+4roxtioW1l/E6Eoz/jWpjUWNmy1NM2eniDP1/fLYAeGWeHdpNi2r3uf
         lo6w==
X-Gm-Message-State: ALoCoQmTt7sukd4T2YL0b1KAfaScsGnTwpGAz2J2qj86nW4B7kOhM5ZB69yJoFaKRHOMA0LT5vCP
X-Received: by 10.140.234.10 with SMTP id f10mr20277033qhc.11.1437769038108;
        Fri, 24 Jul 2015 13:17:18 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g81sm4577115qhc.8.2015.07.24.13.17.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2015 13:17:17 -0700 (PDT)
In-Reply-To: <xmqqbnf1mk72.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274598>

On Fri, 2015-07-24 at 12:25 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > Pseudorefs should not be updated through the ref API, because the ref
> > API is for real refs.  Instead, use a dedicated pseudoref API.
> >
> > This patch changes writes to CHERRY_PICK_HEAD, REVERT_HEAD, and ORIG_HEAD.
> 
> This feels somewhat backwards, and it makes me wonder if it is a
> better approach to teach update_ref() about the naming rules, so
> that the callers do not have to say the same thing twice "This is
> not a ref and I am giving all-caps name, by the way I am also not
> calling update_ref() because that is only for real refs".

Do you mean teach update_ref to call write_pseudoref for pseudorefs and
call the normal codepath for regular refs?  I considered this, but I was
worried about ref transactions.  It would be odd if
ref_transaction_update worked differently than update_ref.  And I didn't
want to deal with making pseudoref updates transactional, because then
alternate backends would have to maintain multiple transactions, which
turned out to be a giant hassle.

But maybe it's OK if update_ref operates differently than
ref_transaction_update?  (and same for
delete_ref/ref_transaction_delete).  After all, people who call
update_ref don't really care about the transactional semantics.
