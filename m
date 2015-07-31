From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] worktrees: add die_if_shared_symref
Date: Fri, 31 Jul 2015 17:36:17 -0400
Message-ID: <CAPig+cRZ4PicP7J0Hdwb1+E9JbE=wsfqEaVX6X4ERST2_nJrxw@mail.gmail.com>
References: <1438369297-4838-1-git-send-email-dturner@twopensource.com>
	<CAPig+cTX0Wav2QSFi734uLVpjdmwFKzcesgkpmVKCPomMB_HyA@mail.gmail.com>
	<1438377312.4735.10.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 23:36:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLHyf-00067X-2F
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 23:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442AbbGaVgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 17:36:22 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:34898 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412AbbGaVgS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 17:36:18 -0400
Received: by ykdu72 with SMTP id u72so69640790ykd.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 14:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=JhBsGM+DUPvDBzm3U1nbHu4hU5exdpKDNWKyeI9A6FY=;
        b=dUqEV8VtIV7OIPkilfisKShYzB9+GiyqmNWFZWX089Oc3y6y7xZikc6KqNHGp2LtMf
         pBR2Dtfq3qTNFrs+B5+Ntiq091SsTjQYhjeHdMs7pMeSFXG9/BMVLmE8yPlpyR6vgok2
         xPk5Hv7etlT8/DARteZGTsHJTxHaQ5RfVMqeefEV+Gx7lcr53d0ReXRn+Ucjc+5KLvpu
         WZNPFnOmNoFmcCXRzDj/9r0eDV+W6o111wi8vNhcf5nOMUDvZp1CUR4wKkT37W/sknvV
         4Ji6I3WmognycaNwG5pRpCqHP4762z85cqDr63sydfm+/ts+Yg1mEK4D7t15GYvZpc5V
         si4g==
X-Received: by 10.170.233.10 with SMTP id z10mr6009245ykf.71.1438378578024;
 Fri, 31 Jul 2015 14:36:18 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Fri, 31 Jul 2015 14:36:17 -0700 (PDT)
In-Reply-To: <1438377312.4735.10.camel@twopensource.com>
X-Google-Sender-Auth: hutzQpiulwke-nChDhinllY0LS4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275079>

On Fri, Jul 31, 2015 at 5:15 PM, David Turner <dturner@twopensource.com> wrote:
> On Fri, 2015-07-31 at 15:35 -0400, Eric Sunshine wrote:
>> On Fri, Jul 31, 2015 at 3:01 PM, David Turner <dturner@twopensource.com> wrote:
>> > Add a new function, die_if_shared_symref, which works like
>> > die_if_checked_out, but for all references.  Refactor
>> > die_if_checked_out to work in terms of die_if_shared_symref.
>> >
>> > Soon, we will use die_if_shared_symref to protect notes merges in
>> > worktrees.
>>
>> I wonder if the diagnostic:
>>
>>     'blorp' is already checked out at '/path/name/'
>>
>> emitted by check_linked_checkout() needs to be adjusted for this
>> change. It still makes sense for die_if_checked_out(), but sounds odd
>> for die_if_shared_symref().
>
> How about:
>
> 'refs/notes/y' is already referenced from 'NOTES_MERGE_REF' in
> '/home/dturner/git/t/trash directory.t3320-notes-merge-worktrees/'
>
> Does that make sense?

That might be the best we can do for the generic case of
die_if_shared_symref(), but I wonder how easily the typical user would
understand it when trying to checkout a branch already checked out
elsewhere. One concern is that that message almost comes across as an
internal Git error (thus inscrutable), whereas:

    % git checkout blorp
    'blorp' is already checked out at '/some/path/'

seems (to me) pretty clearly a user error, thus more easily understood.

> It's not the only place in the error messages that mentions
> NOTES_MERGE_REF, so I think we expect users to understand
> NOTES_MERGE_REF.  The alternative is to move the error handling to an
> even higher level so we can give a notes-specific message.  I don't
> think that's necessary, but I'll do it if others do.

Given such precedence, the generic error message might indeed be fine
for the notes merge case, however, in general, you'd probably get
better and more understandable error messages by tailoring them at the
call sites. (That's a positive vote from me for for lifting error
handling to a higher level.)
