From: Johannes Sixt <j.sixt@viscovery.net>
Subject: nd/magic-pathspec exposes breakage in git-add--interactive on Windows
Date: Thu, 29 Aug 2013 08:54:34 +0200
Message-ID: <521EF02A.2020300@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?UTF-8?B?Tmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 08:54:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEw7v-0000W6-Ai
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 08:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740Ab3H2Gyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 02:54:39 -0400
Received: from so.liwest.at ([212.33.55.24]:24740 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825Ab3H2Gyj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 02:54:39 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VEw7n-0000k6-DX; Thu, 29 Aug 2013 08:54:35 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id F29381660F;
	Thu, 29 Aug 2013 08:54:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
X-Enigmail-Version: 1.5.2
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233238>

With nd/magic-pathspec I get the following failure on Windows in
t2016-checkout-patch.sh:

expecting success:
        set_state dir/foo work head &&
        # the third n is to get out in case it mistakenly does not apply
        (echo y; echo n; echo n) | (cd dir && git checkout -p foo) &&
        verify_saved_state bar &&
        verify_state dir/foo head head

==== xx.
==== 1d.
==== 10e.
msys does not support: :(prefix:4)dir/foo
not ok 13 - path limiting works: foo inside dir

The error message 'msys does not support...' originates from this function
in git-add--interactive.perl (which is invoked from checkout -p):

  sub run_cmd_pipe {
	if ($^O eq 'MSWin32' || $^O eq 'msys') {
		my @invalid = grep {m/[":*]/} @_;
		die "$^O does not support: @invalid\n" if @invalid;
		my @args = map { m/ /o ? "\"$_\"": $_ } @_;
		return qx{@args};
	} else {
		my $fh = undef;
		open($fh, '-|', @_) or die;
		return <$fh>;
	}
  }

It looks like on Windows we disallow arguments that contain double-quote,
colon, or asterisk, and otherwise wrap arguments in double-quotes if they
contain space. Then pass them through qx{}, which I can only guess what it
does.

This code was introduced in 21e9757e (Hack git-add--interactive to make it
work with ActiveState Perl, 2007-08-01). The commit message has the
general statement "It wont work for arguments with special characters
(like ", : or *)), which I do not know how to interpret: Does ActiveState
Perl not work with special charactoers, or Windows? Because the latter is
definitely not true.

Can we be more permissive in the 'my @invalid' check without breaking
ActiveState Perl?

BTW, there is a similar failure in t7105-reset-patch.sh, which invokes
'git reset -p', but I haven't investigate further.

-- Hannes
