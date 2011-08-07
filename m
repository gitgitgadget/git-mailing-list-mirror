From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: test z$foo = zbar (and Re: [PATCH 1/3] bisect: relax requirement
 for a working tree.)
Date: Sun, 7 Aug 2011 09:10:35 -0500
Message-ID: <20110807141035.GC10748@elie.gateway.2wire.net>
References: <1312714240-23647-1-git-send-email-jon.seymour@gmail.com>
 <1312714240-23647-2-git-send-email-jon.seymour@gmail.com>
 <20110807124150.GA20046@elie.gateway.2wire.net>
 <201108071505.00762.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 07 16:11:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq44S-0005nl-O7
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 16:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235Ab1HGOKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 10:10:44 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:58387 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab1HGOKn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 10:10:43 -0400
Received: by iye16 with SMTP id 16so7169686iye.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 07:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Cv2M6BuVS1jMC4ScI8LDrV5Gq25jPKhMinBE3N9MtiQ=;
        b=sJlWBHkvt2M/gd3ch2AYJxDbfjzt635bn+52Y113LwGWYf0aXIY4opTlvwtyX5OsXB
         9OBziYc94kUuZcXpvCzM7t07AJrQnS9eJhfQe6BgC+nR+pMwLX7F0V39ug4q5RwVp0vN
         UoH5qX1OsZfyvB3UNgUC95M7k9mBLBe4n5t14=
Received: by 10.42.29.196 with SMTP id s4mr4635522icc.12.1312726243405;
        Sun, 07 Aug 2011 07:10:43 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-49-224.dsl.chcgil.ameritech.net [69.209.49.224])
        by mx.google.com with ESMTPS id hq1sm7190099icc.14.2011.08.07.07.10.41
        (version=SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 07:10:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201108071505.00762.stefano.lattarini@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178919>

Stefano Lattarini wrote:

>   $ /usr/xpg4/bin/sh -c 'test -z ")"'; echo $?
>   0

Yikes, thanks for pointing it out.  I wonder if we should introduce a
sane_test function, like this.

 empty_string () {
	case $* in
	?*)
		return 1 ;;
	*)
		return 0 ;;
	esac
 }

 # This is like "test", but:
 #  - it only implements a minimal subset of the functionality
 #  - it works around shells that cannot cope with parentheses as
 #    parameters to some operators, like ksh before 2008:
 #
 #	$ /usr/xpg4/bin/sh -c 'test -z ")"'; echo $?
 #	0
 sane_test () {
	# implied -n
	test "$#" = 0 && set -- -n ""
	test "$#" = 1 && set -- -n "$1"
	test "$#" = 2 && test "z$1" = z! && set -- -z "$2"

	test "$#" -le 4 || 

	case $# in
	2)
		case $1 in
		-z)
			empty_string "$2" ;;
		-n)
			! empty_string "$2" ;;
		-*)
			test "$@" ;;
		*)
			die "sane_test: unrecognized unary operator $1" ;;
		esac
		;;
	3)
		case $2 in
		= | !=)
			test "z$1" "$2" "z$3" ;;
		-eq | -lt | -gt | -le | -ge)
			test "$@" ;;
		*)
			die "sane_test: unrecognized binary operator $2" ;;
		esac
		;;
	4)
		test "z$1" = z! ||
		die "sane_test: unrecognized 4-argument test (not a negation)"

		shift
		! sane_test "$@"
		;;
	*)
		die 'sane_test: too many arguments'
		;;
	esac
 }
