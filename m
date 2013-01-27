From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 06/21] git p4 test: use client_view in t9806
Date: Sat, 26 Jan 2013 20:51:35 -0500
Message-ID: <20130127015135.GA29157@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
 <1348833865-6093-7-git-send-email-pw@padd.com>
 <7v4nmiklbt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 02:52:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzHPc-0003Z6-Tj
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 02:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146Ab3A0Bvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 20:51:40 -0500
Received: from honk.padd.com ([74.3.171.149]:37789 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755091Ab3A0Bvj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 20:51:39 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 9DDFB3236;
	Sat, 26 Jan 2013 17:51:38 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 9151B22838; Sat, 26 Jan 2013 20:51:35 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v4nmiklbt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214649>

Yes, this really is four months later.  Somehow I forgot all
about this series.

gitster@pobox.com wrote on Fri, 28 Sep 2012 12:11 -0700:
> Pete Wyckoff <pw@padd.com> writes:
> 
> > Use the standard client_view function from lib-git-p4.sh
> > instead of building one by hand.  This requires a bit of
> > rework, using the current value of $P4CLIENT for the client
> > name.  It also reorganizes the test to isolate changes to
> > $P4CLIENT and $cli in a subshell.
> >
> > Signed-off-by: Pete Wyckoff <pw@padd.com>
> > ---
> >  t/lib-git-p4.sh           |  4 ++--
> >  t/t9806-git-p4-options.sh | 50 ++++++++++++++++++++++-------------------------
> >  2 files changed, 25 insertions(+), 29 deletions(-)
> >
> > diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> > index 890ee60..d558dd0 100644
> > --- a/t/lib-git-p4.sh
> > +++ b/t/lib-git-p4.sh
> > @@ -116,8 +116,8 @@ marshal_dump() {
> >  client_view() {
> >  	(
> >  		cat <<-EOF &&
> > -		Client: client
> > -		Description: client
> > +		Client: $P4CLIENT
> > +		Description: $P4CLIENT
> >  		Root: $cli
> >  		View:
> >  		EOF
> > diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
> > index fa40cc8..37ca30a 100755
> > --- a/t/t9806-git-p4-options.sh
> > +++ b/t/t9806-git-p4-options.sh
> > @@ -126,37 +126,33 @@ test_expect_success 'clone --use-client-spec' '
> >  		exec >/dev/null &&
> >  		test_must_fail git p4 clone --dest="$git" --use-client-spec
> >  	) &&
> > -	cli2=$(test-path-utils real_path "$TRASH_DIRECTORY/cli2") &&
> > +	# build a different client
> > +	cli2="$TRASH_DIRECTORY/cli2" &&
> >  	mkdir -p "$cli2" &&
> >  	test_when_finished "rmdir \"$cli2\"" &&
> >  	test_when_finished cleanup_git &&
> > ...
> > -	# same thing again, this time with variable instead of option
> >  	(
> > ...
> > +		# group P4CLIENT and cli changes in a sub-shell
> > +		P4CLIENT=client2 &&
> > +		cli="$cli2" &&
> > +		client_view "//depot/sub/... //client2/bus/..." &&
> > +		git p4 clone --dest="$git" --use-client-spec //depot/... &&
> > +		(
> > +			cd "$git" &&
> > +			test_path_is_file bus/dir/f4 &&
> > +			test_path_is_missing file1
> > +		) &&
> > +		cleanup_git &&
> 
> Hmm, the use of "test-path-utils real_path" to form cli2 in the
> original was not necessary at all?

Thanks, I will make this removal more explicit, putting it in
with 8/21 where it belongs, with explanation.

> > +		# same thing again, this time with variable instead of option
> > +		(
> > +			cd "$git" &&
> > +			git init &&
> > +			git config git-p4.useClientSpec true &&
> > +			git p4 sync //depot/... &&
> > +			git checkout -b master p4/master &&
> > +			test_path_is_file bus/dir/f4 &&
> > +			test_path_is_missing file1
> > +		)
> 
> Do you need a separate sub-shell inside a sub-shell we are already
> in that you called client_view in?
> 
> >  	)
> >  '

The first subshell is to hide P4CLIENT and cli variable changes
from the rest of the tests.

The second is to keep the "cd $git" from changing behavior of the
following "cleanup_git" call.  That does "rm -rf $git" which
would fail on some file systems if cwd is still in there.  With
just one subshell it would look like:

	(
		P4CLIENT=client2 &&
		git p4 clone .. &&
		cd "$git" &&
		... do test
		cd "$TRASH_DIRECTORY" &&
		cleanup_git &&

		cd "$git" &&
		... more test
	)

It's a bit easier to understand with an extra level of shell,
and sticks to the pattern used in the rest of the t98*.

		-- Pete
