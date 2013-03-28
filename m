From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Wed, 27 Mar 2013 17:07:04 -0700
Message-ID: <20130328000704.GN28148@google.com>
References: <20130327174259.373bafe1@hoelz.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	josh@joshtriplett.org
To: Rob Hoelz <rob@hoelz.ro>
X-From: git-owner@vger.kernel.org Thu Mar 28 01:07:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UL0Nc-00072y-Qm
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 01:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803Ab3C1AHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 20:07:12 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:37108 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283Ab3C1AHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 20:07:09 -0400
Received: by mail-pb0-f42.google.com with SMTP id xb4so5507012pbc.1
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 17:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mekcBItdzgtfv4VFKuddNGFd0umtrw4K/0K13HD7fLI=;
        b=X3S79uy1qLRhYEFMRlRDO6Th7reNe/Vbo9uraky946L0paLQt8N/rZRzjGdhfQGceq
         rw+Yy9zy5MUDjX4HPtov9rdGgcMXAvVcWgxlnFDUF0YCCI8SvRTRm0LXmkAJGBiighAC
         NEI0QzI0qG6r5A26EsnPkDMJ4ie++0bDJzckc8g+tc9i9U3totLqBhR+Uhg0F/87dDty
         ieGkLANUgKbxfuAalnBrlo/uJxMTMKzE2Ow3u2IazJZtzaiWq7DCdU4whJ+2YgYDFBg9
         maJupxTM7JhiOFEebG+1qZRD5O4kqGqSKlZF8b1Lt903U0zwJJvdYrVSCMz/TnYcoCrT
         nktw==
X-Received: by 10.68.212.104 with SMTP id nj8mr31844005pbc.197.1364429229214;
        Wed, 27 Mar 2013 17:07:09 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id cy4sm23163137pbc.13.2013.03.27.17.07.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 Mar 2013 17:07:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130327174259.373bafe1@hoelz.ro>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219360>

Hi,

Rob Hoelz wrote:

> git push currently doesn't consider pushInsteadOf when
> using pushurl; this test tests that.

I'd leave out this paragraph, since it is redundant next to the rest
of the commit message (except that you have added tests, which ideally
every bugfix patch would do :)).

[...]
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2142,8 +2142,7 @@ url.<base>.pushInsteadOf::
>  	automatically use an appropriate URL to push, even for a
>  	never-before-seen repository on the site.  When more than one
>  	pushInsteadOf strings match a given URL, the longest match is
> -	used.  If a remote has an explicit pushurl, Git will ignore this
> -	setting for that remote.
> +	used.

Old-timers used to the previous behavior might not guess immediately
how this interacts with pushurl.  (If I understand the initial
discussion at [1] correctly, an earlier, unreleased version of the
feature would push to the rewritten fetch url *in addition to* the
unmodified push url.  So there's more than one possible behavior here.)

How about:

	url.<base>.pushInsteadOf

		Any URL that starts with this value will not be pushed to;
		instead, it will be rewritten ... even for a
		never-before-seen repository on the site.

		This rewriting takes place even for explicit push URLs
		set using the `remote.<name>.pushurl` configuration
		variable.

		When more than one pushInsteadOf string matches a given
		URL, the longest match is used.

[1] http://thread.gmane.org/gmane.comp.version-control.git/127889

> --- a/remote.c
> +++ b/remote.c
> @@ -465,7 +465,11 @@ static void alias_all_urls(void)
>  		if (!remotes[i])
>  			continue;
>  		for (j = 0; j < remotes[i]->pushurl_nr; j++) {
> -			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites);
> +			char *copy = xstrdup(remotes[i]->pushurl[j]);
> +			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites_push);
> +			if (!strcmp(copy, remotes[i]->pushurl[j]))
> +				remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites);
> +			free(copy);

This is relying on !strcmp to detect that no pushInsteadOf rule
matched the URL.  By contrast, the existing pushInsteadOf support
does the following:

	const char *pushurl = alias_url(url, &rewrites_push);
	if (pushurl != url)
		add_pushurl(remote, pushurl);

Because it compares pointers, not strings, it is able to correctly
treat the identity substitution as a real match.  It also avoids some
allocation churn.  This new alias_url() call site should follow the
same convention.

Looking at that existing code also made me worry "Are we applying
the pushinsteadof subsitution twice?"

So let's see what happens:

	Caller calls into remote_get() to learn about remote "origin".
	... which in turn calls read_config()
	... which sets the config machinery in motion with callback handle_config()
	... which stores rewrite rules in 'rewrites' and 'rewrites_push' and
	    unmodified URLs in remotes[i]->url[], remotes[i]->pushurl[]

	Now read_config() calls alias_all_urls() to tweak the url and
	pushurl fields in place.  For each remote:
	 1. If a pushurl matches an *.insteadof rewrite rule, rewrite it.
	 2. Check if any pushurls exist.
	 3. If a url matches a *.pushinsteadof rule and no raw pushurls
	    existed, use the rewritten url as a push url.

	    If a url matches a *.insteadof rewrite rule, rewrite it.

With your tweak, step (1) above just also checks for *.pushinsteadof
in addition to *.insteadof, which should be safe (modulo the string
comparison vs pointer comparison detail mentioned above)

There's also the legacy .git/remotes and .git/branches code paths,
which are basically the same except there's no place for a pushurl.

How about the below, for squashing in?

diff --git i/Documentation/config.txt w/Documentation/config.txt
index 665c0de..25565ca 100644
--- i/Documentation/config.txt
+++ w/Documentation/config.txt
@@ -2150,9 +2150,14 @@ url.<base>.pushInsteadOf::
 	access methods, some of which do not allow push, this feature
 	allows people to specify a pull-only URL and have Git
 	automatically use an appropriate URL to push, even for a
-	never-before-seen repository on the site.  When more than one
-	pushInsteadOf strings match a given URL, the longest match is
-	used.
+	never-before-seen repository on the site.
++
+This rewriting takes place even for explicit push URLs set
+using the `remote.<name>.pushurl` configuration variable.
++
+When more than one pushInsteadOf string matches a given URL,
+the longest match is used.  If no pushInsteadOf strings match
+the URL, Git falls back to insteadOf strings.
 
 user.email::
 	Your email address to be recorded in any newly created commits.
diff --git i/remote.c w/remote.c
index cfcb77a..7255926 100644
--- i/remote.c
+++ w/remote.c
@@ -466,11 +466,14 @@ static void alias_all_urls(void)
 		if (!remotes[i])
 			continue;
 		for (j = 0; j < remotes[i]->pushurl_nr; j++) {
-			char *copy = xstrdup(remotes[i]->pushurl[j]);
-			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites_push);
-			if (!strcmp(copy, remotes[i]->pushurl[j]))
-				remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites);
-			free(copy);
+			const char *url = remotes[i]->pushurl[j];
+			remotes[i]->pushurl[j] = alias_url(url, &rewrites_push);
+			if (remotes[i]->pushurl[j] == url)
+				/*
+				 * No url.*.pushinsteadof string matched.
+				 * Apply url.*.insteadof.
+				 */
+				remotes[i]->pushurl[j] = alias_url(url, &rewrites);
 		}
 		add_pushurl_aliases = remotes[i]->pushurl_nr == 0;
 		for (j = 0; j < remotes[i]->url_nr; j++) {
