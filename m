From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/3] Remotes library, take 3
Date: Sat, 12 May 2007 00:10:56 -0700
Message-ID: <7viray5xfj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705112234520.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat May 12 09:11:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmlkt-00075U-4v
	for gcvg-git@gmane.org; Sat, 12 May 2007 09:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436AbXELHK6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 03:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756468AbXELHK6
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 03:10:58 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:39474 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756436AbXELHK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 03:10:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512071056.BOKK13903.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 03:10:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id y7Aw1W0071kojtg0000000; Sat, 12 May 2007 03:10:56 -0400
In-Reply-To: <Pine.LNX.4.64.0705112234520.18541@iabervon.org> (Daniel
	Barkalow's message of "Fri, 11 May 2007 22:39:19 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47021>

Daniel Barkalow <barkalow@iabervon.org> writes:

> This series is the same as the previous version, except that it matches 
> the current behavior of builtin-push with respect to treating names as 
> literal URIs.

Thanks.

        diff --git a/remote.c b/remote.c
        index 32a0acf..1dd2e77 100644
        --- a/remote.c
        +++ b/remote.c
        @@ -189,12 +189,14 @@ struct remote *remote_get(const char *name)
                if (!name)
                        name = default_remote_name;
                ret = make_remote(name, 0);
        -	if (*name == '/')
        -		add_uri(ret, name);
        -	if (!ret->uri)
        -		read_remotes_file(ret);
        +	if (name[0] != '/') {
        +		if (!ret->uri)
        +			read_remotes_file(ret);
        +		if (!ret->uri)
        +			read_branches_file(ret);
        +	}
                if (!ret->uri)
        -		read_branches_file(ret);
        +		add_uri(ret, name);
                if (!ret->uri)
                        return NULL;
                return ret;

This is more similar to the original from builtin-push.c than
your previous round, but it is still not identical.

The differences should not matter in real life, but I think we
need to make it clear what the differences are to warn users.
Here is my reading of the change (please correct me).

Earlier.

  - A name that does not begin with a slash could be a remote
    shorthand.  Check remotes, config and branches in this order
    and stop once a match is found.

  - Otherwise use the name as a literal URI.

This patch.

  - Config always wins.

  - A name that does not begin with a slash could be found in
    remotes or branches; check them in this order.

  - Otherwise use it as is.

Theoretically people _could_ have had a config like

	[remote "/pub"]
		url = blah

but it would never have matched.  This ``broken'' config file
suddenly start to interfere when somebody does:

	$ git push /pub

Also people may have had a remotes and config of the same name,
and currently what is defined in config is ignored, but with the
new code, config takes precedence.  Which is unarguably good,
but still a change I should remember to write down in the
release notes, hence prefer to have it clearly described in the
commit log message.

We probably would not care about the first difference, but it is
easy enough to guard against, I think.  Perhaps with this patch?

-- >8 --
parsing remotes: forbid "remote./foo.variable" and fix segfault

Historically we did not pay attention to a remote shorthand
defined in the config file whose name starts with a slash
(because we always took such a string as a literal localfile
URL), but the new organization of the parsing code makes config
always take precedence.  It does not make much sense to define
such a remote shorthand, so protect ourselves against it.

Also, the code forgot that a config variable could be spelled
without a value to denote a boolean set to true, in which case
the config parser passes a NULL in value parameter, and run
xstrdup() on it without checking.  Fix this.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 remote.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/remote.c b/remote.c
index 1dd2e77..05df196 100644
--- a/remote.c
+++ b/remote.c
@@ -149,7 +149,24 @@ static int handle_config(const char *key, const char *value)
 	subkey = strrchr(name, '.');
 	if (!subkey)
 		return error("Config with no key for remote %s", name);
+	if (*subkey == '/')
+		return error("Config remote shorthand cannot begin with '/': %s", name);
 	remote = make_remote(name, subkey - name);
+	if (!value) {
+		/* if we ever have a boolean variable, e.g. "remote.*.disabled"
+		 * [remote "frotz"]
+		 *	disabled
+		 * is a valid way to set it to true; we get NULL in value so
+		 * we need to handle it here.
+		 *
+		 * if (!strcmp(subkey, ".disabled")) {
+		 * 	val = git_config_bool(key, value);
+		 *	return 0;
+		 * } else
+		 *
+		 */
+		return error("Config with no value for remote %s", name);
+	}
 	if (!strcmp(subkey, ".url")) {
 		add_uri(remote, xstrdup(value));
 	} else if (!strcmp(subkey, ".push")) {
