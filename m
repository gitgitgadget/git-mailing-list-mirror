From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/13] Makefile: teach scripts to include make variables
Date: Wed, 5 Feb 2014 14:50:52 -0500
Message-ID: <20140205195052.GA16634@sigill.intra.peff.net>
References: <20140205174823.GA15070@sigill.intra.peff.net>
 <20140205180547.GL15218@sigill.intra.peff.net>
 <xmqqa9e54ayl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 20:51:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB8Ut-0002Dg-Ty
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 20:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbaBETuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 14:50:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:45242 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751481AbaBETuy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 14:50:54 -0500
Received: (qmail 14398 invoked by uid 102); 5 Feb 2014 19:50:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 13:50:54 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 14:50:52 -0500
Content-Disposition: inline
In-Reply-To: <xmqqa9e54ayl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241648>

On Wed, Feb 05, 2014 at 11:26:58AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >  define cmd_munge_script
> >  $(RM) $@ $@+ && \
> > +{ \
> > +includes="$(filter MAKE/%.sh,$^)"; \
> > +if ! test -z "$$includes"; then \
> > +	cat $$includes; \
> > +fi && \
> >  sed -e '1s|#!.*/sh|#!$(call sqi,$(SHELL_PATH))|' \
> >      -e 's|@SHELL_PATH@|$(call sqi,$(SHELL_PATH))|' \
> > -    -e 's|@@DIFF@@|$(call sqi,$(DIFF))|' \
> >      -e 's|@@LOCALEDIR@@|$(call sqi,$(localedir))|g' \
> >      -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
> >      -e 's/@@USE_GETTEXT_SCHEME@@/$(USE_GETTEXT_SCHEME)/g' \
> >      -e $(BROKEN_PATH_FIX) \
> >      -e 's|@@GITWEBDIR@@|$(call sqi,$(gitwebdir))|g' \
> >      -e 's|@@PERL@@|$(call sqi,$(PERL_PATH))|g' \
> > -    $@.sh >$@+
> > +    $@.sh; \
> > +} >$@+
> >  endef
> 
> Sorry, but I am not quite sure what is going on here.
> [...]
> And then after emitting that piece, we start processing the *.sh
> source file, replacing she-bang line?

Yes, there is a bug here. The intent was to end up with:

  #!/bin/sh
  [include snippets]
  [the actual script]

but of course I bungled that, because #!/bin/sh is part of the file
already, and our snippets should not come before. If we take this
technique to its logical conclusion, the sed replacement goes away
entirely, and we end up with something like:

  %: %.sh MAKE/SHELL_SHEBANG.sh
          { cat $(filter MAKE/%.sh,$^) && sed 1d $<; } >$@+
          chmod +x $@+
          mv $@+ $@

  MAKE/SHELL_SHEBANG.sh: MAKE/SHELL_SHEBANG
          echo "#!$(head -1 $<)" >$@+ &&
          mv $@+ $@

I.e., the shebang line simply becomes the first snippet.

> >  create_virtual_base() {
> >  	sz0=$(wc -c <"$1")
> > -	@@DIFF@@ -u -La/"$1" -Lb/"$1" "$1" "$2" | git apply --no-add
> > +	$MAKE_DIFF -u -La/"$1" -Lb/"$1" "$1" "$2" | git apply --no-add
> >  	sz1=$(wc -c <"$1")
> 
> This would mean that after this mechanism is extensively employed
> throughout our codebase, any random environment variable the user
> has whose name happens to begin with "MAKE_" will interfere with us
> (rather, we will override such a variable while we run).  Having to
> carve out our own namespace in such a way is OK, but we would want
> to see that namespace somewhat related to the name of our project,
> not to the name of somebody else's like "make", no?

Yes, it probably makes sense to carve out our own namespace. I kind of
dislike the use of environment variables at all, though, just because it
really bleeds through into how you write the script (as opposed to just
replacing like we do now, or in C, where a snippet defining a
preprocessor macro is just fine).

An alternative is that we could do something like:

  %: %.sh
          script/mkshellscript $^ >$@+ &&
          chmod +x $@+ &&
          mv $@+ $@

and then have mkshellscript look like (and this could obviously be
inline in the Makefile, but I think it's worth pulling it out to avoid
the quoting hell):

  #!/bin/sh

  main=$1; shift

  sed_quote() {
          sed 's/\\/\\\\/g; s/|/\\|/g'
  }

  # generate a sed expression that will replace tokens; if we are given
  # the file MAKE/FOO.sh, the expression will replace  @@FOO@@ with the
  # contents of that file
  sed_replace() {
          for var in "$@"; do
                  key=${i#MAKE/}
                  key=${key%.sh}
                  printf 's|@@%s@@|%s|g' "$key" "$(sed_quote <$var)"
          done
  }

  sed "$(sed_replace "$@")" <"$main"

-Peff
