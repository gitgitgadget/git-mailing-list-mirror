From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFH] - git-svn auth bug (possibly SVN 1.5.0-related)
Date: Mon, 4 Aug 2008 18:18:20 +0400
Message-ID: <20080804141820.GT7008@dpotapov.dyndns.org>
References: <20080725060037.GB14756@untitled> <4889F215.9020804@kitware.com> <20080726054547.GA20494@untitled> <488B2FC5.4080801@kitware.com> <20080803220251.GB3006@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 16:19:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ0uK-0003k4-3N
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 16:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972AbYHDOS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 10:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754816AbYHDOS1
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 10:18:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:46794 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbYHDOS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 10:18:26 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1000897fgg.17
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 07:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=B1kgbyT4qd7Pq8h+YUhsj9J4luTyJmnvR+zEIdQ7Sn0=;
        b=ej1vX8Cvj5T8StibNmWytAFnqi8iU7X7WjT4Is+Gq6+N5ZUqaUXZxOtjrwuVAMNmme
         mW/zkhSXlFXnt914bkc3uke81c1qc/MUgWjx9rsdfNlJrAf9kqg6TkFdnoltFq7khVZf
         szY4KQOqXQ0VWa2zr39If5EktSzdAevZF8BZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rd+tRfruEEfLmVjB4kUpNpYeTyzh3YjjLIXBWU3pTuZ8wOKaCU5YUdzBSR3dAdpVsU
         MkTsSlwTQ8UqQRchPQgS3/DDXvBBWjufBsqHyVEQyjv11nrVQPq3Vc8XVfQg9yiaa5+l
         klLpfHN5Ca3hIRUMTDxzpu2itWORkfHTBUcZI=
Received: by 10.86.80.5 with SMTP id d5mr10452981fgb.26.1217859504492;
        Mon, 04 Aug 2008 07:18:24 -0700 (PDT)
Received: from localhost ( [85.141.237.93])
        by mx.google.com with ESMTPS id e20sm2820136fga.1.2008.08.04.07.18.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Aug 2008 07:18:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080803220251.GB3006@untitled>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91359>

On Sun, Aug 03, 2008 at 03:02:51PM -0700, Eric Wong wrote:
> 
> It could be another incompatibility introduced in SVN 1.5.0.
> 
> I'll try to dist-upgrade a machine to Lenny sometime in the next two
> weeks so I can test; I'm pretty busy these days but if anybody else
> wants to figure this out in the meantime, please do :)

The problem happens only if you use FS format 3 regardless what version
of SVN perl binding you use. Also, there is no problem with using SVN
1.5 (I tried 1.5.1) as long as you use FS format 2 (I tested git-svn
with libsvn-perl 1.4.2 and 1.5.1 works fine) but if your repository is
initialized to use FS format 3 (which is the default in SVN 1.5) then
this problem happens with all versions of SVN perl binding, and it
happens exactly in the same place:

 /home/dpotapov/git/git-svn:3333:    my @ce  = $opts->{ra}->get_commit_editor($opts->{log},
sub get_commit_editor {
 /home/dpotapov/git/git-svn:3909:    my ($self, $log, $cb, $pool) = @_;
 /home/dpotapov/git/git-svn:3910:    my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef, 0) : ();
 /home/dpotapov/git/git-svn:3911:    $self->SUPER::get_commit_editor($log, $cb, @lock, $pool);
sub AUTOLOAD {
 /usr/lib/perl5/SVN/Ra.pm:74:     my $class = ref($_[0]);
 /usr/lib/perl5/SVN/Ra.pm:75:     my $method = $AUTOLOAD;
 /usr/lib/perl5/SVN/Ra.pm:76:     $method =~ s/.*:://;
 /usr/lib/perl5/SVN/Ra.pm:77:     return unless $method =~ m/[^A-Z]/;
 /usr/lib/perl5/SVN/Ra.pm:79:     my $self = shift;
 /usr/lib/perl5/SVN/Ra.pm:82:     my $func = $self->{session}->can ($method)
 /usr/lib/perl5/SVN/Ra.pm:85:     my @ret = $func->($self->{session}, @_);

Numbers of lines may be different for different versions of libsvn-perl,
but the effect is exactly the same. Instead of going to the next line
and completing AUTOLOAD, if you use FS format 3 then you end up in
croak_on_error(), which uses some uninitialized value in string
concatenation (which produces an additional warning) and then calls
croak(). End of the story :(


Dmitry
