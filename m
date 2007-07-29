From: Theodore Tso <tytso@mit.edu>
Subject: Re: [Untested! proposal] git-mergetool.sh: introduce ediff option
Date: Sun, 29 Jul 2007 16:52:32 -0400
Message-ID: <20070729205232.GA10148@thunk.org>
References: <7vy7idydqa.fsf@assigned-by-dhcp.pobox.com> <7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com> <7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net> <7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net> <7vvec4synj.fsf_-_@assigned-by-dhcp.cox.net> <85zm1g3nze.fsf@lola.goethe.zz> <85bqdw27mb.fsf@lola.goethe.zz> <20070729031612.GB17204@thunk.org> <Pine.LNX.4.64.0707291224460.14781@racer.site> <85hcnnwblu.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 00:49:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFHaC-0003aX-4o
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 00:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbXG2Wtt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 18:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbXG2Wtt
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 18:49:49 -0400
Received: from thunk.org ([69.25.196.29]:55240 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763478AbXG2Wts (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 18:49:48 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IFHiQ-0003Lf-Lv; Sun, 29 Jul 2007 18:58:22 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IFFkf-0007Xc-2Q; Sun, 29 Jul 2007 16:52:33 -0400
Content-Disposition: inline
In-Reply-To: <85hcnnwblu.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54144>

On Sun, Jul 29, 2007 at 03:51:34PM +0200, David Kastrup wrote:
> 
> Most actual Emacs users prefer ediff to emerge concerning the
> consolidation of versions.  In general, people habitually using Emacs
> will have this preference reflected in the EDITOR/VISUAL environment
> variables.

Proof, please?  Do you have any polls?  What evidence do you have?
For the past two decades, I have EDITOR set to emacs, but I am not an
ediff fan.  Yes, that's anecdotal evidence, but so are your assertions.

> If such a preference can be found there, ediff will be used/offered in
> preference of emerge (which retains its previous behavior).

Ediff is currently far more confusing for someone who just uses emacs
as an editor.  There are plenty of users who never learned the vi
commands, but who use emacs as a reasonably easy-to-use text editor.
Not everyone who uses emacs is a power-user.....

> In ediff mode, success or failure of the merge will be discerned by
> Emacs either having written or not written the merge buffer; no
> attempt of interpreting the exit code is made.

Sometimes resolving the merge file results in no changes.  So the fact
that ediff is buggy in that it doesn't return an exit code is a real
problem.  We could possibly work around the problem saving and then
checking the modtime --- but only if ediff actually ends up rewriting
the file.

> In order to bypass things like desktop files being loaded, emerge mode
> now passes the "-q" option to Emacs.  This will make it work in more
> situations likely to occur, at the price of excluding possibly
> harmless user customizations with the rest.

But that screws over users who want their customizations, but who
don't use the desktop package.  (And I have a news flash for you; the
desktop package is *not* include as part of emacs21.  It's not part of
Debian's emacs21 package, version 21.4.)  So do not believe your claim
that emacs's desktop package is commonly used.   

Probably a better choice is a config parameter which allows users to
specify a set of options to be passed to emacs when git fires up an
emacs program.  That would allow some people to specfy --no-desktop if
they are using a new enough emacs program that supports it.  It would
also allow users to use other emacs command-line options that they
might like, i.e., -nw, or --title, etc.

> +	ediff)
> +	    case "${EDITOR:-${VISUAL:-emacs}}" in
> +		*/emacs*|*/gnuclient*|*/xemacs*)
> +		    emacs_candidate="${EDITOR:-${VISUAL:-emacs}}";;
> +		*)
> +		    emacs_candidate=emacs;;
> +	    esac
> +	    if base_present ; then
> +		${emacs_candidate} --eval "(ediff-merge-files-with-ancestor (pop command-line-args-left) (pop command-line-args-left) (pop command-line-args-left) nil (pop-command-line-args-left))" "$LOCAL" "$REMOTE" "$BASE" "$path"

... and this will blow up if EMACS is set to emacsclient, and emacs
version is 21.  (And BTW, Debian stable and the current Ubuntu, Edgy
Eft, are still shipping emacs21.  So are a number of current major
distro's.  So if you think the vast majority of users are using
emacs22, you are either on drugs, and have a very skewed view of what
are "normal" emacs users.)

There is a reason why git-mergetool currently hardcodes the use of
"emacs", instead of just blindly using the value of $EDITOR or
$VISUAL.  So what you're doing here in your patch is completely
busted.  If you insist on using emacs_candidate, we need to run emacs
--version and parse the output, and only using the value of EMACS or
VISUAL if the major version number of emacs is at least 22.

(It would probably be a good idea to do this once and cache the
result, so we don't have to repeatedly for each file that git
mergetool needs to process.)

> -    if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
> -        merge_tool_candidates="$merge_tool_candidates emerge"
> -    fi
> +    case "${EDITOR:-${VISUAL}}" in
> +	*/emacs*|*/gnuclient*|*/xemacs*)
> +            merge_tool_candidates="$merge_tool_candidates ediff"
> +    esac

Changing the default from emerge to ediff is a non-starter, sorry.  If
you really want to use ediff, you can set a config parameter to
explicitly request it.

						- Ted
