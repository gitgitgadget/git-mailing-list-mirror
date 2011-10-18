From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 3/2 v3] Refactor Git::config_*
Date: Wed, 19 Oct 2011 00:09:39 +0200
Message-ID: <201110190009.40470.jnareb@gmail.com>
References: <vpqty7wk9km.fsf@bauges.imag.fr> <201110181147.02397.jnareb@gmail.com> <7vty76f57d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Cord Seele <cowose@googlemail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Cord Seele <cowose@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 00:09:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGHr8-00087e-Kb
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 00:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640Ab1JRWJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 18:09:50 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59861 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545Ab1JRWJs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 18:09:48 -0400
Received: by eye27 with SMTP id 27so1022179eye.19
        for <git@vger.kernel.org>; Tue, 18 Oct 2011 15:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=POzXRZdV2XYmKnC5ePrgCuFwL9GYDuB04Wwuw4L0Ikg=;
        b=aOGYojZyLbGu73mK2y3HzDfz6ON69lP70MJ2OvKjJpvHytyKh9c2ydLqH8rvtx7uG1
         o80X+mUfHU1lapFJjLaHBZgc9JD6DaY3/senOAIKqKGlNUMEjVT/1nXXSYPawbInRuD6
         i2BRTo7m9N484CsQpS1l8WrrxhEN4X3SSm+RE=
Received: by 10.223.14.134 with SMTP id g6mr6720961faa.11.1318975787476;
        Tue, 18 Oct 2011 15:09:47 -0700 (PDT)
Received: from [192.168.1.13] (abwe113.neoplus.adsl.tpnet.pl. [83.8.228.113])
        by mx.google.com with ESMTPS id r24sm1202387faa.8.2011.10.18.15.09.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Oct 2011 15:09:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vty76f57d.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183906>

On Tue, 18 Oct 2011, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> > From: Junio C Hamano <gitster@pobox.com>
> >
> > There is, especially with addition of Git::config_path(), much code
> > repetition in the Git::config_* family of subroutines.
> >
> > Refactor common parts of Git::config(), Git::config_bool(),
> > Git::config_int() and Git::config_path() into _config_common()
> > helper method, reducing code duplication.
> >
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> > ---
> > Jakub Narebski wrote:
> > >
> > > I'll resend amended commit.
> >
> > Here it is.
> 
> Well, this breaks t9001 and I ended up spending an hour and half figuring
> out why. Admittedly, I was doing something else on the side, so it is not
> like the whole 90 minutes is the billable hour for reviewing this patch,
> but as far as the Git project is concerned, I didn't have any other branch
> checked out in my working tree, so that whole time was what ended up
> costing.

I'm sorry about that.  I have checked t9700-perl-git.sh and 
t9100-git-svn-basic.sh that the version before fixup had problems with,
but for some reason I had many spurious test failures, so I have not run
the full test suite (well, it would be enough to run those that require
Git.pm).

Nb. I still have:

  Test Summary Report
  -------------------
  t1402-check-ref-format.sh                        (Wstat: 256 Tests: 93 Failed: 1)
    Failed test:  31
    Non-zero exit status: 1
  t4034-diff-words.sh                              (Wstat: 256 Tests: 34 Failed: 2)
    Failed tests:  21, 25
    Non-zero exit status: 1
 
> The real problem was here.
> 
> > @@ -609,25 +592,10 @@ This currently wraps command('config') so it is not so fast.
> >  
> >  sub config_bool {
> >  	my ($self, $var) = _maybe_self(@_);
> > -
> > -	try {
> > -		my @cmd = ('config', '--bool', '--get', $var);
> > -		unshift @cmd, $self if $self;
> > -		my $val = command_oneline(@cmd);
> > -		return undef unless defined $val;
> > -		return $val eq 'true';
> > ...
> > -	};
> > +	my $val = scalar _config_common($self, $var, {'kind' => '--bool'});
> > +	return (defined $val && $val eq 'true');
> >  }
> 
> Can you spot the difference?

Damn.

I really should have done refactoring from scratch myself, instead of basing
it on "how about that" throwaway patch.

Fixed now in the version below.
 
> This is the reason why I do not particularly like a rewrite for the sake
> of rewriting.

The goal was to reduce code duplication to _avoid_ errors.

What I have noticed is that there is slight difference between original
Git::config_path and the one after refactoring.  In the version before
this patch the error catching part of config_path() looks like this:

        } catch Git::Error::Command with {
                my $E = shift;
                if ($E->value() == 1) {
                        # Key not found.
                        return undef;
                } else {
                        throw $E;
                }
        };

while after this patch (and in config()) it looks like this:

        } catch Git::Error::Command with {
                my $E = shift;
                if ($E->value() == 1) {
                        # Key not found.
                        return;
                } else {
                        throw $E;
                }
        };

I am not sure which one is right, but I suspect the latter.
Cord?

-- >8 ------------ >8 -------------- >8 --
From: Junio C Hamano <gitster@pobox.com>

There is, especially with addition of Git::config_path(), much code
repetition in the Git::config_* family of subroutines.

Refactor common parts of Git::config(), Git::config_bool(),
Git::config_int() and Git::config_path() into _config_common()
helper method, reducing code duplication.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 perl/Git.pm |   73 ++++++++++++++++------------------------------------------
 1 files changed, 20 insertions(+), 53 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index c279bfb..b7035ad 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -577,23 +577,7 @@ This currently wraps command('config') so it is not so fast.
 sub config {
 	my ($self, $var) = _maybe_self(@_);
 
-	try {
-		my @cmd = ('config');
-		unshift @cmd, $self if $self;
-		if (wantarray) {
-			return command(@cmd, '--get-all', $var);
-		} else {
-			return command_oneline(@cmd, '--get', $var);
-		}
-	} catch Git::Error::Command with {
-		my $E = shift;
-		if ($E->value() == 1) {
-			# Key not found.
-			return;
-		} else {
-			throw $E;
-		}
-	};
+	return _config_common($self, $var);
 }
 
 
@@ -610,24 +594,11 @@ This currently wraps command('config') so it is not so fast.
 sub config_bool {
 	my ($self, $var) = _maybe_self(@_);
 
-	try {
-		my @cmd = ('config', '--bool', '--get', $var);
-		unshift @cmd, $self if $self;
-		my $val = command_oneline(@cmd);
-		return undef unless defined $val;
-		return $val eq 'true';
-	} catch Git::Error::Command with {
-		my $E = shift;
-		if ($E->value() == 1) {
-			# Key not found.
-			return undef;
-		} else {
-			throw $E;
-		}
-	};
+	my $val = scalar _config_common($self, $var, {'kind' => '--bool'});
+	return undef unless defined $val;
+	return $val eq 'true';
 }
 
-
 =item config_path ( VARIABLE )
 
 Retrieve the path configuration C<VARIABLE>. The return value
@@ -640,23 +611,7 @@ This currently wraps command('config') so it is not so fast.
 sub config_path {
 	my ($self, $var) = _maybe_self(@_);
 
-	try {
-		my @cmd = ('config', '--path');
-		unshift @cmd, $self if $self;
-		if (wantarray) {
-			return command(@cmd, '--get-all', $var);
-		} else {
-			return command_oneline(@cmd, '--get', $var);
-		}
-	} catch Git::Error::Command with {
-		my $E = shift;
-		if ($E->value() == 1) {
-			# Key not found.
-			return undef;
-		} else {
-			throw $E;
-		}
-	};
+	return _config_common($self, $var, {'kind' => '--path'});
 }
 
 =item config_int ( VARIABLE )
@@ -674,15 +629,27 @@ This currently wraps command('config') so it is not so fast.
 sub config_int {
 	my ($self, $var) = _maybe_self(@_);
 
+	return scalar _config_common($self, $var, {'kind' => '--int'});
+}
+
+# Common subroutine to implement bulk of what the config* family of methods
+# do. This curently wraps command('config') so it is not so fast.
+sub _config_common {
+	my ($self, $var, $opts) = @_;
+
 	try {
-		my @cmd = ('config', '--int', '--get', $var);
+		my @cmd = ('config', $opts->{'kind'} ? $opts->{'kind'} : ());
 		unshift @cmd, $self if $self;
-		return command_oneline(@cmd);
+		if (wantarray) {
+			return command(@cmd, '--get-all', $var);
+		} else {
+			return command_oneline(@cmd, '--get', $var);
+		}
 	} catch Git::Error::Command with {
 		my $E = shift;
 		if ($E->value() == 1) {
 			# Key not found.
-			return undef;
+			return;
 		} else {
 			throw $E;
 		}
-- 
1.7.6
