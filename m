From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 1/2] git-svn: add some in-code documentation
	(options-related).
Date: Mon, 22 Jun 2009 21:12:07 +0200
Message-ID: <20090622191207.GA5590@nan92-1-81-57-214-146.fbx.proxad.net>
References: <1245624521-30769-1-git-send-email-ydirson@altern.org> <1245624521-30769-2-git-send-email-ydirson@altern.org> <7vmy81p2r5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 21:11:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIovm-0007Qa-Pa
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 21:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbZFVTLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 15:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbZFVTLk
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 15:11:40 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:57880 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655AbZFVTLj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 15:11:39 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id C62F894015E;
	Mon, 22 Jun 2009 21:11:31 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id CA426940100;
	Mon, 22 Jun 2009 21:11:28 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 681811F0D4; Mon, 22 Jun 2009 21:12:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vmy81p2r5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122055>

On Sun, Jun 21, 2009 at 04:48:30PM -0700, Junio C Hamano wrote:
> Yann Dirson <ydirson@altern.org> writes:
> 
> > +# Option structures here are used to define both command-line options
> > +# and git-config keys.  They are handled by read-repo-config().
> > +# Options in mixed case and with only a long form are only for the
> > +# config file.  All options available from command-line are available
> > +# as config-file options too, but without any dash in their names.
> 
> Hmm... I am a bit confused.  So for example:
> 
> 		'authors-file|A=s' => \$_authors,
> 		'authors-prog=s' => \$_authors_prog,
> 		'repack:i' => \$Git::SVN::_repack,
> 		'noMetadata' => \$Git::SVN::_no_metadata,
> 		'useSvmProps' => \$Git::SVN::_use_svm_props,
> 
> authors-file, authors-prog and repack are not MixdCase (and the first and
> third are not even "only a long form"), so it is not "only for the config
> file".  But noMetadata and useSvmProps are "only for the config file".
> 
> It took me a bit to realize that these two equivalence hold:
> 
>   "not only for the config file" === "also available as command line option"
>   "only for the config file"     === "cannot be given on the command line"
> 
> Since "option structures here are used for both command and config", and
> "anything usable from command line can be used in config file", logically
> it follows that "everything in these option structures here are usable in
> the config".  It took me a bit longer than necessary for that to click,
> too.

Right, that should probably be emphasized more.  I originally did not
realize that those also drive config-file settings, right after I
discovered how the config items are handled, and this clearly shows :)


> After scratching my head for a few minutes, here is a rephrased
> description I came up with (I am not writing this as an improved
> suggestion, but to ask you to sanity check if I read what you wanted to
> say correctly):
> 
>     These are all configurable in the config file (remove dash in their
>     names to use these names as the config key).
> 
>     Options that have MixedCase names without short format (e.g. noMetadata)
>     can only be used from the configuration (iow they cannot be given from
>     the command line as options).

That's what I had got from comments in read_repo_config() and tried to
convey in this comment.

> But then this raises a couple of questions.
> 
>  * What are the examples of MixedCase names that do have short format?
>    Are they usable from the command line?

There are no such example, and I suspect this restriction was only
mentionned for completeness, as a consequence that config-only items
are defined in the code by containing only letters and at least one
uppercase (that is, the real condition also encompasses uppercase-only
items).  I'll try to bring a better formulation.


>  * %fc_opts() has "noMetadata" and %init_opts() has "no-metadata"; how are
>    they related, and how do they affect the above "what's available where
>    and how to spell their names" rule you outlined?

The mixed-case versions are the config items, and the dashed versions
are used by "git svn init" to seed these items at init/clone time, so
one does not have to use "git svn init", then set config, and only
then doing initial fetch.

As a consequence, one can set eg. svn.nometadata in his ~/.gitconfig,
and subsequently have all git-svn-cloned repository initialized with
svn.noMetadata.  That's probably not an example of clarity, and things
being error-prone, such an example in the doc would probably be
welcomed; I can add this too.


Speaking about the doc, I was wondering whether it would not be better
to split my previous patch into 1/3 formatting issues (patch which
could probably be applied early), 2/3 shuffling existing options to
the right place, 3/3 adding missing options.  Afterwards more work can
be done for clarification, but that is not my primary goal, I'd rather
try to document the internals first.
