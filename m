From: Jeff Carr <jcarr@linuxmachines.com>
Subject: git-ls-new-files & make patch, pull, etc.
Date: Mon, 22 Aug 2005 19:07:13 -0700
Message-ID: <430A84D1.2050206@linuxmachines.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 23 04:05:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7OAD-0002Ld-Ak
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 04:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbVHWCFR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Aug 2005 22:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVHWCFR
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Aug 2005 22:05:17 -0400
Received: from [64.71.148.162] ([64.71.148.162]:16049 "EHLO
	mail.linuxmachines.com") by vger.kernel.org with ESMTP
	id S1751323AbVHWCFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2005 22:05:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.linuxmachines.com (Postfix) with ESMTP id 4BC9E6E7EE
	for <git@vger.kernel.org>; Mon, 22 Aug 2005 19:07:13 -0700 (PDT)
Received: from mail.linuxmachines.com ([127.0.0.1])
	by localhost (giant [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 02777-04 for <git@vger.kernel.org>;
	Mon, 22 Aug 2005 19:07:12 -0700 (PDT)
Received: from [172.21.43.70] (x.packeteer.com [12.104.153.15])
	by mail.linuxmachines.com (Postfix) with ESMTP id 9D0A06E7B7
	for <git@vger.kernel.org>; Mon, 22 Aug 2005 19:07:12 -0700 (PDT)
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Enigmail-Version: 0.91.0.0
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at example.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Something simple like the perl script at the bottom would be useful for
showing files that haven't been added via git-update-cache --add already.

I've also found it useful to start adding things to the Makefile's of
the projects I'm putting in git repositories. I think it would be useful
to come up with some standard or recommended names. That could start to
extend the common "make" "make install" with a few other options for
projects that use git as their SCM.

Thanks,
Jeff

patch:
	git-diff-files -p

push:
	git-send-pack `cat .git/branches/origin`

pull:
	git-pull-script `cat .git/branches/origin`
	git-read-tree -m HEAD
	git-checkout-cache -q -f -u -a

commit:
	vi changelog.txt
	GIT_AUTHOR_NAME="$(GIT_AUTHOR_NAME)" \
	GIT_AUTHOR_EMAIL="$(GIT_AUTHOR_EMAIL)" \
	git-commit-tree `git-write-tree` -p $(HEAD) < changelog.txt > .git/HEAD
	rm changelog.txt

add_all:
	./git-ls-new-files |xargs -n 1 git-update-cache --add




#!/usr/bin/perl

# Shows you what files have not been added to your git repository

my %allfiles;

# make a hash of all the files except the .git/ directory

foreach my $file ( `find . -type f` ) {
	chomp $file;
	next if substr($file, 0, 7) eq "./.git/";
	$allfiles{ $file } = "";
}

# now delete all the files from the hash that are already commited

foreach my $file ( split "\n", `git-ls-files` ) {
	chomp $file;
	delete $allfiles{ "./$file" };
}

# print out what's left

foreach my $file ( sort keys %allfiles ) {
	print "$file\n";
}
