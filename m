From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/3] index-pack: eliminate unlimited recursion in get_delta_base()
Date: Tue, 10 Jan 2012 20:16:33 +0700
Message-ID: <CACsJy8C00qRn0adD+ZG78Q2tXD2C3vh_Ci0zYonqi8zgVWZyjg@mail.gmail.com>
References: <1324901080-23215-1-git-send-email-pclouds@gmail.com>
 <1326081546-29320-4-git-send-email-pclouds@gmail.com> <7vvcokcwvt.fsf@alter.siamese.dyndns.org>
 <CACsJy8A-FOpjDeTpxMze7jouceWMJHND_V2fyV5pLNKF8xp8kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 14:17:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkbZi-0001El-Bz
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 14:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756235Ab2AJNRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 08:17:07 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37998 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756232Ab2AJNRG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 08:17:06 -0500
Received: by bkvi17 with SMTP id i17so387044bkv.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 05:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=u+OvKA4Ww3nGWTtuGpjDozOSvUC81lZwwDVaFUP0Gjw=;
        b=DPXx+o1jIhInY3PRLShiUxcStUyFwO5vfRewqCRetayZEePozjT+amDyVAipnP0m4G
         h2r8W2u/+LTgBqbcX71oCAKKEOEYj5GXNmntP0lMZareAq108HlMBEM2tJ94+X3xMNRn
         kVGxFcV0rZE/0ZHbmJtU20xMGE08t4I5Kh4tE=
Received: by 10.204.147.194 with SMTP id m2mr8672425bkv.22.1326201424150; Tue,
 10 Jan 2012 05:17:04 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Tue, 10 Jan 2012 05:16:33 -0800 (PST)
In-Reply-To: <CACsJy8A-FOpjDeTpxMze7jouceWMJHND_V2fyV5pLNKF8xp8kQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188248>

On Tue, Jan 10, 2012 at 8:03 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> correct? Yeah I think it's simpler than current code.

I wrote about core.deltabasecachelimit, then deleted it, thinking it
should be ok, but how do handle the case when you use up cache limit?
Some handled objects may be freed when we're short on cache and need
to be resolved again before we could resolve an unhandled object.

Assume we're at the limit, have resolved A, which has two children B
and C. When we resolve B we need to free A to keep it fit in cache. By
the time we look at C, A needs to be resolved again. Without tracing
back (i.e. what get_base_data() does), we don't know what we need to
re-resolve among all handled objects.
-- 
Duy
