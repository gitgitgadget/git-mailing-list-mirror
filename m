From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v4 20/24] introduce GIT_INDEX_VERSION environment variable
Date: Thu, 28 Nov 2013 10:57:02 +0100
Message-ID: <20131128095615.GA25478@goose.lan>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
 <1385553659-9928-21-git-send-email-t.gummerer@gmail.com>
 <CAPig+cSHcL62EW5z5n68jQcS4BWW9cZ=GqRwZaoyYM69NE55+w@mail.gmail.com>
 <xmqqk3ftsdk4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 28 10:57:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlyLR-0008S6-JW
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 10:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309Ab3K1J5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 04:57:10 -0500
Received: from mail-la0-f45.google.com ([209.85.215.45]:57604 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756783Ab3K1J5E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 04:57:04 -0500
Received: by mail-la0-f45.google.com with SMTP id eh20so5818812lab.4
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 01:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Th+TSQ9O34nbE1NxarKGG6DIUvGX/gHrAiAvaFhDfIE=;
        b=qul5TK/+zqQv8idUwSe9KNTeYa0DxR0pMnY4C3DRzaoHe/feFRlp0ePQdGZI34RkRq
         FjTVRJpGID9ecwLeFo5pO+B7FlRQVyQY8gEqeUApadq2pwYgfyX6iAp4jY1pY/q/A9DD
         3i2zaG+tFSXIp7oCbke5yZ5dqfYJN5nlNBU6hnooHf2EeORC/05bcgS+zkysPlmZRYiN
         lXBLKWItOGfhJqD1lWOKzwvKQo1OYOQUv/zD9w2XijnYflFcb2hhaxiqZHgRqkvaiEpA
         F6IvG4Ttiqirzl8wpozAO98Q0x5VshRXRCk0fT3f69SkU5PUgTkGBISUkCR32WhnSdjA
         49WA==
X-Received: by 10.112.139.72 with SMTP id qw8mr9499524lbb.16.1385632622373;
        Thu, 28 Nov 2013 01:57:02 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id r7sm48963920lbo.5.2013.11.28.01.56.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2013 01:57:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqk3ftsdk4.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2012-12-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238488>

On 11/27, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Wed, Nov 27, 2013 at 7:00 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >> Respect a GIT_INDEX_VERSION environment variable, when a new index is
> >> initialized.  Setting the environment variable will not cause existing
> >> index files to be converted to another format for additional safety.
> >>
> >> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> >> ---
> >> diff --git a/read-cache.c b/read-cache.c
> >> index 46551af..04430e5 100644
> >> --- a/read-cache.c
> >> +++ b/read-cache.c
> >> @@ -1233,8 +1233,13 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
> >>  void initialize_index(struct index_state *istate, int version)
> >>  {
> >>         istate->initialized = 1;
> >> -       if (!version)
> >> -               version = INDEX_FORMAT_DEFAULT;
> >> +       if (!version) {
> >> +               char *envversion = getenv("GIT_INDEX_VERSION");
> >> +               if (!envversion)
> >> +                       version = INDEX_FORMAT_DEFAULT;
> >> +               else
> >> +                       version = atoi(envversion);
> >
> > Do you want to check that atoi() returned a valid value and emit a
> > diagnostic if it did not?
> 
> 
> Good eyes.
> 
> We use strtoul() for this kind of thing instead of atoi() for format
> checking.  The code also needs to make sure that the value obtained
> thusly are among the versions that are supported.
> 
> Thanks.

Thanks both.  Will use strtoul and check the value in the re-roll.

-- 
Thomas
