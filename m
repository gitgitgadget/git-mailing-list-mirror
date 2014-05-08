From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 2/2] ignorecase: Fix git mv on insensitive filesystems
Date: Thu, 08 May 2014 13:40:23 -0700
Organization: Twitter
Message-ID: <1399581623.11843.105.camel@stross>
References: <536B4680.1010806@web.de>
	 <1399569814-20644-1-git-send-email-dturner@twopensource.com>
	 <1399569814-20644-3-git-send-email-dturner@twopensource.com>
	 <xmqqha502ghc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 08 22:40:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiV7K-0005Tf-D4
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 22:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672AbaEHUka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 16:40:30 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:64351 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755668AbaEHUk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 16:40:29 -0400
Received: by mail-qc0-f181.google.com with SMTP id m20so3460171qcx.26
        for <git@vger.kernel.org>; Thu, 08 May 2014 13:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=AP3dWFl6nt0c3G9mKfFsarrT+KhLEwQ6Auknveoxc1o=;
        b=VRfF5miIEiXn8KYwdC3lVmAE6IbpGTfSLnVMTfqxeiwse9kwwKBV1l8Le2O+U0qxhj
         Hvix/D67XbY6UbSVLKBjAndRjUmpb2bm7UvSKxMc9j2CE9psvcZTA9PfETRuRMxCovh8
         Po/8BwH6y24pbIpEGeOOksIrq9YNX72hhfa4BE7Now7D+lUKrMXzea4ALBd3790gOrN1
         +c6f9p+O7L1f0jixvAbbNoLF2zX27jooyJFdvxaK5Y4j3z8czm9wc7eTPB3iQSRRJtqG
         TYECW0v4bFpvORJvXj4smeysQfy0Z1z7JT6lA7awmTHF/WT3TfpBo/yl7aHFyykdy1iL
         8WzA==
X-Gm-Message-State: ALoCoQkxtVfJES8JyqqP3DvLA76kBtXg8c3IKAhh16IXt93rsPAtPimji5mi1Ny+LazsD/Xe0Mrz
X-Received: by 10.140.104.78 with SMTP id z72mr8343591qge.60.1399581629189;
        Thu, 08 May 2014 13:40:29 -0700 (PDT)
Received: from [172.25.144.67] ([8.25.197.27])
        by mx.google.com with ESMTPSA id o3sm3096031qas.0.2014.05.08.13.40.27
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 08 May 2014 13:40:28 -0700 (PDT)
In-Reply-To: <xmqqha502ghc.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248443>

On Thu, 2014-05-08 at 12:54 -0700, Junio C Hamano wrote:
> dturner@twopensource.com writes:
> 
> > From: David Turner <dturner@twitter.com>
> >
> > Make it possible to change the case of a filename on a
> > case-insensitive filesystem using git mv.  Change git mv to allow
> > moves where the destination file exists if the destination file has
> > the same name as the source file ignoring case.
> >
> > Signed-off-by: David Turner <dturner@twitter.com>
> > ---
> >  builtin/mv.c                | 3 ++-
> >  t/t6039-merge-ignorecase.sh | 2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/mv.c b/builtin/mv.c
> > index 45e57f3..f4d89d0 100644
> > --- a/builtin/mv.c
> > +++ b/builtin/mv.c
> > @@ -202,7 +202,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
> >  			}
> >  		} else if (cache_name_pos(src, length) < 0)
> >  			bad = _("not under version control");
> > -		else if (lstat(dst, &st) == 0) {
> > +		else if (lstat(dst, &st) == 0 &&
> > +			 (!ignore_case || strcasecmp(src, dst))) {
> 
> Hmm, I would find it easier to read if it were:
> 
> 		... if (lstat(dst, &st) == 0 &&
>                 	!(ignore_case && !strcasecmp(src, dst))) {
> 
> That is, "it is an error for dst to exist, unless we are on a case
> insensitive filesystem and src and dst refer to the same file.", but
> maybe it is just me.

I personally dislike the double negative. I also considered breaking it
out into a little function with a self-documenting name -- does that
sound better?

> More importantly, what is the end-user visible effect of this
> change?  Is it fair to summarize it like this?
> 
>     On a case-insensitive filesystem, "mv hello.txt Hello.txt"
>     always trigger the "dst already exists" error, because both
>     names refer to the same file to MS-DOS, requiring the user to
                                     ^^^^^^
(I have not actually tested on Windows; I tested on the Mac since that's
what I have handy)

>     pass the "--force" option.  Allow it without "--force".

Yes.

> Overwriting an existing file with "mv hello.txt Hello.txt" on a case
> sensitive filesystem *is* an unusual operation, and that is the
> reason why we require "--force" to make sure that the user means it.
> I have a slight suspicion that the same "mv hello.txt Hello.txt" on
> a case insensitive filesystem, where two names are known (to the end
> user of such a filesystem) to refer to the same path would equally
> be a very unusual thing to do, and such an operation may deserve a
> similar safety precaution to make sure that the user really meant to
> do so by requiring "--force".
> 
> So, I dunno.

The argument against --force is that git's behavior should not
significantly differ between sensitive and insensitive filesystems
(where possible).  I do not see a case-changing rename as unusual on a
case-insensitive filesystem; these filesystems typically preserve case,
and a user might reasonably care about the case of a filename either for
aesthetic reasons or for functionality on sensible filesystems (e.g.
developers who work on Macs but deploy on GNU/Linux, as is quite
common).

The Mac's interface itself provides conflicting evidence: on one hand,
we might expect git mv to work like plain mv: nothing special is needed
to do a case-changing mv). On the other hand, in the Finder, attempting
a case-changing rename causes an error message (which there is no way to
get around other than the two-rename dance).  I read this as "ordinary
users never intentionally change the case of files, but developers
sometimes do", but that's not the only possible reading.

I myself am not actually a Mac user; I simply support a bunch of Mac
users (which is where the merge bug came from).  So I don't know what
Mac users would prefer.  Maybe there are some on the git mailing list?

I also have not tried on Windows.  I put in an email to the one
Windows-using friend I can think of to ask her to give Windows Explorer
(or whatever it's called these days) a try.  My guess (based on a quick
Google search) would be is that it works without error, but I will send
an update if I hear otherwise.
