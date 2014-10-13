From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] test-lib.sh: support -x option for shell-tracing
Date: Mon, 13 Oct 2014 18:43:43 -0400
Message-ID: <20141013224342.GA22290@peff.net>
References: <20141010062722.GB17481@peff.net>
 <20141010064727.GC17481@peff.net>
 <xmqqh9z71uf9.fsf@gitster.dls.corp.google.com>
 <20141013223303.GA17045@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 00:43:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdoLF-0001aJ-88
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 00:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599AbaJMWnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 18:43:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:58152 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753361AbaJMWnp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 18:43:45 -0400
Received: (qmail 24127 invoked by uid 102); 13 Oct 2014 22:43:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Oct 2014 17:43:44 -0500
Received: (qmail 29590 invoked by uid 107); 13 Oct 2014 22:43:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Oct 2014 18:43:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Oct 2014 18:43:43 -0400
Content-Disposition: inline
In-Reply-To: <20141013223303.GA17045@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 13, 2014 at 06:33:03PM -0400, Jeff King wrote:

> > But still it is disturbing to see that there is a blank line
> > difference with and without this change in the file created by the
> > test (i.e. the client of the code this patch touches).
> 
> This fixes it:
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 4dab575..059bb25 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -528,8 +528,7 @@ maybe_setup_valgrind () {
>  test_eval_inner_ () {
>  	eval "
>  		test \"$trace\" = t && set -x
> -		$*
> -	"
> +		$*"
>  }
>  
>  test_eval_ () {
> 
> 
> My patch definitely expands the snippet with an extra trailing newline.
> But what I really don't understand is why that would impact the
> _contents_ of the config file.
> 
> I'll dig further, but I'm about to leave the computer for dinner for a
> few hours, so please don't hold your breath. :)

OK, I lied. I couldn't resist spending 5 more minutes on it.

If you instrument t1308 on master to look at the contents of .git/config
directly after the setup step, you'll see that the file ends with (tabs
marked as ^I):

  [...]
  ^I^Ihorns
  ^IEOF

Which makes sense. We forgot the tab-eating "<<-" in the here-doc, so
the tab-indented EOF was not counted as the end of the input. So this
test is bogus and broken, and the breakage introduced by my patch is
only triggered because of that (which isn't to say we shouldn't
necessarily adjust my patch, but we definitely should fix this test).

What really surprises me is that the shell is fine with a here-doc
ending inside an eval. Bash at least warns:

  $ bash -c "eval 'cat <<EOF
    content'"
  bash: line 2: warning: here-document at line 1 delimited by end-of-file (wanted `EOF')
      content

but dash silently accepts it:
  $ dash -c "eval 'cat <<EOF
    content'"
      content

Maybe this is something that every shell does, but it certainly seems
like something we should not be relying on (and it was definitely not
something the test meant to rely on, as evidenced by the bogus EOF
marker it included).

-Peff
