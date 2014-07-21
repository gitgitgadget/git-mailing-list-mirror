From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 0/6] git_config callers rewritten with the new config cache API
Date: Mon, 21 Jul 2014 14:51:24 +0200
Message-ID: <vpqegxeeuyb.fsf@anie.imag.fr>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 14:51:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9D3z-0004Iv-Ug
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 14:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbaGUMv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 08:51:28 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44467 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753118AbaGUMv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 08:51:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6LCpMbL011072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jul 2014 14:51:22 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6LCpOvd024085;
	Mon, 21 Jul 2014 14:51:24 +0200
In-Reply-To: <1405941145-12120-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 21 Jul 2014 04:12:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 21 Jul 2014 14:51:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6LCpMbL011072
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406551882.89193@hR1k6Fj6FNAwZlITMim+xQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253957>

Tanay Abhra <tanayabh@gmail.com> writes:

> [PATCH v3]: Most of Eric's suggestions has been implemented. See [2] for discussion.
> 	Also, new helpers introduced in v7 of the config-set API series have been used.
> 	See [1] for the documentation of the new functions.
>
> This series builds on the top of 5def4132 in pu or topic[1] in the mailing list
> with name "git config cache & special querying API utilizing the cache".

It's now called ta/config-set (see last "What's cooking in git.git").

> All patches pass every test, but there is a catch, there is slight behaviour
> change in most of them where originally the callback returns
> config_error_nonbool() when it sees a NULL value for a key causing a die
> specified in git_parse_source in config.c.
>
> The die also prints the file name and the line number as,
>
> 	"die("bad config file line %d in %s", cf->linenr, cf->name);"
>
> We lose the fine grained error checking when switching to this method.

I think a first step would be something like this:

--- a/config.c
+++ b/config.c
@@ -656,6 +656,15 @@ int git_config_string(const char **dest, const char *var, const char *value)
        return 0;
 }
 
+// TODO: either make it static or export it properly
+int git_config_string_or_die(const char **dest, const char *var, const char *value)
+{
+       if (git_config_string(dest, var, value) < 0)
+               die("bad config file (TODO: file/line info)");
+       else
+               return 0;
+}
+
 int git_config_pathname(const char **dest, const char *var, const char *value)
 {
        if (!value)
@@ -1336,7 +1345,7 @@ int git_configset_get_string(struct config_set *cs, const char *key, const char
 {
        const char *value;
        if (!git_configset_get_value(cs, key, &value))
-               return git_config_string(dest, key, value);
+               return git_config_string_or_die(dest, key, value);
        else
                return 1;
 }

In the original API, git_config_string was called at parsing time, hence
the file/line information was available through "cf". Here, we're
querying the cache which doesn't have this information yet.

I initially thought that managing properly file/line information would
be just an addition, but this example shows that it is actually needed
to be feature-complete wrt the old API. And I think we should be
feature-complete (i.e. make the code cleaner without harming the user).

So, I think it now makes sense to resurect your "file line info" patch:

  http://article.gmane.org/gmane.comp.version-control.git/253123

Now that the series is properly reviewed, avoid modifying existing
patches as much as possible, and add these file/line info on top of the
existing.

I think you need to:

1) Modify the hashmap data structure and the code that fills it in to
   store the file/line info (already done in your previous WIP patch).

2) Add a by-address parameter to git_configset_get_value that allows the
   user to get the file and line information. In your previous patch,
   that would mean returning a pointer to the corresponding struct
   key_source.

3) Pass this information to git_config_string_or_die, and die with the
   right message (with a helper like die_config(struct key_source *ks)
   that takes care of the formatting)

4) apply the same to git_config_get_<other than string>.

I'd actually add a step 0) before that: add a test that checks your
behavior change. The test should pass without your patches, and fail
with your current patch. Then, it should pass again once you completed
the work.

On a side note, re-reading your previous patch, I found this which
sounds suspicious:

+	struct config_hash_entry *e;
+	struct string_list_item *si;
+	struct key_source *ks = xmalloc(sizeof(*e));

Didn't you mean xmalloc(sizeof(*ks))?
                                ^^

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
