From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/5] Add remote functions
Date: Wed, 2 May 2007 23:27:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705022303370.28708@iabervon.org>
References: <Pine.LNX.4.64.0704281303570.28708@iabervon.org>
 <7virbfg22c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 03 05:28:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjRz4-0007Rt-Pb
	for gcvg-git@gmane.org; Thu, 03 May 2007 05:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767354AbXECD1z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 23:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767355AbXECD1z
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 23:27:55 -0400
Received: from iabervon.org ([66.92.72.58]:4934 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767354AbXECD1y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 23:27:54 -0400
Received: (qmail 8092 invoked by uid 1000); 3 May 2007 03:27:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 May 2007 03:27:52 -0000
In-Reply-To: <7virbfg22c.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46058>

On Sat, 28 Apr 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Make a struct and a set of functions to handle the parsing of remote
> > configurations (branches files, remotes files, and config sections),
> > and do some simple operations on lists of refspecs in the struct.
> >
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> 
> I do not have any objection to making a generally useful library
> function to deal with branches/remotes/config, and this is
> probably a good start.  Eventually we would want to do a built-in
> git-remote command that supports interactive editing of remote
> information, not just fetch/push in C.
> 
> But I do not think I can apply this patch as is, even for 'pu'.
> Comments below.
> 
> > diff --git a/remote.c b/remote.c
> > new file mode 100644
> > index 0000000..58e6a96
> > --- /dev/null
> > +++ b/remote.c
> > @@ -0,0 +1,241 @@
> > +#include "cache.h"
> > +#include "remote.h"
> > +
> > +#define MAX_REMOTES 16
> > +
> > +static struct remote *remotes[MAX_REMOTES];
> 
> I do not think the limitation of MAX_URI=16 in the original is
> unreasonable, but this MAX_REMOTES is way too low, if we want to
> eventually support somebody like Andrew, who has to deal with a
> few dozen git trees.

Sure; easy enough to fix.

> > +static void add_uri(struct remote *remote, const char *uri)
> > +{
> > +	int i;
> > +	for (i = 0; i < MAX_REMOTE_URI; i++) {
> > +		if (!remote->uri[i]) {
> > +			remote->uri[i] = uri;
> > +			return;
> > +		}
> > +	}
> > +	error("ignoring excess uri");
> > +}
> 
> Why not do this just like refspecs, as an array of URIs?  Doing
> so would also lift the MAX_REMOTE_URI limitation.  Although more
> than one URIs per remote is not a norm but an exception (and
> makes sense only for push), it would shrink the base structure,
> and probably make the code simpler.

Again easy enough. Actually, it might be nice to have some common 
functions for arrays of pointers, since I've now got 3 nearly identical 
functions, but not too important.

> > +
> > +static struct remote *make_remote(const char *name, int len)
> > +{
> > +	int i, empty = -1;
> > +
> > +	for (i = 0; i < MAX_REMOTES; i++) {
> > +		if (!remotes[i]) {
> > +			if (empty < 0)
> > +				empty = i;
> > +		} else {
> > +			if (len ? !strncmp(name, remotes[i]->name, len) :
> > +			    !strcmp(name, remotes[i]->name))
> > +				return remotes[i];
> > +		}
> 
> If you have "remote.foobar.url = /git/repo.git", this is called
> with "foobar.url" in name and 6 in len.  Do you want to match an
> existing remote whose name is "foobarbaz"?

Yeah, I need to test !(existing remote)[len] also.

> > +static void read_remotes_file(struct remote *remote)
> > +{
> > +	FILE *f = fopen(git_path("remotes/%s", remote->name), "r");
> > +
> > +	if (!f)
> > +		return;
> > +	while (fgets(buffer, BUF_SIZE, f)) {
> > +		int is_refspec;
> 
> The original dealt with URL or refspec, so "is_refspec" made
> some sense.  It isn't anymore as you differentiate between push
> and fetch refspecs.

"value_list" instead.

> > +static void read_branches_file(struct remote *remote)
> > +{
> > +	const char *slash = strchr(remote->name, '/');
> > +	int n = slash ? slash - remote->name : 1000;
> > +	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
> > +	char *s, *p;
> > +	int len;
> 
> I know you inherited this from builtin-push.c, but can't we
> clean up this magic 1000 somehow, please?

I'm a bit leary of touching this code; I don't have repositories with this 
sort of config to test against. Can I just move it and have someone how 
understands the code clean it up (before or after)?

> > +static const char *default_remote_name = NULL;
> > +static const char *current_branch = NULL;
> > +static int current_branch_len = 0;
> > +
> > +static int handle_config(const char *key, const char *value)
> > +{
> > +	const char *name;
> > +	const char *subkey;
> > +	struct remote *remote;
> > +	if (!prefixcmp(key, "branch.") && current_branch &&
> > +	    !strncmp(key + 7, current_branch, current_branch_len) &&
> > +	    !strcmp(key + 7 + current_branch_len, ".remote")) {
> > +		default_remote_name = xstrdup(value);
> > +	}
> 
> Who sets current_branch to non-NULL value?  It is static and I
> do not see anybody setting it in this file.

I was going to set it when I figured out how to find the right value, but 
then forgot. (This would also make "git-push" use the same remote as 
"git-pull" when the current branch has a "remote" setting, which is 
obviously less surprising, but is a change in behavior)

> Also the original value of default_remote_name leaks here.  But
> you cannot blindly free the original value, as you could end up
> storing it in ret->uri[0] when somebody calls remote_get(NULL).

Actually, read_config() can only do anything once (since it returns with 
default_remote_name not null), so handle_config can't be called again 
after remote_get() has potentially used it. So I can definitely free it.

> > +	if (prefixcmp(key,  "remote."))
> > +		return 0;
> > +	name = key + 7;
> > +	subkey = strchr(name, '.');
> > +	if (!subkey)
> > +		return error("Config with no key for remote %s", name);
> 
> This is not right.
> 
> 	[section "section name"]
>                  variable = value
> 
> allows dot in "section name" part, so you would want strrchr()
> to find out the end of it, not the first dot with strchr().  You
> found an input error (missing subkey) if strrchr() finds the dot
> at the end of "remote." (i.e. subkey == key + 6).

Just replacing strchr with strrchr does the right thing, right? (If I 
start at name (== key + 7), it won't find that wrong dot.)

> > +char *remote_fetch_to(struct remote *remote, const char *ref)
> > +{
> > +	int i;
> > +	for (i = 0; i < remote->fetch_refspec_nr; i++) {
> > +		const char *refspec = remote->fetch_refspec[i];
> > +		const char *cons = strchr(refspec, ':');
> > +		const char *glob = strchr(refspec, '*');
> > +		if (*refspec == '+')
> > +			refspec++;
> 
> I cannot offhand tell what this function is about...
> 
> Would there be callers who are interested in finding out if
> refspec is forcing or not?
> 
> You are not protecting yourself from refspecs without tracking
> branch (i.e. sans any colon) and would segfault in the rest of
> this function.

This is to find the local tracking ref that a remote head would be fetched 
to, taking into account patterns and multiple items in the list. I should 
probably actually be sucking this code out of builtin-fetch--tool and 
connect, which I hadn't noticed handled this in C already.

	-Daniel
*This .sig left intentionally blank*
