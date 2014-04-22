From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Tue, 22 Apr 2014 11:27:02 -0500
Message-ID: <535698563b5d1_3e5aed7308da@nysa.notmuch>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
 <53560DA6.5040202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Ilya Bobyr <ilya.bobyr@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 18:37:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcdhL-0002rr-G1
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 18:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757310AbaDVQh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 12:37:27 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:64381 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756642AbaDVQhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 12:37:25 -0400
Received: by mail-oa0-f42.google.com with SMTP id i4so5968790oah.1
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 09:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=hLE3IZsqHYOt3CzTOcOEoYpkenfAjMrH/7L9x7g6m9w=;
        b=Sye4g5ezkHz/fOoNPshh87+nlTurKbMwqO1qPYxiwXvGAuuuEVlQF+pwznKLCXy/YZ
         jf6dEchPpW/oHDrrP1f9t910w8mLchMhmk4NMvuF2poqYN1zDYp2PHiwlvgD1XSU91ND
         edDpoMQgtScRRIHHhJnzM1Xms9/RvTe8LmOemVpstUVNLaMS9mbx81ORk+a/vUViBC9g
         JBybYcNjQtnAuo+SQj5Gvsb0FimH+i37uhIp5+KSnwj7V98wFhdqVISBN9S26HJUiVBc
         bDRz8fKAP2xfvd7lKMYDWpi9SbR5Pecn+Y0pZum4mTexISUOnSndK0fnaIhBg9wUKQSl
         Q/0Q==
X-Received: by 10.60.39.131 with SMTP id p3mr13164277oek.44.1398184644457;
        Tue, 22 Apr 2014 09:37:24 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id jr2sm10695711obb.8.2014.04.22.09.37.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 09:37:23 -0700 (PDT)
In-Reply-To: <53560DA6.5040202@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246748>

Ilya Bobyr wrote:
> On 4/20/2014 7:23 PM, Felipe Contreras wrote:
> > [...]
> >
> > diff --git a/branch.c b/branch.c
> > index 660097b..c2058d1 100644
> > --- a/branch.c
> > +++ b/branch.c
> > @@ -4,6 +4,7 @@
> >  #include "refs.h"
> >  #include "remote.h"
> >  #include "commit.h"
> > +#include "run-command.h"
> >  
> >  struct tracking {
> >  	struct refspec spec;
> > @@ -304,6 +305,11 @@ void create_branch(const char *head,
> >  	if (real_ref && track)
> >  		setup_tracking(ref.buf + 11, real_ref, track, quiet);
> >  
> > +	if (run_hook_le(NULL, "update-branch", ref.buf + 11, sha1_to_hex(sha1), NULL)) {
> > +		unlock_ref(lock);
> 
> lock is NULL if dont_change_ref is true.  unlock_ref() would crash in
> that case.
> You may want to add a test for that.

That should be easy to fix.
 
> > +		die("hook 'update-branch' returned error");
> > +	}
> > +
> >  	if (!dont_change_ref)
> >  		if (write_ref_sha1(lock, sha1, msg) < 0)
> >  			die_errno(_("Failed to write ref"));
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 9b3c04d..6ec96e5 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -581,9 +581,10 @@ static void update_remote_refs(const struct ref *refs,
> >  	}
> >  }
> >  
> > -static void update_head(const struct ref *our, const struct ref *remote,
> > +static int update_head(const struct ref *our, const struct ref *remote,
> >  			const char *msg)
> >  {
> > +	int err = 0;
> >  	if (our && starts_with(our->name, "refs/heads/")) {
> >  		/* Local default branch link */
> >  		create_symref("HEAD", our->name, NULL);
> > @@ -591,6 +592,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
> >  			const char *head = skip_prefix(our->name, "refs/heads/");
> >  			update_ref(msg, "HEAD", our->old_sha1, NULL, 0, DIE_ON_ERR);
> >  			install_branch_config(0, head, option_origin, our->name);
> > +			err = run_hook_le(NULL, "update-branch", head, sha1_to_hex(our->old_sha1), NULL);
> 
> This is happening after the branch is updated and a config section for
> it is created.

I see that now, however, I cannot find where in builtin/clone.c is the branch
ref actually updated.

Worst, I don't see how I could possibly configure a hook to be triggered when
cloning, so I cannot test.
 
> >  		}
> >  	} else if (our) {
> >  		struct commit *c = lookup_commit_reference(our->old_sha1);
> > @@ -606,6 +608,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
> >  		update_ref(msg, "HEAD", remote->old_sha1,
> >  			   NULL, REF_NODEREF, DIE_ON_ERR);
> >  	}
> > +	return err;
> >  }
> >  
> >  static int checkout(void)
> > @@ -987,7 +990,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
> >  	update_remote_refs(refs, mapped_refs, remote_head_points_at,
> >  			   branch_top.buf, reflog_msg.buf, transport, !is_local);
> >  
> > -	update_head(our_head_points_at, remote_head, reflog_msg.buf);
> > +	err = update_head(our_head_points_at, remote_head, reflog_msg.buf);
> >  
> >  	transport_unlock_pack(transport);
> >  	transport_disconnect(transport);
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 1c41cbd..084dc36 100644
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -631,7 +631,11 @@ do_next () {
> >  		git update-ref -m "$message" $head_name $newhead $orig_head &&
> >  		git symbolic-ref \
> >  		  -m "$GIT_REFLOG_ACTION: returning to $head_name" \
> > -		  HEAD $head_name
> > +		  HEAD $head_name &&
> > +		if test -x "$GIT_DIR"/hooks/update-branch; then
> > +			"$GIT_DIR"/hooks/update-branch $branch_name \
> > +				$newhead $onto
> > +		fi
> 
> It looks like this is also after the branch was already updated.

This and the one below should be easy to fix.

-- 
Felipe Contreras
