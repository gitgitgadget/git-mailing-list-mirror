From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-import
Date: Wed, 7 Feb 2007 00:53:52 -0500
Message-ID: <20070207055352.GB7138@spearce.org>
References: <20070206023111.GB9222@spearce.org> <200702060928.54440.andyparkins@gmail.com> <Pine.LNX.4.64.0702060836180.8424@woody.linux-foundation.org> <20070206164441.GA4949@spearce.org> <200702070117.l171HGxr023213@laptop13.inf.utfsm.cl> <Pine.LNX.4.64.0702061832020.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 06:54:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEfl2-000234-FJ
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 06:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965522AbXBGFyF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 00:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965500AbXBGFyF
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 00:54:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42766 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965522AbXBGFyE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 00:54:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEfki-0004ri-Va; Wed, 07 Feb 2007 00:53:57 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9C5E820FBAE; Wed,  7 Feb 2007 00:53:52 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702061832020.8424@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38891>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Btw, one thing that might be a good idea to document very clearly:
> 
>  - in the native git format, the offset from UTC has *nothing* to do with 
>    the actual time itself. The time in native git is always in UTC, and 
>    the offset from UTC does not change "time" - it's purely there to tell 
>    in which timezone the event happened.
> 
>    So 12345678 +0000 and 12345678 -0700 are *exactly*the*same*date*, 
>    except event one happened in UTC, and the other happened in UTC-7.
> 
>  - in rfc2822 format, the offset from UTC actually *changes* the date. The 
>    date "Oct 12, 2006 20:00:00" will be two _different_ times when you say 
>    it is in PST or in UTC.

Here is the current language relating to date parsing in gfi:

Date Formats
~~~~~~~~~~~~
The following date formats are supported.  A frontend should select
the format it will use for this import by passing the format name
in the `--date-format=<fmt>` command line option.

`raw`::
	This is the Git native format and is `<time> SP <offutc>`.
	It is also gfi's default format, if `--date-format` was
	not specified.
+
The time of the event is specified by `<time>` as the number of
seconds since the UNIX epoch (midnight, Jan 1, 1970, UTC) and is
written as an ASCII decimal integer.
+
The local offset is specified by `<offutc>` as a positive or negative
offset from UTC.  For example EST (which is 5 hours behind UTC)
would be expressed in `<tz>` by ``-0500'' while UTC is ``+0000''.
The local offset does not affect `<time>`; it is used only as an
advisement to help formatting routines display the timestamp.
+
If the local offset is not available in the source material, use
``+0000'', or the most common local offset.  For example many
organizations have a CVS repository which has only ever been accessed
by users who are located in the same location and timezone.  In this
case the offset from UTC can be easily assumed.
+
Unlike the `rfc2822` format, this format is very strict.  Any
variation in formatting will cause gfi to reject the value.

`rfc2822`::
	This is the standard email format as described by RFC 2822.
+
An example value is ``Tue Feb 6 11:22:18 2007 -0500''.  The Git
parser is accurate, but a little on the lenient side.  Its the
same parser used by gitlink:git-am[1] when applying patches
received from email.
+
Some malformed strings may be accepted as valid dates.  In some of
these cases Git will still be able to obtain the correct date from
the malformed string.  There are also some types of malformed
strings which Git will parse wrong, and yet consider valid.
Seriously malformed strings will be rejected.
+
Unlike the `raw` format above, the timezone/UTC offset information
contained in an RFC 2822 date string is used to adjust the date
value to UTC prior to storage.  Therefore it is important that
this information be as accurate as possible.
+
If the source material is formatted in RFC 2822 style dates,
the frontend should let gfi handle the parsing and conversion
(rather than attempting to do it itself) as the Git parser has
been well tested in the wild.
+
Frontends should prefer the `raw` format if the source material
is already in UNIX-epoch format, or is easily convertible to
that format, as there is no ambiguity in parsing.

`now`::
	Always use the current time and timezone.  The literal
	`now` must always be supplied for `<when>`.
+
This is a toy format.  The current time and timezone of this system
is always copied into the identity string at the time it is being
created by gfi.  There is no way to specify a different time or
timezone.
+
This particular format is supplied as its short to implement and
may be useful to a process that wants to create a new commit
right now, without needing to use a working directory or
gitlink:git-update-index[1].
+
If separate `author` and `committer` commands are used in a `commit`
the timestamps may not match, as the system clock will be polled
twice (once for each command).  The only way to ensure that both
author and committer identity information has the same timestamp
is to omit `author` (thus copying from `committer`) or to use a
date format other than `now`.
