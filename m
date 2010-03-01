From: Eli Barzilay <eli@barzilay.org>
Subject: Re: gitweb problem?
Date: Mon, 01 Mar 2010 06:51:58 -0500
Message-ID: <m3zl2suun5.fsf@winooski.ccs.neu.edu>
References: <m34ol0wmze.fsf@winooski.ccs.neu.edu>
	<m3bpf8mj5k.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 01 12:52:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm4Ad-0007hl-Lr
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 12:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226Ab0CALwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 06:52:14 -0500
Received: from lo.gmane.org ([80.91.229.12]:43866 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192Ab0CALwN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 06:52:13 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nm4AV-0007e9-6z
	for git@vger.kernel.org; Mon, 01 Mar 2010 12:52:11 +0100
Received: from winooski.ccs.neu.edu ([129.10.115.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 12:52:11 +0100
Received: from eli by winooski.ccs.neu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 12:52:11 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: winooski.ccs.neu.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:ABi1tZzUqB8snN5iorsKqnofXk0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141318>

Jakub Narebski <jnareb@gmail.com> writes:

> Eli Barzilay <eli@barzilay.org> writes:
>
>> Whenever I view the toplevel gitweb page (running as a cgi script
>> under apache), but not when in a specific repo, I get this in my error
>> log:
>> 
>> gitweb.cgi: Use of uninitialized value $git_dir in concatenation (.) or string at /home/git/gitweb/gitweb.cgi line 2065.
>> fatal: error processing config file(s)
>> gitweb.cgi: Use of uninitialized value $git_dir in concatenation (.) or string at /home/git/gitweb/gitweb.cgi line 2221.
>> gitweb.cgi: Use of uninitialized value $git_dir in concatenation (.) or string at /home/git/gitweb/gitweb.cgi line 2218.
>> 
>> (taken verbatim from the apache error log, removed uninteresting line
>> prefixes.)
>
> In the future (or if my diagnosis would turn out to be incorrect)
> could you please show which lines are those (in *your* gitweb.cgi),
> or at least provide gitweb version?  Changes to gitweb can render
> such line numbers invalid.

Sorry, I should have mentioned that this is from 1.7.0 -- my file is
not modified, and built with no changes to the defaults except for
prefix=/usr/local.  In any case, the script -- with the test that I
added -- is at http://tmp.barzilay.org/x1 .


>> I'm using the pathinfo option, so perhaps there is a problem with
>> that setup?
>
> In the future (or if my diagnosis would turn out to be incorrect)
> could you please include relevant parts of $GITWEB_CONFIG (by
> default it is gitweb_config.perl), at least which features you have
> enabled, and how they are configured?

http://tmp.barzilay.org/x2 (but see below).


>> Looking at the source, the last two line numbers are in
>> `git_get_project_config' -- so my guess is that the code is trying to
>> get the options from the repository config file even when showing the
>> toplevel page.  Based on this, and also guessing that $git_dir is
>> unset when viewing the toplevel page, I added
>> 
>> 	return unless (defined $git_dir);
>> 
>> to the top (of the `git_get_project_config' function), and I get no
>> warnings and everything works as it should.
>> 
>> (Disclaimer: I can barely read perl, and I'm a git newbie, so all of
>> this can be due to some other stupid mistake.)
>
> That looks like lack of hardening against pilot error.  The
> git_get_project_config should never be run when $git_dir is not set,
> as it is meant to access *project* config.
>
> But at the top of git_project_list_body subroutine, which is
> responsible for generating toplevel page with list of projects, we
> have:
> 	my $check_forks = gitweb_check_feature('forks');
> and a bit later
> 	my $show_ctags = gitweb_check_feature('ctags');
>
> Now both of those features are marked as not supporting project specific
> override.  It might be that you by accident set $feature{XXX}{'override'}
> to true... but I might be mistaken.

No, that's not it.  I've tracked all calls to
`git_get_project_config', and the two offending calls are the ones in
`feature_snapshot' and `feature_avatar'.  I then verified that
commenting out these two lines in my config

  $feature{'snapshot'}{'override'} = 1;
  $feature{'avatar'}{'override'} = 1;

avoids the calls -- and the comments indicate that it should be fine
to do that.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
