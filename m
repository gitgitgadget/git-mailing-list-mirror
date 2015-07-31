From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] worktrees: add die_if_shared_symref
Date: Fri, 31 Jul 2015 13:08:09 -0700
Message-ID: <xmqqr3no3xau.fsf@gitster.dls.corp.google.com>
References: <1438369297-4838-1-git-send-email-dturner@twopensource.com>
	<CAPig+cTX0Wav2QSFi734uLVpjdmwFKzcesgkpmVKCPomMB_HyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 22:08:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLGbR-0007kP-SM
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 22:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600AbbGaUIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 16:08:15 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35218 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222AbbGaUIL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 16:08:11 -0400
Received: by pdrg1 with SMTP id g1so47744631pdr.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 13:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zXzu+PhL9Y9OoXNw7z2ixcU+Kiz9xloHDYBuxNxn0x0=;
        b=k+3rR2ZHGpRGPSlmZAG3gLwOXFXnHacWO1ZWoBfHmxFxp+6nT6LTpTtJjJ5Hvv4yoJ
         fYX7TwkUH9dfrX1v3+bbVsJMIRJoclf6QqU/o9k11DMXxpW6SEsTMKlEXmcs4+P95yCC
         yBkVVSJ0qGNB4cLzzeZY2kTyAuB03LV/MY666mYMGy1uEUKkZ1pboWtxXHm4xnO+1M/m
         r/Qwz7uNxZRfhprw+Cz7ZIRh2mb0VtFQzDI+rCptxTStPvKVTUqrMaaas+k0M4RuarYo
         lhZ2NB884b6T2hL1cvGZopfIwESqqQkZlze8DU7wKOk7i3QKhV3Q01GG12xAIWwyTPgV
         KL3w==
X-Received: by 10.70.103.98 with SMTP id fv2mr10802376pdb.9.1438373291161;
        Fri, 31 Jul 2015 13:08:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1b0:46e8:ba02:35e3])
        by smtp.gmail.com with ESMTPSA id fj6sm9230284pdb.21.2015.07.31.13.08.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 13:08:10 -0700 (PDT)
In-Reply-To: <CAPig+cTX0Wav2QSFi734uLVpjdmwFKzcesgkpmVKCPomMB_HyA@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 31 Jul 2015 15:35:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275074>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Jul 31, 2015 at 3:01 PM, David Turner <dturner@twopensource.com> wrote:
>> Add a new function, die_if_shared_symref, which works like
>> die_if_checked_out, but for all references.  Refactor
>> die_if_checked_out to work in terms of die_if_shared_symref.
>>
>> Soon, we will use die_if_shared_symref to protect notes merges in
>> worktrees.
>
> I wonder if the diagnostic:
>
>     'blorp' is already checked out at '/path/name/'
>
> emitted by check_linked_checkout() needs to be adjusted for this
> change. It still makes sense for die_if_checked_out(), but sounds odd
> for die_if_shared_symref().

True.  Lift the dying one callstack up, and make the lower level
helper check_shared_symref() or something that returns NULL (ok) or
that '/path/name' upon an error?

Also I suspect that this comment will become hard to grok after the
commit is actually made:

>  	/*
> -	 * $GIT_COMMON_DIR/HEAD is practically outside
> +	 * $GIT_COMMON_DIR/$symref is practically outside
>  	 * $GIT_DIR so resolve_ref_unsafe() won't work (it
>  	 * uses git_path). Parse the ref ourselves.
>  	 */

A reviewer who is viewing both the pre- and post- text of the patch
can see it used to say HEAD and now it is extended to $symref, but
it would help to have "(e.g. HEAD)" after "...DIR/$symref", I think.
