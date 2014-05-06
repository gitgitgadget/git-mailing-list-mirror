From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] merge-recursive.c: Fix case-changing merge bug
Date: Tue, 06 May 2014 10:36:14 -0700
Organization: Twitter
Message-ID: <1399397774.11843.46.camel@stross>
References: <CAE+yK_m_bPt2pS6MQOrpvVDuLAJf8NFxYOgM8i98tU6-gLcTDw@mail.gmail.com>
	 <1398990069.19099.5.camel@stross>
	 <xmqqwqdyg7jt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 06 20:43:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhjI0-0006H7-7X
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 19:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbaEFRgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 13:36:20 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:51913 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbaEFRgT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 13:36:19 -0400
Received: by mail-qc0-f176.google.com with SMTP id r5so3029730qcx.21
        for <git@vger.kernel.org>; Tue, 06 May 2014 10:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=JiZ9dcTfoZH8CeRB1mWvlA/pWxKrN39rH9tsyklsZ2E=;
        b=BXu0xwV8h1R/GIe8j9sd3XkMqFCAx9l0Cr+s31ZSeKPPDOZhh0/47zPAta6o0DhrXb
         FrEhHvMBLRTHhqvl3j2tg8XO3RdyKVxIY0NktIjNPzUJydFWjVtkmIdTS6Q0GAq1cPKu
         d3ZK45g0nv6nnVOULyVstBp2lWLnjeMbkmjMza9VoLr61LzOnp84w04M+n+GvX67Eb6y
         DW3G+BhOj6xJAX8cCUtz1xB9l8x7vJj/ur9msU5Jr5Xg/A4OSQClLHm3b9geJDAHzDtT
         XPuDq9c1UjRBVZyDwlUlTQ4q6/j5SMt3L+k471C8CmE5OMsFTVDOXWlNrOa7PYG/JPWf
         CfJA==
X-Gm-Message-State: ALoCoQlzUMUMzC8ZGOVJkeZPupETAav4+AUcXRsRGuYVFOVB4g3TuYY1eN2g6tgnkk2SFf+PWV5v
X-Received: by 10.140.95.35 with SMTP id h32mr9549734qge.12.1399397778828;
        Tue, 06 May 2014 10:36:18 -0700 (PDT)
Received: from [172.25.143.182] ([8.25.197.27])
        by mx.google.com with ESMTPSA id w101sm16484027qge.12.2014.05.06.10.36.16
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 06 May 2014 10:36:18 -0700 (PDT)
In-Reply-To: <xmqqwqdyg7jt.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248209>

On Tue, 2014-05-06 at 10:07 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > On a case-insensitive filesystem, when merging, a file would be
> > wrongly deleted from the working tree if an incoming commit had
> > renamed it changing only its case.  When merging a rename, the file
> > with the old name would be deleted -- but since the filesystem
> > considers the old name to be the same as the new name, the new
> > file would in fact be deleted.
> >
> > We avoid this by not deleting files that have a case-clone in the
> > index at stage 0.
> >
> > Signed-off-by: David Turner <dturner@twitter.com>
> > ---
> >  merge-recursive.c           |  6 ++++++
> >  t/t7063-merge-ignorecase.sh | 32 ++++++++++++++++++++++++++++++++
> >  2 files changed, 38 insertions(+)
> >  create mode 100755 t/t7063-merge-ignorecase.sh
> >
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index 4177092..cab16fa 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -589,6 +589,12 @@ static int remove_file(struct merge_options *o, int clean,
> >  			return -1;
> >  	}
> >  	if (update_working_directory) {
> > +		if (ignore_case) {
> > +			struct cache_entry *ce;
> > +			ce = cache_file_exists(path, strlen(path), ignore_case);
> > +			if (ce && ce_stage(ce) == 0)
> > +				return 0;
> > +		}
> >  		if (remove_path(path))
> >  			return -1;
> >  	}
> 
> Thanks.
> 
> I wonder what happens if you did the same merge using the resolve
> strategy, though.  If you see a similar issue, and the true reason
> of the breakage turns out to be because three-way merge performed by
> unpack_trees() (with opts.update set to 1) considers that these
> paths that only differ in case in "our" tree, in the index and in
> the working tree are different paths (I am not saying that is the
> case, but that was one of my first hunches after seeing the initial
> report) then it may suggest that the above might not be the best
> change to fix the issue.

I changed the test to -s resolve, and it changed from failing to
passing.  So while I still don't know whether this is the right change,
it's at least not wrong for that reason.

> > diff --git a/t/t7063-merge-ignorecase.sh b/t/t7063-merge-ignorecase.sh
> > new file mode 100755
> > index 0000000..6d4959f
> > --- /dev/null
> > +++ b/t/t7063-merge-ignorecase.sh
> 
> Hmmm, did you really have to add a file dedicated for this single
> test?

Would you prefer that I add it to t6022-merge-rename.sh?  Or I could
add it to t7062-wtstatus-ignorecase.sh and rename that file to
t7062-ignorecase.sh.  
