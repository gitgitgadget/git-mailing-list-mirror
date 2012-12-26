From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v2 00/14] new git check-ignore sub-command
Date: Wed, 26 Dec 2012 15:44:32 +0000
Message-ID: <CAOkDyE_hs9kVtk4DbN+0gTaud35oLv4S4wiuAgYmtxCnPuUzhA@mail.gmail.com>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
	<1348170383-15751-1-git-send-email-git@adamspiers.org>
	<7v4nms9yja.fsf@alter.siamese.dyndns.org>
	<7vsjac8j52.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 26 16:44:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TntAA-0003Da-Ft
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 16:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682Ab2LZPof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 10:44:35 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:52285 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538Ab2LZPod (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 10:44:33 -0500
Received: by mail-we0-f174.google.com with SMTP id x10so3995671wey.33
        for <git@vger.kernel.org>; Wed, 26 Dec 2012 07:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=+1qZRv9VZJ0GIOKbsFIOOkS0aCTR73E6jLbytWOXSDE=;
        b=QY18j6novDkVEkUa0hqrKcY9RxI4Z/DFsBBRKV9aIZsMuGG4YW0Qpwxit3/T8SD/8U
         ebkOr3mZvbNo5QSH02v+p6Az65uB5ndaFsML9/YwY+kBwpmgDmHXF70HVozu5VWHtsPa
         qVJF6gdxbzBn1kR+3ETzneiH2fUW5pL4dcrIGEXeyJ4Ud24hpdKxqidEc+vNubEyPzpH
         eGqsgvZ7nOZ/pfIlx2KH+4W6+GT6NZN53RV5eG5SdRXypaa9oF4+DG/gOfrke4NI1LOb
         qdn7Jso21xkM+/NhXImoD7Vf7z/nRQh2qd5Bv/Tb5y8Pf4K2yvvVz7aJvOLn1Bg0lK+k
         H1vg==
Received: by 10.194.236.68 with SMTP id us4mr45010100wjc.11.1356536672155;
 Wed, 26 Dec 2012 07:44:32 -0800 (PST)
Received: by 10.194.84.97 with HTTP; Wed, 26 Dec 2012 07:44:32 -0800 (PST)
In-Reply-To: <7vsjac8j52.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: AULlRQPyD85wxl2uZKtloZeOmcY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212137>

On Thu, Sep 20, 2012 at 10:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Adam Spiers <git@adamspiers.org> writes:
>>> Adam Spiers (14):
>>>   Update directory listing API doc to match code
>>>   Improve documentation and comments regarding directory traversal API
>>>   Rename cryptic 'which' variable to more consistent name
>>>   Rename path_excluded() to is_path_excluded()
>>>   Rename excluded_from_list() to is_excluded_from_list()
>>>   Rename excluded() to is_excluded()
>>>   Refactor is_excluded_from_list()
>>>   Refactor is_excluded()
>>>   Refactor is_path_excluded()
>>>   For each exclude pattern, store information about where it came from
>>>   Refactor treat_gitlinks()
>>>   Extract some useful pathspec handling code from builtin/add.c into a
>>>     library
>>>   Provide free_directory() for reclaiming dir_struct memory
>>>   Add git-check-ignore sub-command

[snipped]

> As to the "who owns x->src and when is it freed" question, it may
> make sense to give el a "filename" field (command line and other
> special cases would get whatever value you deem appropriate, like
> NULL or "<command line>"), have x->src point at that field when you
> queue many x's to the el in add_exc_from_file_to_list().  Then when
> you pop an element in the exclude_stack, you can free el->filename
> to plug a potential leak.

I have done this, but it required a change to struct dir:

Currently, when dir->exclude_stack is more than one entry deep, the
exclude_list pointed to by dir->exclude_list[EXC_DIRS] is a
concatenation of exclude elements from multiple files, so there will
be different values for src.  The same is true of EXC_FILE, which
typically mixes patterns from .git/info/exclude and core.excludesfile.
Therefore I have split each exclude_list into potentially multiple
exclude_lists, one per pattern source, whilst preserving the EXC_*
grouping and ordering.

My latest re-roll of as/check-ignore is nearly ready, and when I send
it, you will see a new patch in there covering the above change.

> Also I do not see why you need to have the strdup() in the caller of
> add_excludes_from_file_to_list().  If you need to keep it stable
> because you are copying it away in exclude or excludde_list,
> wouldn't it make more sense to do that at the beginning of the
> callee, i.e. add_excludes_from_file_to_list() function?

No, because in all other callers of add_excludes_from_file_to_list(),
the exclude source is already stable.  The re-roll will make this
clearer.
