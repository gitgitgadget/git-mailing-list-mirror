From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Working on gitweb (was: [PATCHv5] Add Gitweb support for XZ compressed snapshots)
Date: Mon, 3 Aug 2009 19:26:11 +0200
Message-ID: <200908031926.15255.jnareb@gmail.com>
References: <B05AF655-7430-420A-A22E-389601558B0D@uwaterloo.ca> <9b18b3110908010313x38991dffx3e4a2f2a5c5fff9f@mail.gmail.com> <9b18b3110908010413w51e901dfk5a6f1666e5c3197f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 19:26:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY1Iw-0007f3-DP
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 19:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbZHCR0V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Aug 2009 13:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbZHCR0V
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 13:26:21 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:38191 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbZHCR0U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 13:26:20 -0400
Received: by ewy10 with SMTP id 10so3203337ewy.37
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 10:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=wC4ckugMrV3yWLBvaEOka/hPsU64j37sNKptBniG48o=;
        b=ZOfkjMgtBdjAK6Rm4DCzyorM1tS6TlY43nGcMkIt2A/gzNQT7xJeIKxpkWf5dfFkVy
         jxyMqd5O19Z6zKpSs723HKNVBByNOWUpjRHGwtGKwFk7yO6mhPKTTgr7XHdqFJQPgTE9
         jXMjB3knuoUwP3l3t2Zk2NsSzXlZ2MuMndvD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YxY0OZPnE1ZHR2E4pLMcm7aSR2CmXC1qSPKfTD2daQ0gyM2oN7Wn2J5bzL/U5ohXwK
         Zaysy32vqgTRXriyEZoUra0CObuw5XDZMJMb6+01XqdPPKctcj2q6/z4805ngwRVh5yg
         5pI+KxNZCyqINsr0KbO8dvg6mWBY7xFnkQZ6A=
Received: by 10.211.202.14 with SMTP id e14mr7677775ebq.50.1249320380196;
        Mon, 03 Aug 2009 10:26:20 -0700 (PDT)
Received: from ?192.168.1.13? (abvc247.neoplus.adsl.tpnet.pl [83.8.200.247])
        by mx.google.com with ESMTPS id 10sm283139eyd.12.2009.08.03.10.26.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Aug 2009 10:26:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <9b18b3110908010413w51e901dfk5a6f1666e5c3197f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124706>

Dnia sobota 1. sierpnia 2009 13:13, demerphq napisa=C5=82:

> One thing i notice is that most/all of the existing repos are forks o=
f git.
>=20
> And the changes are to gitweb.perl, persumably on the assumption that
> people upgrade using the install process.
>=20
> That doesn't make it easy to track changes that are made to the
> production version ("installed" version), unless im missing something=
=2E
>=20
> How does one set up gitweb so that one can hack its sources and track
> them in a sane way when you are not using make install-gitweb
> (whatever) all the time?

There are at least two possible options. First (that is the one I use)
is to create script to update gitweb, which would run "make gitweb/gitw=
eb.cgi",
with appropriate option, then copy files, like gitweb-update.sh script =
below.

Second option is to do like t/t9500* gitweb test, which means providing
config file by using GITWEB_CONFIG environment variable, and set all=20
required options/variables like $GIT via config file instead of via=20
build time configuration.  See also gitweb-run.sh script below.

-- [gitweb-update.sh] --
#!/bin/bash

#BINDIR=3D"/usr/bin"
BINDIR=3D"/home/local/git"

function make_gitweb()
{
	pushd "/home/jnareb/git/"

	make GITWEB_PROJECTROOT=3D"/home/local/scm" \
	     GITWEB_CSS=3D"/gitweb/gitweb.css" \
	     GITWEB_LOGO=3D"/gitweb/git-logo.png" \
	     GITWEB_FAVICON=3D"/gitweb/git-favicon.png" \
	     GITWEB_BLAMEJS=3D"/gitweb/blame.js" \
	     GITWEB_HOMETEXT=3D"/home/local/scm/indextext.html" \
	     bindir=3D$BINDIR \
	     gitweb/gitweb.cgi

	popd
}

function copy_gitweb()
{
	cp -fv ~/git/gitweb/gitweb.{cgi,css} /home/local/gitweb/
}

make_gitweb
copy_gitweb

# end of gitweb-update.sh

-- [gitweb-run.sh] --
#!/bin/bash

export GATEWAY_INTERFACE=3D"CGI/1.1"
export HTTP_ACCEPT=3D"*/*"
export REQUEST_METHOD=3D"GET"
export QUERY_STRING=3D""$1""
export PATH_INFO=3D""$2""

export GITWEB_CONFIG=3D"~/git/gitweb/gitweb_config.perl"

perl -- ~/git/gitweb/gitweb.perl

-- [gitweb_config.perl] --
#!/usr/bin/perl

# gitweb configuration

our $version =3D "current";
#our $GIT =3D "/usr/bin/git";
our $GIT =3D "/home/local/git/git";
our $projectroot =3D "/home/local/scm";
our $home_link_str =3D "projects";
our $site_name =3D "[localhost]";
our $site_header =3D "";
our $site_footer =3D "";
our $home_text =3D "indextext.html";
our @stylesheets =3D ("file:///home/user/git/gitweb/gitweb.css");
our $logo =3D "file:///home/user/git/gitweb/git-logo.png";
our $favicon =3D "file:///home/user/git/gitweb/git-favicon.png";
our $blamejs =3D "file:///home/user/git/gitweb/blame.js";
our $projects_list =3D "";
our $export_ok =3D "";
our $strict_export =3D "";
our $project_maxdepth =3D 2007;
our @git_base_url_list =3D ("/home/user/git");

$feature{'blame'}{'default'} =3D [1];
$feature{'grep'}{'default'} =3D [1];
$feature{'pickaxe'}{'default'} =3D [1];

# end of gitweb_config.perl
--=20
Jakub Narebski
Poland
