From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/9] pseudorefs: create and use pseudoref update and delete functions
Date: Fri, 24 Jul 2015 13:53:33 -0700
Message-ID: <xmqqa8ull1ki.fsf@gitster.dls.corp.google.com>
References: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
	<1437713129-19373-7-git-send-email-dturner@twopensource.com>
	<xmqqbnf1mk72.fsf@gitster.dls.corp.google.com>
	<1437769035.1141.16.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 22:53:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIjyQ-0000R3-DQ
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 22:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759AbbGXUxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 16:53:39 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33032 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753AbbGXUxh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 16:53:37 -0400
Received: by pdbnt7 with SMTP id nt7so18660732pdb.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OjEMU7SWcKp8+H9DxRE+Ljwo1MjPGo5D1/jmMq2Pt20=;
        b=0SJrA3///PjUqQAWBVT4ONW3BcZ9FoU9k4XODjWTrvT3vpcwkztgMmIVZxaCeRxLln
         CwiG2IBpZWESHCwYBS/LoklF0PXCqo8rQVF3tpjyu+LNBAOVyAt5eHYBkao9Mkqbjy2K
         5ZwX36khJzCyGaRZ5xAUhvbTSDAxVtqZ0Vw9hIGkEjb7mRsXrsSRRr8VuyAHdRf61KhR
         LbStIL6DA2fpMDDJkDreJfwaH4Jgi3girUk+15H8EB8rgfY3vbK3Htx6uCuWlCRS08iw
         U+2XhaZjNJe9EVFkDVM2gpbv3dOtmXUB9crrDq/yB/dG8JA1q9nhTlCPME6uM/L5fm0l
         UQgA==
X-Received: by 10.70.23.98 with SMTP id l2mr35246100pdf.74.1437771217073;
        Fri, 24 Jul 2015 13:53:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:bdad:9e5d:aa9:33a9])
        by smtp.gmail.com with ESMTPSA id o8sm16145995pdp.70.2015.07.24.13.53.34
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 24 Jul 2015 13:53:35 -0700 (PDT)
In-Reply-To: <1437769035.1141.16.camel@twopensource.com> (David Turner's
	message of "Fri, 24 Jul 2015 16:17:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274601>

David Turner <dturner@twopensource.com> writes:

> On Fri, 2015-07-24 at 12:25 -0700, Junio C Hamano wrote:
>> David Turner <dturner@twopensource.com> writes:
>> 
>> > Pseudorefs should not be updated through the ref API, because the ref
>> > API is for real refs.  Instead, use a dedicated pseudoref API.
>> >
>> > This patch changes writes to CHERRY_PICK_HEAD, REVERT_HEAD, and ORIG_HEAD.
>> 
>> This feels somewhat backwards, and it makes me wonder if it is a
>> better approach to teach update_ref() about the naming rules, so
>> that the callers do not have to say the same thing twice "This is
>> not a ref and I am giving all-caps name, by the way I am also not
>> calling update_ref() because that is only for real refs".
>
> Do you mean teach update_ref to call write_pseudoref for pseudorefs and
> call the normal codepath for regular refs?

While reviewing this series, I mostly am viewing them from the point
of view of a user of the ref API.

You may name that "always delegate to filesystem backend" helper
function "write_pseudoref()" or whatever name we (i.e. the ref API
implementors) find easy to remember and understand, and as long as
it is static within refs.c (or refs-be-file.c), a user of the ref
API does not have to know.  He does not have to care (ideally he
shouldn't have to be able to call it directly, but that is merely a
safety against bugs).

> I considered this, but I was worried about ref transactions.

Considering the nature of these FOO_HEADs, I think it is perfectly
fine to declare that handling of them _must_ happen within a single
transaction that does not involve regular refs, or that handling of
them _must_ happen outside transactions.  I do not think any of the
existing creation, update, or deletion of these FOO_HEADs happen
inside any transaction anyway.
