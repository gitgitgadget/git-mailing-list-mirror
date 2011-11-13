From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Copy resolve_ref() return value for longer use
Date: Sun, 13 Nov 2011 14:09:12 +0700
Message-ID: <CACsJy8ARAzNWjZfXwnNG0AprCFXLCkiDrE+eFj9icbeNX14xKw@mail.gmail.com>
References: <CACsJy8Aw4_O_GMiK_D=HTENfxGUXTTzCHqM7FkriqU+mQtVWtA@mail.gmail.com>
 <1320719428-1802-1-git-send-email-pclouds@gmail.com> <7vehxcpns5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Tony Wang <wwwjfy@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 13 08:09:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPUCS-0002yT-Rf
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 08:09:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236Ab1KMHJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 02:09:45 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50984 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab1KMHJo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 02:09:44 -0500
Received: by bke11 with SMTP id 11so4723838bke.19
        for <git@vger.kernel.org>; Sat, 12 Nov 2011 23:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gowhEBQYlUmqK5y6g0OltHxhEKaZm6o/aH3mBURIRxk=;
        b=XJtaDL7gq3Xn3+vzn+K4ltTs7Tfnd8r2uyGuEhKxGL4N444clOBVUOIv970P6RZu3U
         FdE45TO8gWxLXwvc/MBu6AThmif+mEQCBERS6kfwikn01zqMYMRMy2NGBr4YpeM78do8
         oVKMZyzmUToMPesGjC2lyeRro3uDeRK0YsMhs=
Received: by 10.204.10.81 with SMTP id o17mr14575592bko.65.1321168183096; Sat,
 12 Nov 2011 23:09:43 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Sat, 12 Nov 2011 23:09:12 -0800 (PST)
In-Reply-To: <7vehxcpns5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185322>

2011/11/13 Junio C Hamano <gitster@pobox.com>:
> The above log message with the callchain would be a perfect explanation
> for a patch to fix builtin/merge.c and nothing else, but among 50+
> callsites of resolve_ref(), only 5 places are modified in this patch, and
> it is not explained in the commit log message at all how they were chosen.
> Were the other 40+ or so places inspected and deemed to be OK? Or is this
> "I just did a few of them in addition to the immediate need of fixing what
> was reported, and the rest are left as an exercise to the readers" patch?

I went through all of them. Most of them only checks if return value
is NULL, or does one-time string comparison. Others do xstrdup() to
save the return value. Will update the patch message to reflect this.

> Some variables that receive xstrdup()'ed result with this patch are
> globals whose lifetime lasts while the process is alive, and I do not
> think it is a huge problem that this patch does not free it, but it seems
> the patch does not free some other function scope variables once their use
> is done even when it is fairly easy to do so.

Will fix.

> How much overhead would it incur if we return xstrdup()'ed memory from the
> resolve_ref() and make it the caller's responsibility to free it? Would it
> make the calling site too ugly?

Given a lot of callsites do "if (resolve_ref(...)) ...", yes it may
look ugly. Though if you don't mind a bigger patch, we could turn

const char *resolve_ref(const char *path, const char *sha1, int
reading, int *flag);

to

int resolve_ref(const char *path, const char *sha1, int reading, int
*flag, char **ref);

where *ref is the current return value and is only allocated by
resolve_ref() if ref != NULL.
-- 
Duy
