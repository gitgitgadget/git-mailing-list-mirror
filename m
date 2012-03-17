From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 7/9] difftool: teach difftool to handle directory diffs
Date: Sat, 17 Mar 2012 07:32:12 -0700 (PDT)
Message-ID: <m3fwd7l2mu.fsf@localhost.localdomain>
References: <1331949574-15192-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 15:32:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8ug7-00013v-HQ
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 15:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077Ab2CQOcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 10:32:15 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:60440 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616Ab2CQOcO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 10:32:14 -0400
Received: by wejx9 with SMTP id x9so4715598wej.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 07:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=lRysVr51KlQSNM/ME8tIf37IDlPrNp66rUJVQUP1qDA=;
        b=EkRVU9LzpZWaEBExlpkHl/cZWnYlIDoN5/x51rH5mkhgL4Mq4wKi8j7VP4QX6UKlW3
         7od2qsobss2ht5c+LuYHwlBneNS4g7L9qnG9HKUCZL28T6OEqc/2ZBY87TtLXyecgvBn
         f8i9hJe4dTAIS8221ZEGMa7EIgMfy2wK8wZqoF0xD4jIxBlBQd2kxzd2L3SHrNYYsYb1
         QuYG210O4Z1sq5wgFeK42RZ5JcdH0xxBGg2MI+N9e2d6ec2uuqJAALUgSaiOHEEFos2R
         8eO+XPfUm4w7D+zc6ydj9olbozvKwVIfH8NkJ3Vi1VBWQficH+j7ItjcTtHlIH3UbLwr
         nCLA==
Received: by 10.180.91.10 with SMTP id ca10mr6579922wib.17.1331994733041;
        Sat, 17 Mar 2012 07:32:13 -0700 (PDT)
Received: from localhost.localdomain (aeho214.neoplus.adsl.tpnet.pl. [79.186.196.214])
        by mx.google.com with ESMTPS id j3sm13238593wiw.1.2012.03.17.07.32.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Mar 2012 07:32:12 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q2HEWAdG017892;
	Sat, 17 Mar 2012 15:32:11 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q2HEW9oc017889;
	Sat, 17 Mar 2012 15:32:09 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1331949574-15192-1-git-send-email-tim.henigan@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193330>

Tim Henigan <tim.henigan@gmail.com> writes:

> +	foreach my $path (keys %submodule) {
> +		if (defined $submodule{$path}{left}) {
> +			open(SUBMOD, ">$ldir/$path") or die $!;
> +			print(SUBMOD "Subproject commit $submodule{$path}{left}");
> +			close(SUBMOD);
> +		}
> +		if (defined $submodule{$path}{right}) {
> +			open(SUBMOD, ">$rdir/$path") or die $!;
> +			print(SUBMOD "Subproject commit $submodule{$path}{right}");
> +			close(SUBMOD);

Could you please use modern Perl, and use lexical filehandles instead
of globs, and 3-arg version of 'open', i.e.

  +			open my $submod_fh, ">", "$ldir/$path" or die $!;
  +			print $submod_fh "Subproject commit $submodule{$path}{left}";
  +			close $submod_fh;


> +if (defined($dirdiff)) {
> +	my ($a, $b) = setup_dir_diff();
> +	if (defined($extcmd)) {
> +		system("$extcmd $a $b");
> +	} else {
> +		$ENV{GIT_DIFFTOOL_DIRDIFF} = 'true';
> +		system("git difftool--helper $a $b");
> +	}
> +	# TODO: if the diff including working copy files and those
> +	# files were modified during the diff, then the changes
> +	# should be copied back to the working tree
> +} else {
> +	if (defined($prompt)) {
> +		$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
> +	}
> +	elsif (defined($no_prompt)) {
> +		$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
> +	}
> +
> +	$ENV{GIT_PAGER} = '';
> +	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
> +	git_cmd_try { Git::command_noisy(('diff', @ARGV)) } 'exit code %d';
> +}

Why you use 'system' (and not in list form which does not require
escaping shell characters) instead of git_cmd_try for first 
"git difftool--helper" invocation?

Is $extcmd and resultof setup_dir_diff() to be treated as shell
snippet, and used in string form of 'system' without escaping shell
metacharacters (like ' ' in filename)?

-- 
Jakub Narebski
