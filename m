From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: buggy 'commitdiff_plain' output
Date: Fri, 10 Jul 2009 19:33:38 +0200
Message-ID: <200907101933.39424.jnareb@gmail.com>
References: <alpine.LFD.2.01.0907100941060.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 19:33:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPJyu-0005ME-Sq
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 19:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbZGJRdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 13:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbZGJRdt
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 13:33:49 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:35823 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbZGJRds (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 13:33:48 -0400
Received: by fxm18 with SMTP id 18so1039872fxm.37
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LKDKAe6SVzBOPD5DsxojTu86TZuO+pj+dk5IS9cM6P0=;
        b=LHfHqkNqqkjDMWAw+0KP9bQ1hzF5Xnlx21awNr73mDMF2/ESh6Blu60jfmrMdelF4I
         xDVhbHQI3vO7PPa6A7WJqrOLLnGBZCWHTjXtiRRaC1XB7+PwryvJK2cAhAuQuRirIb4j
         LoMhiy/HXOWQDSdyAZ/PqyZBawndO8ojAGjGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=uPf5Vc0upb7jOK6wjyy0clQPrp1qWjp/HpYvoxyHeUgO/GcBuLcbYYA36i/JNB4Xdu
         OS+hrzDpwbvyQGNnTiiSanb5lyY7h3NOu/gzLbRjCoCWb+zbefvAHllBGM5ya7S7G8d1
         FGzx1x/NQB+gqg3B0Js8PGdZjHlkRfsD1se4U=
Received: by 10.103.189.8 with SMTP id r8mr1212344mup.11.1247247226568;
        Fri, 10 Jul 2009 10:33:46 -0700 (PDT)
Received: from ?192.168.1.13? (abwp104.neoplus.adsl.tpnet.pl [83.8.239.104])
        by mx.google.com with ESMTPS id n7sm6916742mue.28.2009.07.10.10.33.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Jul 2009 10:33:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.2.01.0907100941060.3352@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123071>

On Fri, 10 July 2009, Linus Torvalds wrote:
> 
> I complained to the CIFS people about their crazy duplicated commit 
> message headers: see for example
[...]

> It turns out that that duplication is because they use gitweb as a strange 
> patch distribution system (rather than emailing each other patches), and 
> download the 'commitdiff_plain' version of the diff and then apply it with 
> 'git am -s'.

First question: do they use gitweb from git.git repository, or a custom
fork of gitweb (like git.kernel.org gitweb, which has caching, but IIRC
does not have all new gitweb features)?

> Ok, so it's a really odd way of doing things, but hey, that gitweb feature 
> clearly does try to support that exact workflow, or why would that 
> commitdiff_plain output try to look like an email?
> 
> But gitweb is a totally buggy piece of trash when it comes to exporting 
> commits that way.

Actually the problem is deeper; both 'commitdiff' and 'commitdiff_plain'
try to do two things at once: an equivalent of "git show <commit>" _and_ 
equivalent of "git diff <commit 1> <commit 2>"... and they fail.

> 
> Why? Because it first has a 'Subject:' line, and then the "body" of the 
> email repeats the raw commit message output. So _of_course_ you get the 
> header duplicated.

Yes, this is bug in 'commitdiff_plain' output.  Perhaps it should mimic
'--pretty=email' format better.  Perhaps it shouldn't mimic email format
at all, but be more like "git show <commit>".

THE SOLUTION is to use 'patch' or 'patches' view, introduced by 
Giuseppe Bilotta on 18 Dec 2008 in series of commits from 9872cd6f to
75bf2cb2.  It uses git-format-patch, and can be fed directly to git-am.
Problem solved.

> Now, I asked Steve to not use gitweb (or edit the result some way), but 
> this really is a gitweb bug. And since I don't do perl, I can't fix it, 
> even though I can pinpoint exactly where the bug is (lines 5732 - 5752 in 
> gitweb/gitweb.perl).
> 
> I totally untested patch written by a monkey who doesn't actually do perl 
> is appended as a purely theoretical pointer in the right direction. But I 
> really have no clue about perl, so what the heck do I know? This is like 
> my tcl programming - pattern matching rather than any real understanding.
> 
> I'm sure there are smarter ways to do this with some simple mapping 
> function or whatever.
> 
> 		Linus

I'd have to examine closer what git_commitdiff_plain does, and what
parse_commit_text does to extract subject from commit message.
With the caveat that perhaps it would be better to get rid of mail-like
'commitdiff_plain' and mimic git-show output...
 
> ---
>  gitweb/gitweb.perl |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 6a1b5b5..a809768 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5729,6 +5729,7 @@ sub git_commitdiff {
>  		}
>  
>  	} elsif ($format eq 'plain') {
> +		my $show = false;
>  		my $refs = git_get_references("tags");
>  		my $tagname = git_get_rev_name_tags($hash);
>  		my $filename = basename($project) . "-$hash.patch";
> @@ -5747,7 +5748,11 @@ sub git_commitdiff {
>  		print "X-Git-Url: " . $cgi->self_url() . "\n\n";
>  
>  		foreach my $line (@{$co{'comment'}}) {
> -			print to_utf8($line) . "\n";
> +			if ($show) {
> +				print to_utf8($line) . "\n";
> +			} else if ($line ne "") {
> +				$show = true;
> +			}
>  		}
>  		print "---\n\n";
>  	} elsif ($format eq 'patch') {
> 

-- 
Jakub Narebski
Poland
