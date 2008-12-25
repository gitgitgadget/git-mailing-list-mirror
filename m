From: demerphq <demerphq@gmail.com>
Subject: Re: git rev-list with --name-status?
Date: Thu, 25 Dec 2008 19:24:34 +0100
Message-ID: <9b18b3110812251024n1a824eedpa127309d48acf351@mail.gmail.com>
References: <2729632a0812241453x4ae50362g4bcd3317e5be0429@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Thu Dec 25 19:25:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFuuC-0006ZL-IE
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 19:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbYLYSYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2008 13:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbYLYSYh
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 13:24:37 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:11652 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbYLYSYg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 13:24:36 -0500
Received: by qw-out-2122.google.com with SMTP id 3so2523233qwe.37
        for <git@vger.kernel.org>; Thu, 25 Dec 2008 10:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=UeydBJgRdo6lrVGuMcZOq5e3X1XlTU6KUW8lYO/i+c4=;
        b=QfIEMj4cGNeqvmhICWQ7v1DLEQA+OefviiWj37qUE60+xnjmi9EdiL1hG8/1uHT5yX
         rC+hUvtDX7pMhvjGlDqsGL9kWP3ugFveLuBIPMwQzqNfmUiB8K4nGp8r2oMWLBb+q3Pa
         Fru+ySMtgwlZKJr/In+wydeFzP3i1M1Wgtwic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MGOFNXtTiSbQSQPcGH/5vvxr8jzLCInyaTe29gIay0LvULR6t8Rmnvc3MNZaUrKooZ
         RT+BPVYAJ9VXyrb3AIMNJKSftPKLlhRc06OQJe6q4Xb16S1qv/WYajBM6WmhXPAgsZLx
         U1rX25rfCfGqnfzHh6Io8P3s3VWbwzIxvuHms=
Received: by 10.214.181.17 with SMTP id d17mr9434459qaf.355.1230229474615;
        Thu, 25 Dec 2008 10:24:34 -0800 (PST)
Received: by 10.214.217.13 with HTTP; Thu, 25 Dec 2008 10:24:34 -0800 (PST)
In-Reply-To: <2729632a0812241453x4ae50362g4bcd3317e5be0429@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103906>

2008/12/24  <skillzero@gmail.com>:
> Is there a way to print the equivalent of --name-status with git
> rev-list? The post-receive script that comes with git for sending
> comment emails does this to generate the commit log:
>
> git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
>        git rev-list --pretty --stdin $oldrev..$newrev
>
> I'd like to also include the output of --name-status so the email
> shows which files were changed by each commit (rather than just a
> summary at the end since our pushes sometimes have a lot of commits in
> them).
>
> git rev-list doesn't seem to support --name-status and git log doesn't
> seem to support --stdin. Is there a better way to do what I want?

I wrote the following shell script function which you can add to your
post-receive-mail script. Any git rev-list --pretty statements there
can have the --pretty removed and have their output redirected to
this, and you get what you want. An  existing function changed to use
it follows. Theres probably prettier ways to do this, but hope it
helps. Id send a diff of the script as a whole except that its full of
other likely irrelevent changes.

Yves

# show_log_for_sha1s_on_std()
#
# take a list of sha1's on STDIN and print out their logs.
#
# if there are
#
# 0 commits output a notice saying there no changes in this update
#
# 1 commits - show the log only
#
# >1 commits - show log with --name-status output (list of files with
M/D/A type tags
# next to them for Modified Deleted and Added)
#
# This partly exists because we can't use --name-status with rev-list, and
# because we cant use --stdin with git log (even tho the docs might say
# otherwise in older gits). Although since we count SHA1's we can also do some
# special stuff like dealing with the 0/1/N commits differently.

show_log_for_sha1s_on_stdin()
{
                perl -e'
                        chomp(my @sha1= <>);
                        if (!@sha1) {
                                print "No new revisions added by this update\n";
                        }
                        else {
                            my $ns= @sha1 > 1 ? " --name-status" : "";
                            for my $idx (0..$#sha1) {
                                print $idx ? "\n" :  "" ,
                                      `git-log --pretty$ns -1 $sha1[$idx]`;
                                }
                        }
                '
}

generate_create_branch_email()
{
        # This is a new branch and so oldrev is not valid
        echo "        at  $newrev ($newrev_type)"
        echo ""

        echo $LOGBEGIN
        # This shows all log entries that are not already covered by
        # another ref - i.e. commits that are now accessible from this
        # ref that were previously not accessible
        # (see generate_update_branch_email for the explanation of this
        # command)
        git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
        git rev-list --stdin $newrev | show_log_for_sha1s_on_stdin
        echo $LOGEND
}

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
