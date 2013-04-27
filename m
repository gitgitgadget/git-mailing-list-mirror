From: Ilya Basin <basinilya@gmail.com>
Subject: Possible meaningless block in perl/Git/SVN/Fetcher.pm: sub find_empty_directories
Date: Sat, 27 Apr 2013 23:10:05 +0400
Message-ID: <1225928524.20130427231005@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Ray Chen <rchen@cs.umd.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 21:11:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWAXO-0006YI-AG
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121Ab3D0TLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:11:43 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:61574 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab3D0TLm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:11:42 -0400
Received: by mail-la0-f46.google.com with SMTP id fs13so1787294lab.33
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 12:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=6DwrweAjYmqiwAPihyF/T4j+MFDodEhyBklFUtBog88=;
        b=r1+0v1PFVVXBceQ0sXCoQnxW+q6XkhRHu95NTll5T7iYxuNE4goGsJL8oez3ZmqdJ6
         3xYbjM03wapIclR3CAtYlZxoPRDt2QNF7MKdnnEj4Y2ydqsP/v/VitCNkb1YDpnpZdLy
         F2mjSXTba7pw8jFrVAkhvvc64bV8t+lnZgY86i/nOrH9i1qEYIbwGr5wABl3eZ6NSD6h
         A0HABNbhqHrdtd2h8QUtypJxkddtgLmgBEmPKBYxxgZl2swsJOwC1nV2bfD8yMwuZymU
         ye64oY049kNW8XuwT0YXEEqXeFx9FGizlzw5mIuoPewOJqBUI0/IirVrT0hg22PsP8dU
         LWhQ==
X-Received: by 10.112.147.229 with SMTP id tn5mr17494150lbb.112.1367089901221;
        Sat, 27 Apr 2013 12:11:41 -0700 (PDT)
Received: from [192.168.0.78] (92-100-233-116.dynamic.avangarddsl.ru. [92.100.233.116])
        by mx.google.com with ESMTPSA id w6sm6840774law.8.2013.04.27.12.11.39
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 12:11:40 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222659>

Hi list, Hi Ray.
Ray Chen who coded this part didn't show up in this list since 2011,
so I'm asking everyone else.
Also, I don't know perl. Excuse me, if the question is stupid.

Here's the function. It's supposed to return a list of directories
that became empty during this commit. The returned paths should be SVN
paths (like "trunk/*"), but that's another question.

My comments inside.

    sub find_empty_directories {
        my ($self) = @_;
        my @empty_dirs;
        my %dirs = map { dirname($_) => 1 } @deleted_gpath;
    
        foreach my $dir (sort keys %dirs) {
                next if $dir eq ".";
    

IB> ################################################
IB> The variable $dir isn't used here.
IB> I think the value of $skip_added will be the same (0 or 1) in all
IB> iterations, regardless of $dir
                # If there have been any additions to this directory, there is
                # no reason to check if it is empty.
                my $skip_added = 0;
                foreach my $t (qw/dir_prop file_prop/) {
                        foreach my $path (keys %{ $self->{$t} }) {
                                if (exists $self->{$t}->{dirname($path)}) {
                                        $skip_added = 1;
                                        last;
                                }
                        }
                        last if $skip_added;
                }
                next if $skip_added;
IB> ################################################
    
                # Use `git ls-tree` to get the filenames of this directory
                # that existed prior to this particular commit.
                my $ls = command('ls-tree', '-z', '--name-only',
                                 $self->{c}, "$dir/");
                my %files = map { $_ => 1 } split(/\0/, $ls);
    
                # Remove the filenames that were deleted during this commit.
                delete $files{$_} foreach (@deleted_gpath);
    
                # Report the directory if there are no filenames left.
                push @empty_dirs, $dir unless (scalar %files);
        }
        @empty_dirs;
    }
