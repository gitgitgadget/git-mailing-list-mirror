From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: teach dcommit about svn auto-props
Date: Thu, 24 Jul 2008 23:00:37 -0700
Message-ID: <20080725060037.GB14756@untitled>
References: <4885024A.3050200@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 08:01:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMGN1-0002uI-0e
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 08:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbYGYGAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 02:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbYGYGAi
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 02:00:38 -0400
Received: from hand.yhbt.net ([66.150.188.102]:34653 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbYGYGAh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 02:00:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 37E952DC095;
	Thu, 24 Jul 2008 23:00:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4885024A.3050200@kitware.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90002>

Brad King <brad.king@kitware.com> wrote:
> 
> Subversion repositories often require files to have properties such as
> svn:mime-type and svn:eol-style set when they are added.  Users
> typically set these properties automatically using the SVN auto-props
> feature with 'svn add'.  This commit teaches dcommit to look at the user
> SVN configuration and apply matching auto-props entries for files added
> by a diff as it is applied to the SVN remote.  A later commit will make
> this feature optional.
> 
> Signed-off-by: Brad King <brad.king@kitware.com>

Hi Brad,

I like this patch.  Can we get an automated test of this functionality?
We can (and probably should) set $HOME for the test and ignore the
existing ~/.subversion/config of the user.

Also, some minor nitpicks on whitespace/formatting inline below.

Not sure if writing a new unit test will trigger that bug below for you.
It really shouldn't...

> ---
> This change honors the user's enable-auto-props svn config setting.
> The next patch will configure this at the git level and add the
> corresponding documentation.
> 
> I've tested this by hand on an real SVN repo that checks for mime type.
> Unfortunately I'm unable to run the git-svn test suite because I get
> the error reported here:
> 
>   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=486527
>
> (even without my changes).

I haven't had the chance to look at this.   Can anybody else shed more
light on that bug?  It's really strange that the tests won't run because
of it.  Are you unable to run some git-svn tests or all of them?

<snip>

> +sub apply_autoprops {
> +	my ($self, $file, $fbat) = @_;
> +	my $conf_t = ${$self->{config}}{'config'};
> +	no warnings 'once';
> +	# Check [miscellany]/enable-auto-props in svn configuration.
> +	if (SVN::_Core::svn_config_get_bool($conf_t,
> +					    $SVN::_Core::SVN_CONFIG_SECTION_MISCELLANY,
> +					    $SVN::_Core::SVN_CONFIG_OPTION_ENABLE_AUTO_PROPS,

Long lines here and below.  I'd rather just align to the left (tabs are
assumed to be 8 characters wide on screen).

> +					    0)) {
> +		# Auto-props are enabled.  Enumerate them to look for matches.
> +		my $callback = sub {
> +			$self->check_autoprop($_[0], $_[1], $file, $fbat);
> +		};
> +		SVN::_Core::svn_config_enumerate($conf_t,
> +						 $SVN::_Core::SVN_CONFIG_SECTION_AUTO_PROPS,
> +						 $callback);
> +	}
> +}
> +
>  sub A {
>  	my ($self, $m) = @_;
>  	my ($dir, $file) = split_path($m->{file_b});
> @@ -3535,6 +3581,7 @@ sub A {
>  	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
>  					undef, -1);
>  	print "\tA\t$m->{file_b}\n" unless $::_q;
> +        $self->apply_autoprops($file, $fbat);

Hard tabs are used for indentation.

Thanks!

-- 
Eric Wong
