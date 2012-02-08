From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] docs: add a basic description of the config API
Date: Wed, 8 Feb 2012 13:55:30 +0700
Message-ID: <CACsJy8B1cMBbrUznOp95u8YmfLf5bbzox8g9cuQUwgf-vY1XrQ@mail.gmail.com>
References: <20120206095306.GA2404@sigill.intra.peff.net> <20120206095346.GA4300@sigill.intra.peff.net>
 <7vbopb61cd.fsf@alter.siamese.dyndns.org> <20120207180625.GA27189@sigill.intra.peff.net>
 <7vlioe1o1g.fsf@alter.siamese.dyndns.org> <CACsJy8AU3ZA1=Q3vahhP6Nr=FZNKd7oRJ04mtKVs+uvNqJeVaw@mail.gmail.com>
 <7vmx8tzv3l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 07:56:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rv1Rn-0008Ki-M3
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 07:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756472Ab2BHG4D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Feb 2012 01:56:03 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54365 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756372Ab2BHG4B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2012 01:56:01 -0500
Received: by wgbdt10 with SMTP id dt10so263370wgb.1
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 22:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jp55asxbzxN8Wk7soRnzFAWloqUz4KbEF04O96fjmac=;
        b=GAl201CmWek71Q32KytR+UB90WPkkKaLZ/JQZRmnjozq+z0Nca2Sls1z768zEJkFih
         fJHpjE0Uc23aknbYlgkzDx2o4+Ov42RpV24B6v6PTs6cdg1afF6KWNo0mly+lxUbCHOK
         syvHtpnDaSKW/uAbxd5sSQB5pNhCmHOrFYJiI=
Received: by 10.180.19.97 with SMTP id d1mr38888871wie.12.1328684160228; Tue,
 07 Feb 2012 22:56:00 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Tue, 7 Feb 2012 22:55:30 -0800 (PST)
In-Reply-To: <7vmx8tzv3l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190224>

On Wed, Feb 8, 2012 at 1:40 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Your excuse that "the toplevel callback in my callchain never returns=
 1,
> so overall the nd/columns series is ok" just muddies the water. =C2=A0=
It means
> if later somebody wanted to use inner callback functions you use from=
 the
> git_column_config() callchain chain as a toplevel callback for whatev=
er
> reason, that will violate the "0 for success, or -1 for error" conven=
tion.
> More importantly, if somebody wants to turn a top-level callback that
> currently returns 0 into a sub callback used by his callback callchai=
n, he
> cannot change that existing callback to return 1 to tell him to short
> circuit, because for other callers returning 1 would be a violation.
>
> What I was getting at is that we probably should officially declare t=
hat
> returning 1 to signal success is perfectly acceptable (and it probabl=
y
> should mean the caller who called the callback function as a sub call=
back
> should return immediately, taking it as a signal that the key has alr=
eady
> been handled), as the primary purpose of this thread to discuss Peff'=
s
> patch is to write these rules down.

Or allow multiple callbacks from git_config(). The problem with is it
adds another common set of config vars. Now it's common to chain var
sets by doing

int config_callback(...)
{
    ....
    return yet_another_callback(...);
}

int main()
{
   git_config(config_callback, ...)
   ...

where yet_another_callback() hard codes another callback (usually
git_default_config). This is inflexible. If we allow multiple
callbacks, git_column_config() could be changed to return just 0 or -1
(i.e. 1 remains unsuccessful error code).

On second thought, I think calling git_config() multiple times, each
time with one callback, may work too. We may want to cache config
content to avoid accessing files too many times though.

> Of course, all that relies on the audit of the git_config() machinery=
=2E I
> think it is written to accept non-negative as success, and that is wh=
y I
> said "I too think this should be acceptable" in the first place.
--=20
Duy
