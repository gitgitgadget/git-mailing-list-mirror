From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git 2.7.0 gitignore behaviour regression
Date: Fri, 8 Jan 2016 16:02:31 +0700
Message-ID: <20160108090231.GA9609@lanh>
References: <4B0F686D-3DF9-4E5D-971D-DB106C6573FD@mikemcquaid.com>
 <20160105150602.GA4130@sigill.intra.peff.net>
 <20160107234455.GB265296@vauxhall.crustytoothpaste.net>
 <CACsJy8C1R+JVmOXQ87eBP1COFNk3Vfqtb6AKzzT65catUhPczg@mail.gmail.com>
 <20160108024125.GD265296@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Mike McQuaid <mike@mikemcquaid.com>,
	Git Mailing List <git@vger.kernel.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Jan 08 10:02:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHSwM-0002q8-Ll
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 10:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbcAHJC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 04:02:29 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33099 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbcAHJC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 04:02:28 -0500
Received: by mail-pa0-f42.google.com with SMTP id cy9so279078119pac.0
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 01:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=oZgszk12JflpsqyXdYGlWDCoRVZ9nn+v3G8Xrtd/0sw=;
        b=nwGdKmtJCwqJLDX2hDRP12HrVtQIaQ7psdfmtvVG0Bsl136gfd7DIPxH7OrVauKUAU
         L/p6A84azqRUE87tAoam8ni7gE9AUZDwJkh8mymSAj3mz2cC4C8LVLeKvqTw6L/7WLHH
         v8MwiFAX8aI8YjvasjVvrgNltZYlsti+zODDE3WYi/qXKyuMO9nngKvcCEh4OOHR/XZB
         1UlJLp0XwN5wSiKn9CS4bCEQAK+2zs8X5GnsOglDubR+TOOKZFWcHJ19Fkh+gjH7k3ZA
         LthTdZkbEqURXJjday4uKo38x2L4X6X3+qmF1D0A6KyWn23n4Q4YxTSSM19onYWi8gnf
         QcDw==
X-Received: by 10.67.14.201 with SMTP id fi9mr157444033pad.41.1452243747585;
        Fri, 08 Jan 2016 01:02:27 -0800 (PST)
Received: from lanh ([171.233.231.79])
        by smtp.gmail.com with ESMTPSA id cq4sm49701450pad.28.2016.01.08.01.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2016 01:02:26 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 08 Jan 2016 16:02:31 +0700
Content-Disposition: inline
In-Reply-To: <20160108024125.GD265296@vauxhall.crustytoothpaste.net>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283528>

On Fri, Jan 08, 2016 at 02:41:25AM +0000, brian m. carlson wrote:
> On Fri, Jan 08, 2016 at 07:38:58AM +0700, Duy Nguyen wrote:
> > On Fri, Jan 8, 2016 at 6:44 AM, brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > > I think there's still a bug in the code here.  If you do
> > >
> > >   git init
> > >   mkdir -p base/a/
> > >   printf 'base/a/\n!base/a/b.txt\n' >.gitignore
> > 
> > Here we have the ignore rule "base/a/", but gitignore.txt, section
> > NOTES mentions this
> > 
> >  - The rules to exclude the parent directory must not end with a
> >    trailing slash.
> 
> The text here says, "To re-include files or directories when their
> parent directory is excluded, the following conditions must be met".  In
> other words, the text implies that it's required for re-inclusion to
> work, not exclusion.
> 
> > >   git add .gitignore
> > >   git commit -m 'Add .gitignore'
> > >   >base/a/b.txt
> > >   git add base/a/b.txt
> > >   git commit -m 'Add base/a/b.txt'
> > >   >base/a/c.txt
> > >   git status --porcelain
> > >
> > > git status outputs base/a/c.txt as unknown, when it should be ignored.
> > > We saw this in a repository at $DAYJOB.
> > 
> > If I delete that trailing slash, c.txt is ignored. So it's known
> > limitation. I think we can make trailing slash case work too, but if I
> > remember correctly it would involve a lot more changes, so I didn't do
> > it (there are other conditions to follow anyway to make it work).
> 
> The case I'm seeing is that b.txt was already checked into the
> repository before being re-added, and c.txt was not.  So it didn't
> affect us that b.txt was ignored (as it was already in the repo), but
> c.txt not being ignored broke a whole bunch of scripts that checked that
> the repository was clean, simply because we upgraded Git.
> 
> I think regardless of whether b.txt is re-included, c.txt should be
> ignored.  If it isn't possible to re-include b.txt, that's fine, since
> that isn't a regression, but ignored files should remain ignored.

Thanks for clarification. I looked at this the wrong way. I agree it
is a regression.

The following should fix it. It looks correct (and does fix your test
case), but I will have to look harder over the weekend before sending
a proper patch.

-- 8< --
diff --git a/dir.c b/dir.c
index d2a8f06..7934e87 100644
--- a/dir.c
+++ b/dir.c
@@ -1008,6 +1008,7 @@ static struct exclude *last_exclude_matching_from_list(const char *pathname,
 	if (exc &&
 	    !(exc->flags & EXC_FLAG_NEGATIVE) &&
 	    !(exc->flags & EXC_FLAG_NODIR) &&
+	    !(exc->flags & EXC_FLAG_MUSTBEDIR) &&
 	    matched_negative_path)
 		exc = NULL;
 	return exc;
-- 8< --
--
Duy
