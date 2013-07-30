From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] sha1_file: introduce close_one_pack() to close packs on
 fd pressure
Date: Tue, 30 Jul 2013 03:51:59 -0400
Message-ID: <CAPig+cR68PQ62JC266iGBidD-udBq2BaL-BWaTpY1JkWWBOp0Q@mail.gmail.com>
References: <1375157113-608-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 09:52:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V44j3-0001wQ-PV
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 09:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757897Ab3G3HwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 03:52:04 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55270 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757884Ab3G3HwB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 03:52:01 -0400
Received: by mail-lb0-f174.google.com with SMTP id w20so434558lbh.5
        for <git@vger.kernel.org>; Tue, 30 Jul 2013 00:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Jte3G7WqvrTKvuK52U2W3uaXDh/Hvlj7Ua/srqPWZD0=;
        b=G9FOMfx4mnWTMO9oByPLfnBsKo0glehyCLcgWZjU/VvoIwKaoyXPnpOzVLgEWj4Vbm
         mMiC7LpVTDpuJBcFgwi+VMV2lmhASE5UNjNt4Jv4S0xGaCQYykf9Bx9NfmiiDhI0tadz
         KJKPxnfFQpT6NMjYUD4PvZxCY+j4Krye7lJ0bZ+K1+bG5Vv2B/wqKEW1zD0Wo5hcPhQR
         wMEAjyfQ+FeUA7JXt/hF2j2DrP83Sz6+9FCJrIGZ7SUsI9ooIf1Uh7BnNwCnljOUhiz8
         vtbmBbNEqub9HIufIASd0yVtPeARDK5X1v3PS3z4OEUFX4kDsWS7oJ43JMeOf/D3lbgl
         WCTQ==
X-Received: by 10.112.77.164 with SMTP id t4mr26924737lbw.52.1375170719680;
 Tue, 30 Jul 2013 00:51:59 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Tue, 30 Jul 2013 00:51:59 -0700 (PDT)
In-Reply-To: <1375157113-608-1-git-send-email-bcasey@nvidia.com>
X-Google-Sender-Auth: ySpWua8M95sF7XR9PwBKOoEf-qc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231350>

On Tue, Jul 30, 2013 at 12:05 AM, Brandon Casey <bcasey@nvidia.com> wrote:
> When the number of open packs exceeds pack_max_fds, unuse_one_window()
> is called repeatedly to attempt to release the least-recently-used
> pack windows, which, as a side-effect, will also close a pack file
> after closing its last open window.  If a pack file has been opened,
> but no windows have been allocated into it, it will never be selected
> by unuse_one_window() and hence its file descriptor will not be
> closed.  When this happens, git may exceed the number of file
> descriptors permitted by the system.
>
> This latter situation can occur in show-ref or receive-pack during ref
> advertisement.  During ref advertisement, receive-pack will iterate
> over every ref in the repository and advertise it to the client after
> ensuring that the ref exists in the local repository.  If the ref is
> located inside a pack, then the pack is opened to ensure that it
> exists, but since the object is not actually read from the pack, no
> mmap windows are allocated.  When the number of open packs exceeds
> pack_max_fds, unuse_one_window() will not able to find any windows to

s/not able/not be able/
...or...
s/not able to find/not find/

> free and will not be able to close any packs.  Once the per-process
> file descriptor limit is exceeded, receive-pack will produce a warning,
> not an error, for each pack it cannot open, and will then most likely
> fail with an error to spawn rev-list or index-pack like:
>
>    error: cannot create standard input pipe for rev-list: Too many open files
>    error: Could not run 'git rev-list'
>
> This is not likely to occur during upload-pack since upload-pack
> reads each object from the pack so that it can peel tags and
> advertise the exposed object.  So during upload-pack, mmap windows
> will be allocated for each pack that is opened and unuse_one_window()
> will eventually be able to close unused packs after freeing all of
> their windows.
>
> When we have file descriptor pressure, in contrast to memory pressure,
> we need to free all windows and close the pack file descriptor so that
> a new pack can be opened.  Let's introduce a new function
> close_one_pack() designed specifically for this purpose to search
> for and close the least-recently-used pack, where LRU is defined as
>
>    * pack with oldest mtime and no allocated mmap windows or
>    * pack with the least-recently-used windows, i.e. the pack
>      with the oldest most-recently-used window
>
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
