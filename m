From: Duy Nguyen <pclouds@gmail.com>
Subject: Splitting config.txt
Date: Wed, 6 Mar 2013 21:01:42 +0700
Message-ID: <20130306140141.GA24386@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 06 15:01:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDEu3-0001pn-Hd
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 15:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756857Ab3CFOAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 09:00:41 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:34108 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345Ab3CFOAk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 09:00:40 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp2so6050839pbb.34
        for <git@vger.kernel.org>; Wed, 06 Mar 2013 06:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=dGJ+sdMu8OdkH0CdUuYZSUg9n1sMQlEbttTRXpeRpTk=;
        b=Gybz9C0cp2Si6O5SZ5qsP2wLeFY9z8nbGakudQblM/b/XnJA8jC8mo+zJFN9CJLwg6
         5R92sr2muj3lYfPzhactnJt37rAlvr9N2+4xLwbQiSOrSNZOnkoFMQ46j/1NCu591xKn
         GmKxZkLMWVx6FcKVu9ukLhp91Z7aem7vH31PvtJ+AXum6xGOf0Nj91SkEKdQ56ykrMUp
         uQqRcu4A7FPGsze1/e/cmDYEPxbg4mxrkA1fpZo/XMlobr/upRLEAZaEfVOEYRrJe6OL
         GlX/RDk5zkQU/yoTjkndzvp408+MfkRceB9OCd9rRra40AvPsvvyjExY+Xa3LDp0Aehp
         6lvQ==
X-Received: by 10.68.29.98 with SMTP id j2mr47036074pbh.216.1362578440305;
        Wed, 06 Mar 2013 06:00:40 -0800 (PST)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id c8sm31454779pbq.10.2013.03.06.06.00.36
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Mar 2013 06:00:38 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 06 Mar 2013 21:01:42 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217526>

We discussed this before about adding configuration variables into
individual command man pages [1]. This may be a step towards
that. With this, I could add selected configuration variables to
git-push.txt, for example, with a simple patch:

-- 8< --
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 1398025..c130c90 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -348,6 +348,13 @@ you are certain that nobody in the meantime fetched your earlier commit A
 overwrite it. In other words, "git push --force" is a method reserved for
 a case where you do mean to lose history.
 
+CONFIGURATION
+-------------
+
+include::config/push.default.txt[]
+include::config/remote.name.pushurl.txt[]
+include::config/remote.name.push.txt[]
+
 
 Examples
 --------
-- 8< --

I know it makes man pages longer (and more intimidating for new
users), but the point is we could select just important keys for each
man page, instead of all keys affecting the command.

I don't post the final patch that splits config.txt, just the script I
use to split it. You can try it yourself. It puts each config key into
a file under Documentation/config, with some characters mangled to be
more fs friendly. Run it inside Documentation/. generated git-config.1
is the same after the split.

-- 8< --
#!/usr/bin/perl

sub extract {
    my ($line) = @_;
    open CC, ">config/$filename" || die "failed to open config/$filename";
    foreach $l (@lines[($start - 1)..($line - 2)]) {
	$l =~ s/^include::/include::..\//;
	print CC $l;
    }
    close CC;
    print C "include::config/$filename" . "[]\n";
}

open C, "config.txt" || die "failed to open config.txt";
our @lines = <C>;
close C;

our $start = 0;
our $filename;

open F, "grep -n '^[a-z].*::\$' config.txt|" || die "failed to grep";
open C, ">config.txt.new" || die "unable to open config.txt.new";
while (<F>) {
    chomp;
    $_ =~ m/([^:]*):(.*)/;
    my $line = $1;
    my $name = $2;
    $name =~ s/\*/_/g;
    $name =~ s/<//g;
    $name =~ s/>//g;
    $name =~ s/::$//;
    $name = "http.speedLimit" if $name eq "http.lowSpeedLimit, http.lowSpeedTime";
    $name = "gitcvs.userpass" if $name eq "gitcvs.dbuser, gitcvs.dbpass";
    next if $line - $start == 1;
    if ($start > 0) {
	extract $line;
    } else {
	foreach $l (@lines[0..($line-2)]) {
	    print C $l;
	}
    }
    $start = $line;
    $filename = $name . ".txt";
}

extract $#lines + 2;
close C;
system "mv config.txt.new config.txt";
-- 8< --

[1] http://thread.gmane.org/gmane.comp.version-control.git/206780/focus=206939
