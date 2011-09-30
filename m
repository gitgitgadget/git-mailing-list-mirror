From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] use new Git::config_path() for aliasesfile
Date: Fri, 30 Sep 2011 12:55:45 -0700
Message-ID: <7vsjndoldq.fsf@alter.siamese.dyndns.org>
References: <vpqty7wk9km.fsf@bauges.imag.fr>
 <1317379945-9355-1-git-send-email-cowose@gmail.com>
 <1317379945-9355-3-git-send-email-cowose@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>,
	Cord Seele <cowose@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Cord Seele <cowose@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 21:55:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9jBa-0007mm-8i
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 21:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756196Ab1I3Tzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 15:55:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755450Ab1I3Tzs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 15:55:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AE13422C;
	Fri, 30 Sep 2011 15:55:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QpuaH+qNKV+LN09PiFl3UOLUU6o=; b=OtiBwQ
	fVLx0VBvx6W67FGhhfi324GPLGRncPfT4+yitCybkNHl9LOwylQ2xe96wr8MiU5D
	gxrC7IPSpulOd1r+HSW/LqHdQvNDUqz2mG789mR1pFqVC3JMxX31c1ibRUYayU9z
	aV8J3uuY9koIvUbY7fhNISdDCQkBBKff63oHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wGQnMnw40+1ckbfqHwy5JosIHQvFb07v
	VFEIr/XtiCEuY8wH+KfjYC8gO66nsM8NX+yZS+EE5qHX7eSkEBALFscKmhIIjPsQ
	ZGJfk2X180It9ifjXyGmIhTgBrQkfhnjuMC4Hp4peQ/G+gBRG0CawFWnYx2C6ka0
	g8Nz3z8QC6o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20DD9422B;
	Fri, 30 Sep 2011 15:55:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77FA94227; Fri, 30 Sep 2011
 15:55:46 -0400 (EDT)
In-Reply-To: <1317379945-9355-3-git-send-email-cowose@gmail.com> (Cord
 Seele's message of "Fri, 30 Sep 2011 12:52:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30132B2A-EB9E-11E0-B682-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182507>

I think the addition of "config --path" support is a good idea, but the
resulting code suffers from too many cut&paste cruft across the config*
family of methods.

How about doing a bit of refactoring, perhaps something like this, on top
as a separate patch?

I tried to be careful to still forcing the "one value only" for config_bool
and config_int, but extra sets of eyeballs would be needed.

 perl/Git.pm |   93 +++++++++++++++++-----------------------------------------
 1 files changed, 27 insertions(+), 66 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index c279bfb..f0a6e92 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -563,22 +563,18 @@ sub wc_chdir {
 }
 
 
-=item config ( VARIABLE )
+=item _config_common ( VARIABLE )
 
-Retrieve the configuration C<VARIABLE> in the same manner as C<config>
-does. In scalar context requires the variable to be set only one time
-(exception is thrown otherwise), in array context returns allows the
-variable to be set multiple times and returns all the values.
-
-This currently wraps command('config') so it is not so fast.
+Common subroutine to implement bulk of what the config* family of methods
+do. This wraps command('config') so it is not so fast.
 
 =cut
 
-sub config {
-	my ($self, $var) = _maybe_self(@_);
-
+sub _config_common {
+	my ($self, $var, $opts) = _maybe_self(@_);
+	
 	try {
-		my @cmd = ('config');
+		my @cmd = ('config', $opts->{'kind'} ? @{$opts->{'kind'}} : ());
 		unshift @cmd, $self if $self;
 		if (wantarray) {
 			return command(@cmd, '--get-all', $var);
@@ -594,6 +590,21 @@ sub config {
 			throw $E;
 		}
 	};
+
+}
+
+=item config ( VARIABLE )
+
+Retrieve the configuration C<VARIABLE> in the same manner as C<config>
+does. In scalar context requires the variable to be set only one time
+(exception is thrown otherwise), in array context returns allows the
+variable to be set multiple times and returns all the values.
+
+=cut
+
+sub config {
+	my ($self, $var) = _maybe_self(@_);
+	return _config_common($self, $var, +{});
 }
 
 
@@ -603,60 +614,24 @@ Retrieve the bool configuration C<VARIABLE>. The return value
 is usable as a boolean in perl (and C<undef> if it's not defined,
 of course).
 
-This currently wraps command('config') so it is not so fast.
-
 =cut
 
 sub config_bool {
 	my ($self, $var) = _maybe_self(@_);
-
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
+	return (defined $val && $val eq 'true');
 }
 
-
 =item config_path ( VARIABLE )
 
 Retrieve the path configuration C<VARIABLE>. The return value
 is an expanded path or C<undef> if it's not defined.
 
-This currently wraps command('config') so it is not so fast.
-
 =cut
 
 sub config_path {
 	my ($self, $var) = _maybe_self(@_);
-
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
+	return _config_common($self, $var, +{'kind' => '--path'});
 }
 
 =item config_int ( VARIABLE )
@@ -667,26 +642,12 @@ or 'g' in the config file will cause the value to be multiplied
 by 1024, 1048576 (1024^2), or 1073741824 (1024^3) prior to output.
 It would return C<undef> if configuration variable is not defined,
 
-This currently wraps command('config') so it is not so fast.
-
 =cut
 
 sub config_int {
 	my ($self, $var) = _maybe_self(@_);
-
-	try {
-		my @cmd = ('config', '--int', '--get', $var);
-		unshift @cmd, $self if $self;
-		return command_oneline(@cmd);
-	} catch Git::Error::Command with {
-		my $E = shift;
-		if ($E->value() == 1) {
-			# Key not found.
-			return undef;
-		} else {
-			throw $E;
-		}
-	};
+	my $val = scalar _config_common($self, $var, +{'kind' => '--int'});
+	return $val;
 }
 
 =item get_colorbool ( NAME )
