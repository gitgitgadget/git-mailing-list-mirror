From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Setting file timestamps to commit time (git-checkout)
Date: Tue, 10 Dec 2013 20:02:29 +0100
Message-ID: <87bo0olebe.fsf@igel.home>
References: <20131209112528.GA5309@linux.vnet.ibm.com>
	<xmqqsiu1yd7p.fsf@gitster.dls.corp.google.com>
	<20131210083531.GB4087@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 10 20:02:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqSZs-0003gj-4A
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 20:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797Ab3LJTCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 14:02:36 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:59720 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415Ab3LJTCf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 14:02:35 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3df9d6109hz4KK23
	for <git@vger.kernel.org>; Tue, 10 Dec 2013 20:02:33 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3df9d56fVXzbbfN
	for <git@vger.kernel.org>; Tue, 10 Dec 2013 20:02:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id kvbxH-RBdGdH for <git@vger.kernel.org>;
	Tue, 10 Dec 2013 20:02:31 +0100 (CET)
X-Auth-Info: QFEpmXO0hZEMXWSKMDGn82qiia21lJ5gUHXQIMKBNGM=
Received: from igel.home (ppp-46-244-235-149.dynamic.mnet-online.de [46.244.235.149])
	by mail.mnet-online.de (Postfix) with ESMTPA
	for <git@vger.kernel.org>; Tue, 10 Dec 2013 20:02:31 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id F41592C025B; Tue, 10 Dec 2013 20:02:29 +0100 (CET)
X-Yow: I'm rated PG-34!!
In-Reply-To: <20131210083531.GB4087@linux.vnet.ibm.com> (Dominik Vogt's
	message of "Tue, 10 Dec 2013 09:35:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239150>

Dominik Vogt <vogt@linux.vnet.ibm.com> writes:

> The second best approach I could think of is to stamp files with the
> timestamp of the last commit that touched that, but I guess that is
> not a cheap operation either.

I'm using this script for this:

#!/bin/sh
git log --name-only --format=format:%n%ct -- "$@" |
perl -e 'my $do_date = 0; chomp(my $cdup = `git rev-parse --show-cdup`);
    while (<>) {
	chomp;
	if ($do_date) {
	    next if ($_ eq "");
	    die "Unexpected $_\n" unless /^[0-9]+$/;
	    $d = $_;
	    $do_date = 0;
	} elsif ($_ eq "") {
	    $do_date = 1;
	} elsif (!defined($seen{$_})) {
	    $seen{$_} = 1;
 	    utime $d, $d, "$cdup$_";
 	}
    }'

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
