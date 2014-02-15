From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Sat, 15 Feb 2014 15:53:55 +0700
Message-ID: <20140215085355.GA15461@lanh>
References: <20140214113136.GA17817@raven.inka.de>
 <87a9dt981o.fsf@igel.home>
 <CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com>
 <xmqqy51dirjs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Josef Wolf <jw@raven.inka.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 15 09:58:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEb0R-0002Ew-5A
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 09:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbaBOIxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 03:53:47 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:49398 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbaBOIxq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 03:53:46 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so13326086pbc.38
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 00:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eQHUtm+4d9k/LN5Uizs82Dz15rgdwx+L7lwavK2q6Uc=;
        b=YUnXlSekIQyevGbKjiLBi9Ke3pp9Stoq5oeYtItr9cXM1d9KAGmSWNT8SO/53p899k
         5K9ruEjJ+K2FXD07aewfT7DStSZPq+3d6U1UJAJOliIVBqKegl/aNMEmxUELM4KFMWgT
         QJ+equb7iS1ZnC4IHr3ZbfB3lnYXilDWYCr9NAznGuqYI3eoYDpprGuGjNVpefX7ESHP
         G3AMtfW2SzKdbRDvJe6iuU/mWAQNYUSDJdDV2+HAapCeRspoEdE6dz0gmxWAVnC9mdvm
         y0Gq4D3nkaIySO48DAVyWHg04/1wwaUjE+41V1+lE80VcpKVU5GIDMoXnp9ovGZZDmdO
         xDUQ==
X-Received: by 10.68.189.100 with SMTP id gh4mr14022600pbc.21.1392454426144;
        Sat, 15 Feb 2014 00:53:46 -0800 (PST)
Received: from lanh ([115.73.215.60])
        by mx.google.com with ESMTPSA id nz11sm61916714pab.6.2014.02.15.00.53.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Feb 2014 00:53:45 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 15 Feb 2014 15:53:55 +0700
Content-Disposition: inline
In-Reply-To: <xmqqy51dirjs.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242181>

On Fri, Feb 14, 2014 at 08:32:07AM -0800, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > On Fri, Feb 14, 2014 at 7:45 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> >> Josef Wolf <jw@raven.inka.de> writes:
> >>
> >>> Notice the refs/heads _within_ refs/heads!
> >>>
> >>> Now I wonder how I managed to get into this situation and what's the best way
> >>> to recover?
> >>
> >> Probably you did something like "git branch refs/heads/master".  You can
> >> remove it again with "git branch -d refs/heads/master".
> >
> > As a porcelain, "git branch" should prevent (or at least warn) users
> > from creating such refs, I think.
> 
> "warn", possibly, but I do not see a reason to *prevent*.
> 
>  A. You are not allowed to call your branch with a string that begins with
>     'refs/heads/'.
>  B. Why?
>  A. Because it will confuse you.
>  B. I know what I am doing.
>  A. ???

Prevent is a strong word. I meant we only do it if they force
it. Something like this..

-- 8< --
diff --git a/branch.c b/branch.c
index 723a36b..3f0540f 100644
--- a/branch.c
+++ b/branch.c
@@ -251,6 +251,11 @@ void create_branch(const char *head,
 			forcing = 1;
 	}
 
+	if (!force && dwim_ref(name, strlen(name), sha1, &real_ref))
+		die(_("creating ref refs/heads/%s makes %s ambiguous.\n"
+		      "Use -f to create it anyway."),
+		    name, name);
+
 	real_ref = NULL;
 	if (get_sha1(start_name, sha1)) {
 		if (explicit_tracking) {
-- 8< --
