From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 2/2] notes: handle multiple worktrees
Date: Mon, 03 Aug 2015 14:46:23 -0400
Organization: Twitter
Message-ID: <1438627583.4439.11.camel@twopensource.com>
References: <1438380669-11012-1-git-send-email-dturner@twopensource.com>
	 <1438380669-11012-2-git-send-email-dturner@twopensource.com>
	 <CALKQrgcrpQ2j2J-65RJhN7owwmSzhqyGinGjUbicFbY=m82tNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Aug 03 20:46:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMKkr-0002Ca-0K
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 20:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbbHCSq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 14:46:28 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36108 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025AbbHCSq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 14:46:26 -0400
Received: by qgeh16 with SMTP id h16so94753869qge.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 11:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=mHKMMvSJNisIHiaJInvJnmvlPldpO93xnD1vz+r5emw=;
        b=lL2Ru33sRft9jqYyPrRYgjmbjLkpD195DPR9sq+x72eCWnVHXnfRxTh9o/8RwxshVk
         9uM9N3t/zLXcTusH07F36TyTHSDBBOOE9tI+WpeE2bk8L89dcFds86JuavifUqMUDFkJ
         CJUqHoBW+ByniMHeBwS3I0c3dB8TzuW2g6n7diVBH2mvao2FHDv76CZEX8fDPMrMaMEC
         WrEX2x/6ZM6bljhTTuFxUIF+bzGeIDJ5nv5qbeHarKLfzi+cPYjvO0MN7StDFt5g7nly
         erQXwAUKZJ/1qPyYpzOuijM+HCn1tR1cFLqVXQ1/H9tvoE7PUmtZSaT4jq7+24zqVJ4j
         Wd/A==
X-Gm-Message-State: ALoCoQnbI+c/In5Ev5CEjD6YZjUGVJCkiX3ghhb0zmwB2faCL8in9mTIDngDIn3CxCRqpld7JJek
X-Received: by 10.140.85.208 with SMTP id n74mr26309168qgd.67.1438627585688;
        Mon, 03 Aug 2015 11:46:25 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id f27sm7311179qkh.23.2015.08.03.11.46.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Aug 2015 11:46:24 -0700 (PDT)
In-Reply-To: <CALKQrgcrpQ2j2J-65RJhN7owwmSzhqyGinGjUbicFbY=m82tNA@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275186>

On Sat, 2015-08-01 at 15:51 +0200, Johan Herland wrote:
> On Sat, Aug 1, 2015 at 12:11 AM, David Turner <dturner@twopensource.com> wrote:
> > Before creating NOTES_MERGE_REF, check NOTES_MERGE_REF using
> > find_shared_symref and die if we find one.  This prevents simultaneous
> > merges to the same notes branch from different worktrees.
> >
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  builtin/notes.c                  |  5 +++
> >  t/t3320-notes-merge-worktrees.sh | 72 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 77 insertions(+)
> >  create mode 100755 t/t3320-notes-merge-worktrees.sh
> >
> > diff --git a/builtin/notes.c b/builtin/notes.c
> > index 63f95fc..e4dda79 100644
> > --- a/builtin/notes.c
> > +++ b/builtin/notes.c
> > @@ -19,6 +19,7 @@
> >  #include "string-list.h"
> >  #include "notes-merge.h"
> >  #include "notes-utils.h"
> > +#include "branch.h"
> >
> >  static const char * const git_notes_usage[] = {
> >         N_("git notes [--ref <notes-ref>] [list [<object>]]"),
> > @@ -825,10 +826,14 @@ static int merge(int argc, const char **argv, const char *prefix)
> >                 update_ref(msg.buf, default_notes_ref(), result_sha1, NULL,
> >                            0, UPDATE_REFS_DIE_ON_ERR);
> >         else { /* Merge has unresolved conflicts */
> > +               char *existing;
> >                 /* Update .git/NOTES_MERGE_PARTIAL with partial merge result */
> >                 update_ref(msg.buf, "NOTES_MERGE_PARTIAL", result_sha1, NULL,
> >                            0, UPDATE_REFS_DIE_ON_ERR);
> >                 /* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
> > +               existing = find_shared_symref("NOTES_MERGE_REF", default_notes_ref());
> 
> Please confirm my assumption here: existing originally comes from a
> strbuf_detach(), so it's the caller's (i.e. our) responsibility to
> free() it, but we don't care, as we just die()d anyway. Correct?

Confirmed.

 I will fix the other issues you reported.
