From: Stefan Sperling <stsp@elego.de>
Subject: Re: [PATCH v2] Add svnrdump
Date: Wed, 14 Jul 2010 17:32:06 +0200
Message-ID: <20100714153206.GH25630@jack.stsp.name>
References: <20100709142910.GB20383@debian>
 <20100713201105.GN13310@ted.stsp.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "dev@subversion.apache.org" <dev@subversion.apache.org>,
        Bert Huijben <rhuijben@collab.net>,
        Daniel Shahaf <d.s@daniel.shahaf.name>,
        Will Palmer <wmpalmer@gmail.com>,
        David Michael Barr <david.barr@cordelta.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sverre Rabbelier <srabbelier@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: dev-return-5003-gcvsd-dev=m.gmane.org@subversion.apache.org Wed Jul 14 17:33:15 2010
Return-path: <dev-return-5003-gcvsd-dev=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsd-dev@lo.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <dev-return-5003-gcvsd-dev=m.gmane.org@subversion.apache.org>)
	id 1OZ3xR-0007AF-TX
	for gcvsd-dev@lo.gmane.org; Wed, 14 Jul 2010 17:33:14 +0200
Received: (qmail 48176 invoked by uid 500); 14 Jul 2010 15:33:12 -0000
Mailing-List: contact dev-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:dev-help@subversion.apache.org>
List-Unsubscribe: <mailto:dev-unsubscribe@subversion.apache.org>
List-Post: <mailto:dev@subversion.apache.org>
List-Id: <dev.subversion.apache.org>
Delivered-To: mailing list dev@subversion.apache.org
Received: (qmail 48168 invoked by uid 99); 14 Jul 2010 15:33:11 -0000
Received: from nike.apache.org (HELO nike.apache.org) (192.87.106.230)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 14 Jul 2010 15:33:11 +0000
X-ASF-Spam-Status: No, hits=-0.7 required=10.0
	tests=RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (nike.apache.org: local policy)
Received: from [192.109.42.8] (HELO einhorn.in-berlin.de) (192.109.42.8)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 14 Jul 2010 15:33:04 +0000
X-Envelope-From: stsp@stsp.name
Received: from jack.stsp.name (i577B52DC.versanet.de [87.123.82.220])
	(authenticated bits=128)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o6EFWAnP017020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 14 Jul 2010 17:32:10 +0200
Received: from jack.stsp.name (stsp@localhost [127.0.0.1])
	by jack.stsp.name (8.14.3/8.14.3) with ESMTP id o6EFW9bJ003129;
	Wed, 14 Jul 2010 17:32:09 +0200 (CEST)
Received: (from stsp@localhost)
	by jack.stsp.name (8.14.3/8.14.3/Submit) id o6EFW6mZ030831;
	Wed, 14 Jul 2010 17:32:06 +0200 (CEST)
Mail-Followup-To: Ramkumar Ramachandra <artagnon@gmail.com>,
	"dev@subversion.apache.org" <dev@subversion.apache.org>,
	Bert Huijben <rhuijben@collab.net>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Will Palmer <wmpalmer@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100713201105.GN13310@ted.stsp.name>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150997>

On Tue, Jul 13, 2010 at 10:11:05PM +0200, Stefan Sperling wrote:
> Review below.

A couple of additional remarks:

Playing with svnrdump and comparing its output to the output of
svnadmin dump --deltas, I noticed that:

 - svnrdump doesn't dump revision 0.
   It should dump revision 0, because that revision can contain important
   revprops such as metadata for svnsync (svn:sync-last-merge-rev etc.)
 - You're missing a couple of fields:
   The UUID of the repository.
   Text-content-sha1
   Text-delta-base-md5
   Text-delta-base-sha1
 - I've seen a "Prop-delta: true" line which svnadmin dump does not print.
 - You're missing some newlines that svnadmin dump prints (cosmetic,
   but it would be nice if both produced matching output).

How to reproduce what I'm seeing:
  Use svnsync to get a copy of the numptyphysics repository at
    https://vcs.maemo.org/svn/numptyphysics (I had a dump of that lying
    around... other repositories might do the job just as well, of course)
  Dump the repository using svnadmin dump --deltas.
  Dump the repository using svnrdump.
  Compare output with diff -u.

Please get rid of all global variables in svnrdump.c:
subversion/svnrdump/svnrdump.c:43: warning: declaration of `pool' shadows a glob
al declaration
subversion/svnrdump/svnrdump.c:33: warning: shadowed declaration is here
subversion/svnrdump/svnrdump.c:91: warning: declaration of `pool' shadows a glob
al declaration
subversion/svnrdump/svnrdump.c:33: warning: shadowed declaration is here

When adding unit tests for svnrdump, please make each and every one of
those tests compare with output of svnadmin dump --deltas, so that we
will keep them in sync.

Thanks,
Stefan
