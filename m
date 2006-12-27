From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/6] gitweb: Some mod_perl specific support (but not only)
Date: Wed, 27 Dec 2006 23:55:31 +0100
Message-ID: <200612272355.31923.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 28 01:03:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzikI-0002Eb-Rg
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 01:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWL1ADj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 19:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWL1ADj
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 19:03:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:55841 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964827AbWL1ADi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 19:03:38 -0500
Received: by ug-out-1314.google.com with SMTP id 44so4021260uga
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 16:03:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cUPWaneWTG+h4cuMWyvj8Y2ntYLhlE8H7gvmCOXg5RjzcLBZZ8tygsdoY39PCv0q16DyieIJPQeYYN5vHb+KjLrXHt4LG2aFpRJmolDANPT82s7EvdMw6fGrgAOmLmxNCo0uWkuVRnWQw7yulO3ILrG+k+s7xj/7WF/jCWiCD24=
Received: by 10.67.117.2 with SMTP id u2mr20703300ugm.1167264217031;
        Wed, 27 Dec 2006 16:03:37 -0800 (PST)
Received: from host-81-190-19-121.torun.mm.pl ( [81.190.19.121])
        by mx.google.com with ESMTP id j3sm19956330ugd.2006.12.27.16.03.36;
        Wed, 27 Dec 2006 16:03:36 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35487>

This is series of gitweb patches to provide better mod_perl
support, for now running gitweb under mod_perl's Registry,
but in the future as mod_perl handler.

First patch is mod_perl related only in a way that it provides
path to mod_perl specific support, but has its own advantages
even when running gitweb simply as CGI script, namely the
centralization of stopping output after HTTP header for HEAD
requests. Till this patch only git_feed had this feature (originally
by Andreas Fuchs).

Second patch was created because further patches make gitweb to
have different codepath for mod_perl; so mod_perl version string
was added to "generator" meta header in HTML header.

I'm not so sure about third patch, namely if I understood what
is written in CGI(3pm) about compile method.

Fourth patch prepares the way for mod_perl specific support.
Perhaps "our $r = shift @_;" instead of "my $r = shift @_;"
would be better.

Fifth patch appears to be unnecessary, at least for now, because
mod_perl Registry populates %ENV hash (and does not need to set
envirionmental variables). Still, it prepares the way for future
running gitweb as mod_perl handler, and not under Registry.

Sixth patch is an RFC. It tries to add HTTP headers directly,
allowing Apache to not need to parse headers, which should speed
up gitweb a bit. It also makes use of mod_perl meets_expectation
method to respond to If-Modified-Since: and If-None-Match: requests
for cache validation. Current state is a bit of mess as it is now.
Comments (and patches) appreciated.

Table of contents (shortlog):
=============================
 [PATCH 1/6] gitweb: Separate HTTP header output
 [PATCH 2/6] gitweb: Add mod_perl version string to "generator" meta header
 [PATCH 3/6] gitweb: Precompile CGI routines for mod_perl
 [PATCH/RFC 4/6] gitweb: Prepare for mod_perl specific support
 [RFC/PATCH 5/6] gitweb: Make possible to run under mod_perl without SetupEnv
 [RFC/PATCH 6/6] gitweb: Make possible to run under mod_perl without ParseHeaders

Diffstat:
=========
 gitweb/gitweb.perl |  227 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 205 insertions(+), 22 deletions(-)

Benchmarks:
===========
$ ab -n 10 "http://localhost/perl/gitweb/gitweb.cgi?p=git.git;a=summary"
$ ab -n 10 -c 2 "http://localhost/perl/gitweb/gitweb.cgi?p=git.git;a=summary"
(hot cache)

$ ab -n 10 "http://localhost/perl/gitweb/gitweb.cgi/git.git"
$ ab -n 10 -c 2 "http://localhost/perl/gitweb/gitweb.cgi/git.git"
(hot cache)

patch                                         | mean +/- sd     | mean -c 2
-----------------------------------------------------------------------------
[before first patch in series]:               | 287 +/-  8.8 ms | 296.049 ms
 (path_info version)                          | 293 +/- 10.6 ms | 314.526 ms
gitweb-Separate-HTTP-header-output:           | 302 +/- 46.7 ms | 300.305 ms
gitweb-Add-mod_perl-to-generator:             | 288 +/- 15.6 ms | 306.050 ms
gitweb-Precompile-CGI-routines-for-mod_perl:  | 291 +/- 10.9 ms | 306.704 ms
gitweb-Prepare-for-mod_perl-specific-support: | 299 +/- 11.0 ms | 300.879 ms
gitweb-mod_perl-without-SetupEnv:             | 288 +/- 12.4 ms | 296.809 ms
 (path_info version)                          | 292 +/- 12.7 ms | 307.380 ms
gitweb-mod_perl-without-ParseHeaders:         | ???             | ???

-- 
Jakub Narebski
Poland
