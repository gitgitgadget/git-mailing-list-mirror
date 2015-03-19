From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: Re: [PATCH, RFC] checkout: Attempt to checkout submodules
Date: Thu, 19 Mar 2015 16:15:09 -0400
Message-ID: <20150319201509.GB21536@tsaunders-iceball.corp.tor1.mozilla.com>
References: <1426681643-7516-1-git-send-email-tbsaunde@tbsaunde.org>
 <xmqqy4msizu1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 21:15:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYgqf-0004tx-Lz
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 21:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbbCSUPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 16:15:15 -0400
Received: from tbsaunde.org ([66.228.47.254]:57236 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbbCSUPN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 16:15:13 -0400
Received: from tsaunders-iceball.corp.tor1.mozilla.com (unknown [66.207.208.102])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id B9749C0A8;
	Thu, 19 Mar 2015 20:15:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqy4msizu1.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265823>

On Thu, Mar 19, 2015 at 11:53:10AM -0700, Junio C Hamano wrote:
> Trevor Saunders <tbsaunde@tbsaunde.org> writes:
> 
> > If a user does git checkout HEAD -- path/to/submodule they'd expect the
> > submodule to be checked out to the commit that submodule is at in HEAD.
> 
> Hmmm.
> 
> Is it a good idea to do that unconditionally by hard-coding the
> behaviour like this patch does?

if I was sure it was a good idea it wouldn't be an RFC :-)

> Is it a good idea that hard-coded behaviour is "checkout [-f]"?

I suspect it depends on how you end up in checkout_entry.  If you do git
checkout HEAD -- /some/file then you force over writing any changes to
/some/file so I think a user should probably expect when the path is to
a submodule the effect is the same, the path is forced to be in the state
it is in HEAD.

> I think "git submodule update" is the command people use when they
> want to "match" the working trees of submodules, and via the
> configuration mechanism submodule.*.update, people can choose what
> they mean by "match"ing.  Some people want to checkout the commit
> specified in the superproject tree by detaching HEAD at it.  Some
> people want to integrate by merging or rebasing.

 git submodule update is certainly the current way to deal with the
 situation that your checkout of the submodule is out of sync with what
 is in the containing repo.  However I think users who aren't familiar
 with submodules would expect to be able to use "standard" git tools to
 deal with them.  So if they see

diff --git a/git-core b/git-core
index bb85775..52cae64 160000
--- a/git-core
+++ b/git-core
@@ -1 +1 @@
-Subproject commit bb8577532add843833ebf8b5324f94f84cb71ca0
+Subproject commit 52cae643c5d49b7fa18a7a4c60c284f9ae2e2c71

I think they'd expect they could restore git-core to the state in head the same
way they could with any other file by running git checkout HEAD -- git-core,
and they'd be suprised when that sighlently did nothing.  I suppose its
an option to print a message saying that nothing is being done with the
submodule git submodule should be used, but that seems kind of
unhelpful.

On one hand it seems kind of user hostile to just toss out any changes
in the submodule that are uncommitted, on the other for any other path
it would seem weird to have git checkout trigger rebasing or merging.

Trev


> 
> > This is the most brute force possible way of try to do that, and so its
> > probably broken in some cases.  However I'm not terribly familiar with
> > git's internals and I'm not sure if this is even wanted so I'm starting
> > simple.  If people want this to work I can try and do something better.
> >
> > Signed-off-by: Trevor Saunders <tbsaunde@tbsaunde.org>
> > ---
> >  entry.c | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/entry.c b/entry.c
> > index 1eda8e9..2dbf5b9 100644
> > --- a/entry.c
> > +++ b/entry.c
> > @@ -1,6 +1,8 @@
> >  #include "cache.h"
> > +#include "argv-array.h"
> >  #include "blob.h"
> >  #include "dir.h"
> > +#include "run-command.h"
> >  #include "streaming.h"
> >  
> >  static void create_directories(const char *path, int path_len,
> > @@ -277,9 +279,25 @@ int checkout_entry(struct cache_entry *ce,
> >  		 * just do the right thing)
> >  		 */
> >  		if (S_ISDIR(st.st_mode)) {
> > -			/* If it is a gitlink, leave it alone! */
> > -			if (S_ISGITLINK(ce->ce_mode))
> > +			if (S_ISGITLINK(ce->ce_mode)) {
> > +				struct argv_array args = ARGV_ARRAY_INIT;
> > +				char sha1[41];
> > +
> > +				argv_array_push(&args, "checkout");
> > +
> > +				if (state->force)
> > +					argv_array_push(&args, "-f");
> > +
> > +				memcpy(sha1, sha1_to_hex(ce->sha1), 41);
> > +				argv_array_push(&args, sha1);
> > +				
> > +				run_command_v_opt_cd_env(args.argv,
> > +					       		 RUN_GIT_CMD, ce->name,
> > +							 NULL);
> > +				argv_array_clear(&args);
> > +
> >  				return 0;
> > +			}
> >  			if (!state->force)
> >  				return error("%s is a directory", path.buf);
> >  			remove_subtree(&path);
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
