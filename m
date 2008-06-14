From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [RFC/PATCH (WIP)] gitweb: Use Test::WWW::Mechanize::CGI to test
 gitweb output
Date: Sat, 14 Jun 2008 16:40:13 +0200
Message-ID: <4853D84D.5010303@gmail.com>
References: <200806141447.28052.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 16:40:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Wvs-0003zX-P2
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 16:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660AbYFNOju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 10:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754854AbYFNOju
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 10:39:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:20774 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057AbYFNOjt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 10:39:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2980523fgg.17
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 07:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=McgeRdBDCYscU2Qh1eNaCSGk03RLWdT5f2F2Y5uCE5c=;
        b=KKpAnAoBqujibWx3iJxuil/rFS3eOdocdE0LHNDrug9MOavafBOTSjg0UlZHkJCDZ9
         uFbhEzIP4CcW9DMzdnhTrnPcvXT9y2V9D+yqbh/miqah8RByp986QUymrx2w/lZAF2D2
         7jnLcBpTGVQhVsfeJSZjerBXIl1+0T/ZSTJwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=CwSu2FOiVl7d/Axc9I5dV1HWKt/WeQ/0tIiMGjYhEpz+P9JbvEtNCGjF3BzwvLJcWc
         GrdEtK8NrScBjm870R2UkXYlZhPEdzi+/Lvpy4v1cZhwOA8l4fRyFxd4f7G/d85OqI20
         KBgdLtLPQhl+lYScDzij/F2u0Iq6Ki8hy0wjw=
Received: by 10.86.27.9 with SMTP id a9mr5757829fga.57.1213454387845;
        Sat, 14 Jun 2008 07:39:47 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.200.93])
        by mx.google.com with ESMTPS id e20sm8600899fga.1.2008.06.14.07.39.46
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 07:39:47 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <200806141447.28052.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85017>

Jakub Narebski wrote:
> This test requires [PATCH] t/test-lib.sh: add test_external and test_external_without_stderr

For everyone's convenience, here's the raw patch: 
http://article.gmane.org/gmane.comp.version-control.git/83415/raw
(When repo.or.cz is up again you can also locate a version with fixed 
whitespace in my repo: <http://repo.or.cz/w/git/gitweb-caching.git>)

> This test uses Perl module Test::WWW::Mechanize::CGI to check
> gitweb output, using HTML::Lint (if present) to validate HTML.

Awesome, thank you so much for making a start here!  Here are some quick 
comments.

> NOTE: Currently test_external_without_stderr fails because when trying
> to access URL for non-existent commit gitweb writes to STDERR; it is
> not necessarily a bug because it is not written to web server logs

Without having looked at the cause of that, I think that gitweb should 
not be writing stuff to stderr unless an internal or serious error 
occurs; in particular trying to access invalid commits shouldn't cause 
messages on stderr, only to log files if at all.

That said, as long as it isn't fixed, here's my workaround to 
temporarily discard stderr (from my t/t9710/test.pl):

our $old_stderr;
sub discard_stderr {
         open our $old_stderr, ">&", STDERR or die "cannot save STDERR";
         close STDERR;
}
sub restore_stderr {
         open STDERR, ">&", $old_stderr or die "cannot restore STDERR";
}

It works on Unix, but I don't know about other platforms.

> +cat >gitweb_config.perl <<EOF
> [...]
> +our \$GIT = "git";

t9500 seems to be doing the same(?) thing, but this somehow doesn't work 
with your t9503 test:

$ git     # no git in PATH to make sure it picks up the right git binary
bash: git: command not found
$ ./t9500-gitweb-standalone-no-errors.sh | grep passed
* passed all 75 test(s)
$ ./t9503-gitweb-Mechanize.sh -v
[...]
	gitweb.perl: Can't exec "git": No such file or directory at 
/home/lea/source/git/fresh-git/gitweb/gitweb.perl line 380.

-- Lea
