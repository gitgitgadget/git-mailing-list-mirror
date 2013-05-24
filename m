From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/7] sha1_name: implement finding @{push}
Date: Fri, 24 May 2013 23:51:32 +0530
Message-ID: <CALkWK0mmJE3Q2WU3pmhWdcrxv=jFXb8oVhPCRW+Zc6yLdDmfUg@mail.gmail.com>
References: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
 <1369321970-7759-8-git-send-email-artagnon@gmail.com> <CACsJy8CV192WVW8u6YRnbf6Ue6tFbzyiCARwicwzapSZucaaMw@mail.gmail.com>
 <CALkWK0=XufbcwObBq7_MWX3jL63Nv3YeSvTUpOfXD+XoKkvMag@mail.gmail.com>
 <CACsJy8AHX0181uON5Aa7oJzX8j3qAA26Ymh5G3YEGidD4O5zvA@mail.gmail.com>
 <CALkWK0=LXNRaWz0vN_FwmJKbXT+W11mHABqzSJnbm_izQ0Ttrw@mail.gmail.com> <7vehcw9s0k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 24 20:22:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufwd8-0002OO-D6
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 20:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756458Ab3EXSWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 14:22:14 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:46630 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab3EXSWN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 14:22:13 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so12964724ief.40
        for <git@vger.kernel.org>; Fri, 24 May 2013 11:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eBOg587XNM+tm15vwLzMkdik641N1niIpQBdSFlKFi4=;
        b=hHhEeliXfn/gyNjadRA1y4SGVEYYLcruPkw032i+hzHBHseS4ROOQRjYCxKiwyG824
         e9XoohiczIiKycUMdobe1LmYq/nZzjiiMzSFGFHRrSvTRrLHxEF7ltZcCfNmZkK1q+hB
         +9Ap/wi9hUvBXUupIRO0STiU065aGTKQIX7d1CxHBABMaHPPzyCI9YeMfdXbOko7UGop
         ws1zGyrCQ95XWuhBfpIsW+rerVuF+uACQtKwEUvtSbqz6fXurSY4GreIEKT1Z/u59FrF
         BvXEjybsSgk144vHWk1x2Is1i4LhsWToJtX15PTkgopDF1b/0HrbNo+QMizyDEQT2xQD
         FPHA==
X-Received: by 10.43.68.134 with SMTP id xy6mr13215770icb.48.1369419733169;
 Fri, 24 May 2013 11:22:13 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 24 May 2013 11:21:32 -0700 (PDT)
In-Reply-To: <7vehcw9s0k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225393>

Junio C Hamano wrote:
>>> rev-parse (with an option, maybe) may be a better place for
>>> this.
>>
>> Er, no.  I actually want things like diff @{p}..HEAD.  I want it to be
>> a first-class revision, just like @{u}.
>
> I think Duy's suggestion makes perfect sense; rev-parse already has
> a mechanism to expand @{u} to the full name, so if you are hooking
> into the same codepath as @{u} to implement the "I publish there"
> information, which I think you should, you already should have it
> for free.

*scratches head*

Okay, I'm not understanding this.  I've implemented @{push} as a
revision, so all callers who know how to get_sha1_basic() will be able
to resolve this (including rev-parse).  Are you talking about
--symbolic-full-name?  That just calls dwim_ref(), which calls
interpret_branch_name() anyway: except you get a symbolic name instead
of the sha1.  Why do I have to think about rev-parse specifically in
this patch series?  rev-parse has no special logic for @{u} either.

The codepath that resolves @{u} is in interpret_branch_name(): it's
just a matter of reading branch->merge[0]->dst; it's trivial to
determine because read_config() just reads the configuration file and
fills in these values when you get_branch().  How do I get "I publish
there" information for free?  Where is it contained?  In fact, it's so
complicated to get that information that I had to break my head to
even get this far (after mucking around in the transport layer);
that's what I'm trying to show in this series.  Unless I'm very badly
mistaken, it's _impossible_ for any codepath in git to determine where
a push will go, except the one activated by invoking the builtin push.

The long-term impact of this series is not just @{push}, but that
anyone else in git will be able to determine where a push is supposed
to go.  Ultimately, it can lead to very heavy optimizations of the
transport_push() codepath (which is currently super-convoluted unless
I'm missing something).
