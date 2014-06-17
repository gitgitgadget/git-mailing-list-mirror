From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] alias.c: Replace git_config with
 git_config_get_string
Date: Tue, 17 Jun 2014 01:43:57 -0400
Message-ID: <20140617054357.GC29957@sigill.intra.peff.net>
References: <1402910154-417-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 07:44:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwmBe-0000Os-Gg
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 07:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219AbaFQFn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 01:43:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:45807 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752160AbaFQFn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 01:43:58 -0400
Received: (qmail 11105 invoked by uid 102); 17 Jun 2014 05:43:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Jun 2014 00:43:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jun 2014 01:43:57 -0400
Content-Disposition: inline
In-Reply-To: <1402910154-417-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251844>

On Mon, Jun 16, 2014 at 02:15:54AM -0700, Tanay Abhra wrote:

> **DOUBT**
> This patch builds on top of patch series[1]. The first patch in the 
> replace `git_config` series is [2], which passed all the tests.
> 
> But this patch falters at this test in t1300-repo-config.sh,
> 
> git config alias.checkconfig "-c foo.check=bar config foo.check" &&
> 		echo bar >expect &&
> 		git checkconfig >actual &&
> 		test_cmp expect actual
> 
> I hand tested this case and the outputs match. But I don't know why the tests
> are failing.

I get:

    expecting success: 
            git config alias.split-cmdline-fix 'echo "' &&
            test_must_fail git split-cmdline-fix &&
            echo foo > foo &&
            git add foo &&
            git commit -m 'initial commit' &&
            git config branch.master.mergeoptions 'echo "' &&
            test_must_fail git merge master
    
    Segmentation fault
    test_must_fail: died by signal: git split-cmdline-fix

Running with valgrind gives more details (it looks like the segfault I
mentioned in the other thread).

>  char *alias_lookup(const char *alias)
>  {
> -	alias_key = alias;
> -	alias_val = NULL;
> -	git_config(alias_lookup_cb, NULL);
> +	char *alias_key, *alias_val;
> +	const char *v;
> +	alias_key = xmalloc(7+strlen(alias));
> +	strcpy(alias_key, "alias.");
> +	strcat(alias_key, alias);

Please use a strbuf instead of hand-rolling the math. It's much easier
to verify that it is correct, and it avoids badly designed functions
like strcat. I.e.:

  struct strbuf key = STRBUF_INIT;
  strbuf_addf(&key, "alias.%s", alias);
  ...
  strbuf_release(&key);

(note also that since the key/val variables are no longer static
 globals, it's fine to use a shorter, less clunky name).

> +	v = git_config_get_string(alias_key);
> +	if (!v)
> +		config_error_nonbool(alias_key);

What does a NULL output from git_config_get_string mean? I think with
the current code, it means "no such key was found".  In which case, you
should be returning NULL here (there is no such alias), not complaining
with config_error_nonbool.

Again, this is going to depend on your strategy for storing booleans
that I mentioned elsewhere.

-Peff
