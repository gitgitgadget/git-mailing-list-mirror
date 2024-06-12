Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2745181B94
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209295; cv=none; b=b641VmeW8WZFuYqLLT0KyeGEDYToHsr5J3DMc4XHG3JsbtVjxn2iX/s7P2kixfYfZswMnBsj2WTXSEyZ145k57bekw2SWlyyhPSYTk0jQcZxArPjLp3tHQMc5CpRVt2kfAi5S/KCvQkxorEyHMa9t4fzbKn77rjp47ZmrsfePl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209295; c=relaxed/simple;
	bh=iiRKVUMv5sboRF9MPVBX9tntiXfFhIG8FY6LuKmnkPs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HLciqY7hJTNNbFdi4tseRAe6IGWEwegIAxZVUJyvUtpFk2Lcb1dqG10uvvio+F0Vzo1nolV07jDM1IQEOBG7ydwd9/nV95SUSGSznNuqNfCwq/QqIFCUdadIdRor/9Fw3RiFCUAiuVbZHNIy+Z9EzAQiABz1D5gTJJA8oFRfHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iQ+Qv0nC; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iQ+Qv0nC"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3FEA92E543;
	Wed, 12 Jun 2024 12:21:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=i
	iRKVUMv5sboRF9MPVBX9tntiXfFhIG8FY6LuKmnkPs=; b=iQ+Qv0nCxPrVFU/DW
	9pkR7ZBJyAffs2ikXuxaT43uAi23iDHhTVX8PEGkoDYZO3KlcwgnjvJcKUH1A0uj
	P0Uda3vMs6lBBF4w4Go6OCWxzMcfs1zrFFodNHmG0HUPFDV7LO1XAFsplWjkt9aq
	q0pECaNioYP0EYN8OY1aGUxqWM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 38D632E542;
	Wed, 12 Jun 2024 12:21:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CFEA22E541;
	Wed, 12 Jun 2024 12:21:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [RFH] t9500 failing???
Date: Wed, 12 Jun 2024 09:21:28 -0700
Message-ID: <xmqqr0d2p1x3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D339E4CC-28D7-11EF-8400-C38742FD603B-77302942!pb-smtp20.pobox.com

Suddenly t9500.70 has started failing for me in my local environment
(but $Corp IT folks control pretty much which version of base software
is installed and updated at what time, once I choose "I want to do CGI
in Perl" by selecting the libcgi-pm-perl module, I am not sure from
which version the thing was updated from.  The Debian version claims
to be 4.62-1.

It fails with path-info test, starting at t9500.70 with extra
warning in the log.  This code

	if ($path_info) {
		# $path_info has already been URL-decoded by the web server, but
		# $my_url and $my_uri have not. URL-decode them so we can properly
		# strip $path_info.
		$my_url = unescape($my_url);
		$my_uri = unescape($my_uri);
		if ($my_url =~ s,\Q$path_info\E$,, &&
		    $my_uri =~ s,\Q$path_info\E$,, &&
		    defined $ENV{'SCRIPT_NAME'}) {
			$base_url = $cgi->url(-base => 1) . $ENV{'SCRIPT_NAME'};
		}
	}

before it calls unescape(), I know $my_url is a
http://localhost/gitweb.cgi and after it calls unescape, it becomes
undefined.  That will trigger a "Use of uninitialized value $my_url
in substitution (s///)" warning.

unescape comes from CGI::Util because we do

	use CGI::Util qw(unescape);

early in the program.

As a workaround I locally have the attached patch to disable calling
CGI::Util::unescape implicitly as a sub, and instead make an
explicit call to it as a class method, and it seems to make the
tests pass.  Please do not ask me why it works---the reason why I am
posting this message is to find somebody who can explain it to me ;-)

The "unescape" thing in CGI::Util.pm begins with the standard
boilerplate that lets you call it as a plain-vanilla sub as well as
a class method, like so:

    # unescape URL-encoded data
    sub unescape {
      shift() if @_ > 0 and (ref($[0]) || (defined $[1] && $_[0] eq $CGI::DefaultClass));

but it seems that it has been that way since 2009, so it does not
explain why it started breaking for me all of sudden, even though
it _is_ curious that its counterpart in the same file, escape,
starts slightly differently to (presumably) achieve the same thing.

    sub escape {
      # If we being called in an OO-context, discard the first argument.
      shift() if @_ > 1 and ( ref($[0]) || (defined $[1] && $_[0] eq $CGI::DefaultClass));

Notice that the former does "shift" as long as there is even a
single argument, while the latter does so only when there are at
least two arguments.  Both presumably would take a single argument,
the string to either escape or unescape, and the shift is presumably
to shift away the class object if they are called as class methods,
so the guard at the beginning of unscape looks suspect, but I am not
a Perl person, and as I said, it seems that the code has been that
way since 2009, so it is very likely that I am barking up a wrong
tree.

Anyway.  TIA for whoever explains the solution to this puzzle to me.


 gitweb/gitweb.perl | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git c/gitweb/gitweb.perl w/gitweb/gitweb.perl
index ccd14e0e30..a0a8b79ef4 100755
--- c/gitweb/gitweb.perl
+++ w/gitweb/gitweb.perl
@@ -13,7 +13,7 @@
 # handle ACL in file access tests
 use filetest 'access';
 use CGI qw(:standard :escapeHTML -nosticky);
-use CGI::Util qw(unescape);
+use CGI::Util qw();
 use CGI::Carp qw(fatalsToBrowser set_message);
 use Encode;
 use Fcntl ':mode';
@@ -22,6 +22,11 @@
 use Time::HiRes qw(gettimeofday tv_interval);
 use Digest::MD5 qw(md5_hex);
 
+sub unescape {
+	my $url = shift;
+	return CGI::Util->unescape($url);
+}
+
 binmode STDOUT, ':utf8';
 
 if (!defined($CGI::VERSION) || $CGI::VERSION < 4.08) {
